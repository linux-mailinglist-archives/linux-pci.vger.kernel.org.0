Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857A23317C3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCHTvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhCHTvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 14:51:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A199C06174A;
        Mon,  8 Mar 2021 11:51:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b15so254441pjb.0;
        Mon, 08 Mar 2021 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=MR4so0u4aLw+FpC3OPyIZQuptiwXJSZIxuzhw3BjAlFwKoMbzFt/zZxKqRoUcMRTp7
         N+LJszTfcvp+Z2IpaQEbBpyd6A2wkYJHwHYYnaDA7veaVrU8J4dR5r1n2ZAmd9/wiumS
         oowFfgC00FREtFg0LvhiQ/Sc8OREtAEnq4h6UpIhvCkIn5Lj+TolXNpwYVmTDGs5XisY
         kRSTaaBMKNPynqJPP48YOOy6IzTzigwwHeJJFiRwdd5UhbrEj6BWhOgcW8sXqCb1O97T
         +MYw1KDqD+XjzPgyi15gGYijF9CLDiTqodDNJM34a8O6PRo4yJkDnXGrol93S3r7hxfb
         GFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3skkHZLGnNb4o4IjNFBvtLuN+EXmgZbKt3sCXgsAjA=;
        b=eNi4XuwbW8Id2L6sjU5I35ZrgV1c/f+2JscXXA8zYTUs8aM/y0Ob5CM7+H3IpJl5nB
         ije15Kte4ZVcA1guAu6Q9RzJQMPVECy1ZkARqvcV6Xs07ectOyXSluB/VsJzZfEhTKXg
         flxQ+Z994XOFjKzjsq/LCkY3SKpmy53jXlEVlXDZlXp2kfMoBXWK5xrv2h/NeFwoWNJ4
         m5SY/xB6aPrQ13CzVTkBFjsShcuCAVQr/6AE99hsffyUr0kdQGmF1yM6oXKUNSwXSZk9
         sQkrx6kIfbTes24gbFYlNOlnD1vTrxfMcZ7u8w/ZjR7CG4x/LMVyud+oOH1FtKTMcxfN
         kq6g==
X-Gm-Message-State: AOAM530yqN5HlIWwmV3oPdCoBEoRgosVtep1AW1lLcQrqNA6ZogEvgLw
        82DwQ5IMi+3m3sKE15Amvlc=
X-Google-Smtp-Source: ABdhPJzu1luD0rWLMCswTu+ky/7Wpeh7oH2TeMY7592yIP9uRwtYuY70u7UhlAP3foPMXphwTtswUA==
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr531226pjb.13.1615233060172;
        Mon, 08 Mar 2021 11:51:00 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y1sm64685pjr.3.2021.03.08.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:50:59 -0800 (PST)
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
Subject: [PATCH v4 1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Mon,  8 Mar 2021 14:50:36 -0500
Message-Id: <20210308195037.1503-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308195037.1503-1-jim2101024@gmail.com>
References: <20210308195037.1503-1-jim2101024@gmail.com>
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

