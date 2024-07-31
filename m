Return-Path: <linux-pci+bounces-11085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276589438FA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F08287221
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D816D9DD;
	Wed, 31 Jul 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IBpxp6Ix"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84210171E7C
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464933; cv=none; b=kGHBAY1gWhUGEBGXKCsiEXRVwUT9CoReeDVVWPXqmMTtT1NRWejR5L8Qv/5niq2FOlM7cpC4sxmBS9N13zj3VbPw7tP2opLfSuXrbn0+FBIf0kkmOCJNMnRwT0Yxn2XFrV/gSQYpO7OYkfk3nd+ppB8lAi3ASdyULP9M2ONGFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464933; c=relaxed/simple;
	bh=m8Yb5XC7EBKDcQqhey6p9ZpidQ1IqDx4NiWP2Ahl+bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mbFjYB8Or2lnCrd3XqVPZGn9r5t8t+1plfoEuTppPpHFYlVwX7Nsr34q2XEwoSepYcSTrmgd7wUNHLcM7g/3OT4DkIipwamueZPHajMZvknarsBUacT3G9DRAY4rj1XPNnxS/cby+2Czp6z+dUz7k5BDYo44CoNtez4tsUdZE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IBpxp6Ix; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fdcd7a622so31050531cf.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464929; x=1723069729; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5hMN9hd5R2EuxrKDlmPrY0rWJepmZzVZcJJrxjFbWRw=;
        b=IBpxp6IxzOPulOg8KOf23BKPUNZW8C5mbRmh1zFpxjq+4kMapy74N9x1L6VsAoVzMq
         xw6iXbD2S1JQp8OGnEc4mcR1XVw2DqClGCfjchyU67oAbdIxkh/W5z6m3CrtkJ2aisT0
         33g/v9Ui06SnE9U/xjuH3ijJuIB+t9uyh+geY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464929; x=1723069729;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hMN9hd5R2EuxrKDlmPrY0rWJepmZzVZcJJrxjFbWRw=;
        b=Iup0iWBYPERbczH4/3Cn/4BnxOnqrJuP/MJSVvIN+epYWpeTF3WnorvnDvTsgE3XKY
         urfBW7TIUYIJfFsnVq7vLPF7fHw8B61hpyik5INZThiP2eXhzCmdTOM8xbOs4XST1Efw
         lC3RqhF+GCNk1QQj7prIG1vX96bvgBi+RGNpeHUDmMHK5afa+TIGr8EOLtkJ1Bb1a9SC
         wfSua0VDcPbIPZ/IaNSBmdbDIcfPbV+w6PxQZq83ezOO+Zx+hHsUTEjSy3qLiR15fCvI
         I4v44SS6ZLFXkO28lcgWai13KjRojGEmv8EVBz/WlirJYuOnMH0vtheHXMvfNXA5RmEE
         h9CQ==
X-Gm-Message-State: AOJu0YxYcOQggVHfAP/VaUrJADNuxP9zEODfNEVSMvIVWjWYajWEgwy7
	fM1BK3/Sh1EFNwUL8WY3p9p26ZjB9vv/yOI0DAkunty8/uFwYGzLUJ1RNS9yduq6cDls0w0sug7
	zdlDD/ltELbmWHpoIgp4B7j5WpYljVG5W32MQ6e3lvIbBPYhHALgc08+GQ6tG11CFBAqVipohGn
	Gl+VV9kk5y955jmOslkaf5YPoF2JRHX4ISH217hfFs5qgViA==
X-Google-Smtp-Source: AGHT+IHb4s3V73+ztQ4zJoX+XZ9jOaCR5frA7+yF6G8XoMSBIJbRurH1mjZU8SRenbvMvCHRsNTPoQ==
X-Received: by 2002:ac8:5914:0:b0:447:e046:8482 with SMTP id d75a77b69052e-4514f98bdb3mr7983191cf.23.1722464929441;
        Wed, 31 Jul 2024 15:28:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:48 -0700 (PDT)
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/12] PCI: brcmstb: Check return value of all reset_control_xxx calls
Date: Wed, 31 Jul 2024 18:28:24 -0400
Message-Id: <20240731222831.14895-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Always check the return value for invocations of reset_control_xxx() and
propagate the error to the next level.  Although the current functions
in reset-brcmstb.c cannot fail, this may someday change.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
 1 file changed, 73 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 0ecca3d9576f..c4ceb1823a79 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -239,8 +239,8 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	const bool has_phy;
 	unsigned int num_inbound_wins;
-	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
 struct subdev_regulators {
@@ -285,8 +285,8 @@ struct brcm_pcie {
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
@@ -749,12 +749,18 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 	return base + DATA_ADDR(pcie);
 }
 
-static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
+	int ret = 0;
+
 	if (val)
-		reset_control_assert(pcie->bridge_reset);
+		ret = reset_control_assert(pcie->bridge_reset);
 	else
-		reset_control_deassert(pcie->bridge_reset);
+		ret = reset_control_deassert(pcie->bridge_reset);
+
+	if (ret)
+		dev_err(pcie->dev, "failed to %s 'bridge' reset, err=%d\n",
+			val ? "assert" : "deassert", ret);
 
 	if (!pcie->bridge_reset) {
 		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
@@ -764,9 +770,11 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
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
@@ -774,20 +782,29 @@ static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
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
 
@@ -795,15 +812,19 @@ static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
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
 
 static inline void set_bar(struct inbound_win *b, int *count, u64 size,
@@ -1016,19 +1037,28 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
@@ -1247,7 +1277,9 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	int ret, i;
 
 	/* Unassert the fundamental reset */
-	pcie->perst_set(pcie, 0);
+	ret = pcie->perst_set(pcie, 0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -1439,15 +1471,17 @@ static inline int brcm_phy_stop(struct brcm_pcie *pcie)
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
@@ -1460,7 +1494,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
-	pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->bridge_sw_init_set(pcie, 1);
+
+	return ret;
 }
 
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
@@ -1478,9 +1514,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
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
@@ -1509,7 +1548,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
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
@@ -1524,7 +1566,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
 	u32 tmp;
-	int ret;
+	int ret, rret;
 
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
@@ -1586,7 +1628,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
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


