Return-Path: <linux-pci+bounces-33035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8930B13C23
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C34E063D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AC2701BD;
	Mon, 28 Jul 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLmSmbmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDE26D4DD;
	Mon, 28 Jul 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710775; cv=none; b=pic2jpjJXSu/MUo0/XeBm2ZB6JQ3oA1HTDGx8PpfTUZOqvvhNWg8WDexACnDfejEIvq6bJsWz1h1GdApWW97fxV8MyiTuzzpMcDzcE5Y6YiV8KeLkXp4xMuEsg4nku4XSFvRUt6Ds/KqMc+RyZDOMm3XRXesVRj3LnbZjz431YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710775; c=relaxed/simple;
	bh=AqBuQnK0sDfshKqlYHLg/bl0U14MWqk1At9ebxulyvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezWuQ55tFOTBnfMNP74Caa1svAHFNCtEYbuTZHdsIOPLc2RPYaavrfO/8ke+d5DxgeEswfhak7Jh0wDiCPWTlpbKgouu6EzGSP3AQ9tPk0l+uwIXDGQfHYP51L6EVbDU5kz/+lrdwCrF7WR5q+r6YbU7uFflG695LmnRqiPvooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLmSmbmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3109FC4CEE7;
	Mon, 28 Jul 2025 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710775;
	bh=AqBuQnK0sDfshKqlYHLg/bl0U14MWqk1At9ebxulyvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLmSmbmJBslsBOUQm6x1VY/uQhZDigYPp6vu6f8cZnOFKdUgddBGu5LoZYiHoJ/uE
	 VYJSjGusa7UGBn3joUWUEtUQF9W3kamKiA4oQKfVMomuw9MOxUfAyzmUwcS6Xp4JCo
	 r3OstmDVhEs5rEkquJVjIR25JeSNDD1ij81nUF0jhpNgbxy3opqS/dRgLP364cRTcR
	 DvDqfpSrl+511jQ8KDt56t370BxvU5TQuo4iLEgOU9b1qOgFytstpyG+N87XIVYQ4m
	 z4g3NrRiqSjeXZEqK3gfIkYwYgyVMGBqU9WZlysh7e8VK5EvbG9yWsSWLJXX4jaAhy
	 fbe087Qq8IA5w==
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
Subject: [RFC PATCH v1 03/38] tsm: Move dsm_dev from pci_tdi to pci_tsm
Date: Mon, 28 Jul 2025 19:21:40 +0530
Message-ID: <20250728135216.48084-4-aneesh.kumar@kernel.org>
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

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/pci/tsm.c       | 72 ++++++++++++++++++++++++-----------------
 include/linux/pci-tsm.h |  4 +--
 2 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 794de2f258c3..e4a3b5b37939 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -415,15 +415,55 @@ static enum pci_tsm_type pci_tsm_type(struct pci_dev *pdev)
 	return PCI_TSM_INVALID;
 }
 
+/* lookup the Device Security Manager (DSM) pf0 for @pdev */
+static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
+{
+	struct pci_dev *uport_pf0;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return NULL;
+
+	if (pf0 == pdev)
+		return no_free_ptr(pf0);
+
+	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
+	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
+		return no_free_ptr(pf0);
+
+	/*
+	 * For cases where a switch may be hosting TDISP services on
+	 * behalf of downstream devices, check the first usptream port
+	 * relative to this endpoint.
+	 */
+	if (!pdev->dev.parent || !pdev->dev.parent->parent)
+		return NULL;
+
+	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
+	if (!uport_pf0->tsm)
+		return NULL;
+	return pci_dev_get(uport_pf0);
+}
+
 /**
  * pci_tsm_initialize() - base 'struct pci_tsm' initialization
  * @pdev: The PCI device
  * @tsm: context to initialize
  */
-void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
+int pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
 {
+	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
+	if (!dsm_dev)
+		return -EINVAL;
+
 	tsm->type = pci_tsm_type(pdev);
 	tsm->pdev = pdev;
+	/*
+	 * No reference needed because when we destroy
+	 * dsm_dev all the tdis get destroyed before that.
+	 */
+	tsm->dsm_dev = dsm_dev;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_tsm_initialize);
 
@@ -447,7 +487,8 @@ int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
 	}
 
 	tsm->state = PCI_TSM_INIT;
-	pci_tsm_initialize(pdev, &tsm->tsm);
+	if (pci_tsm_initialize(pdev, &tsm->tsm))
+		return -ENODEV;
 
 	return 0;
 }
@@ -612,32 +653,6 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 }
 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
 
-/* lookup the Device Security Manager (DSM) pf0 for @pdev */
-static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
-{
-	struct pci_dev *uport_pf0;
-
-	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
-	if (!pf0)
-		return NULL;
-
-	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
-	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
-		return no_free_ptr(pf0);
-
-	/*
-	 * For cases where a switch may be hosting TDISP services on
-	 * behalf of downstream devices, check the first usptream port
-	 * relative to this endpoint.
-	 */
-	if (!pdev->dev.parent || !pdev->dev.parent->parent)
-		return NULL;
-
-	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
-	if (!uport_pf0->tsm)
-		return NULL;
-	return pci_dev_get(uport_pf0);
-}
 
 /* Only implement non-interruptible lock for now */
 static struct mutex *tdi_ops_lock(struct pci_dev *pf0_dev)
@@ -695,7 +710,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
 		return -ENXIO;
 
 	tdi->pdev = pdev;
-	tdi->dsm_dev = dsm_dev;
 	tdi->kvm = kvm;
 	pdev->tsm->tdi = tdi;
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 1920ca591a42..0d4303726b25 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -38,7 +38,6 @@ enum pci_tsm_type {
  */
 struct pci_tdi {
 	struct pci_dev *pdev;
-	struct pci_dev *dsm_dev;
 	struct kvm *kvm;
 };
 
@@ -56,6 +55,7 @@ struct pci_tdi {
  */
 struct pci_tsm {
 	struct pci_dev *pdev;
+	struct pci_dev *dsm_dev;
 	enum pci_tsm_type type;
 	struct pci_tdi *tdi;
 };
@@ -173,7 +173,7 @@ void pci_tsm_core_unregister(const struct pci_tsm_ops *ops);
 int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
 			 const void *req, size_t req_sz, void *resp,
 			 size_t resp_sz);
-void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
+int pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
 int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id);
 int pci_tsm_unbind(struct pci_dev *pdev);
-- 
2.43.0


