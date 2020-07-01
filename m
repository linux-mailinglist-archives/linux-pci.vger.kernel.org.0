Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93A2114E7
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 23:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGAVWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 17:22:13 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43222 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbgGAVWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2020 17:22:12 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 9813B30C0C1;
        Wed,  1 Jul 2020 14:22:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 9813B30C0C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1593638530;
        bh=wMcRiDP4Wvw9D413aeqotR4mafwEoV1r2WAiCdjiDuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtYg1I3HXbWRf1pKA483kdaLgh+ENkGe2dAend1U2Rn3CNBYYmRlcKAwRrqHinqeh
         +OytabA/cOt6C4RwlcP6pCJ43Gugjoboh3WJquCcj0/1KV4qF45jGsWTwnnF7q4Cuj
         0CYIPxBoUvI09X6qyRhLu1whX3vqtUdkMJ8PglWM=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CCE2F140069;
        Wed,  1 Jul 2020 14:22:08 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/12] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Wed,  1 Jul 2020 17:21:32 -0400
Message-Id: <20200701212155.37830-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701212155.37830-1-james.quinlan@broadcom.com>
References: <20200701212155.37830-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

A reset controller "rescal" is shared between the AHCI driver and the PCIe
driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared control() to handle this sharing.

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

