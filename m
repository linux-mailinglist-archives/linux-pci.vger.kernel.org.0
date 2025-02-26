Return-Path: <linux-pci+bounces-22428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD818A45EB6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41653B454B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEA21A42D;
	Wed, 26 Feb 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA1TmOPM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01053212B23;
	Wed, 26 Feb 2025 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572037; cv=none; b=gu7laDVUAUxjrtf3C6O3Q4MjfO8QPAyNAMBrBUVLp/bmBwrbrkZJPx4UeSlYLM9R1LZCtVX8r4LVmoQooE28A2lDZHFxc72hnFSYvEdrDPf2sU2rYVOSWofopDhh9kRV1YWKtu21cUSnAlrgojLmR6p/jSt4tyqUZwGfX6A3yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572037; c=relaxed/simple;
	bh=YCTHFBcDBDHDDhBI6zIFYbkTjLyD/E1UDY9bHzwe+Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ8EUn+P+rpwhGqPM2BE47z8GsxhXqZ7AldfPpOZl0fG7eC1+w5TD8c3QmbmeNhUM2HY3KPlR3RT3jCai7Y84pIQyX+sEJ9sLJxPR/ZLR80MXdaWjPNAeRIlf225VF0t4KGejCivpY/5TJue+hljc6TF/pSVL1ZvtjGaYsvPgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA1TmOPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54377C4CEE8;
	Wed, 26 Feb 2025 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572036;
	bh=YCTHFBcDBDHDDhBI6zIFYbkTjLyD/E1UDY9bHzwe+Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA1TmOPMAJR+hXWzZtGMRvSih60QqYBXgTSDQsNPA6k43BE+D9SCI3YjxBH3LSdt/
	 yuZoP1Duv5UlORH9w6aKmD97H3izn2Q9z+pR4B9etr2ewJhC+UZ+cs7IDLaOnklliZ
	 CXqrWE+EuQXaM3YsndU1CSiT3ccSWw7Rx5wEcrej40n2NoaZbYwwQeh5jCRZ4Y9EiO
	 Y2yiTlv9deWd8y20nOxtvW6SI9jNjkVMf83QnB13EU8I8j5bTKkL2LvaeF9ZuXqJmu
	 6AWkVoJ0N+f/c1h1bnyDA09/vdnSm3Tbn+0pFqcu/GVFT8UFOrXyBgsX7aySBWyP9C
	 O6q0jk/kGnF+Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	gregkh@linuxfoundation.org,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 3/7] tsm: vfio: Add tsm bind/unbind support
