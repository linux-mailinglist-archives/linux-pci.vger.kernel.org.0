Return-Path: <linux-pci+bounces-41042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE6C55681
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE813B5022
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADDA29D280;
	Thu, 13 Nov 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA1Qdm+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44822E11D2
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000050; cv=none; b=Dh8ePxuRftpiz0HgZQ7Ra4SaxJt1LEkaGCl+CUrOV/aEy88mhECX5G6+NJisLqndvx7117SYmi6Q73yfW2TgmHUXobgpcHERIRH687uwSdMfE2NcZke4W2JO9oKhlHv4ritgPULkNdwDoq1YeKSrRC3x4v+Lrib2Hx0fy05LGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000050; c=relaxed/simple;
	bh=B+ulc6jhjr3yZ/FVEBcVFXYbImeJlste+UsX9q2rWhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0UXl2PiJrwOBaittJvrTd6VwpzvVFTdPYm/vJr9ZIjPRw++Uu0pbI9tYcD3DBlLiGt9uwAixwsoSyHrMWDxpe1IU5ojMYg6Nv2PWysvxAqMaPIr6x27cyy7dDSW0Pm7+rwoK/KSh1p/YXhklMFszEiYTDty2lgq1CP7XNIIbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA1Qdm+P; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000049; x=1794536049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+ulc6jhjr3yZ/FVEBcVFXYbImeJlste+UsX9q2rWhs=;
  b=EA1Qdm+P4XMG6EXGGlgVwFc3cSuGQk1Ru20/Ml2FUfs21/yFjfrR/tPV
   0fUMYylu2xqAFoJt6Q/QcpbzU/dBYE5OunzTP/RqObXPVdwR+R1JOVlZk
   C2SoJmfmn/fXpBv+4DdgkbPOX8RNJKgV2mQy7bakfv2t/zJJ3vhFtamSG
   3DphCpO7NvicYjLb2KZgie0VFvwZRgc8oGHEC2A+eYJuJyvBUhkzPKsvC
   I1lA2G9QGDTMKbmOTQaGCTS6e6NQodfbogtAnyRdwv7XbzdOqdrRsUx6/
   7Y2n6nrWrEMVj6fd/zAj4BWDkxEdTl6kIdmE1AujEMTRzj1ipJtv4hanX
   w==;
X-CSE-ConnectionGUID: 9kAClkkXQfy1Nk3pSG9CQA==
X-CSE-MsgGUID: 90Fr5mnoQ9G4oDzazfzbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471776"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:06 -0800
X-CSE-ConnectionGUID: XLg4Q+P5Qx2JIjIxB3/Rxw==
X-CSE-MsgGUID: o6MZkVz7R8SqiXN5UjIWpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802501"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 6/8] PCI/TSM: Add pci_tsm_bind() helper for instantiating TDIs
Date: Wed, 12 Nov 2025 18:14:44 -0800
Message-ID: <20251113021446.436830-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a PCIe device has established a secure link and session between a TEE
Security Manager (TSM) and its local Device Security Manager (DSM), the
device or its subfunctions are candidates to be bound to a private memory
context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
Device Interface (TDI).

The pci_tsm_bind() requests the low-level TSM driver to associate the
device with private MMIO and private IOMMU context resources of a given TVM
represented by a @kvm argument. A device in the bound state corresponds to
the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
it involves host side resource establishment and context setup on behalf of
the guest. It is also expected to be performed lazily to allow for
operation of the device in non-confidential "shared" context for pre-lock
configuration.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci-tsm.h |  34 +++++++++++++
 drivers/pci/tsm.c       | 109 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index d7b078d5e272..a5e297677917 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -6,6 +6,8 @@
 
 struct pci_tsm;
 struct tsm_dev;
+struct kvm;
+enum pci_tsm_req_scope;
 
 /*
  * struct pci_tsm_ops - manage confidential links and security state
@@ -29,12 +31,16 @@ struct pci_tsm_ops {
 	 * @connect: establish / validate a secure connection (e.g. IDE)
 	 *	     with the device
 	 * @disconnect: teardown the secure link
+	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
+	 * @unbind: remove a TDI from secure operation with a TVM
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
+	 * lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
@@ -42,6 +48,9 @@ struct pci_tsm_ops {
 		void (*remove)(struct pci_tsm *tsm);
 		int (*connect)(struct pci_dev *pdev);
 		void (*disconnect)(struct pci_dev *pdev);
+		struct pci_tdi *(*bind)(struct pci_dev *pdev,
+					struct kvm *kvm, u32 tdi_id);
+		void (*unbind)(struct pci_tdi *tdi);
 	);
 
 	/*
@@ -61,12 +70,25 @@ struct pci_tsm_ops {
 	);
 };
 
+/**
+ * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
+ * @pdev: host side representation of guest-side TDI
+ * @kvm: TEE VM context of bound TDI
+ * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
+ */
+struct pci_tdi {
+	struct pci_dev *pdev;
+	struct kvm *kvm;
+	u32 tdi_id;
+};
+
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
  * @pdev: Back ref to device function, distinguishes type of pci_tsm context
  * @dsm_dev: PCI Device Security Manager for link operations on @pdev
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
+ * @tdi: TDI context established by the @bind link operation
  *
  * This structure is wrapped by low level TSM driver data and returned by
  * probe()/lock(), it is freed by the corresponding remove()/unlock().
