Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C606136FDA8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3PXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhD3PXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:23:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BDC06174A;
        Fri, 30 Apr 2021 08:22:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j189so2623506pgd.13;
        Fri, 30 Apr 2021 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1RYFyHGpmuSBGVIKtF2cRB9Rxzfh1Zoo7ktedPdj8k=;
        b=ijh00j9ZNOdICIFEeE+Blmg5hYFoxcaZjUS7BVCRANVXzftCwMyg1l2wjuJn6FSKxN
         mtKQFNFrLUIQkI+79cfkoryy6c+jjXYziq7uN31OnEZELbSRLhG7gvulAeAJH2uVz9Bs
         t20A6nUKrPZfc2IoNcFc9mG+/Zi+bL1FlEetVfY63TZjlfHkYWKToijLxuzK9WC4K6kV
         SEC3QENjgaG+mqDhc2d/+AKaShFGrOgsyvBB5s7+3FlXcPItQnUouaEt6hsAUYPBen8F
         UMTGrtzk1kq3MRb+KfWYkdWPq3whQSwyqbZfjXUjR4BzHW9FujJ0+QNGlqoICJKFHIga
         hUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S1RYFyHGpmuSBGVIKtF2cRB9Rxzfh1Zoo7ktedPdj8k=;
        b=I4snRSZzaqET7KD02UDR1MflmXPa/0ea+c28aEES7u3pJF69fE8cV70GbIb6ItgYYG
         xWdBib+WZknCZWyHFHMu9F6Gl3J7y1CBK1RTxAB9hTFRGAn1dHbVzASFatyikHC2Ru4N
         1LKqvaCrXBxD7Km/89cvs+Tz+w60WrIXAvVq1g6PnlgiVfZhtafzAASkl5QPqMa4PoE6
         WEpBq3uE90Im+cNrqXRUsITUIJY+OMW8VWfaW5ZA9wOulRLcr2P+i8qukd51i9WIwsHP
         w4rjbsoqwzTV9ZfwaaLXKCeMro4sGRmmy8VVTS8LWilWRcKdO+fRWlsNIRr7xZv0E57T
         Rthg==
X-Gm-Message-State: AOAM533gpgfrmfN5DeQTTe3cp91yTmKAqx/WjjXAp8VBQqgR6AwntwAJ
        oMomjCl80rUW7u1DZakGP8Y=
X-Google-Smtp-Source: ABdhPJx21aO2czAx4J1Wd952RkDiotpIsu+3OxvKIr7dWfLKb4o/OwejjnrGvx2h0udaMDO/3pHcBw==
X-Received: by 2002:a63:4442:: with SMTP id t2mr5220942pgk.232.1619796132567;
        Fri, 30 Apr 2021 08:22:12 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q128sm2543034pfb.67.2021.04.30.08.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:22:12 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/3] PCI: brcmstb: Use reset/rearm instead of deassert/assert
Date:   Fri, 30 Apr 2021 11:21:56 -0400
Message-Id: <20210430152156.21162-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430152156.21162-1-jim2101024@gmail.com>
References: <20210430152156.21162-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom STB PCIe RC uses a reset control "rescal" for certain chips.
The "rescal" implements a "pulse reset" so using assert/deassert is wrong
for this device.  Instead, we use reset/rearm.  We need to use rearm so
that we can reset it after a suspend/resume cycle; w/o using "rearm", the
"rescal" device will only ever fire once.

Of course for suspend/resume to work we also need to put the reset/rearm
calls in the suspend and resume routines.

Fixes: 740d6c3708a9 ("PCI: brcmstb: Add control of rescal reset")
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e330e6811f0b..3b35d629035e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1148,6 +1148,7 @@ static int brcm_pcie_suspend(struct device *dev)
 
 	brcm_pcie_turn_off(pcie);
 	ret = brcm_phy_stop(pcie);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
 	return ret;
@@ -1163,9 +1164,13 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
+	ret = reset_control_reset(pcie->rescal);
+	if (ret)
+		goto err_disable_clk;
+
 	ret = brcm_phy_start(pcie);
 	if (ret)
-		goto err;
+		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
 	pcie->bridge_sw_init_set(pcie, 0);
@@ -1180,14 +1185,16 @@ static int brcm_pcie_resume(struct device *dev)
 
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
-		goto err;
+		goto err_reset;
 
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
 	return 0;
 
-err:
+err_reset:
+	reset_control_rearm(pcie->rescal);
+err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
 }
@@ -1197,7 +1204,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
 	brcm_phy_stop(pcie);
-	reset_control_assert(pcie->rescal);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 }
 
@@ -1278,13 +1285,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->perst_reset);
 	}
 
-	ret = reset_control_deassert(pcie->rescal);
+	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
-		reset_control_assert(pcie->rescal);
+		reset_control_rearm(pcie->rescal);
 		clk_disable_unprepare(pcie->clk);
 		return ret;
 	}
-- 
2.17.1