Date: Wed, 26 Feb 2025 17:43:19 +0530
Message-ID: <20250226121323.577328-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226121323.577328-1-aneesh.kumar@kernel.org>
References: <yq5a4j0gc3fp.fsf@kernel.org>
 <20250226121323.577328-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used to bind a TDI to the VM instance.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c           |  48 +++++++++++++++
 drivers/vfio/pci/vfio_pci.c |  13 ++++
 drivers/vfio/vfio_main.c    |  31 ++++++++++
 include/linux/pci-tsm.h     |  17 ++++++
 include/linux/vfio.h        |   6 ++
 include/uapi/linux/kvm.h    |  17 ++++++
 virt/kvm/vfio.c             | 116 ++++++++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 720b54d422b7..1a071130dea3 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -292,3 +292,51 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 		       req_sz, resp, resp_sz);
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
+
+static int __pci_tsm_bind(struct vfio_device *vfio_dev, u32 guest_rid)
+{
+	int rc;
+	struct pci_dev *pdev = to_pci_dev(vfio_dev->dev);
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->lock) {
+		if (pci_tsm->state != PCI_TSM_CONNECT)
+			return -ENXIO;
+
+		/* This should hold a reference to the module providing tsm_ops */
+		rc = tsm_ops->bind(vfio_dev, guest_rid);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+int pci_tsm_bind(struct vfio_device *vfio_dev, u32 guest_rid)
+{
+	int ret = -ENXIO;
+
+	scoped_cond_guard(rwsem_read_intr, return -EINTR, &pci_tsm_rwsem) {
+		if (tsm_ops)
+			ret = __pci_tsm_bind(vfio_dev, guest_rid);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_bind);
+
+/*
+ * pci_tsm_ops can't be NULL since we hold a module reference during bind.
+ * Hence No pci_tsm_rwsem locking needed.
+ */
+void pci_tsm_unbind(struct vfio_device *vfio_dev)
+{
+	struct pci_dev *pdev = to_pci_dev(vfio_dev->dev);
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	scoped_cond_guard(mutex_intr, return, &pci_tsm->lock) {
+		if (pci_tsm->state != PCI_TSM_BOUND)
+			return;
+
+		tsm_ops->unbind(vfio_dev);
+	}
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unbind);
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e727941f589d..a1e1eb4c26db 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/pci-tsm.h>
 
 #include "vfio_pci_priv.h"
 
@@ -127,6 +128,16 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
+static int vfio_pci_tsm_bind(struct vfio_device *core_vdev, u32 guest_rid)
+{
+	return pci_tsm_bind(core_vdev, guest_rid);
+}
+
+static void vfio_pci_tsm_unbind(struct vfio_device *core_vdev)
+{
+	return pci_tsm_unbind(core_vdev);
+}
+
 static const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
@@ -144,6 +155,8 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
 	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
 	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
+	.tsm_bind	= vfio_pci_tsm_bind,
+	.tsm_unbind	= vfio_pci_tsm_unbind,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582..b24644c9c841 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -462,6 +462,21 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 	device->kvm = kvm;
 }
 
+int vfio_tsm_bind(struct kvm *kvm, struct vfio_device *vdev, u32 guest_rid)
+{
+	if (vdev->ops->tsm_bind)
+		return vdev->ops->tsm_bind(vdev, guest_rid);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(vfio_tsm_bind);
+
+void vfio_tsm_unbind(struct kvm *kvm, struct vfio_device *vdev)
+{
+	if (vdev->ops->tsm_bind)
+		return vdev->ops->tsm_unbind(vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_tsm_unbind);
+
 void vfio_device_put_kvm(struct vfio_device *device)
 {
 	lockdep_assert_held(&device->dev_set->lock);
@@ -472,6 +487,11 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	if (WARN_ON(!device->put_kvm))
 		goto clear;
 
+	/* Unbind TDI here */
+	vfio_tsm_unbind(device->kvm, device);
+	/* drop the reference held in kvm_dev_tsm_bind */
+	vfio_put_device(device);
+
 	device->put_kvm(device->kvm);
 	device->put_kvm = NULL;
 	symbol_put(kvm_put_kvm);
@@ -1447,6 +1467,17 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
 
+struct vfio_device *vfio_file_device(struct file *filep)
+{
+	struct vfio_device_file *df = filep->private_data;
+
+	if (filep->f_op != &vfio_device_fops)
+		return NULL;
+
+	return df->device;
+}
+EXPORT_SYMBOL_GPL(vfio_file_device);
+
 /*
  * Sub-module support
  */
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index beb0d68129bc..774496d7b37e 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -2,6 +2,7 @@
 #ifndef __PCI_TSM_H
 #define __PCI_TSM_H
 #include <linux/mutex.h>
+#include <linux/vfio_pci_core.h>
 
 struct pci_dev;
 
@@ -17,6 +18,7 @@ enum pci_tsm_state {
 	PCI_TSM_ERR = -1,
 	PCI_TSM_INIT,
 	PCI_TSM_CONNECT,
+	PCI_TSM_BOUND,
 };
 
 /**
@@ -49,6 +51,8 @@ struct pci_tsm_ops {
 	void (*remove)(struct pci_dsm *dsm);
 	int (*connect)(struct pci_dev *pdev);
 	void (*disconnect)(struct pci_dev *pdev);
+	int (*bind)(struct vfio_device *vfio_dev, u32 guest_rid);
+	void (*unbind)(struct vfio_device *vfio_dev);
 };
 
 enum pci_doe_proto {
@@ -63,6 +67,9 @@ void pci_tsm_unregister(const struct pci_tsm_ops *ops);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 			 const void *req, size_t req_sz, void *resp,
 			 size_t resp_sz);
+int pci_tsm_bind(struct vfio_device *vfio_dev, u32 guest_rid);
+void pci_tsm_unbind(struct vfio_device *vfio_dev);
+
 #else
 static inline int pci_tsm_register(const struct pci_tsm_ops *ops,
 				   const struct attribute_group *grp)
@@ -79,5 +86,15 @@ static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
 {
 	return -ENOENT;
 }
+
+static inline int pci_tsm_bind(struct vfio_device *vifo_dev, u32 guest_rid);
+{
+	return -EINVAL;
+}
+
+static inline void pci_tsm_unbind(struct vfio_device *vfio_dev)
+{
+	return -EINVAL;
+}
 #endif
 #endif /*__PCI_TSM_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 000a6cab2d31..a177dcade4aa 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -129,6 +129,8 @@ struct vfio_device_ops {
 	void	(*dma_unmap)(struct vfio_device *vdev, u64 iova, u64 length);
 	int	(*device_feature)(struct vfio_device *device, u32 flags,
 				  void __user *arg, size_t argsz);
+	int	(*tsm_bind)(struct vfio_device *vdev, u32 guest_rid);
+	void	(*tsm_unbind)(struct vfio_device *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -316,6 +318,10 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+struct vfio_device *vfio_file_device(struct file *file);
+void vfio_tsm_unbind(struct kvm *kvm, struct vfio_device *vdev);
+int vfio_tsm_bind(struct kvm *kvm, struct vfio_device *vdev, u32 guest_rid);
+
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9cabf9b6a9b4..6c251f04c5dd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1604,4 +1604,21 @@ struct kvm_arm_rmm_psci_complete {
 /* FIXME: Update nr (0xd2) when merging */
 #define KVM_ARM_VCPU_RMM_PSCI_COMPLETE	_IOW(KVMIO, 0xd2, struct kvm_arm_rmm_psci_complete)
 
+#define  KVM_DEV_VFIO_DEVICE			2
+#define  KVM_DEV_VFIO_DEVICE_TDI_BIND		1
+#define  KVM_DEV_VFIO_DEVICE_TDI_UNBIND		2
+
+/*
+ * struct kvm_vfio_tsm_bind
+ *
+ * @guest_rid: Hypervisor provided identifier used by the guest to identify
+ *             the TDI in guest messages
+ * @devfd: a fd of VFIO device
+ */
+struct kvm_vfio_tsm_bind {
+	__u32 guest_rid;
+	__s32 devfd;
+} __packed;
+
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 196a102e34fb..525aeccfaf2b 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
+#include <linux/tsm.h>
 #include "vfio.h"
 
 #ifdef CONFIG_SPAPR_TCE_IOMMU
@@ -80,6 +81,23 @@ static bool kvm_vfio_file_is_valid(struct file *file)
 	return ret;
 }
 
+static struct vfio_device *kvm_vfio_file_device(struct file *file)
+{
+	struct vfio_device *(*fn)(struct file *file);
+	struct vfio_device *ret;
+
+	fn = symbol_get(vfio_file_device);
+	if (!fn)
+		return NULL;
+
+	ret = fn(file);
+
+	symbol_put(vfio_file_device);
+
+	return ret;
+}
+
+
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 static struct iommu_group *kvm_vfio_file_iommu_group(struct file *file)
 {
@@ -291,6 +309,94 @@ static int kvm_vfio_set_file(struct kvm_device *dev, long attr,
 	return -ENXIO;
 }
 
+static int kvm_dev_tsm_bind(struct kvm_device *dev, void __user *arg)
+{
+	int (*tsm_bind)(struct kvm *kvm, struct vfio_device *vdev, u32 guest_rid);
+	struct kvm_vfio *kv = dev->private;
+	struct kvm_vfio_tsm_bind tb;
+	struct vfio_device *vdev;
+	struct file *filp;
+	int ret;
+
+	if (copy_from_user(&tb, arg, sizeof(tb)))
+		return -EFAULT;
+
+	filp = fget(tb.devfd);
+	if (!filp)
+		return -EBADF;
+
+	ret = -ENOENT;
+
+	tsm_bind = symbol_get(vfio_tsm_bind);
+	if (!tsm_bind)
+		goto err_out;
+
+	mutex_lock(&kv->lock);
+	vdev = kvm_vfio_file_device(filp);
+	if (vdev) {
+		/* hold the reference to the vfio device file when we bind. */
+		get_device(&vdev->device);
+		ret = (*tsm_bind)(dev->kvm, vdev, tb.guest_rid);
+		if (ret)
+			vfio_put_device(vdev);
+	}
+	mutex_unlock(&kv->lock);
+	symbol_put(vfio_tsm_bind);
+err_out:
+	fput(filp);
+	return ret;
+}
+
+static int kvm_dev_tsm_unbind(struct kvm_device *dev, void __user *arg)
+{
+	void (*tsm_unbind)(struct kvm *kvm, struct vfio_device *vdev);
+	struct kvm_vfio *kv = dev->private;
+	struct kvm_vfio_tsm_bind tb;
+	struct vfio_device *vdev;
+	struct file *filp;
+	int ret;
+
+	if (copy_from_user(&tb, arg, sizeof(tb)))
+		return -EFAULT;
+
+	filp = fget(tb.devfd);
+	if (!filp)
+		return -EBADF;
+
+	ret = -ENOENT;
+
+	tsm_unbind = symbol_get(vfio_tsm_unbind);
+	if (!tsm_unbind)
+		goto err_out;
+
+	mutex_lock(&kv->lock);
+	vdev = kvm_vfio_file_device(filp);
+	if (vdev) {
+		(*tsm_unbind)(dev->kvm, vdev);
+		/* drop the reference held in kvm_dev_tsm_bind */
+		vfio_put_device(vdev);
+		ret = 0;
+	}
+	mutex_unlock(&kv->lock);
+	symbol_put(vfio_tsm_unbind);
+err_out:
+	fput(filp);
+	return ret;
+}
+
+static int kvm_vfio_set_device(struct kvm_device *dev, long attr,
+			       void __user *arg)
+{
+	switch (attr) {
+	case KVM_DEV_VFIO_DEVICE_TDI_BIND:
+		return kvm_dev_tsm_bind(dev, arg);
+	case KVM_DEV_VFIO_DEVICE_TDI_UNBIND:
+		return kvm_dev_tsm_unbind(dev, arg);
+	}
+
+	return -ENXIO;
+}
+
 static int kvm_vfio_set_attr(struct kvm_device *dev,
 			     struct kvm_device_attr *attr)
 {
@@ -298,6 +404,9 @@ static int kvm_vfio_set_attr(struct kvm_device *dev,
 	case KVM_DEV_VFIO_FILE:
 		return kvm_vfio_set_file(dev, attr->attr,
 					 u64_to_user_ptr(attr->addr));
+	case KVM_DEV_VFIO_DEVICE:
+		return kvm_vfio_set_device(dev, attr->attr,
+					   u64_to_user_ptr(attr->addr));
 	}
 
 	return -ENXIO;
@@ -317,6 +426,13 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 			return 0;
 		}
 
+		break;
+	case KVM_DEV_VFIO_DEVICE:
+		switch (attr->attr) {
+		case KVM_DEV_VFIO_DEVICE_TDI_BIND:
+		case KVM_DEV_VFIO_DEVICE_TDI_UNBIND:
+			return 0;
+		}
 		break;
 	}
 
-- 
2.43.0


