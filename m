Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD51C3398A1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhCLUqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhCLUq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 15:46:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A9C061574;
        Fri, 12 Mar 2021 12:46:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so11645364pjb.0;
        Fri, 12 Mar 2021 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1RYFyHGpmuSBGVIKtF2cRB9Rxzfh1Zoo7ktedPdj8k=;
        b=OfLEhdslmGxo+bf0qx9JW1v1Ahu1izq8hxueThidOekrhcwQdNDNnpG0oR9jbskhCn
         qtb+ouMqjIA78dC1ABjMCAWI5gX+9YqPlmUALycYdMf4kwzju1QxLcgrWbcFdImRueWZ
         D+jx/VBsZAY7FhXdBWPaJr9QTY6gHULzkbY4+MS+SczGW+Iqbjs6pOMAMTXj/7vfsFaI
         L+dujKdHxCRr2RMRI+favzmJAtJbzKLEMXsGza3sbyRtGqn9D+m/zVBf1xZeI5/bOJlf
         I5Hnf01xXcs+Ig9CKqF+57JWwbKajfIxmA39dCxr9SX/dWAReF6jQ1Fqevgo9WXBt6y4
         jplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S1RYFyHGpmuSBGVIKtF2cRB9Rxzfh1Zoo7ktedPdj8k=;
        b=SHUki64fRf42YkML9lYA4j4ClOoRYlgF2GEhVBHW3au4eHzewgd8LOXSADkUfZ7OC1
         m/h7pImdT0WkG5YWJh9k6mO09e9fUDI8TuWJDj3VVn31LyjC+p/BXNXqBi7rIZdlB1hd
         zuJ6PraExiJ6uYhd321va1MEJmFQpY+L/o4UL1UlwhTMnCShzhGbbyYpEh6EYAp4fZaU
         xlr8d3pM7dImCM1UUCzxpq3dVVcMkjaU/JOdTdcvRgHzz9UwlV7U11it10Aw7Ks/VRZP
         Oy6ZBhYV4AUWnjEIUgH5nRvvBmggz+81CSthyz4VykJZ+4lw8z3O41918dIPsbWq1B/U
         jEjA==
X-Gm-Message-State: AOAM533kxO1Aw+WLIPTqh2Qcsm65Ymu8haGn1EakTkmvgLykc7lGZ9CH
        +Js0mfOKZNeGKXGfIUUo091GV2L/q2I=
X-Google-Smtp-Source: ABdhPJypoqz4Lq9DD5u+edyaYE5Ubq0+FVoG46J90KrJU59Cjl56/OUESzzqONi5G+pU7jP1qDWj4w==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr110751pjf.41.1615581988954;
        Fri, 12 Mar 2021 12:46:28 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i22sm2959613pjz.56.2021.03.12.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:46:28 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/2] PCI: brcmstb: Use reset/rearm instead of deassert/assert
Date:   Fri, 12 Mar 2021 15:45:55 -0500
Message-Id: <20210312204556.5387-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312204556.5387-1-jim2101024@gmail.com>
References: <20210312204556.5387-1-jim2101024@gmail.com>
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

