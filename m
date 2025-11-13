Return-Path: <linux-pci+bounces-41043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D808C55684
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E16A3B5259
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A262E0B64;
	Thu, 13 Nov 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJNgfU58"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A52E1C4E
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000050; cv=none; b=GGNOkk/bZZa2TwHlIfS0wr4C+QxCq9CZaFLqMkg8gYja/YkMyI4Ckoe2PdcsR/7Fnx9WvB6qTiwiq3IsDJdTY1Wn4bEOMN1vM3QRKIqebppSI5549yU6h34CQqZrmJyEb5dynFo7gWzGVlCZS/njyoHJbitrkJwlCtkJZ1HZtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000050; c=relaxed/simple;
	bh=i9CfNEJ3Rkz9Oyk+1uKWI+/ZPZdWGfA1o07CAz4x0Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChUEAP3sKA1NT0YeqhnjaKMIU21NbvhmKn8Bu952maIJdXid0jIBZF/X0zDrgBL361lDxQjv6/rsMZVdkliephyAdyW4//ho6oNFT4iSU87X+u/CeiNyHUR4kAnLhtYbhEk1gdZTuS53JWVrAKZn3BhrEj95mznk219Psn73rGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJNgfU58; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000049; x=1794536049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9CfNEJ3Rkz9Oyk+1uKWI+/ZPZdWGfA1o07CAz4x0Yw=;
  b=gJNgfU58bzjkyvSguLNLkY2xk4Xolc8kABvSRtiwYGjloVOBkWOdeLUy
   9i4wwMQG7iFCWIA03gtFcYRxal9ABga2ls54que5mEOp40BE/Ciw6+4u8
   MUDE9Q2+q5RUa1M16fILtj2cQomJnqct1FvEkGK/L1zcL208ewmsqkRXr
   o4UgU0cB0FbHpLzbZagdyBM/NHFfa2DJI4E8gsTNtAmGQpPi7nrkrU8AM
   taAF2BTieNQjXZq/KGY4wI49/9Io2pxpdgTxBQpVaJn7KYt4zF0xk1j5P
   EGNl0q1sm8WBG9lnKWPWINwR3KpxRbAouI55Ex8IQweQuVhKf82So8UJn
   A==;
X-CSE-ConnectionGUID: ba+qlpl6S7uFYbzPhZ7xeA==
X-CSE-MsgGUID: jVf5YCSfSvOilOmZ5VL3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471779"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:06 -0800
X-CSE-ConnectionGUID: MxEI4Tf6QS+QNBgZ9mBvAw==
X-CSE-MsgGUID: bsyS/r2UQ3WMV/Qk7XyDmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802504"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 7/8] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Date: Wed, 12 Nov 2025 18:14:45 -0800
Message-ID: <20251113021446.436830-8-dan.j.williams@intel.com>
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

A PCIe device function interface assigned to a TVM is a TEE Device
Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
steps taken by the TVM to be accepted into the TVM's Trusted Compute
Boundary (TCB) and transitioned to the RUN state.

pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
like Device Interface Reports, and effect TDISP state changes, like
LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
these are long running operations involving SPDM message passing via the
DOE mailbox.

The path for a TVM to invoke pci_tsm_guest_req() is:
* TSM triggers exit via guest-to-host-interface ABI (implementation specific)
* VMM invokes handler (KVM handle_exit() -> userspace io)
* handler issues request (userspace io handler -> ioctl() ->
  pci_tsm_guest_req())
* handler supplies response
* VMM posts response, notifies/re-enters TVM

This path is purely a transport for messages from TVM to platform TSM. By
design the host kernel does not and must not care about the content of
these messages. I.e. the host kernel is not in the TCB of the TVM.

As this is an opaque passthrough interface, similar to fwctl, the kernel
requires that implementations stay within the bounds defined by 'enum
pci_tsm_req_scope'. Violation of those expectations likely has market and
regulatory consequences. Out of scope requests are blocked by default.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci-tsm.h | 62 +++++++++++++++++++++++++++++++++++++++--
 drivers/pci/tsm.c       | 60 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a5e297677917..a6435aba03f9 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/sockptr.h>
 
 struct pci_tsm;
 struct tsm_dev;
