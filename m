Return-Path: <linux-pci+bounces-10414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07609333A7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 23:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BC8286330
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2A143733;
	Tue, 16 Jul 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aCWDO1N3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55C145B0F
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165538; cv=none; b=HJ5t6KSLyxjARFwiMzt0Rdu0Sl86y+xKkjqv0FK7aN36EnHJ99fA+HkPKo/87jjjrdDcNfkpabqcSDZ2tNRe6tZAKAS92NakIsKFvbryI5Mn+VDCM8G2eKdU0WLXq4MWFhxqRmjI9cTHWD4Ny+sTdRtzbA51JREcQBLm3h7jrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165538; c=relaxed/simple;
	bh=qsUzdUXInW0JKZ11RkqGoykS05aC7G/tgCtmAYBOzbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=nbfDLh4ah/NwGsfirFyEeXD9/bC2dwR92Hx0bfbQk/9YgWj9/sBF5+tK2XJPl5LS4ObMUaJUL+PEbWSO65UEE2d0jAUQcQWpZx98PK7MpCVKV/io9h3rQaQVYRWeBJ5Bko3vXD745Nx9r5RgcKwDmEwmnIzy/HMKCrZ8kkhIe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aCWDO1N3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso147362b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721165535; x=1721770335; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bks+n/VbRmef8IqU9r5ISiYowb16wscFOQwliTnXQxs=;
        b=aCWDO1N3LM+z9Svqr/qW3qAAVbaHW9jcVdhHxKFQlctToTEb6daOJ+98zEAaHus4yE
         dhZJSmbEE6aLezrAV1ZedHUpBVdb7DM2le7zh8czsugqeP/EA/Lhe524kO1dTMuZZKLH
         7yQqvN3LX6V7CbaubLuq3iUX+NVc+ADDw1tQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165535; x=1721770335;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bks+n/VbRmef8IqU9r5ISiYowb16wscFOQwliTnXQxs=;
        b=jmEbg/e5B+Wbd8v2L5DnVcJXlQ6KfOIeF5yCcANGJx00fu5e+7YEn3WHHpth0YCnJo
         Z/whqNBGqsKC7t6P6sl38e6ZPYgkRtjvA2t2DcdiyCeilUpNnLs6PynE1uqMso+Zc/WO
         1Nm8yEOX/FHUdJyujTinsxW2ACSK/Cb6fNOSJW+c3A/UnOJTYrYdJPDuQh2jColk2aQr
         mfiJj3+iwr95YmxlY4Xvy8Qt5ztysPCEcZYP8AqqAcFZ/LlVFCJt1UTtDu/DAmw6xE6H
         4m6h4Yt9+XU3ZDFFU19jyV7mXa5EzcC3VdBER/b4Xl0Ko1roIUSyBCrpUj7VT7krQs7q
         wl8g==
X-Gm-Message-State: AOJu0YwfOAix7ZyO9HTLS0tSRfCkNFQxG2OZXvyW+TQUZ8VQMc3q/jzT
	RkP9PfhB5vE7atM9YEcGi0mgYu1Q69DF5CZukIbpiEx0fSZ6H05aY1gqIZydkF4LCyso3f0d8yJ
	vkeRYOJRCB/Iu12NHvI0Oi/gLbr4e45tMWrw4EHh7vdBZfBJdFwqCurPOYqH27IPcE76oI1FnNs
	GNJxCG5tiOC0RW26xciLD+JZ4+FAWPQ7s75grHdPiB09MwXVCv
X-Google-Smtp-Source: AGHT+IF3n49suP6SQrP+H1Dav6+5O1Eqi3J47jRydAlZlGts/YPBCDlSNfaWtB5vekrWc2VnHs0GXg==
X-Received: by 2002:a05:6a20:7487:b0:1c0:f630:97a5 with SMTP id adf61e73a8af0-1c3f1fb382amr5190061637.10.1721165535114;
        Tue, 16 Jul 2024 14:32:15 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e20fsm6812828b3a.31.2024.07.16.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:32:14 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/12] PCI: brcmstb: Check return value of all reset_control_xxx calls
Date: Tue, 16 Jul 2024 17:31:25 -0400
Message-Id: <20240716213131.6036-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716213131.6036-1-james.quinlan@broadcom.com>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005c9842061d64147a"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--0000000000005c9842061d64147a

In some cases the result of a reset_control_xxx() call have been ignored.
Now we check all return values of such functions and propagate the error to
the next level.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 101 ++++++++++++++++++--------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c44a92217855..2fe1f2a26697 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -232,8 +232,8 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	const bool has_phy;
 	unsigned int num_inbound;
-	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 struct subdev_regulators {
@@ -278,8 +278,8 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
@@ -742,13 +742,18 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 	return base + DATA_ADDR(pcie);
 }
 
