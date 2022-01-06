Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B466486747
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiAFQEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbiAFQEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:04:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34AC061201;
        Thu,  6 Jan 2022 08:04:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iy13so2814378pjb.5;
        Thu, 06 Jan 2022 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UHomRXytyYgyL9vtpaE63/zjvL/tbxiA4ouQRYYuZNM=;
        b=c5EaoEwe0k4Y+kQIV5nbnpVpnij3u8gmP/HYggIXoYlNSEvMPLnJC2YgPb+PeLhYoT
         8UadcBboJznJOT1R9M3EfhTqcV6yUGz5bFxz5+EDQOknZ+UdlZCzqnb3rFnotQuUDUAk
         CBU8emUqfl/XtO5E3i5RMpAaaaKOFS9xMYCsDjzf/Q29aWqp09nbgZXGxoQmGsh8Yh1B
         pto/5wpZLodO0Ia4hUclXeiSILBIAaUAMUZPet147zwswHA3gAMCGnx5pdIBQ8eqj5Dn
         P05OgdMsdVUT1C+iseGBwrBYLgP5aNnFgtN7ia+2+bK10VwGX5bhMhT2wxQ1VIeoV2da
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UHomRXytyYgyL9vtpaE63/zjvL/tbxiA4ouQRYYuZNM=;
        b=OLTF1fK1+Dpv3dEvpfrY+JTDOWmMO1YsJ9DFD/oGN3eOUrHX0bp30GoK0vegO+QCpf
         QXAq2qQ31bjEC8v2ZyDbKHFJUBmgVGOZtYhr0jpJpxKfaP3qBnZZY7mDE8PTT5RrPiTV
         Dfk5M/WUACoo4B/5IlFKl8YMgJvjaT1BU+tszHRUzJVkBEdgtGeoiAakRCMJvC4OWrDs
         IwIpjXYr+LcGCzcxPz3a6TlTwNsaZGC7Oa9am/9BtG/2h+Wztp3PlhEqchIrp/oHXC2E
         UQyiwS1XPusuUPAHomSdvCBMwKFcAkK0XwwxAsOsikUOLMO71T7MwHGjxDUFxx+sym3r
         BbLw==
X-Gm-Message-State: AOAM532FxO6k4/5NlHFx5l/68HgXS6YPkaza+D95GA3LzxBrpBBOfXRt
        Q2K97Muug/TgmSp2GR3Jme0Zh9MSrA0=
X-Google-Smtp-Source: ABdhPJx6++vXFv73cMhMbu7dLZ1FYH3JW6xuu7wKmHwNUI65WS5IwVZh0B82ylv7LxL5ZzRpeFIaHA==
X-Received: by 2002:a17:902:c401:b0:149:7451:2200 with SMTP id k1-20020a170902c40100b0014974512200mr51383018plk.14.1641485039575;
        Thu, 06 Jan 2022 08:03:59 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:59 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 7/7] PCI: brcmstb: Do not turn off WOL regulators on suspend
Date:   Thu,  6 Jan 2022 11:03:30 -0500
Message-Id: <20220106160332.2143-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
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
index 3c1b2fefe7e1..8a3321314b74 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -308,6 +308,7 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
 	struct subdev_regulators *sr;
+	bool			ep_wakeup_capable;
 };
 
 /*
@@ -1269,9 +1270,21 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
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
@@ -1290,11 +1303,22 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1315,10 +1339,21 @@ static int brcm_pcie_resume(struct device *dev)
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

