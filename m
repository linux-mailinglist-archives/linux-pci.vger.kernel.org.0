Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BF5771D8
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiGPWZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiGPWZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A31C936;
        Sat, 16 Jul 2022 15:25:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so14757524pjo.3;
        Sat, 16 Jul 2022 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HeZBaSe2b0OdhqH1Akhrcs1GY2Xz94hdQRqqwnsXn8k=;
        b=X63dXK3oXI9/A7LLN4VeFHqJdv5ssf8srCUQDCtmm9vqeQcEob+XIwVHfJymyawNvQ
         Dd3427QaH8Ql4rLsQkHBZrpJsBtuMP1LzAwyGSppm05rNbwrFwRBdt0OFgBskl/mU2F0
         m321DUYtIcTGmqgyk8YtsNYlbxwljCxQHkRcPUlvOmT12dj9MKTELbK6FfocRtMLPbUA
         MfZXxOdcT7zjD8MDgAwGnLYK5zz1MOv5GoDsuQtQAOXgGxybP9x2AGNcG4IcEnB/Et+O
         p2kQWVCtR7oqMroZpK+TBx+ahUfKXi+78aR2YkzNgJsG1zRO+VW6Kb5yAEAMmJ3SD+Aq
         U2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HeZBaSe2b0OdhqH1Akhrcs1GY2Xz94hdQRqqwnsXn8k=;
        b=EvQFEGuvmqujf9gc/JlgmRwENLse3hbqj7JYfIJpNWIfrfQho4QsvqHrEEX8Xoe5BP
         qGR9T5Bocb/4VpI8/iN/dPIC/A5DgYt0/b0DQfmbhUxY1p2p7aznOUkjM4tHPfVoaMJK
         wURCHvbZGHLGBi839bJO7wuL/OVHzLWNBpbgQ2LhT9geWAApFHiV773HtxpmvAwO+10v
         qXZCOf7AQHvK8SaT2eAHZ94yJUaWbf33VlHxCPde0NrWP4irHPGTqajO2kSErOO199wV
         tkj61Tukd7MEaBr3ywgoUnjaIngmHWHS4bJ0DmZmJEKSNhZxFBv20aaw/4Rdz9sQE2CV
         Ec3g==
X-Gm-Message-State: AJIora8h27HJO+L1l3wJFZ/6ACwGbLpcdRTmUp1ZC4aFs3LgL+/Mf1IT
        ejrPM2ervyW/r6nb3Vlv/n5YM6Xhfzg=
X-Google-Smtp-Source: AGRyM1uGmPxUgdybb+yGepSh9vUg1gbQESh8TvcQKrkppQEGDwrJuzFtyujlBWx1CzxylLxgmBywDA==
X-Received: by 2002:a17:90a:f2d7:b0:1ef:8859:d61 with SMTP id gt23-20020a17090af2d700b001ef88590d61mr30585783pjb.215.1658010316742;
        Sat, 16 Jul 2022 15:25:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:16 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/6] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Sat, 16 Jul 2022 18:24:53 -0400
Message-Id: <20220716222454.29914-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device can be a wakeup device, do not turn off the
regulators as the device will need them on.

Link: https://lore.kernel.org/r/20220106160332.2143-8-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 54 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 88339fde0df7..570c98594d47 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -264,6 +264,7 @@ struct brcm_pcie {
 	bool			refusal_mode;
 	bool			regulator_oops;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1301,9 +1302,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_info(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
 static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1322,11 +1335,22 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
 	}
 
 	if (pcie->sr) {
-		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn off regulators\n");
-			reset_control_reset(pcie->rescal);
-			return ret;
+		/*
+		 * Now turn off the regulators, but if at least one
+		 * downstream device is enabled as a wake-up source, do not
+		 * turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		pci_walk_bus(bridge->bus, pci_dev_may_wakeup,
+			     &pcie->ep_wakeup_capable);
+		if (!pcie->ep_wakeup_capable) {
+			ret = regulator_bulk_disable(pcie->sr->num_supplies,
+						     pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn off regulators\n");
+				reset_control_reset(pcie->rescal);
+				return ret;
+			}
 		}
 	}
 	clk_disable_unprepare(pcie->clk);
@@ -1371,11 +1395,21 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies,
-					    pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_reset;
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the suspend we
+			 * did not disable the power supplies, so there is
+			 * no need to enable them (and falsely increase their
+			 * usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+		} else {
+			ret = regulator_bulk_enable(pcie->sr->num_supplies,
+						    pcie->sr->supplies);
+			if (ret) {
+				dev_err(dev, "Could not turn on regulators\n");
+				goto err_reset;
+			}
 		}
 	}
 
-- 
2.17.1

