Return-Path: <linux-pci+bounces-11086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D59438FC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941AE1C23D31
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3A183CB7;
	Wed, 31 Jul 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JkB8hIVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33122183CA4
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464934; cv=none; b=j+9Z6D+wMFJZ3VbTlWP/g8JwrQ3YpVDK82ZGx9ekMVnTJqX7v1acdKJSQTEjw1JWQI2ORDnTMUd2IDK0vs2Fxa1Zj+gPA39eElTq3JDDs0HXvfLKe2xEOfLoBHxD87u0woa6EhRyqLgrioeXKckVTtLJrYFHFesuSGHrbECrLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464934; c=relaxed/simple;
	bh=KnEfs6HZv31jHNJ3+N/UsBfCm6ko0napd6s47uUx07M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lXFwctF2n2wVbrpVjQO1O2mhOLUUboFPwitMW0gF3Zr90xIrDqCtasB0i5b2du9ERG8mfdsscAkLGuNd1w+XwsF/rQKHosytarkvgfGU1Y7KGiVeMijyO9ix1UO1IlWB2/iL7SjaJChAv8iXiRvAfEexDPdgFUc5JeviJ23Ek20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JkB8hIVv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d0ad7113so429539785a.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464932; x=1723069732; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YZm55XuvS5TsIWPd2I5O2BqV2wZK6adjRKLxKY6gWyA=;
        b=JkB8hIVvwyT2BCgpRZc7VEgGdcV5Ucj5w2rK79mf9A1xpl2cYHZJlBYRwv0dmwC/Gw
         QNT2Ex3OrzzBDn5JKBMakJQ8d0B1l5A5I/rZ5Qr5oB+PhOWP6t7OeWOvrxJzCvWNfyM3
         gZzPBH36XxF+e284IbyFxq7pxkRCYqKuo3POM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464932; x=1723069732;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZm55XuvS5TsIWPd2I5O2BqV2wZK6adjRKLxKY6gWyA=;
        b=qhvBnLWLamM+cO3kysd1hkA0uAy+aC1dHpJURAjHdqZFb+D6uU4l4wbR5lyp4H9ZJN
         iJZg16mvc6b/tqKFxowqDUAy/FsqRzhdcI+1+3/Hwjvk2aKoUMZCpR/DaBxixyBmPns3
         9S0gpQDorxI8cby1yiGINeMvSCet609Ne6Jt0Wmj5103k9zIY2TrCbuEIgj2m6IXarOF
         uNMLh2wKf29F/aLZtoyu/tmq1UgTLqUw6gDKz3Jwry95vOaJHiuEEtK+kCA3tStUmAmj
         H90O5RPqcagInfopwhrdb+uv69eeAKuuHovUR37plsapxUWYCa9VeWGlGFIRq2y7tRDG
         8ffw==
X-Gm-Message-State: AOJu0YwEyu6oJbnHjvUgEiwWmJy4qXLBXjTSRk9UGEwjdf4vYcEv/pY0
	cdtt20aPfzBHW3kDrzVA1vcOkEGsAfFV6kf6kpAqpMb0pgxIZ8m7QO9i90QxB0cOwzVKvOrRtT/
	bRfhV58URG7DPVlf9rEZR/aqf4JtnShV89GaPY3NK63EHbzJ9+FJj+2WTlaHIzTIFA3SVOlsYHF
	0mCBKMJWFbtnQCFn7KG6FwQbaI2bHQQDKp8dTC7Qy8vfwi0A==
X-Google-Smtp-Source: AGHT+IEndjov11wcEzjulUpPn9DsM2Y3SCKwPkMcrsPJUtiLRsQRjQ/eaIW0tsU5qan9kt+FiHASmw==
X-Received: by 2002:a05:620a:450b:b0:7a2:d63:4cc6 with SMTP id af79cd13be357-7a30c67f324mr66945185a.39.1722464931517;
        Wed, 31 Jul 2024 15:28:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:50 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 11/12] PCI: brcmstb: Change field name from 'type' to 'soc_base'
