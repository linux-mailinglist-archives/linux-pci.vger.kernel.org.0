Return-Path: <linux-pci+bounces-33052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3DB13C4D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37141C21530
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CA62727E1;
	Mon, 28 Jul 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulgfYV/j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E3266B64;
	Mon, 28 Jul 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710878; cv=none; b=dz/BWujlJWetLT94hzyyWN8QqSFBOgYlBSvlUMEAF0mKUE1LojdhZvPmwyVKeOdeaEBa3IUX0DedMCOpk8wzlZMmyr12git9XI/+quJpDEaOUz5wOPzDI6vSKir7n33jCrYqTp52VPAvuB7l+RROimpdf6HoLfz59Fm4qTbkG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710878; c=relaxed/simple;
	bh=+O/Ekqre//pHRoxg1Kfr3iyIx8FWcqaOqXHmmmNgPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWTlTfcIs6QgKpF7w1uorCTXsWxMkduaT+DZAqjAf5zvTEWCC45tLGUA/UCUXrWGb2IPklS8J4/V9mw1Vx0RzCHMyvAmytS2UNz+Kla8+s/vv/U5bLf45Qj/FgsG2tLjie8bs2ppmaBeKaD6JZdSRMCHpL9S27Ja73v+ue7FQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulgfYV/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF6C4CEE7;
	Mon, 28 Jul 2025 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710876;
	bh=+O/Ekqre//pHRoxg1Kfr3iyIx8FWcqaOqXHmmmNgPiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulgfYV/jNL7gXEFZR+Y0s+wwjgiB0l8I7uKkh5I/Xws+j0YXbEvG5zUsyrdW4nOoN
	 9MiuBBvLYi2Kw4nDvdKibDmZBq3AHQM3O+BKdhTQUGz3kvOgRxByDYALCjsMu7CpfD
	 4h6PfmKTO5ltOkOwAHW8CVQDyOb7HCz8eMDNXeIeWdEvWyOH7uttWJitx292kBSajA
	 l9ehAdhfLK+L5ivNEyvHCkPGFC0PF57JOQxKsjRo5565wkx0SG7Bsi5cLysffUIxGp
	 Ja3JbD50NsPVZtu1dgOTEh1I5n1wDi9BAilV0/OnX7k+g/1K8gt2/ucyCmee01SPvD
	 E6rdj3LZBN4vQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 20/38] coco: host: arm64: Add support for creating a virtual device
Date: Mon, 28 Jul 2025 19:21:57 +0530
Message-ID: <20250728135216.48084-21-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to support the creation of virtual device objects with RMM.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        | 13 +++++
 arch/arm64/include/asm/rmi_smc.h         | 30 +++++++++++
 drivers/virt/coco/arm-cca-host/Kconfig   |  1 +
 drivers/virt/coco/arm-cca-host/arm-cca.c | 30 +++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 67 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  | 17 ++++++
 6 files changed, 158 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index aef0b0ee062e..7d91f847069b 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -574,4 +574,17 @@ static inline unsigned long rmi_pdev_set_pubkey(unsigned long pdev_phys, unsigne
 	return res.a0;
 }
 
+static inline unsigned long rmi_vdev_create(unsigned long rd,
+					    unsigned long pdev_phys,
+					    unsigned long vdev_phys,
+					    unsigned long vdev_params_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_CREATE, rd, pdev_phys,
+			     vdev_phys, vdev_params_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 4a5ba98c1c0d..e5238b271493 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -53,6 +53,8 @@
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
 #define SMC_RMI_PDEV_SET_PUBKEY		SMC_RMI_CALL(0x017b)
 #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
+#define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
+
 
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
@@ -407,4 +409,32 @@ struct rmi_public_key_params {
 	};
 };
 
