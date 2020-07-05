#include<iostream>
#include<cmath>
#include<Eigen/Core>
#include<Eigen/Dense>
#include<sophus/so3.h>
#include<sophus/se3.h>
#include<chrono>

using namespace std;
int main(){
    //define initial parameters
    Eigen::Vector3d w(0.01, 0.02, 0.02);
    Eigen::AngleAxisd angle_axis = Eigen::AngleAxisd(M_PI/5, Eigen::Vector3d(0,0,1));
    Eigen::Matrix3d R = angle_axis.toRotationMatrix();
    Sophus::SO3 so3_R(R);
    Eigen::Quaterniond q = Eigen::Quaterniond(R);

    //Quaternion update with Eigen
    cout<<"Quaternion update start: ===================="<<endl;
    auto start = chrono::system_clock::now();
    Eigen::Quaterniond w_q(1, w[0]/2, w[1]/2, w[2]/2);
    Eigen::Quaterniond update_q = (q * w_q).normalized(); //keep orthogonal of rotation matrix
    auto end = chrono::system_clock::now();
    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    cout << "Quaternion update with Eigen cost: "<< double(duration.count()) << "us" <<endl;

    //SO(3) update with Sophus
    cout<<"SO(3) update with Sophus start: ===================="<<endl;
    start = chrono::system_clock::now();
    Sophus::SO3 so3_update = so3_R * Sophus::SO3::exp(w);
    end = chrono::system_clock::now();
    duration = chrono::duration_cast<chrono::microseconds>(end - start);
    cout << "SO(3) update with Sophus cost: "<< double(duration.count()) << "us" <<endl;

    auto diff = update_q.toRotationMatrix() - so3_update.matrix();
    cout << "Difference between update_q and update_so3 is "<< endl << diff << endl;

}
