Return-Path: <linux-pci+bounces-9754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93F9267B4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF92879D5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE39194C7E;
	Wed,  3 Jul 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cN5EM7pA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8F194AE4
	for <linux-pci@vger.kernel.org>; Wed,  3 Jul 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029810; cv=none; b=flDgoGTR4dkyOXGWILaakXk6LTBkKrTmYlA0KWtSb/vksAY4Ak1jJeYNwcPzAUqJ9yA0ikSxbSRENo9JY8r3/HVSAIxGl90sAg3rJOptbifgxvS4SUZDoMLvrBKky1HyuAC+x86VeWqj9FGQObOL/J70VZHs4BvWJzNeREhAWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029810; c=relaxed/simple;
	bh=GZJY9iiWQpN/yPFWHIR2eYaqvMGQhuxatNcxbMxXIaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=JmWlMJ1BF2MEaN1QRKsWY7Eye7/Q2KSYjt1HNDlKMeU/zFQ0uRL7Rh8Jmfb/eNq3ZpDNoSN2x38opOoNgppLRMGEWQWMaqJKF4+H9vKtRniJeqw+N2NchvW3yHs2Uhr2c4uQzbmSi8LVIKTG81UjYAS6Yr2138GzrbNs6em0kVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cN5EM7pA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b56000f663so27476446d6.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2024 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720029806; x=1720634606; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvCiK0BlPyfjWugEWZw9N5xcsjjFeFSbLSjcf6AY0ow=;
        b=cN5EM7pAjeI1/jAeYWj4Hw6EgGoZs7MD4BtMBWwQ1nOsk1Rbw1a40UW2hz6/IFVhLw
         gj3TFu7uDgwDbg4CCpjG4y0n8QUT8+6oHA0GjdO7nM32+fUDQKvswFLnxiaT50OpbFF/
         fItYERXuNgNr2tjByhSkyAZE8r9ENi4++hlrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029806; x=1720634606;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvCiK0BlPyfjWugEWZw9N5xcsjjFeFSbLSjcf6AY0ow=;
        b=G6LvvbNYZJoogCSFnC82vA7S0Bg8A9b9RbSBTnnDZul8u9Pr+3sAl2NE0vZ502w4LR
         Yj9GxaAmGWIctYLYvn7HCehnoAJ8LMWEKZi8dGv1tcycHoTPE35XwYKl5QQc0RFMy2fa
         Lc+UMt5fhC1LGhVvMRI/BKq/U7Pldu8G9KNAEgdqDkcmleY6UldhL3cepSr+1Tpg4viH
         P919+msnEA6aicGvix05UZrj1L3lOo0UYfWHyL25tRQx3dI+Z/VoPMQfg1qIIwyeJdUD
         m1M13B3OQ5f1Yln/MJI0gMs/8Uf6AVagB5XBfjWsR/x3HY+Yxse2PcrxXHegWNteWrw/
         CB/w==
X-Gm-Message-State: AOJu0Yx03jo630i18EXdYAiGB3PBC5kkstSr+Bv2AV2ZYFHUsuVO0aGU
	yhqyoKFKXFAYXrEfy2tW5Zk2RFHtGww1X/mQ4K+Kq5E6bzjTu7BU1UQYiUJPdvpwjretyvasLMy
	unEqL8e+xfI8UVAKXGMuFJtxH8J3ST++jbRQ9V4JSo6Yj4g3l1eX3JWQL4508JZ4fx6l9/jysjd
	b0n+KGKJfyVcFIgejzFyMub4c01f48wkFiKftT950qnHHFV7Ax
X-Google-Smtp-Source: AGHT+IHOqGCTjRLkEcd+6HhFKBD+yy0FViPSyxm6PVq6h/Kw1ScniT7xyeh2B7nDdfIeB9m31sepmg==
X-Received: by 2002:a05:6214:ac5:b0:6b0:737f:534a with SMTP id 6a1803df08f44-6b5b70c2eb2mr210792386d6.27.1720029806290;
        Wed, 03 Jul 2024 11:03:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm55589626d6.83.2024.07.03.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:03:25 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
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
Subject: [PATCH v2 12/12] PCI: brcmstb: Change field name from 'type' to 'model'
Date: Wed,  3 Jul 2024 14:02:56 -0400
Message-Id: <20240703180300.42959-13-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240703180300.42959-1-james.quinlan@broadcom.com>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a2a7c8061c5ba554"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--000000000000a2a7c8061c5ba554

The 'type' field used in the driver to discern SoC differences is confusing
so change it to the more apt 'model'.  We considered using 'family' but
this conflicts with Broadcom's conception of a family; for example, 7216a0
and 7216b0 chips are both considered separate families as each has multiple
derivative product chips based on the original design.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 39d7dea282ff..3ab35d3dbe36 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -211,7 +211,7 @@ enum {
 	PCIE_INTR2_CPU_BASE,
 };
 