@@ -82,6 +104,7 @@ struct pci_tsm {
 	struct pci_dev *pdev;
 	struct pci_dev *dsm_dev;
 	struct tsm_dev *tsm_dev;
+	struct pci_tdi *tdi;
 };
 
 /**
@@ -139,6 +162,10 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
+void pci_tsm_unbind(struct pci_dev *pdev);
+void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
+			     struct kvm *kvm, u32 tdi_id);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -147,5 +174,12 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 {
 }
+static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
+{
+	return -ENXIO;
+}
+static inline void pci_tsm_unbind(struct pci_dev *pdev)
+{
+}
 #endif
 #endif /*__PCI_TSM_H */
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 6a2849f77adc..39de91a47a26 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -270,6 +270,95 @@ static int remove_fn(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
+/*
+ * Note, this helper only returns an error code and takes an argument for
+ * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
+ * always succeeds.
+ */
+static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
+{
+	struct pci_tdi *tdi;
+	struct pci_tsm_pf0 *tsm_pf0;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return 0;
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	guard(mutex)(&tsm_pf0->lock);
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return 0;
+
+	to_pci_tsm_ops(pdev->tsm)->unbind(tdi);
+	pdev->tsm->tdi = NULL;
+
+	return 0;
+}
+
+void pci_tsm_unbind(struct pci_dev *pdev)
+{
+	guard(rwsem_read)(&pci_tsm_rwsem);
+	__pci_tsm_unbind(pdev, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unbind);
+
+/**
+ * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
+ * @pdev: PCI device function to bind
+ * @kvm: Private memory attach context
+ * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ *
+ * Context: Caller is responsible for constraining the bind lifetime to the
+ * registered state of the device. For example, pci_tsm_bind() /
+ * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
+ */
+int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
+{
+	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tdi *tdi;
+
+	if (!kvm)
+		return -EINVAL;
+
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	if (!pdev->tsm)
+		return -EINVAL;
+
+	if (!is_link_tsm(pdev->tsm->tsm_dev))
+		return -ENXIO;
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	guard(mutex)(&tsm_pf0->lock);
+
+	/* Resolve races to bind a TDI */
+	if (pdev->tsm->tdi) {
+		if (pdev->tsm->tdi->kvm != kvm)
+			return -EBUSY;
+		return 0;
+	}
+
+	tdi = to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);
+	if (IS_ERR(tdi))
+		return PTR_ERR(tdi);
+
+	pdev->tsm->tdi = tdi;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_bind);
+
+static void pci_tsm_unbind_all(struct pci_dev *pdev)
+{
+	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
+	__pci_tsm_unbind(pdev, NULL);
+}
+
 static void __pci_tsm_disconnect(struct pci_dev *pdev)
 {
 	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
@@ -278,6 +367,8 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
 	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
 	lockdep_assert_held_write(&pci_tsm_rwsem);
 
+	pci_tsm_unbind_all(pdev);
+
 	/*
 	 * disconnect() is uninterruptible as it may be called for device
 	 * teardown
@@ -439,6 +530,22 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
 	return NULL;
 }
 
+/**
+ * pci_tsm_tdi_constructor() - base 'struct pci_tdi' initialization for link TSMs
+ * @pdev: PCI device function representing the TDI
+ * @tdi: context to initialize
+ * @kvm: Private memory attach context
+ * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
+ */
+void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
+			     struct kvm *kvm, u32 tdi_id)
+{
+	tdi->pdev = pdev;
+	tdi->kvm = kvm;
+	tdi->tdi_id = tdi_id;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_tdi_constructor);
+
 /**
  * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
  * @pdev: The PCI device
@@ -532,7 +639,7 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
 
 static void pci_tsm_fn_exit(struct pci_dev *pdev)
 {
-	/* TODO: unbind the fn */
+	__pci_tsm_unbind(pdev, NULL);
 	tsm_remove(pdev->tsm);
 }
 
-- 
2.51.1