-static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
+	int ret = 0;
+
 	if (pcie->bridge) {
 		if (val)
-			reset_control_assert(pcie->bridge);
+			ret = reset_control_assert(pcie->bridge);
 		else
-			reset_control_deassert(pcie->bridge);
+			ret = reset_control_deassert(pcie->bridge);
+		if (ret)
+			dev_err(pcie->dev, "failed to %s 'bridge' reset, err=%d\n",
+				val ? "assert" : "deassert", ret);
 	} else {
 		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
 		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
@@ -757,9 +762,11 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
 		tmp = (tmp & ~mask) | ((val << shift) & mask);
 		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	}
+
+	return ret;
 }
 
-static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
 	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
@@ -767,20 +774,29 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	tmp = (tmp & ~mask) | ((val << shift) & mask);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
+	int ret;
+
 	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
-		return;
+		return -EINVAL;
 
 	if (val)
-		reset_control_assert(pcie->perst_reset);
+		ret = reset_control_assert(pcie->perst_reset);
 	else
-		reset_control_deassert(pcie->perst_reset);
+		ret = reset_control_deassert(pcie->perst_reset);
+
+	if (ret)
+		dev_err(pcie->dev, "failed to %s 'perst' reset, err=%d\n",
+			val ? "assert" : "deassert", ret);
+	return ret;
 }
 
-static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
@@ -788,15 +804,19 @@ static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
 	u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
 	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+
+	return 0;
 }
 
-static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+
+	return 0;
 }
 
 static inline void set_bar(struct rc_bar *b, int *count, u64 size,
@@ -1008,19 +1028,28 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
 	int num_out_wins = 0, num_rc_bars = 0;
-	int memc;
+	int memc, ret;
 
 	/* Reset the bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->type == BCM2711)
-		pcie->perst_set(pcie, 1);
+	if (pcie->type == BCM2711) {
+		ret = pcie->perst_set(pcie, 1);
+		if (ret) {
+			pcie->bridge_sw_init_set(pcie, 0);
+			return ret;
+		}
+	}
 
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	tmp = readl(base + HARD_DEBUG(pcie));
 	if (is_bmips(pcie))
@@ -1239,7 +1268,9 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	ret = pcie->perst_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -1431,15 +1462,17 @@ static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
-static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
+static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 {
 	void __iomem *base = pcie->base;
-	int tmp;
+	int tmp, ret;
 
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	pcie->perst_set(pcie, 1);
+	ret = pcie->perst_set(pcie, 1);
+	if (ret)
+		return ret;
 
 	/* Deassert request for L23 in case it was asserted */
 	tmp = readl(base + PCIE_MISC_PCIE_CTRL);
@@ -1452,7 +1485,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+
+	return ret;
 }
 
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
@@ -1470,9 +1505,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
-	int ret;
+	int ret, rret;
+
+	ret = brcm_pcie_turn_off(pcie);
+	if (ret)
+		return ret;
 
-	brcm_pcie_turn_off(pcie);
 	/*
 	 * If brcm_phy_stop() returns an error, just dev_err(). If we
 	 * return the error it will cause the suspend to fail and this is a
@@ -1501,7 +1539,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 						     pcie->sr->supplies);
 			if (ret) {
 				dev_err(dev, "Could not turn off regulators\n");
-				reset_control_reset(pcie->rescal);
+				rret = reset_control_reset(pcie->rescal);
+				if (rret)
+					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",
+						rret);
 				return ret;
 			}
 		}
@@ -1516,7 +1557,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
 	u32 tmp;
-	int ret;
+	int ret, rret;
 
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
@@ -1578,7 +1619,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	if (pcie->sr)
 		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_reset:
-	reset_control_rearm(pcie->rescal);
+	rret = reset_control_rearm(pcie->rescal);
+	if (rret)
+		dev_err(pcie->dev, "failed to rearm 'rescal' reset, err=%d\n", rret);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
-- 
2.17.1


--0000000000005c9842061d64147a
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB959NOfk/YM/RwL272v6ybdYEGah26
zC1sycZyC+jXCzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTYyMTMyMTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAgnj19Rsskd0vYBQVCQ7d3bd3qfpHPZxBL5DI8hTqQT31sKeh
k1/Ie3+2gmIRjTcsFXraUMz5kCj0dLJBAY87RbIxhrzuHorUuBlC4CnZEHliLsNeD6yYcqwzq1yV
8zorV3wqa2NPvoQSgcIioWxngtJHAXg0S4wUoRXib/iPW9JUdBqQFukAQIubA/B8l4JIIANz79EA
Or9C9XlKkzwaGF3LDeeXfmsdE2XUu+yS7C9UnCEvIuQfCxx9xJ5o/EHx99ntUD1N3vsnSjEr2iZS
hpqfYaXJ8dWgG4BV2GgO7KBO53BhN4ecykdkluvUgf34JwxAdpj2RZTNYeuFVs3ndw==
--0000000000005c9842061d64147a--

