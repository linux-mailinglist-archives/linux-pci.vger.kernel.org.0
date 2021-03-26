Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA05E34AF39
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZTTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhCZTTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72ABC0613AA;
        Fri, 26 Mar 2021 12:19:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y6so7554606eds.1;
        Fri, 26 Mar 2021 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aRGVWfDxNXOJckN8x4iVoENPxOwno7jCXTgCsRiW338=;
        b=fhc+yzrE/z+CWOtndebBylxn1QIw88dre7bmz0hmlsJ84Sj6NyudXUnUiZxwxUe+he
         pq15Jcdf43l2ZgzhJ1kWhqGBWyUECV2gUsGB0QgE2lfzC97p7puVbJcQfhDNTSbteNzM
         5Jfo+W8RPRE06lMROGyCb9cdAh5Vt9IB6U1TwoFNB7VJ1ybkvZ0usXc/keEvkL/riry8
         HcqZeZg4qgD2RBEhJza0BIBtNeNq4k5jqkLmyYnhmCfYWHssD4ZFed+UBKpTFgA4PNjH
         5p5hEHRt066Vz95OdG4cO4v8nHNLuJK6cNPeQUO6fbOzjz95R8lfoeET/YB1FRqIVxnZ
         Kg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aRGVWfDxNXOJckN8x4iVoENPxOwno7jCXTgCsRiW338=;
        b=RNq6C2Zc1BoIo6hCVT4c2KAx8QjSu1YmYabDnrZmtJHsCh7GLIejQQSifQ7/NR4iYH
         N6ch5wMF4zCve4/3nF1rHgDpHemVtb5Z1pfQ0NNSHjGtycgLsKoRzTsL1DdpMm8o6FhP
         LXOUdWiWIeeocVQ9t7hU/7+j9X0xt77GFUxD2zX59tOrSyR2zkQLY3GKTOn+ZVRfVpeY
         WSmEbu6AhFFk/7M7PzGVlEu1Cr8NM8u/H81VB1BnpgkMNtXwBmHk1RoqSYfLLehXx9Mm
         qphuZSKFysycvGlK8pdNPYbrCZA8UCOBE/MYH15eE25pX0G5PjUna3H/lUCe4oBhpfn3
         3ztw==
X-Gm-Message-State: AOAM532bv2VqsbpVMayPuY5RLBhYTA1Ybgg3mLWAWpx4IT95bo7Uxmwi
        DBtTyVkIBY/VDg30XPQaT3pe8sK3K/w=
X-Google-Smtp-Source: ABdhPJw4elY6W9cfQuMiOKMYTuCL7b1gW0Zn04QBKF0fyxgs+fwH+RuJke3SmnIdGFbDYT8FPRzdZA==
X-Received: by 2002:a05:6402:312b:: with SMTP id dd11mr16712199edb.149.1616786358870;
        Fri, 26 Mar 2021 12:19:18 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:18 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/6] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Fri, 26 Mar 2021 15:19:01 -0400
Message-Id: <20210326191906.43567-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326191906.43567-1-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 58 +++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index b76ec7d9af32..89745bb6ada6 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -193,6 +193,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -299,22 +300,65 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
 	unsigned int		num_supplies;
+	bool			ep_wakeup_capable;
 };
 
-static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
 {
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
+enum {
+	TURN_OFF,		/* Turn egulators off, unless an EP is wakeup-capable */
+	TURN_OFF_ALWAYS,	/* Turn Regulators off, no exceptions */
+	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */
+};
+
+static int brcm_set_regulators(struct brcm_pcie *pcie, int how)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
 	if (!pcie->num_supplies)
 		return 0;
-	if (on)
+	if (how == TURN_ON) {
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the
+			 * previous suspend we did not disable the power
+			 * supplies, so there is no need to enable them
+			 * (and falsely increase their usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+			return 0;
+		}
+	} else if (how == TURN_OFF) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		if (bridge->bus && brcm_pcie_link_up(pcie)) {
+			pci_walk_bus(bridge->bus, pci_dev_may_wakeup, &pcie->ep_wakeup_capable);
+			if (pcie->ep_wakeup_capable)
+				return 0;
+		}
+	}
+
+	if (how == TURN_ON)
 		ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	else
 		ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to %s EP regulators\n",
-			on ? "enable" : "disable");
+			how == TURN_ON ? "enable" : "disable");
 	return ret;
 }
 
@@ -1218,7 +1262,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	brcm_phy_stop(pcie);
 	clk_disable_unprepare(pcie->clk);
 
-	return brcm_set_regulators(pcie, false);
+	return brcm_set_regulators(pcie, TURN_OFF);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1231,7 +1275,7 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
-	ret = brcm_set_regulators(pcie, true);
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		return ret;
 
@@ -1271,7 +1315,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
-	brcm_set_regulators(pcie, false);
+	brcm_set_regulators(pcie, TURN_OFF_ALWAYS);
 	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
 }
 
@@ -1369,7 +1413,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	ret = brcm_set_regulators(pcie, true);
+	ret = brcm_set_regulators(pcie, TURN_ON);
 	if (ret)
 		goto fail;
 
-- 
2.17.1

