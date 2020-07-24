Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55B22CFC8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGXUpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 16:45:52 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.232.150]:34408 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgGXUpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 16:45:43 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id AF7F31A0403;
        Fri, 24 Jul 2020 13:36:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com AF7F31A0403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1595622993;
        bh=8GSFboYK0oeAhy/qjD7k9hQDV9Eog0D9xn/mkZHz9sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gL7qfUMUFWgkj4rR/2TEwcXSwICWscv44Q4WgdVsMReDs08alLA9dL5bNw8yZmByB
         CRLNgTP+/1QQlImHRrzNzrMVjzU69Ls9wDz0a+oadsvv5053Ym7g/uPDKDKUCysWB4
         ichDLjGVdOAgTMp/pbNVjCmsJpOcvw2URUwb0rYI=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CD9BF14020D;
        Fri, 24 Jul 2020 13:34:15 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 02/12] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 24 Jul 2020 16:33:44 -0400
Message-Id: <20200724203407.16972-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724203407.16972-1-james.quinlan@broadcom.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

A reset controller "rescal" is shared between the AHCI driver and the PCIe
driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared() to handle this sharing.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
---
 drivers/ata/ahci_brcm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6853dbb4131d..d6115bc04b09 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 
 	/* Reset is optional depending on platform and named differently */
 	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
+		priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
 	else
-		reset_name = "ahci";
+		priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
 
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
 	if (IS_ERR(priv->rcdev))
 		return PTR_ERR(priv->rcdev);
 
@@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
-- 
2.17.1

