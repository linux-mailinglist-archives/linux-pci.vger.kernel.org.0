Return-Path: <linux-pci+bounces-11474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BF94B6BE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 08:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6613284104
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B2187FE5;
	Thu,  8 Aug 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFRtuBlf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E0181328
	for <linux-pci@vger.kernel.org>; Thu,  8 Aug 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098671; cv=none; b=an7RTRC0WfgbZQPr1Daf7WsYldXDeLH+4gkyKxZ9jrI2Xpo4CSp7YAO1QWBXad0UzLCWBVOyyy8xaIBWjR/+yr6gaX0ylE4+Qpf7znPRSwDOphFnUCpWo6Hx2Ae5ObfFPs8yZWpcsIY6Ty7BSuuWmsyYzHOY722l12293W68xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098671; c=relaxed/simple;
	bh=8tcV6h51qTImYpVkN/XYbqQUsKUdeQdzBSWpJGgvF2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hrcszrorekO+w61LJ/pmcRJBh9xo/jRR0WvfxL82iYFn98CvarJyqktf1TM5D98DlbLlrD58s+zKTKV2QlIQuD6beEoofq0xNOE1qfDaDZg2ba80mdi1mkfwGIb57d2YIXJPWHkTyh0Hp8w7Or5Gi1UvClvs/29Yx+DQQX+13Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFRtuBlf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc65329979so6870525ad.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723098668; x=1723703468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL02WkDHX6MB6U3tlx7TFw4sDSoGDOr7FVNC/xGND0g=;
        b=EFRtuBlfxR6nc4Hg3OD7yMr7IwCyft5fiUEENZvPoCJeGsEJHr7SbT6taKPblynriB
         ldBAmtanuIfDs3sKyDeYZmFK5U+DLQ/yjnfYCYfmp6XYMaqP4oYa6SgA4RsrMCoOA1oO
         uvnQZiMO8ltU5j2XoEhlH0LIe+0jQCHkYnNs3uaTh7Cb2JVPU02SwUOy1lAeASTdRg9X
         kUGu6RfpHMGAZFrDg9W9GCnxfz0p5HfJCGcmF2Z6GQ6W3SYuT8Nvlo7grFhrqQDpia9L
         nApdLqIuKrCR3NLax1S0MOkJbuGNngZb2g4k3IuVuqOlF5O1kBEllh6eeZgnfwTAWNgg
         kAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098668; x=1723703468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uL02WkDHX6MB6U3tlx7TFw4sDSoGDOr7FVNC/xGND0g=;
        b=U0xbvdeDPi76gpFxH9yFDV1esLKbtqWVNqIuOnHl5rnZUkqcQfzR4qYxFk3ozBY4HL
         OxVcVWKYUYqKvibY3OUcp7FF7BYV0/CDG4Ub1V7tGIe5VkCGN559JIWuXBbzlBEJ5ES6
         un8qkx/t8dDRvO0i/QXhZSG0Vw/dkn1O6XFyvnbP2trBWM/Dou3mCFq5oyAjdUW5DlFh
         dDdA9iiKHbSASj/ne2pBOhxRTYowtIb+gzANClI8Xp9WCqFnGUCoS8MuOnLgM7TGVSek
         4kpYdvtxGxgqJ34iqfyNeh4mPBey2wpQqmIRc0XMYPql11JBdyzRcaJlbFd4rtcgnTVy
         0+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXc/GMCRSCIoRnF7g6oAFvBcBsAz06z8sOi9neTw3qd5dxT8zQ9qVD9g7vpquQMrM4Vysxs+11x8oszAUoesPwXAYKeFFm4fYpy
X-Gm-Message-State: AOJu0YxGkYfOX7F6DIyQp2N5oF0ch4Z3KbS/p5op5jgpO7YpBW0zg9AM
	yq5nFckeONqtpeL9q0HIuGQaHnZ1SlO0NnVzi+8IHb5X7ONwmrz30DrnCsmPTrwoJZ5qDNyN244
	=
X-Google-Smtp-Source: AGHT+IGQt0i5NhwN7Ci91sWmaz9DV0yumS/TmjkZMx5oG6iE3KgHew5o9t+jkvkw0fUPz38IFnljNw==
X-Received: by 2002:a17:903:120b:b0:1fc:3daa:52 with SMTP id d9443c01a7336-20095224ad2mr14708325ad.11.1723098668125;
        Wed, 07 Aug 2024 23:31:08 -0700 (PDT)
Received: from localhost.localdomain ([120.60.136.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929ad84sm116520415ad.270.2024.08.07.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 23:31:07 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P SoC
Date: Thu,  8 Aug 2024 12:00:57 +0530
Message-Id: <20240808063057.7394-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SA8775P SoC has support for the hardware parity check feature on the MHI
RAM (entity that holds MHI registers etc...). But due to a hardware bug in
the parity check logic, the data parity error interrupt is getting
generated all the time when using MHI. So the hardware team has suggested
disabling the parity check error to workaround the hardware bug.

So let's mask the parity error interrupt in PARF_INT_ALL_5_MASK register.

Fixes: 58d0d3e032b3 ("PCI: qcom-ep: Add support for SA8775P SOC")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..a9b263f749b6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -58,6 +58,7 @@
 #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_CFG			0x2c00
+#define PARF_INT_ALL_5_MASK			0x2dcc
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
 #define PARF_INT_ALL_LINK_DOWN			BIT(1)
@@ -127,6 +128,9 @@
 /* PARF_CFG_BITS register fields */
 #define PARF_CFG_BITS_REQ_EXIT_L1SS_MSI_LTR_EN	BIT(1)
 
+/* PARF_INT_ALL_5_MASK fields */
+#define PARF_INT_ALL_5_MHI_RAM_DATA_PARITY_ERR	BIT(0)
+
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
 #define ELBI_CS2_ENABLE				0xa4
@@ -158,10 +162,12 @@ enum qcom_pcie_ep_link_status {
  * struct qcom_pcie_ep_cfg - Per SoC config struct
  * @hdma_support: HDMA support on this SoC
  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
+ * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error check
  */
 struct qcom_pcie_ep_cfg {
 	bool hdma_support;
 	bool override_no_snoop;
+	bool disable_mhi_ram_parity_check;
 };
 
 /**
@@ -480,6 +486,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
+	if (pcie_ep->cfg && pcie_ep->cfg->disable_mhi_ram_parity_check) {
+		val = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_5_MASK);
+		val &= ~PARF_INT_ALL_5_MHI_RAM_DATA_PARITY_ERR;
+		writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_5_MASK);
+	}
+
 	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
@@ -901,6 +913,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
 	.hdma_support = true,
 	.override_no_snoop = true,
+	.disable_mhi_ram_parity_check = true,
 };
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
-- 
2.25.1


