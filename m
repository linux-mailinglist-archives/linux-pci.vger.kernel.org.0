Return-Path: <linux-pci+bounces-33033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E063B13C1A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614FB167052
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8DA26D4CF;
	Mon, 28 Jul 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv2nI0qE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB626B743;
	Mon, 28 Jul 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710764; cv=none; b=n7g72Ye8PjC+10q0/ZHzmYREVyJ1DG7i/PuG83D6cNFC+mINMj7nzufaoOtJAZ5E5QWU9FA2JHF6jTbcCf8ZspCwbFw/1cuEgmncGcCMnHWqfe9dmvfx8vjiYwO9J+Og1irojaNivBvZkd1k1+TbCXIUivWEeZ01Z6Ifyg1SiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710764; c=relaxed/simple;
	bh=r9I5x3rhdwoNdyxPe37nFGR+zoeXLnHyQ8tCPsAsayQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9KcBHGxUnWK0oKJ5g2j8PPxzcGSelrx8BSxMHE+PMt5e6cwagPFSH45Vrv1flnm9iO8QW31k76iraL9+J8leb4Xi5+RMkBZ3dpeDTWrZcVScm8IVnMtMt7ONSQ8cOgGxzppKtNAkw1On8iVTbDtlT3ZsnNMMbEnlcGlHGQp8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv2nI0qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F85C4CEF7;
	Mon, 28 Jul 2025 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710763;
	bh=r9I5x3rhdwoNdyxPe37nFGR+zoeXLnHyQ8tCPsAsayQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tv2nI0qE/IofMktgF1TJRe/ckGstPmaO7cm3Cquh+AUB0qZcCTfrJ5yqe9/eRld8m
	 3ZKrFwX9mmQMnPnUE7eWcvIzfjb9C4zQI8NZXYpaRKLYXmdI2Qvd4GzVOXAOZVafUK
	 5k5rToNhHrzV34LQWswGd3X07+rxuTcSveo7Lbnz2Uv484ptb+G6z9VNkMYY14+Rb2
	 n4i+nPtazkHvIhkUP5m1gdDnbQ7M9v9CVZ/zLCj8Bp5dbpikOhPN2MqGigpI2R4LgP
	 DCgy4UDbDQ9amdvcIWvGD2cUmwh0qA1CBRsY2gFcLbVifNLveHsqk9jYGnhCClnmUB
	 y9BqQEBjGNOEA==
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
Subject: [RFC PATCH v1 01/38] tsm: Add tsm_bind/unbind helpers
Date: Mon, 28 Jul 2025 19:21:38 +0530
Message-ID: <20250728135216.48084-2-aneesh.kumar@kernel.org>
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

This will be later used by iommufd to bind a tdi to guest.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/host/tsm-core.c | 18 ++++++++++++++++++
 include/linux/tsm.h               |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index bd9e09b07412..0a7c9aa46c56 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -116,6 +116,24 @@ void tsm_ide_stream_unregister(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
 
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
+}
+EXPORT_SYMBOL_GPL(tsm_bind);
+
+int tsm_unbind(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_unbind(to_pci_dev(dev));
+}
+EXPORT_SYMBOL_GPL(tsm_unbind);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_core_dev *core = container_of(dev, typeof(*core), dev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 915c4c8b061b..0aab8d037e71 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -118,6 +118,9 @@ struct tsm_core_dev *tsm_register(struct device *parent,
 void tsm_unregister(struct tsm_core_dev *tsm_core);
 struct pci_dev;
 struct pci_ide;
+struct kvm;
 int tsm_ide_stream_register(struct pci_dev *pdev, struct pci_ide *ide);
 void tsm_ide_stream_unregister(struct pci_ide *ide);
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
+int tsm_unbind(struct device *dev);
 #endif /* __TSM_H */
-- 
2.43.0


