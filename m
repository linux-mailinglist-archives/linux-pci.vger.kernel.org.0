Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEE457888
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhKSWLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhKSWLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:21 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AAC061756;
        Fri, 19 Nov 2021 14:08:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 206so4702677pgb.4;
        Fri, 19 Nov 2021 14:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ejdtBcGu/O1Cxw2YS57FB14hxKmb2vB0wySR/Hf7zE=;
        b=jdKk9h0KGCz7rzKg7MWOpNLiwNJ+xR77xNz2Lxp2dg9w7GUe0LJGBzukoh9vYX6vZX
         1D2J6dPOj7CrAIBuw5Iwep3uFzwg8/YkZgqNoW5OOL19QSCkrmdf3qpHqurRgL9OTAe7
         xgGk5YkPXlhjKZ83iVhlC37YjNkit/aIb2fCMRvx6cmTHZD8Qi2IRh05HRGQzgWKtuf6
         4VG75KaQ4B9pPt71kJsmMqWMeyaPEEg0eqjLIXc6+JQUHFoQF/LR+qEAKWwv0wsml8L/
         KMO6G4As02e//7bphr0MS5/ZRo+KJ+IGtSG7RNOJ+1fc8hXDauiIBgRICwZcLWmtPkYU
         Nsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ejdtBcGu/O1Cxw2YS57FB14hxKmb2vB0wySR/Hf7zE=;
        b=LT1d/sSbFKv1PRYPK9qiXRmbQeEMG+dR6XoDB1IEHZy+IEtcwvlPMCtWAlkBLhgCSY
         lyJeyR2yPziDT3JjwdAfa/Stm5MBK+X4FgSMAxNI64JGmymKiQCbqFEY6C6Zi4VbS5iv
         cEcIFxePgFCOnOQNbE87fBI5vzQHiQbijhCPSAAXJDysMoiXV9D9/c4heXVppR0Eif29
         rq01Cm9p/Sz4P2d7LDw8M7ICsbeOm3833LVuzrd1b7JNfocv2sO2DL6cMx5kwrhxTKj2
         vB/guV3AXVUHgK2/HCFKYvztP/OmStPHwEL+4yZjuZAssoxLZAiEL3H3V7MQCC8QPEgx
         rqAQ==
X-Gm-Message-State: AOAM533qsCguAhwRwJBMofaZCBVyL3G3XoWwg+Le80tZ41emIKh8YYXx
        AZSszuQG29oCZIfMKtqeCG/YHjKbp3OPnA==
X-Google-Smtp-Source: ABdhPJxfHsOlCGlDapHzJKdRp+W1ALfXhzzHf0u5YLalK3nbMWxxpORK+mLoBIIEPwEk6dmSgOWegA==
X-Received: by 2002:a63:454:: with SMTP id 81mr19078349pge.24.1637359698006;
        Fri, 19 Nov 2021 14:08:18 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:17 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 7/7] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Fri, 19 Nov 2021 17:07:54 -0500
Message-Id: <20211119220756.18628-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device can be awoken do not turn off
the regulators as the device will need them on.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 53 ++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9b4df253e79a..8e5cbf6850cd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -298,6 +298,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 /*
@@ -1166,9 +1167,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
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
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	int ret;
 
 	brcm_pcie_turn_off(pcie);
@@ -1187,11 +1200,22 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1212,10 +1236,21 @@ static int brcm_pcie_resume(struct device *dev)
 		return ret;
 
 	if (pcie->sr) {
-		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
-		if (ret) {
-			dev_err(dev, "Could not turn on regulators\n");
-			goto err_disable_clk;
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
+				goto err_disable_clk;
+			}
 		}
 	}
 
-- 
2.17.1

