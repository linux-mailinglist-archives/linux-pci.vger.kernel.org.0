Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6606B2DC875
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLPVmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 16:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgLPVmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 16:42:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8BC061282;
        Wed, 16 Dec 2020 13:41:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x18so7597959pln.6;
        Wed, 16 Dec 2020 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gebM/NY4tNWgCbFYoE1q1n2pn/ZSQVXoyJa8i4huQEA=;
        b=ZpFwhAYJnQOhYj1DBW6mjhUKcZBOXlH2zUWH77qTM+k+RpdLu/8zybD83BcsmaLI6r
         vmxaUel8bKoTlV8FmShRwhdvODKqLA/zW8465LYQf2AoZ8KYOX3j0LIMTWnZbpZv2QPV
         uQ0MkxZKWiJVwcmzXEu13yC+2tLKXj30Mb3JZZr1bgmoBANgsrm3jT4f3DDfOscUWd83
         mBMbINTdhwgjEajSUDMKzzJj4m7B0kijTe0cvwCTQu64tVQLWkYpFrsrz3KaC6AXajKn
         B8+MI3qGApDzo0ATU31U66fQO6u8ddKP0T8h6jrbW1tyWCpXLqiyu+1I/buplOmaG8wm
         abBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gebM/NY4tNWgCbFYoE1q1n2pn/ZSQVXoyJa8i4huQEA=;
        b=sGu9rnNWr2h+a64MT66dxEHh9EiH/VreojnfoD/FSXw19EkUJ/8hTcXiadbv0w7hK9
         eHJDMjxOr96IQeB2jNdFW6rTEnH2c+kccOYZin1fmZ/pqHUuHU9l+R+3dJaa/JRWzfJm
         X/j5nl9kqS4BJZQ6JHRWDmOc2TY/qKHW3w43yM2beurtcn5FgC135HZoozY4UH5+lXFM
         4IthIA5MVep3SJeNFwNMxncApT8fn439j5/hNBvcMHsKt8lpD7ECupenCgFZIm39YuQl
         7yqBP47BQoHq1ltiBbjjFax2AxNBphLj8PJmyWOg1dW8ernjW3TE2V9INsS/MCJTURp+
         sDTQ==
X-Gm-Message-State: AOAM532K+yUFdkoDn5KFoiGkrdK8eJclhGF4KpgpCERkKHTmOGSdnYzt
        ePiIL4yfLadWuOI+Sp7T6hM=
X-Google-Smtp-Source: ABdhPJxU2B8fjTcmWTWUY6yEypICiX3JcviG8S60c0wlkzRuYMoWGQgdMUmJF+vNJF/AzJBFf+VNxw==
X-Received: by 2002:a17:902:7c92:b029:dc:1425:e5af with SMTP id y18-20020a1709027c92b02900dc1425e5afmr5621721pll.3.1608154897573;
        Wed, 16 Dec 2020 13:41:37 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h12sm3612237pgf.49.2020.12.16.13.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 13:41:37 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v3 2/2] PCI: brcmstb: use reset/rearm instead of deassert/assert
Date:   Wed, 16 Dec 2020 16:41:05 -0500
Message-Id: <20201216214106.32851-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216214106.32851-1-james.quinlan@broadcom.com>
References: <20201216214106.32851-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Brcmstb PCIe RC uses a reset control "rescal" for certain chips.  This
reset implements a "pulse reset" so it matches more the reset/rearm
calls instead of the deassert/assert calls.

Also, add reset_control calls in suspend/resume functions.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d41257f43a8f..9f190db4cfcf 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1127,6 +1127,7 @@ static int brcm_pcie_suspend(struct device *dev)
 
 	brcm_pcie_turn_off(pcie);
 	ret = brcm_phy_stop(pcie);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
 	return ret;
@@ -1142,9 +1143,13 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
+	ret = reset_control_reset(pcie->rescal);
+	if (ret)
+		goto err0;
+
 	ret = brcm_phy_start(pcie);
 	if (ret)
-		goto err;
+		goto err1;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
 	pcie->bridge_sw_init_set(pcie, 0);
@@ -1159,14 +1164,16 @@ static int brcm_pcie_resume(struct device *dev)
 
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
-		goto err;
+		goto err1;
 
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
 	return 0;
 
-err:
+err1:
+	reset_control_rearm(pcie->rescal);
+err0:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
 }
@@ -1176,7 +1183,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
 	brcm_phy_stop(pcie);
-	reset_control_assert(pcie->rescal);
+	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 }
 
@@ -1251,13 +1258,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->rescal);
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

