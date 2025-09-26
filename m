Return-Path: <linux-pci+bounces-37084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E5BA2C7C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F0A1C01009
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D890287271;
	Fri, 26 Sep 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH8zptJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD522868AD
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871823; cv=none; b=fhybR97r2Mkzx7+U5GPnMHsN6kEKzGSQM4ecnv3lM+1b4hhgqS16G4HjZo4feIKhHPQWryDRI96KeXD26FRlQcNz4sKU/DUrct5JWF7X0zOi1kTERB0GKg6eHEXtsuCkbaXpg7bwz/dCQSVL/qwx/1euNt6wGd/K32qxGDqd8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871823; c=relaxed/simple;
	bh=lihxpIMyiYQyOiFumHF1rN7h6XSKOa+ADOFBNYBSWmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2TpYrmyWvuAhhthjHuaFcnwA+nzL2jG+uXaPc2699cJcLHodpaenY90d8tiAyd2wIKCuRRCM5hdPgvTBRsNHakEnhPktva61CAivIyHywydZ5dzNjmfgQ9su+ybXzsAsv9xuFmr7/zXsbmr1QSUe6uC4+zJRuV2BKZg9ciWlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH8zptJD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-267facf9b58so14238775ad.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871821; x=1759476621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrOxWiHrOu/Wl7h0gaVf9cIOyykBhAug5LCU/y/0I4Q=;
        b=mH8zptJD5OIZKuNRUq4+3H1Cotw557egOPZMko7dWKrKqAIxi+bCuLzQpTeo3DsnZa
         LUneR4DQQUR4LqwBlHqto+98esYr+r5WnqH9ICcpswbs5q851+3kc2Vw70tKJk9kU2x2
         pTSdK/w15bdWFgLi6HX++XwH2HfjzqBBb7oLMOBFpbM8PJbBVGxXWnB/PKDjfuVAunc8
         X5pcDVfGIVp3d4wVdRsXY37AdTV9i89zecVraIAIEs7nxzcL1k4rJFfl+3DHYuQxoSyT
         FS4DK3AzlfRlUVgWB1jRvrq3qc097vJj9+c8OMN7jg+ZeaMPD0VUgyXVdZY9HZ1/xq2a
         uIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871821; x=1759476621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrOxWiHrOu/Wl7h0gaVf9cIOyykBhAug5LCU/y/0I4Q=;
        b=dQSOsoPndNF9zUK0nbvyiIvvBNr86f+Uy9aBiEk4DWzGUakJTosHXK7Lj7pl8Nqw73
         7Kp4/oYub/3+blzcbkHNtqB7b4vVRH6jNNvtTsesG0ITyNeFPiaKy4Q+jWEmLnDpNnXe
         FmlT9f8sOVZfaROgBwhujNbE41in+cOA709GH09CL+j7TxBSb8Sxi3XUKrpcqOyQNcs5
         A+U3pp3vVhJOZA4TiedimOtlyWH+4zKl1GK16AKuLm/1j8pcQ94Y6Mac8gqMPMDiumP7
         ZNKyxFIdlk3C99T+10+rcDi71s3oZ+qMfechqKUgQuqTKIGmDGH9XQM7J4NkckbzXWeS
         Yhdg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTF//UoFtCOVv4UooESAHs+KIDPnC9CUV4+o9UggQHAOk5B7zglhMKzXz4FKT5nvcGU5CUX6JLsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wFcSg/msyrhQB9xqtyxVDb/EWsUMr9V4nTFvtH9xT8A++V7H
	8Z7RAHDn725/kOFEhdZ42/RaLfdiZUdrHfKd4KXGb2TAMtsWUWQMTgO/