-enum pcie_type {
+enum pcie_model {
 	GENERIC,
 	BCM7425,
 	BCM7435,
@@ -229,7 +229,7 @@ struct rc_bar {
 
 struct pcie_cfg_data {
 	const int *offsets;
-	const enum pcie_type type;
+	const enum pcie_model model;
 	const bool has_phy;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
@@ -269,7 +269,7 @@ struct brcm_pcie {
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
 	const int		*reg_offsets;
-	enum pcie_type		type;
+	enum pcie_model		model;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge;
@@ -287,7 +287,7 @@ struct brcm_pcie {
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->type == BCM7435 || pcie->type == BCM7425;
+	return pcie->model == BCM7435 || pcie->model == BCM7425;
 }
 
 /*
@@ -842,7 +842,7 @@ static int brcm_pcie_get_rc_bar_sizes_and_offsets(struct brcm_pcie *pcie,
 	 * to system memory but to a regiion all of the SOC registers.  No
 	 * one uses this anymore.
 	 */
-	if (pcie->type != BCM7712)
+	if (pcie->model != BCM7712)
 		set_bar(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -859,7 +859,7 @@ static int brcm_pcie_get_rc_bar_sizes_and_offsets(struct brcm_pcie *pcie,
 		 * That being said, each BARs size must still be a power of
 		 * two.
 		 */
-		if (pcie->type == BCM7712)
+		if (pcie->model == BCM7712)
 			set_bar(b++, &n, size, cpu_beg, pcie_beg);
 
 		if (n > pcie->num_inbound)
@@ -876,7 +876,7 @@ static int brcm_pcie_get_rc_bar_sizes_and_offsets(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->type == BCM7712)
+	if (pcie->model == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -985,7 +985,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711)
+	if (pcie->model == BCM2711)
 		pcie->perst_set(pcie, 1);
 
 	usleep_range(100, 200);
@@ -1009,9 +1009,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (is_bmips(pcie))
 		burst = 0x1; /* 256 bytes */
-	else if (pcie->type == BCM2711)
+	else if (pcie->model == BCM2711)
 		burst = 0x0; /* 128 bytes */
-	else if (pcie->type == BCM7278)
+	else if (pcie->model == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
@@ -1054,7 +1054,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->type == BCM7712) {
+		if (pcie->model == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_calc_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1217,7 +1217,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 		 */
 		clkreq_cntl |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
 		/* 7712 does not have this (RGR1) timer */
-		if (pcie->type != BCM7712)
+		if (pcie->model != BCM7712)
 			brcm_extend_rbus_timeout(pcie);
 
 	} else {
@@ -1639,28 +1639,28 @@ static const int pcie_offset_bcm7712[] = {
 
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= GENERIC,
+	.model		= GENERIC,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 static const struct pcie_cfg_data bcm7425_cfg = {
 	.offsets	= pcie_offsets_bmips_7425,
-	.type		= BCM7425,
+	.model		= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM7435,
+	.model		= BCM7435,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM4908,
+	.model		= BCM4908,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
@@ -1675,21 +1675,21 @@ static const int pcie_offset_bcm7278[] = {
 
 static const struct pcie_cfg_data bcm7278_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.model		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
 	.offsets	= pcie_offsets,
-	.type		= BCM2711,
+	.model		= BCM2711,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
 	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
+	.model		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
@@ -1699,7 +1699,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 	.offsets	= pcie_offset_bcm7712,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-	.type		= BCM7712,
+	.model		= BCM7712,
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
@@ -1753,11 +1753,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
-	pcie->type = data->type;
+	pcie->model = data->model;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
-	pcie->num_inbound = (pcie->type == BCM7712) ? 10 : 3;
+	pcie->num_inbound = (pcie->model == BCM7712) ? 10 : 3;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1828,7 +1828,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->model == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1843,7 +1843,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->model == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.17.1


--000000000000a2a7c8061c5ba554
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA8m1cOjRLPkxEYVNg2/oqTRAg/fXYr
p4UFgnH2zUKR1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDMxODAzMjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEABA7QaDsygGaKXOsVbVAscpNGC8/qDjsC1QCGe1z5chnrDWPP
HCdW3zPWwxHsiu0GwgjFp+34zHiFC7qMAg4vwlAVGtg45Eufys76nZD1xSBOzenGCBeLvpU+7ocs
3dAEmRXtp0UdkIYMVlLaW/BrbdhLTwMId2iAcenHwfqJqIt7tLdQjo99mL9gTZvcB24cqtsSnn27
7J17uDKxFgtqq+vUDf8pOvhI+8S9StIWLNsW11n7O7ffcmQsd7T5/M3VRDpSiYsv4qBoe6JNA0U6
NBaFATKCX0BtQenr5Wx99kkwm6Oj4Fe/ISDY0AvtAp7wRFVDQAGbD93ENUDn3qve6w==
--000000000000a2a7c8061c5ba554--

