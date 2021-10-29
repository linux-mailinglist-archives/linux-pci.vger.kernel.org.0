Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA64403C0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhJ2UGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhJ2UGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994AC061766;
        Fri, 29 Oct 2021 13:03:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso8101908pjb.1;
        Fri, 29 Oct 2021 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xm4SxmqwuOzBa/eZu2FFd0i6Z3G+Vk7bausmQ5xw+Wk=;
        b=Ukpz40DOhJCbTS0qUysan/cT59elQe3QGvN3TqPOJ9ouYTGiABkDBzs0G1TJ2/++sy
         NZa+I1/MJ02SV0AyDQg+x4sIvcSelYgVP/IWVgX6WB69sY6bz1VDX2HELr47w3nzxFC6
         jypWTJ9BUYStdK+qnKNDygx3BqwIE7Lw0XuWitHusQxOCE6QoqDMppBhQAIo18gc0g4q
         TgjhJNCa8R7+IDZFWfAWl73IkeIjGkoMHW/EMkWO+YjHKQaPerU35AftWjCs/dkofE9q
         eNh9WdNCqh0u15YoGMH2smxpI5r33H62uC0qGr8YeJxoxEJXuZQ04jJtcVIyMOzgMsnk
         EIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xm4SxmqwuOzBa/eZu2FFd0i6Z3G+Vk7bausmQ5xw+Wk=;
        b=UF8hGdH3lT0zDggwQx3VJqw5N03/yskFYunNNipz0BlTSwBh2YxkhIjtLBvjSp36WM
         XI17P9xzQlbLYhN/od/GwkV69VHYfTEWIYMCQ2XKuQix3JCUP+jzs4yISZDYxo3ih1Pg
         yold68XFNm8a/od5yroBUoHGsvgjjVTJIbvT1nLMKxNRSiMI2vSFMuZTWo3IoG/iOkKr
         NHNcVWHgfAHKNRVIu+wiOeFeGQAxMwQ8kYh6m17dNIut3ib5RsFjSM/2p5BlcwCeeCxx
         pPaOiddcAztpvNgECyPds+bzm2gRgTa903En3dOShgPXk3dTP/zvtIPnJ4MLn5nkE134
         fmcw==
X-Gm-Message-State: AOAM532TuYgIvTeTotS3fwy/+uVdnPjjGyPmRtIaVUUefP9E6qaGyxKY
        VP3UWtYwO5lxq16U5HD5YzZBlqmRt3aYlg==
X-Google-Smtp-Source: ABdhPJyBfG5E+MF9U5ej9v+kNG6zjDbhbmOpAJsBRFAGkk7Xi3emFFxmGH3ASKOyUClSZjy3uUvTeQ==
X-Received: by 2002:a17:90b:33c7:: with SMTP id lk7mr13790866pjb.172.1635537821370;
        Fri, 29 Oct 2021 13:03:41 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:41 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 8/9] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Fri, 29 Oct 2021 16:03:16 -0400
Message-Id: <20211029200319.23475-9-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 49 ++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 6635e143cfcb..18b9f7c97864 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -192,6 +192,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
 
 static const char * const supplies[] = {
 	"vpcie3v3",
@@ -304,8 +305,20 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
 	unsigned int		num_supplies;
+	bool			ep_wakeup_capable;
 };
 
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
 static int brcm_regulators_on(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -313,6 +326,18 @@ static int brcm_regulators_on(struct brcm_pcie *pcie)
 
 	if (!pcie->num_supplies)
 		return 0;
+
+	if (pcie->ep_wakeup_capable) {
+		/*
+		 * We are resuming from a suspend.  In the previous suspend
+		 * we did not disable the power supplies, so there is no
+		 * need to enable them (and falsely increase their usage
+		 * count).
+		 */
+		pcie->ep_wakeup_capable = false;
+		return 0;
+	}
+
 	ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to enable EP regulators\n");
@@ -320,13 +345,28 @@ static int brcm_regulators_on(struct brcm_pcie *pcie)
 	return ret;
 }
 
-static int brcm_regulators_off(struct brcm_pcie *pcie)
+static int brcm_regulators_off(struct brcm_pcie *pcie, bool force)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
 	if (!pcie->num_supplies)
 		return 0;
+
+	pcie->ep_wakeup_capable = false;
+
+	if (!force && bridge->bus && brcm_pcie_link_up(pcie)) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
+			     &pcie->ep_wakeup_capable);
+		if (pcie->ep_wakeup_capable)
+			return 0;
+	}
+
 	ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to disable EP regulators\n");
@@ -1248,7 +1288,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return brcm_regulators_off(pcie);
+	return brcm_regulators_off(pcie, false);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1264,6 +1304,7 @@ static int brcm_pcie_resume(struct device *dev)
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		goto err_disable_clk;
+
 	ret = brcm_regulators_on(pcie);
 	if (ret)
 		goto err_reset;
@@ -1311,7 +1352,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 	if (pcie->num_supplies) {
-		brcm_regulators_off(pcie);
+		brcm_regulators_off(pcie, true);
 		regulator_bulk_free(pcie->num_supplies, pcie->supplies);
 	}
 }
@@ -1382,7 +1423,7 @@ static int brcm_pcie_pci_subdev_prepare(struct pci_bus *bus, int devfn,
 	return 0;
 
 err_out1:
-	brcm_regulators_off(pcie);
+	brcm_regulators_off(pcie, true);
 err_out0:
 	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
 	pcie->num_supplies = 0;
-- 
2.17.1