X-Gm-Gg: ASbGncs3FE0mxiC7crD/pAKh+5HZ1KeVUijfjvXXdb+1xILajhcW+u0gvuOD1dkoDiu
	xfmSzyw2vjO28OR+tkbLa/SmBBFTsoyqdD5UGZH4yupYUEIK158ck6OMd794LS/yUfnTKpkiI8F
	uvtx0YFqS2LirE64SX53sacniBph6EpiW9Qxf6r42CSH4W0V0Vguf82lGOom5NlaqiroZrRNUmb
	XS/vxfqkgZKbH6voOfQ4gd1qhfhLeqBZ6ZRq+olKP7RobBUjO/LPLOog1s3VNqbxldIR1SS2qHF
	SK3hfz5CtSenlbQXv/V+B5AsQICj6VYCMdq8+Bgfb6qMEtkZi3zIL5I3EISZfa3v7UblN9yR140
	ReJjKtQWYA4WSUYyMHIVo
X-Google-Smtp-Source: AGHT+IE+CU63RMRJ3Okrq3A6S2HUdCCZU8QN3LT/sYHTcNpsGnNXxTUjqoCCTa+kQD0qqNn6+qTeOg==
X-Received: by 2002:a17:903:b47:b0:25c:ae94:f49e with SMTP id d9443c01a7336-27ed4a91f06mr65238255ad.37.1758871820534;
        Fri, 26 Sep 2025 00:30:20 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a98b9sm44083065ad.111.2025.09.26.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:30:19 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 4/5] PCI: tegra: Use BIT() and GENMASK() macros for register definitions
Date: Fri, 26 Sep 2025 12:57:45 +0530
Message-ID: <20250926072905.126737-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926072905.126737-1-linux.amoon@gmail.com>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace opencode masking and shifting bit operations with standard BIT()
and GENMASK() macros. This improves code readability and maintainability
by removing magic numbers and resolving checkpatch.pl warnings.

Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: New patch in this series
---
 drivers/pci/controller/pci-tegra.c | 129 +++++++++++++++--------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b0056818a203..02cee0763396 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -13,6 +13,7 @@
  * Author: Thierry Reding <treding@nvidia.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -84,17 +85,17 @@
 #define AFI_MSI_EN_VEC(x)	(0x8c + ((x) * 4))
 
 #define AFI_CONFIGURATION		0xac
-#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
-#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
+#define  AFI_CONFIGURATION_EN_FPCI		BIT(0)
+#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	BIT(31)
 
 #define AFI_FPCI_ERROR_MASKS	0xb0
 
 #define AFI_INTR_MASK		0xb4
-#define  AFI_INTR_MASK_INT_MASK	(1 << 0)
-#define  AFI_INTR_MASK_MSI_MASK	(1 << 8)
+#define  AFI_INTR_MASK_INT_MASK	BIT(0)
+#define  AFI_INTR_MASK_MSI_MASK	BIT(8)
 
 #define AFI_INTR_CODE			0xb8
-#define  AFI_INTR_CODE_MASK		0xf
+#define  AFI_INTR_CODE_MASK		GENMASK(3, 0)
 #define  AFI_INTR_INI_SLAVE_ERROR	1
 #define  AFI_INTR_INI_DECODE_ERROR	2
 #define  AFI_INTR_TARGET_ABORT		3
@@ -113,32 +114,32 @@
 #define AFI_INTR_SIGNATURE	0xbc
 #define AFI_UPPER_FPCI_ADDRESS	0xc0
 #define AFI_SM_INTR_ENABLE	0xc4
-#define  AFI_SM_INTR_INTA_ASSERT	(1 << 0)
-#define  AFI_SM_INTR_INTB_ASSERT	(1 << 1)
-#define  AFI_SM_INTR_INTC_ASSERT	(1 << 2)
-#define  AFI_SM_INTR_INTD_ASSERT	(1 << 3)
-#define  AFI_SM_INTR_INTA_DEASSERT	(1 << 4)
-#define  AFI_SM_INTR_INTB_DEASSERT	(1 << 5)
-#define  AFI_SM_INTR_INTC_DEASSERT	(1 << 6)
-#define  AFI_SM_INTR_INTD_DEASSERT	(1 << 7)
+#define  AFI_SM_INTR_INTA_ASSERT	BIT(0)
+#define  AFI_SM_INTR_INTB_ASSERT	BIT(1)
+#define  AFI_SM_INTR_INTC_ASSERT	BIT(2)
+#define  AFI_SM_INTR_INTD_ASSERT	BIT(3)
+#define  AFI_SM_INTR_INTA_DEASSERT	BIT(4)
+#define  AFI_SM_INTR_INTB_DEASSERT	BIT(5)
+#define  AFI_SM_INTR_INTC_DEASSERT	BIT(6)
+#define  AFI_SM_INTR_INTD_DEASSERT	BIT(7)
 
 #define AFI_AFI_INTR_ENABLE		0xc8
