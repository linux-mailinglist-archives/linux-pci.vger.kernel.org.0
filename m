Return-Path: <linux-pci+bounces-31467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9792AF82E7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA85A0968
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9C2C1595;
	Thu,  3 Jul 2025 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gt4BOjmB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E772C08D2
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579612; cv=none; b=hYjMkgjLltrSKgmKNKXvsI0Lm9xPKQJVlh4LEGxX2YVQk7I9aR1PZdUN1lkztKdQPFr5AYOBViYae006aZ5H5XxHunjSE+m+5ee6vICBFTZuxUxQBn0tYeHqwvX3g++puWX/1mQC+tD2xN3upEmAoGTfVBZr9M0H1lx5E0rpz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579612; c=relaxed/simple;
	bh=gReumBugAMPkL+f0s/yNu2rliKIaTFJgDBbHJ0cCnSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoWJ7QTjS4wIFgJKKLLuhhGO6E/5/sg0IFw6ER+uafDtPOmnM0XFtCj3SgL3zdxUeivsOu0t0fsio+1inXKGRYZgb9EY1pzyru50+sG9G3sU6fYfbvHKGmfL5TsxynYM5tu3qPAO0X6u9cRkarijr8IbEJ1+dZv2mQsUHNQDosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gt4BOjmB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b440afa7so4649445ad.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751579609; x=1752184409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxuuX3SmTe/KHiGqxZf5tezD/Xp394VdI3B/HTH6SAc=;
        b=gt4BOjmB9j30Xk/N0Ky0uhOdLnXfGS0+HGtDmv65evo7hofyZRLS8N2LTVP0MyHCvQ
         8G9E4aK/nFfffWHNSLvvyHC98nSLJLNSQ2DD14UHoipoGQe8+DQ+Xkn5aVE/vM9XlHwH
         n7hI8zF94jukkut36XOlFytjL0gBGPsQwOnzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751579609; x=1752184409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxuuX3SmTe/KHiGqxZf5tezD/Xp394VdI3B/HTH6SAc=;
        b=Q4TC0lrWUuDHJQqAhLZEngHoQKEVTXyEksVjFAcqvm/BQA7FwuPWO3KweFcj6oZt0G
         XquZR2Rp5VAIHwpBV82NJcSV7GU4k5LfyPpRLJSrTllJeJ+ik3A5MRpBZ9vonj9GttaQ
         aNbP4cm+of2myvHxge0xanGzF/w1ak2YHd9+p7gz98jkUPvged0J1TmO12TeR7hZI5xE
         OhdKshDnhSksWd6PQTp0A9CJKF10OjyaTcO1Ahwp0PdTsJLXaoN9LlqbdMTVTTUIRtod
         QFQLh9soGePlvGWoV1Qnu2uOjKhIViEAImm6cU0Z7g08k6p3MZCud4UUU7vOfCRwgHmq
         16LQ==
X-Gm-Message-State: AOJu0YzrGzK/QrsscgsbveWrbA9rlCwA4xkV9yu3KbVMsFKhMTMHgwAE
	nPS1UZifw2bQVM45CbueoyC53w6jDppFelRwRHtRQnb8Mkobfm+IXLs3ZjMJDzAMf5ixWXAE/oW
	OBtqO0xIuHALPWWwlDaVkPh+lBCL7xjDa+eGPMOwVeYagWEt0wiHPLhaecoaucaPYYdgfvbfQmA
	uJ/L+SCC5c/03gn9O0jAKN/p+6eHSGx8LUKV0igot66CFWyEq6pQ==
X-Gm-Gg: ASbGnctRPTun4iZawpNCNz8tZcsLVMHBvDZJFOeAiAQaS24o1NH3Bi8LNaVkLrVT5Yr
	32V7TrGWf8jyMUNfvgR8YWVaiDf4tf9YVNPQyeeZzrIFDiLWpXimvPLY1wB+HtTlj5dtsbKgaA+
	GbZh+O9XPxr5+M5/k/H1LKrLM98knwzAaDUcSxGAaVoa8kvxm59pXPteiLwuWKOlkf1/4DkRia4
	zkhVOyG/+rYraWhFxKXYCWI9FyMrnNz+JIlVH6BSPF/R5MUqbns65XBIYs3w2hTOzpAzo0xyVIM
	pz/BDvu2LnPevVgtH1Ed2p8PjXNUJosaZ/fj7uQ9/C2QRhPDxFwD4Nlz17fw1FE07sCWgoPg01b
	2wgr56Seu8WixjISu8LtIDWl8khe3Dgjf83MR1F9Rkw==
X-Google-Smtp-Source: AGHT+IFglctMK4Y0kmMgoX4O2sEYz7+usWw4Ox+ioQ0YNjPdTo5gPJOnupN4TRKyDCVpucZphxoS0w==
X-Received: by 2002:a17:902:f684:b0:210:f706:dc4b with SMTP id d9443c01a7336-23c86064c7amr4212915ad.13.1751579609484;
        Thu, 03 Jul 2025 14:53:29 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8459b3a0sm4249645ad.219.2025.07.03.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:53:28 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] PCI: brcmstb: Add 74110a0 SoC configuration details
Date: Thu,  3 Jul 2025 17:53:13 -0400
Message-Id: <20250703215314.3971473-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703215314.3971473-1-james.quinlan@broadcom.com>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable PCIe for 74110a0 SoC.  This chip uses a simple mechanism
to map inbound memory regions.  Both the "ranges" and "dma-ranges"
are identity-mapped to PCIe space.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 362ac083e112..bfedab15a162 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -276,6 +276,7 @@ enum pcie_soc_base {
 	BCM7435,
 	BCM7712,
 	BCM33940,
+	BCM74110,
 };
 
 /*
@@ -291,7 +292,7 @@ enum pcie_soc_base {
  * power of two.  Such systems may or may not have an IOMMU between the RC
  * and memory.
  */
-#define IS_NG_PCI_SOC(t) (0)
+#define IS_NG_PCI_SOC(t) ((t) == BCM74110)
 
 struct inbound_win {
 	u64 size;
@@ -2046,6 +2047,14 @@ static const int pcie_offsets_bcm7712[] = {
 	[PCIE_INTR2_CPU_BASE]	= 0x4400,
 };
 
+static const int pcie_offset_bcm74110[] = {
+	[RGR1_SW_INIT_1] = 0xc010,
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x8000,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[PCIE_INTR2_CPU_BASE] = 0x4300,
+};
+
 static const int pcie_offset_bcm33940[] = {
 	[RGR1_SW_INIT_1] = 0x9210,
 	[EXT_CFG_INDEX] = 0x9000,
@@ -2162,6 +2171,15 @@ static const struct pcie_cfg_data bcm33940_cfg = {
 	.num_inbound_wins = 10,
 };
 
+static const struct pcie_cfg_data bcm74110_cfg = {
+	.offsets	= pcie_offset_bcm74110,
+	.soc_base	= BCM74110,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.has_phy	= true,
+	.has_err_report	= true,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
@@ -2177,6 +2195,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
 	{ .compatible = "brcm,bcm33940-pcie", .data = &bcm33940_cfg },
+	{ .compatible = "brcm,bcm74110-pcie", .data = &bcm74110_cfg },
 	{},
 };
 
-- 
2.34.1


