Return-Path: <linux-pci+bounces-11731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD906953DBF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 01:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30981C254F5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A815E5BA;
	Thu, 15 Aug 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a80GbWli"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701715DBB2
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762706; cv=none; b=u3s2NK6Qx4Bb2plrNZNcCj92pjWUobF1UsVkpELemc1TzcHjW69ATIo93UlYnTGu+H5HaFpKU1u6NXA+TIrOUXSoboFFqjKa/nwKy7VAnAuBjO7lQq4EsJS64QovVaUjjLuS0LFGQ2xRkhze3ArxYPCcdOkB8tpJ8/sbczst+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762706; c=relaxed/simple;
	bh=YUiBwGW+m04rOUlTgB37xDgYkR8Ez4/3RyKUoIWtZGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jH6E8dyrXKPEdH3/KTL2xOslGuO003s+BVwVsq31ajlfTn8k8t3MwR2I6B9sNxM3cQ7/bqc+DJSSRUoDnmaLlX9ACIlxcuD37pN+sc0HeSPmUsGSpfCOYoL+oiT4ZxDBOvxxmjABdBJIPhlfIGzh5ZM5zor7P39kpVe8K9dzIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a80GbWli; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c9a67eaeso868207a91.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762704; x=1724367504; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CByAuUDKr027puS5rnvd5GaxVjxWYrvVYxntQLFOZp8=;
        b=a80GbWlibKXYbWnWw//1yKaKZQQ3SyRyi1PluKGGqYl6nju3jWQGlIRe7tCvWfOmNi
         ProPpMpj0pMACoFOQ3QX88KgSHL5ZhH0g4Ng8EdWX87xDTMnodwKGls+RRkMJ0MyKJ4G
         KvZ+jwjYLl+s8J78OVc+VQZ5JGg1ODiv2sxxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762704; x=1724367504;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CByAuUDKr027puS5rnvd5GaxVjxWYrvVYxntQLFOZp8=;
        b=dwsrOaEhmQoHylGytzUP0LWJUaXItjv5tFmO5D4rsySFamw2oa80Z62ZxvuEwlBLMV
         pHBri0brONdF38Tnxzf307nmHik7zhG5fARuM2yPITm8zr9amew5V44ktRypQO6GDP5D
         Idb4CVz16JcZW08CMzSxe3hJAX7CIrYtXIDgwLFaWzAoB9SwDoQe+jL9tP7qYKDJiHq9
         KWFEEm/2cqRgNopTmn9xcDuAUvTv1ubjxORlQRNh/neqi+1+LVQApQVOx7eiCMb9LxiZ
         meQEyLnYikI5RN0LUSY4nFGpnPhWaumaMPQ4q/F8MmDFF+mvajybcP1xM8GUYNGXpaHV
         FzGw==
X-Gm-Message-State: AOJu0YxtVV0cEs8f5E9JUkK+15IBSHs3irtdf0v0csS168YWYlYdvQps
	6aATzpN+DL1ixrZtqVBQ8G61phpF5MecV/JaO4TL0vVT7hYflxusvvU1YWjkfTwY0270f1Gix3V
	pUZd7b8h5npjXklI/07kKSpfvd8vukXVsPnhpOeRlxhiqDMjJZ+phUbVDsC+MVJinEUiGevlQbZ
	u7KAMMlnEwPH9/KVIGGrhQd4xyOeIZXOulLUYNAV/eMVH6Hg==
X-Google-Smtp-Source: AGHT+IHStnKddiGSY4g7fehS+BcIowHG4comnSuVMlHCA47vkFuMMMSi84s1NB99e00TboqBa4okNQ==
X-Received: by 2002:a17:90a:c28b:b0:2c9:80fd:a111 with SMTP id 98e67ed59e1d1-2d3dfc6c299mr1353521a91.18.1723762703465;
        Thu, 15 Aug 2024 15:58:23 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:23 -0700 (PDT)
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
Subject: [PATCH v6 12/13] PCI: brcmstb: Change field name from 'type' to 'soc_base'
Date: Thu, 15 Aug 2024 18:57:25 -0400
Message-Id: <20240815225731.40276-13-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
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
index d19eeeed623b..26e8f544da4c 100644
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
 	u8 num_inbound_wins;
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
@@ -861,7 +861,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * security considerations, and is not implemented in our modern
 	 * SoCs.
 	 */
-	if (pcie->type != BCM7712)
+	if (pcie->soc_base != BCM7712)
 		add_inbound_win(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -878,7 +878,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * That being said, each BARs size must still be a power of
 		 * two.
 		 */
-		if (pcie->type == BCM7712)
+		if (pcie->soc_base == BCM7712)
 			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
 
 		if (n > pcie->num_inbound_wins)
@@ -895,7 +895,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->type == BCM7712)
+	if (pcie->soc_base == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1018,7 +1018,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->type == BCM7712) {
+		if (pcie->soc_base == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1046,7 +1046,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711) {
+	if (pcie->soc_base == BCM2711) {
 		ret = pcie->perst_set(pcie, 1);
 		if (ret) {
 			pcie->bridge_sw_init_set(pcie, 0);
@@ -1077,9 +1077,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -1676,7 +1676,7 @@ static const int pcie_offsets_bmips_7425[] = {
 
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= GENERIC,
+	.soc_base	= GENERIC,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1684,7 +1684,7 @@ static const struct pcie_cfg_data generic_cfg = {
 
 static const struct pcie_cfg_data bcm7425_cfg = {
 	.offsets	= pcie_offsets_bmips_7425,
-	.type		= BCM7425,
+	.soc_base	= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1692,7 +1692,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 
 static const struct pcie_cfg_data bcm7435_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM7435,
+	.soc_base	= BCM7435,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1700,7 +1700,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM4908,
+	.soc_base	= BCM4908,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1716,7 +1716,7 @@ static const int pcie_offset_bcm7278[] = {
 
 static const struct pcie_cfg_data bcm7278_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.num_inbound_wins = 3,
@@ -1724,7 +1724,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 
 static const struct pcie_cfg_data bcm2711_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM2711,
+	.soc_base	= BCM2711,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 	.num_inbound_wins = 3,
@@ -1732,7 +1732,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 
 static const struct pcie_cfg_data bcm7216_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.soc_base	= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
@@ -1789,7 +1789,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
-	pcie->type = data->type;
+	pcie->soc_base = data->soc_base;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
@@ -1867,7 +1867,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1882,7 +1882,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.17.1