@@ -33,14 +34,15 @@ struct pci_tsm_ops {
 	 * @disconnect: teardown the secure link
 	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
 	 * @unbind: remove a TDI from secure operation with a TVM
+	 * @guest_req: marshal TVM information and state change requests
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
-	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
-	 * lock.
+	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
+	 * and the DSM lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
@@ -51,6 +53,11 @@ struct pci_tsm_ops {
 		struct pci_tdi *(*bind)(struct pci_dev *pdev,
 					struct kvm *kvm, u32 tdi_id);
 		void (*unbind)(struct pci_tdi *tdi);
+		ssize_t (*guest_req)(struct pci_tdi *tdi,
+				     enum pci_tsm_req_scope scope,
+				     sockptr_t req_in, size_t in_len,
+				     sockptr_t req_out, size_t out_len,
+				     u64 *tsm_code);
 	);
 
 	/*
@@ -152,6 +159,46 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
+/**
+ * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
+ *
+ * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
+ * a given TDI. A TSM driver is responsible for maintaining the kernel security
+ * model and limit commands that may affect the host, or are otherwise outside
+ * the typical TDISP operational model.
+ */
+enum pci_tsm_req_scope {
+	/**
+	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
+	 * typical TDISP collateral information like Device Interface Reports.
+	 * No device secrets are permitted, and no device state is changed.
+	 */
+	PCI_TSM_REQ_INFO = 0,
+	/**
+	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
+	 * UNLOCKED->LOCKED, LOCKED->RUN, or other architecture specific state
+	 * changes to support those transitions for a TDI. No other (unrelated
+	 * to TDISP) device / host state, configuration, or data change is
+	 * permitted.
+	 */
+	PCI_TSM_REQ_STATE_CHANGE = 1,
+	/**
+	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
+	 *
+	 * A method to facilitate TVM information retrieval outside of typical
+	 * TDISP operational requirements. No device secrets are permitted.
+	 */
+	PCI_TSM_REQ_DEBUG_READ = 2,
+	/**
+	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
+	 *
+	 * The request may affect the operational state of the device outside of
+	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
+	 * will taint the kernel.
+	 */
+	PCI_TSM_REQ_DEBUG_WRITE = 3,
+};
+
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
@@ -166,6 +213,9 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
 void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 			     struct kvm *kvm, u32 tdi_id);
+ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
+			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
+			  size_t out_len, u64 *tsm_code);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -181,5 +231,13 @@ static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id
 static inline void pci_tsm_unbind(struct pci_dev *pdev)
 {
 }
+static inline ssize_t pci_tsm_guest_req(struct pci_dev *pdev,
+					enum pci_tsm_req_scope scope,
+					sockptr_t req_in, size_t in_len,
+					sockptr_t req_out, size_t out_len,
+					u64 *tsm_code)
+{
+	return -ENXIO;
+}
 #endif
 #endif /*__PCI_TSM_H */
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 39de91a47a26..5e57501f693e 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -353,6 +353,66 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 }
 EXPORT_SYMBOL_GPL(pci_tsm_bind);
 
+/**
+ * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
+ * @pdev: @pdev representing a bound tdi
+ * @scope: caller asserts this passthrough request is limited to TDISP operations
+ * @req_in: Input payload forwarded from the guest
+ * @in_len: Length of @req_in
+ * @req_out: Output payload buffer response to the guest
+ * @out_len: Length of @req_out on input, bytes filled in @req_out on output
+ * @tsm_code: Optional TSM arch specific result code for the guest TSM
+ *
+ * This is a common entry point for requests triggered by userspace KVM-exit
+ * service handlers responding to TDI information or state change requests. The
+ * scope parameter limits requests to TDISP state management, or limited debug.
+ * This path is only suitable for commands and results that are the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
+ *
+ * Returns 0 on success and -error on failure and positive "residue" on success
+ * but @req_out is filled with less then @out_len, or @req_out is NULL and a
+ * residue number of bytes were not consumed from @req_in.  On success or
+ * failure @tsm_code may be populated with a TSM implementation specific result
+ * code for the guest to consume.
+ *
+ * Context: Caller is responsible for calling this within the pci_tsm_bind()
+ * state of the TDI.
+ */
+ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
+			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
+			  size_t out_len, u64 *tsm_code)
+{
+	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tdi *tdi;
+	int rc;
+
+	/* Forbid requests that are not directly related to TDISP operations */
+	if (scope > PCI_TSM_REQ_STATE_CHANGE)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	if (!is_link_tsm(pdev->tsm->tsm_dev))
+		return -ENXIO;
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
+		return rc;
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return -ENXIO;
+	return to_pci_tsm_ops(pdev->tsm)->guest_req(tdi, scope, req_in, in_len,
+						    req_out, out_len, tsm_code);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
+
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
 	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
-- 
2.51.1


