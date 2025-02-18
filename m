Return-Path: <linux-pci+bounces-21736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1CA3A019
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47090189482C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA126B099;
	Tue, 18 Feb 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi1FAJjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0826AA8D;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889418; cv=none; b=DdjZ9Y34dQnPStZziv9+VjLjEEmHL++WQDNAC3TSKu/SFcqvHzqB0tqxP/lHwl6lTkulhN9IiW7t+QnYCnGFHeJ2Xf6JEQYsSxwUMwyD6jBVQed08D8nsqHA1l6qgrbNYFcn1p2vcVTd5nEZs0PA5BQihkXEyVxIYjC+oA7jX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889418; c=relaxed/simple;
	bh=96dzHbNUlonjbIF4OjJogOraBYUUAqyVClMsMXe91/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYP3kBJKfR19+4Sj4rRTXfl4k+DvNNik+zpLssh75R2E2GF7ZNZaK0IjSRfUgKKArijwGvxYBaZYfPExmdYJ572B+rjs5v0lRM1AV1Fe6IX5BTepPPOYxXH3UUYX6e0DdUYXv/VCv0SHgMVkEf8EouJM+guNfILqQyWmkB8or1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi1FAJjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7882BC4CEEC;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889418;
	bh=96dzHbNUlonjbIF4OjJogOraBYUUAqyVClMsMXe91/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mi1FAJjdE5tCGT+xgGO+2PtN+j4OMI4wQjoObwvkV+7oSqqLTI9nt/kXTO9ajuliB
	 W2DfOFP4siqKsKWg4IeVTVFVbLPJ/WoifbO7m8VcwmYUPuTLsCOHm0YgMLEfdYt859
	 odnppm7yEz+HFsZJz+B5cQZQv6lZdMNw6r7GXqK8OprqJrfmWvLlJN+ancb+33hKZC
	 rz+S67v0YrRRukViKCmg9n2FYz0r0i77dwaBsm19YU/tKDcrUxYLFdHAKcSBx6RhZa
	 N/m7NjSYWHK5gYT6varQ3sF+UPFvLFbzTU9WY8jho2OJMqlHhIjFbzf0zGbBDfJe6A
	 aZ4uQXgkWheNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F5C02198;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 18 Feb 2025 20:06:43 +0530
Subject: [PATCH 4/4] PCI: qcom-ep: Mask PTM_UPDATING interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pcie-qcom-ptm-v1-4-16d7e480d73e@linaro.org>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
In-Reply-To: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>, 
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=X8FrHGG/Y5bqtzA78r7NFQEcJV50dm29EwABf+RgvWo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBntJsHhjGbHY6Q7I/y/ze6vd3blhN1A0HrKeF+F
 yr/ctlRT0KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ7SbBwAKCRBVnxHm/pHO
 9UzoCACPUS9F6y/oWa2xHAIMf40x74TmzYyirduM/fPhPjn597iCw0IwZxVLOEI3IRYlnVT1RDo
 mcd10VKMQ8VlNnJ6x6frBvsGlur7q3MQUIsXcV+THeCgIKy3OgtpFTtTK6bhZn37Zrd+x0PcNpV
 y1yl7ZfgaYktanFCAigjXnpuMsmP+tuxXilWIwARjnCON+sVJ9qVyGaa6yRoUR/YCWUbQmLTM2H
 PAbIM1OB/mBew1IK24SX65V+vKmT3MjdFlhSMmcrLDugije2FR0DUSTUqffXehJjYmMZ1OHV+eR
 MxuVOFB27w1mdmz7fWLLwKEMcOgDestH4kocGjtFMi3tE/8U
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
index c08f64d7a825..940edb7be1b9 100644
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
2.25.1