-#define  AFI_INTR_EN_INI_SLVERR		(1 << 0)
-#define  AFI_INTR_EN_INI_DECERR		(1 << 1)
-#define  AFI_INTR_EN_TGT_SLVERR		(1 << 2)
-#define  AFI_INTR_EN_TGT_DECERR		(1 << 3)
-#define  AFI_INTR_EN_TGT_WRERR		(1 << 4)
-#define  AFI_INTR_EN_DFPCI_DECERR	(1 << 5)
-#define  AFI_INTR_EN_AXI_DECERR		(1 << 6)
-#define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
-#define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
+#define  AFI_INTR_EN_INI_SLVERR		BIT(0)
+#define  AFI_INTR_EN_INI_DECERR		BIT(1)
+#define  AFI_INTR_EN_TGT_SLVERR		BIT(2)
+#define  AFI_INTR_EN_TGT_DECERR		BIT(3)
+#define  AFI_INTR_EN_TGT_WRERR		BIT(4)
+#define  AFI_INTR_EN_DFPCI_DECERR	BIT(5)
+#define  AFI_INTR_EN_AXI_DECERR		BIT(6)
+#define  AFI_INTR_EN_FPCI_TIMEOUT	BIT(7)
+#define  AFI_INTR_EN_PRSNT_SENSE	BIT(8)
 
 #define AFI_PCIE_PME		0xf0
 
 #define AFI_PCIE_CONFIG					0x0f8
-#define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
-#define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
-#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK	(0xf << 20)
+#define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		BIT((x) + 1)
+#define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		GENMASK(3, 1)
+#define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK	GENMASK(23, 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_SINGLE	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_420	(0x0 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_X2_X1	(0x0 << 20)
@@ -149,79 +150,79 @@
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
-#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		(1 << ((x) + 29))
-#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		(0x7 << 29)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		BIT((x) + 29)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		GENMASK(31, 29)
 
 #define AFI_FUSE			0x104
-#define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
+#define  AFI_FUSE_PCIE_T0_GEN2_DIS	BIT(2)
 
 #define AFI_PEX0_CTRL			0x110
 #define AFI_PEX1_CTRL			0x118
-#define  AFI_PEX_CTRL_RST		(1 << 0)
-#define  AFI_PEX_CTRL_CLKREQ_EN		(1 << 1)
-#define  AFI_PEX_CTRL_REFCLK_EN		(1 << 3)
-#define  AFI_PEX_CTRL_OVERRIDE_EN	(1 << 4)
+#define  AFI_PEX_CTRL_RST		BIT(0)
+#define  AFI_PEX_CTRL_CLKREQ_EN		BIT(1)
+#define  AFI_PEX_CTRL_REFCLK_EN		BIT(3)
+#define  AFI_PEX_CTRL_OVERRIDE_EN	BIT(4)
 
 #define AFI_PLLE_CONTROL		0x160
-#define  AFI_PLLE_CONTROL_BYPASS_PADS2PLLE_CONTROL (1 << 9)
-#define  AFI_PLLE_CONTROL_PADS2PLLE_CONTROL_EN (1 << 1)
+#define  AFI_PLLE_CONTROL_BYPASS_PADS2PLLE_CONTROL BIT(9)
+#define  AFI_PLLE_CONTROL_PADS2PLLE_CONTROL_EN BIT(1)
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
 #define RP_ECTL_2_R1	0x00000e84
-#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		GENMASK(15, 0)
 
 #define RP_ECTL_4_R1	0x00000e8c
-#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	GENMASK(31, 16)
 #define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
 
 #define RP_ECTL_5_R1	0x00000e90
-#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_6_R1	0x00000e94
-#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_2_R2	0x00000ea4
 #define  RP_ECTL_2_R2_RX_CTLE_1C_MASK	0xffff
 
 #define RP_ECTL_4_R2	0x00000eac
