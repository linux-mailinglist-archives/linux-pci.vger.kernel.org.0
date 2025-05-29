Return-Path: <linux-pci+bounces-28650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A7AC7EE9
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1624B1C02F84
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA7225403;
	Thu, 29 May 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smbrmo4K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB97211A19;
	Thu, 29 May 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525892; cv=none; b=Dl2TDFnrn8jzckOm3cWgXgEJXqVF4s12ScgTI5iln1KgzcaBN0+s23unkeeefgEivV75YwJ40G4cV7mWHmFUq1+MCOEjayey9m7TEuE6jHwkQ7+ovfjvQMbUXk9qMt1O2E6e9udGBJqRQRdATIacjE26Fpvef788+jOrgtM8RrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525892; c=relaxed/simple;
	bh=LY04EkKCdI/ocKGgI1W5jQdahxO+d4WrIUTVEUwTMhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y43Tc2HHH5TzUYtb9YVFQx7QyvgSzPytG78ojDc5EXx5vmE19b2ic7H93+LGZbC2rawjBkPu7Gge7jNXdsL5/mIwGBCkZDz6jq9cDl/a04SU9LJ17zh/vgw39EoYqdygNd2/gFkzMt63+1xOwK8EBpRnyomPe/5kXRBWl6AN6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smbrmo4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECF6C4CEE7;
	Thu, 29 May 2025 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525891;
	bh=LY04EkKCdI/ocKGgI1W5jQdahxO+d4WrIUTVEUwTMhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smbrmo4K26g3nSy3HOrifYDRLbY7c1dMcRgrxXikeIsYgdsQc3NW7yCM8dUmCIldq
	 aBFaEVkhFmJWQNSy0usTpX4K4uSQcXGOpMSQQqi1aol58RsFRqPYGYIOK4+2yIHrZl
	 LxgEQilkzf1M0unoJQDI6RgEg2sUJpanAlPs+Sbes0qEUprnk7WGTMcAcKOdEQ3Pkf
	 g7utjgMoM8aEnXK2rMvMFcbvrkN5PJzM8RsjqItZCvP+TDI+37NE8M8xk1hLdv8oVd
	 1nc0blMw9XkoRIZFh5nDQQZxOR/U/zS4mT4U6fPtaDWRPbIacqTT1QIC0MxX7UgEE4
	 gV5/dad0Xis8A==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	lukas@wunner.de,
	suzuki.poulose@arm.com,
	sameo@rivosinc.com,
	jgg@nvidia.com,
	zhiw@nvidia.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH 1/3] coco: tsm: Add tsm_bind/unbind helpers
Date: Thu, 29 May 2025 19:07:54 +0530
Message-ID: <20250529133757.462088-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <yq5a5xhj5yng.fsf@kernel.org>
References: <yq5a5xhj5yng.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be later used by iommufd bind a tdi to guest.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/tsm-core.c | 18 ++++++++++++++++++
 include/linux/tsm.h          |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index bd9e09b07412..0a7c9aa46c56 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
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


