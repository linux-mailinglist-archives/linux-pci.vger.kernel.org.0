Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63CE36FDA6
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhD3PW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhD3PW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:22:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD45C06174A;
        Fri, 30 Apr 2021 08:22:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so1899322pjd.4;
        Fri, 30 Apr 2021 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=WoDbvr6t/6Loj2/scnIAb91IbA+zVIaMfZeXgj0IxEJhYC8AeHjT+XRLcRxSVStpK+
         nZ4ARSTII+GkdVn9yLEWV98cADWaLs3Kl/NBsTuY1cE24bbiwikdljXHaG/dQAdyCxxg
         Qa99KSDMnThjWYmCie5xVadH+hqOJVshOcM7wj8NYq7x1pO1hsemnlBEEbqMoHX70xGz
         jr0UQPJMVhEuN7SrT4j/CNYcIa24uy7YGj29iofTG5S2BZ1g3nOh1KGb/RYQNep/hVoE
         OW3Qo+MX1TxhWpZUf0tG2V6Yh6zdOtwS9bo666FEjQ6Csatziyefxrd7DByGUMlARFro
         yzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=WHZdoU1VL1egOrlqYJh6MMy9ZnQrsuACE1Ak+k/DgUNMI8UEC13qBh7Jw3QR/riAhe
         Hh9EyDDKOzx9D50xkzhhqswIr1FeBHCI7ryXzoMbI8Jm2xcj1ZxbpMBkG8hV+FCtpDMK
         T8YTF75SfSALMDhAidmBje3ft1Pvry+tYNDVTsc+RWmHZSOpSjZkyXDbLYshEoTDd/AD
         Z9K3DXYmRJQoThwLdxE0kcnPlv0sC7iEfatFcnUfQ6RDfITv5FLHSZj0qWTYdYuiKAEP
         WLuf1N2ZDBwHHEla9rfS0V93MNhUv5j2T2+RKLQEuj8FN3Zp9Xc/CKPRPAX82OBoLNYh
         ZCoA==
X-Gm-Message-State: AOAM531zvSR65Vu1zxFBrehWw8PXHgc5LSSMu7TCSOQp0Jxtpb3yqc3m
        BJNMeu3DRKTHcbF3iSiFZWE=
X-Google-Smtp-Source: ABdhPJyesoTBoOlJsdQFzeeDalnE9+cMIF/D+W8IOW9QPE5FGnFgw5HWDZWx8ieMAUQnRDMMlpxT/A==
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr5839797pjq.149.1619796129594;
        Fri, 30 Apr 2021 08:22:09 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q128sm2543034pfb.67.2021.04.30.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:22:09 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/3] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 30 Apr 2021 11:21:55 -0400
Message-Id: <20210430152156.21162-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430152156.21162-1-jim2101024@gmail.com>
References: <20210430152156.21162-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver may use one of two resets controllers.  Keep them in separate
variables to keep things simple.  The reset controller "rescal" is shared
between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared() to handle this sharing.

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 5b32df5d33ad..6e9c5ade4c2e 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -86,7 +86,8 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
-	struct reset_control *rcdev;
+	struct reset_control *rcdev_rescal;
+	struct reset_control *rcdev_ahci;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -352,8 +353,8 @@ static int brcm_ahci_suspend(struct device *dev)
 	else
 		ret = 0;
 
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 
 	return ret;
 }
@@ -365,10 +366,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev_ahci);
+	if (ret)
+		return ret;
+	ret = reset_control_reset(priv->rcdev_rescal);
 	if (ret)
 		return ret;
 
@@ -434,7 +435,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -456,15 +456,15 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	/* Reset is optional depending on platform and named differently */
-	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
-	else
-		reset_name = "ahci";
-
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
-	if (IS_ERR(priv->rcdev))
-		return PTR_ERR(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216) {
+		priv->rcdev_rescal = devm_reset_control_get_optional_shared(
+			&pdev->dev, "rescal");
+		if (IS_ERR(priv->rcdev_rescal))
+			return PTR_ERR(priv->rcdev_rescal);
+	}
+	priv->rcdev_ahci = devm_reset_control_get_optional(&pdev->dev, "ahci");
+	if (IS_ERR(priv->rcdev_ahci))
+		return PTR_ERR(priv->rcdev_ahci);
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
@@ -485,10 +485,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_reset(priv->rcdev_rescal);
+	if (ret)
+		return ret;
+	ret = reset_control_deassert(priv->rcdev_ahci);
 	if (ret)
 		return ret;
 
@@ -539,8 +539,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 	return ret;
 }
 
-- 
2.17.1