-#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	GENMASK(31, 16)
 #define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
 
 #define RP_ECTL_5_R2	0x00000eb0
-#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	GENMASK(31, 0)
 
 #define RP_ECTL_6_R2	0x00000eb4
-#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	GENMASK(31, 0)
 
 #define RP_VEND_XP	0x00000f00
-#define  RP_VEND_XP_DL_UP			(1 << 30)
-#define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
-#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
-#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
+#define  RP_VEND_XP_DL_UP			BIT(30)
+#define  RP_VEND_XP_OPPORTUNISTIC_ACK		BIT(27)
+#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	BIT(28)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	GENMASK(25, 18)
 
 #define RP_VEND_CTL0	0x00000f44
-#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	GENMASK(15, 12)
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
 
 #define RP_VEND_CTL1	0x00000f48
-#define  RP_VEND_CTL1_ERPT	(1 << 13)
+#define  RP_VEND_CTL1_ERPT	BIT(13)
 
 #define RP_VEND_XP_BIST	0x00000f4c
-#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	(1 << 28)
+#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	BIT(28)
 
 #define RP_VEND_CTL2 0x00000fa8
-#define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
+#define  RP_VEND_CTL2_PCA_ENABLE BIT(7)
 
 #define RP_PRIV_MISC	0x00000fe0
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
-#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		GENMASK(3, 1)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		GENMASK(3, 0)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	GENMASK(22, 16)
 #define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
-#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
-#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		BIT(23)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	GENMASK(30, 24)
 #define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
-#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		BIT(31)
 
 #define RP_LINK_CONTROL_STATUS			0x00000090
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
@@ -232,22 +233,22 @@
 #define PADS_CTL_SEL		0x0000009c
 
 #define PADS_CTL		0x000000a0
-#define  PADS_CTL_IDDQ_1L	(1 << 0)
-#define  PADS_CTL_TX_DATA_EN_1L	(1 << 6)
-#define  PADS_CTL_RX_DATA_EN_1L	(1 << 10)
+#define  PADS_CTL_IDDQ_1L	BIT(0)
+#define  PADS_CTL_TX_DATA_EN_1L	BIT(6)
+#define  PADS_CTL_RX_DATA_EN_1L	BIT(10)
 
 #define PADS_PLL_CTL_TEGRA20			0x000000b8
 #define PADS_PLL_CTL_TEGRA30			0x000000b4
-#define  PADS_PLL_CTL_RST_B4SM			(1 << 1)
-#define  PADS_PLL_CTL_LOCKDET			(1 << 8)
-#define  PADS_PLL_CTL_REFCLK_MASK		(0x3 << 16)
+#define  PADS_PLL_CTL_RST_B4SM			BIT(1)
+#define  PADS_PLL_CTL_LOCKDET			BIT(8)
+#define  PADS_PLL_CTL_REFCLK_MASK		GENMASK(17, 16)
 #define  PADS_PLL_CTL_REFCLK_INTERNAL_CML	(0 << 16)
-#define  PADS_PLL_CTL_REFCLK_INTERNAL_CMOS	(1 << 16)
+#define  PADS_PLL_CTL_REFCLK_INTERNAL_CMOS	BIT(16)
 #define  PADS_PLL_CTL_REFCLK_EXTERNAL		(2 << 16)
 #define  PADS_PLL_CTL_TXCLKREF_MASK		(0x1 << 20)
 #define  PADS_PLL_CTL_TXCLKREF_DIV10		(0 << 20)
-#define  PADS_PLL_CTL_TXCLKREF_DIV5		(1 << 20)
-#define  PADS_PLL_CTL_TXCLKREF_BUF_EN		(1 << 22)
+#define  PADS_PLL_CTL_TXCLKREF_DIV5		BIT(20)
+#define  PADS_PLL_CTL_TXCLKREF_BUF_EN		BIT(22)
 
 #define PADS_REFCLK_CFG0			0x000000c8
 #define PADS_REFCLK_CFG1			0x000000cc
-- 
2.50.1