+enum rmi_vdev_state {
+	RMI_VDEV_READY,
+	RMI_VDEV_COMMUNICATING,
+	RMI_VDEV_STOPPING,
+	RMI_VDEV_STOPPED,
+	RMI_VDEV_ERROR,
+};
+
+#define MAX_VDEV_AUX_GRANULES	32
+
+struct rmi_vdev_params {
+	union {
+		struct {
+			u64 flags;
+			u64 vdev_id;
+			u64 tdi_id;
+			u64 num_aux;
+		};
+		u8 padding1[0x100];
+	};
+	union {	/* 0x100 */
+		struct {
+			unsigned long aux[MAX_VDEV_AUX_GRANULES];
+		};
+		u8 padding2[0x900];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
index a5b777f0d50e..52ed1cd5f06a 100644
--- a/drivers/virt/coco/arm-cca-host/Kconfig
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -6,6 +6,7 @@ config ARM_CCA_HOST
 	tristate "Arm CCA Host driver"
 	depends on ARM64
 	depends on PCI_TSM
+	depends on KVM
 	select KEYS
 	select X509_CERTIFICATE_PARSER
 	select TSM
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index c65b81f0706f..2da513f45974 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -10,6 +10,8 @@
 #include <linux/pci.h>
 #include <linux/tsm.h>
 #include <linux/vmalloc.h>
+#include <linux/kvm_host.h>
+#include <linux/pci.h>
 
 #include "rmm-da.h"
 
@@ -221,11 +223,39 @@ static void cca_tsm_disconnect(struct pci_dev *pdev)
 	free_dev_communication_buffers(&dsc_pf0->comm_data);
 }
 
+static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_dev,
+				    struct kvm *kvm, u64 tdi_id)
+{
+	void *rmm_vdev;
+	struct cca_host_tdi *host_tdi __free(kfree) = NULL;
+	struct realm *realm = &kvm->arch.realm;
+
+	if (pdev->is_virtfn)
+		return ERR_PTR(-ENXIO);
+
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-ENXIO);
+
+	host_tdi = kmalloc(sizeof(struct cca_host_tdi), GFP_KERNEL);
+	if (!host_tdi)
+		return ERR_PTR(-ENOMEM);
+
+	rmm_vdev = rme_create_vdev(realm, pdev, pf0_dev, tdi_id);
+	if (!IS_ERR_OR_NULL(rmm_vdev)) {
+		host_tdi->rmm_vdev = rmm_vdev;
+		return &no_free_ptr(host_tdi)->tdi;
+	}
+
+	module_put(THIS_MODULE);
+	return rmm_vdev;
+}
+
 static const struct pci_tsm_ops cca_pci_ops = {
 	.probe = cca_tsm_pci_probe,
 	.remove = cca_tsm_pci_remove,
 	.connect = cca_tsm_connect,
 	.disconnect = cca_tsm_disconnect,
+	.bind	= cca_tsm_bind,
 };
 
 static void cca_tsm_remove(void *tsm_core)
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index 3715e6d58c83..41314db1d568 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -9,6 +9,8 @@
 #include <crypto/internal/rsa.h>
 #include <keys/asymmetric-type.h>
 #include <keys/x509-parser.h>
+#include <linux/kvm_types.h>
+#include <asm/kvm_rme.h>
 
 #include "rmm-da.h"
 
@@ -517,3 +519,68 @@ void rme_unassign_device(struct pci_dev *pdev)
 	if (WARN_ON(ret != RMI_SUCCESS))
 		return;
 }
+
+static unsigned long pci_get_tdi_id(struct pci_dev *pdev)
+{
+	/* requester segment is marked reserved. */
+	return pci_dev_id(pdev);
+
+}
+
+void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
+		      struct pci_dev *pf0_dev, u32 guest_rid)
+{
+	phys_addr_t rd_phys = virt_to_phys(realm->rd);
+	struct rmi_vdev_params *params = NULL;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	phys_addr_t rmm_pdev_phys;
+	phys_addr_t rmm_vdev_phys;
+	void *rmm_vdev;
+	int ret;
+
+	dsc_pf0 = to_cca_dsc_pf0(pf0_dev);
+	if (!dsc_pf0->rmm_pdev) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	rmm_vdev = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!rmm_vdev) {
+		ret =  -ENOMEM;
+		goto err_out;
+	}
+
+	rmm_vdev_phys = virt_to_phys(rmm_vdev);
+	if (rmi_granule_delegate(rmm_vdev_phys)) {
+		ret = -ENXIO;
+		goto err_free_vdev;
+	}
+
+	params = (struct rmi_vdev_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params) {
+		ret = -ENOMEM;
+		goto err_granule_undelegate;
+	}
+
+	params->flags = 0;
+	params->vdev_id = guest_rid;
+	params->tdi_id = pci_get_tdi_id(pdev);
+	params->num_aux = 0;
+
+	rmm_pdev_phys = virt_to_phys(dsc_pf0->rmm_pdev);
+	ret = rmi_vdev_create(rd_phys, rmm_pdev_phys,
+			      rmm_vdev_phys, virt_to_phys(params));
+	if (ret)
+		goto err_granule_undelegate;
+
+	free_page((unsigned long)params);
+	return rmm_vdev;
+
+err_granule_undelegate:
+	rmi_granule_undelegate(rmm_vdev_phys);
+err_free_vdev:
+	free_page((unsigned long)rmm_vdev);
+	free_page((unsigned long)params);
+err_out:
+	return ERR_PTR(ret);
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 03c3149b8a98..6d612ea3b87f 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -45,6 +45,11 @@ struct cca_host_dsc_pf0 {
 	struct cache_object vca;
 };
 
+struct cca_host_tdi {
+	struct pci_tdi tdi;
+	void *rmm_vdev;
+};
+
 #define PDEV_COMMUNICATE	0x1
 static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
 {
@@ -71,7 +76,19 @@ static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
 	return NULL;
 }
 
+static inline struct cca_host_tdi *to_cca_host_tdi(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm || !tsm->tdi)
+		return NULL;
+
+	return container_of(tsm->tdi, struct cca_host_tdi, tdi);
+}
+
 int rme_asign_device(struct pci_dev *pdev);
 void rme_unassign_device(struct pci_dev *pdev);
 int schedule_rme_ide_setup(struct pci_dev *pdev);
+void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
+		      struct pci_dev *pf0_dev, u32 guest_rid);
 #endif
-- 
2.43.0