Date: Wed, 31 Jul 2024 18:28:25 -0400
Message-Id: <20240731222831.14895-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The 'type' field used in the driver to discern SoC differences is
confusing; change it to the more apt 'soc_base'.  The 'base' is because
some SoCs have the same characteristics as previous SoCs so it is
convenient to classify them in the same group.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++--------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c4ceb1823a79..4623b70f9ad8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -218,7 +218,7 @@ enum {
 	PCIE_INTR2_CPU_BASE,
 };
 
-enum pcie_type {
+enum pcie_soc_base {
 	GENERIC,
 	BCM7425,
 	BCM7435,
@@ -236,7 +236,7 @@ struct inbound_win {
 
 struct pcie_cfg_data {
 	const int *offsets;
-	const enum pcie_type type;
+	const enum pcie_soc_base soc_base;
 	const bool has_phy;
 	unsigned int num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
@@ -277,7 +277,7 @@ struct brcm_pcie {
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
 	const int		*reg_offsets;
-	enum pcie_type		type;
+	enum pcie_soc_base	soc_base;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
@@ -295,7 +295,7 @@ struct brcm_pcie {
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->type == BCM7435 || pcie->type == BCM7425;
+	return pcie->soc_base == BCM7435 || pcie->soc_base == BCM7425;
 }
 
 /*
@@ -860,7 +860,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * security considerations, and is not implemented in our modern
 	 * SoCs.
 	 */
-	if (pcie->type != BCM7712)
+	if (pcie->soc_base != BCM7712)
 		set_bar(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -877,7 +877,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * That being said, each BARs size must still be a power of
 		 * two.
 		 */
-		if (pcie->type == BCM7712)
+		if (pcie->soc_base == BCM7712)
 			set_bar(b++, &n, size, cpu_beg, pcie_beg);
 
 		if (n > pcie->num_inbound_wins)
@@ -894,7 +894,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->type == BCM7712)
+	if (pcie->soc_base == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1017,7 +1017,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->type == BCM7712) {
+		if (pcie->soc_base == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1045,7 +1045,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711) {
+	if (pcie->soc_base == BCM2711) {
 		ret = pcie->perst_set(pcie, 1);
 		if (ret) {
 			pcie->bridge_sw_init_set(pcie, 0);
@@ -1076,9 +1076,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (is_bmips(pcie))
 		burst = 0x1; /* 256 bytes */
-	else if (pcie->type == BCM2711)
+	else if (pcie->soc_base == BCM2711)
 		burst = 0x0; /* 128 bytes */
-	else if (pcie->type == BCM7278)
+	else if (pcie->soc_base == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
@@ -1675,7 +1675,7 @@ static const int pcie_offsets_bmips_7425[] = {
 
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= GENERIC,
+	.soc_base	= GENERIC,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1683,7 +1683,7 @@ static const struct pcie_cfg_data generic_cfg = {
 
 static const struct pcie_cfg_data bcm7425_cfg = {
 	.offsets	= pcie_offsets_bmips_7425,
-	.type		= BCM7425,
+	.soc_base	= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1691,7 +1691,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 
 static const struct pcie_cfg_data bcm7435_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM7435,
+	.soc_base	= BCM7435,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1699,7 +1699,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM4908,
+	.soc_base	= BCM4908,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1715,7 +1715,7 @@ static const int pcie_offset_bcm7278[] = {
 
 static const struct pcie_cfg_data bcm7278_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.num_inbound_wins = 3,
@@ -1723,7 +1723,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 
 static const struct pcie_cfg_data bcm2711_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM2711,
+	.soc_base	= BCM2711,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1731,7 +1731,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 
 static const struct pcie_cfg_data bcm7216_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
@@ -1788,7 +1788,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
-	pcie->type = data->type;
+	pcie->soc_base = data->soc_base;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
@@ -1858,7 +1858,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1871,7 +1871,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
-	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.17.1


