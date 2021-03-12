Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2D33989F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhCLUqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhCLUqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 15:46:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD6AC061574;
        Fri, 12 Mar 2021 12:46:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so11646904pjv.1;
        Fri, 12 Mar 2021 12:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=TtA6PnyAmeRXacDS9DCmkoeLgkgx4pdBPKJmkZjN8kjevYUN2ApJwnN6n/JW8OESdO
         StXgBCcXkwgj4YWtSkF7Ay7MVoGBY8/JS4vV9rLK0rG1NePiBMUi/f68TN+JPBbjLmBR
         6m4M/DRcXyFHZjCrZJBc2Qze7fI16InG3uQZw8Fs5nz8TRpNEKw+lp7JBSUVQK51Yu61
         DDRro2q8qmZNZYe/Njx+taMiIL888VScxvhHco7SJIm8HsNeL7Ooptg+pEIGPji3roT/
         Vu/xKR/h6x8baH3uRBeNv+m9kajOPQfCnGircwac3WjE3tlc/W4rQZW04DefKgGrhVys
         D7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=bU77UdY3Kekb3jM89nGqlS9KvEvKVSfgryaKBgcshWBK+xX6KdFi7iUq0A6nkITxvF
         q0++UEGXl0iTeFc09n1EZ5EF4QRgaON/VFBiP9JOzy7IMU/fJO2RoPAjoBsoX0oje3WS
         BOEvuUAwu75b5eHwXZZj/Ce0D/XptujE/h02p5J+atlqdha/XLSAg+JY49TKOEwJYal/
         Iq6tb+Jbtxk4aq3WzP51Ywy53UuXnwxfBkFg2naQfjG4ziA0Ft9cAuh5vutv9T3XUzLg
         5IUdjSZZ+EU93wDZHoInHs9qp9DMkf/YbP7zFBHKekH6wP23Pod2F9t1xa5ktsCIaLyi
         F9jQ==
X-Gm-Message-State: AOAM531EWa31B4ivSHLd5+QkGQha1GzK6U2x7bh76FRmyzoByENWUkU6
        YDwV7JAYogaL7V6uv0gGLY0=
X-Google-Smtp-Source: ABdhPJy43CoYvtZs3wJc3/cX425cVohxjvouSF6VMAgTWKiG51EQU+z7X4KnUBgV4zHrE1y8Z2552g==
X-Received: by 2002:a17:90a:d911:: with SMTP id c17mr130953pjv.98.1615581980597;
        Fri, 12 Mar 2021 12:46:20 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i22sm2959613pjz.56.2021.03.12.12.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:46:20 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 12 Mar 2021 15:45:54 -0500
Message-Id: <20210312204556.5387-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312204556.5387-1-jim2101024@gmail.com>
References: <20210312204556.5387-1-jim2101024@gmail.com>
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

