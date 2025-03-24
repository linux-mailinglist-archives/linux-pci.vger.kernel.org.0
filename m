Return-Path: <linux-pci+bounces-24514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE8A6D805
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99D27A52BB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8A25DB15;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6H2RGj5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBF19E7D0;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810678; cv=none; b=V8WOAMF7jL5u82Fx9Eor/qCbYkIxG4jq4peU9o5kKUS+On0+5jv5RhHOlp7mhuZW5/U1zrjmN1akHaOYSPXbp7zCfzd3YRu5AAOwQ0l7y94AyCCN8ZqPzn8TKHh3uliGlwTg4ga8VRIvOCcq12nI3WUq6s6A0ct0FBaoh+oy7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810678; c=relaxed/simple;
	bh=tiFBT4izYq0mO62xpAVSkd1XSTz0IJZxX8Q1ISdVDLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeju6zrN+sKTs5FPxUqN3cIn+3yxprU8hytK+jzbMZEdnBozs8noepBGfZMp5KOndpPBS35KX/wFACNy6BMbyESkX20bk3EdAty0a0qKrD3uZtvzlyVJo8nKeiwbCXUuK/YkDq71XNFC/MjBTAO5CjKt+Qtb+/BIlGTBbMn7RYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6H2RGj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B62CC4CEE4;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742810678;
	bh=tiFBT4izYq0mO62xpAVSkd1XSTz0IJZxX8Q1ISdVDLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D6H2RGj5OEpuVc/lWpqdMEWt0Al65wCk+ZzTtlCq0Uj2B2eUnGeXVw3UKfWVdHzZl
	 rMXzskAK+fMRrN89fRpJD74+kNynbhJzqUx9ISbFbXFKJ75szVhcnBVNO8JIdT8NbC
	 uzs8q/1oLUAqA40aDHZkZQI1ytZHncpOZx9a5o5GUD/ZF8uiFgfTCMSzyae2jjNC/y
	 6vrMi5jH8qGwv6t7N0OhNXk0oIkzc2woTdr3f8nU8nQSZTKJaVFX2QeLECVSOg5lH8
	 df6rrz/ND9T1Qmn/hlNUIOXBuDeHFakbruhJXWUACXL9vkUBVId8RqLeUxgOXvagDW
	 a2825xibbDXWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E22CC3600C;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 24 Mar 2025 15:34:37 +0530
Subject: [PATCH v2 3/3] PCI: qcom-ep: Mask PTM_UPDATING interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-pcie-ptm-v2-3-c7d8c3644b4a@linaro.org>
References: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
In-Reply-To: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=S+C5W5xt7FcF/117DRTgds/MCdeKQEYkVZEdwTlTN4o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn4S4z77panSiJ5a5utTxcnz9RDExFPZrdJE+t7
 7aQw3DzWiCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ+EuMwAKCRBVnxHm/pHO
 9SkSB/9DzYwUpInvbToiGbQhOXX0ojfZSZ264VjDinBjQJRBMOGDEzY68XUGw5+CTkf7a59LHK9
 uoV7eim/pA6woy+3duYaAa4KkaUT/b7Y5u8xiWR1hEOUz1nx5+9KX+eGsEbeBtfzWDgL94wRZ4M
 VRHwwSR6qG8GWt+Nligg4gQ2ht8qpSALXWZmAHyx8sOLpjMmhpoGnIjf4WKR1TqQYEhQa9Q/dCe
 zqqneATiXNz639c0YiV/ALUI9BesXSkH8NfuzvLzAfct69WulfFJERGROkE65UshxY8PeJDg23Y
 WkVdja/Xq2WSHfo9shIhlXw2a6nFrJP8gs7DARwUs6Hzy0mC
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When PTM is enabled, PTM_UPDATING interrupt will be fired for each PTM
context update, which will be once every 10ms in the case of auto context
update. Since the interrupt is not strictly needed for making use of PTM,
mask it to avoid the overhead of processing it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825fa5da22976c8020f96ee5faa5462..940edb7be1b920840556246613f186769aca4159 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -60,6 +60,7 @@
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 #define PARF_INT_ALL_5_MASK			0x2dcc
+#define PARF_INT_ALL_3_MASK			0x2e18
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_DOWN			BIT(1)
@@ -132,6 +133,9 @@
 /* PARF_INT_ALL_5_MASK fields */
 #define PARF_INT_ALL_5_MHI_RAM_DATA_PARITY_ERR	BIT(0)
 
+/* PARF_INT_ALL_3_MASK fields */
+#define PARF_INT_ALL_3_PTM_UPDATING		BIT(4)
+
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
 #define ELBI_CS2_ENABLE				0xa4
@@ -497,6 +501,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_5_MASK);
 	}
 
+	val = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_3_MASK);
+	val &= ~PARF_INT_ALL_3_PTM_UPDATING;
+	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_3_MASK);
+
 	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);

-- 
2.43.0



