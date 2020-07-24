Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12922CFBA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGXUph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 16:45:37 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.232.150]:34322 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726801AbgGXUpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 16:45:36 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 140FC1A0495;
        Fri, 24 Jul 2020 13:36:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 140FC1A0495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1595622996;
        bh=XN+BpSBqlruC6dXl2kGreIgIavpEs23SMaE+m8V+Yo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V13wr/Ek5ZKdO9uBLueWPtrmkJ7Qi4tDuddj0aRXv4lBrDjoR6XY6yP104lNBb4de
         i2GnxKHN/VptEk/BaXm61krvkQUUx4KTUtCT8TPj2NCdM2Sso+DmUwQ25oCr/ZmNFC
         h1hAYjmoL+wYoX8YFcUWywSQnHm/OoO/puYhOcbM=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 76EFE140254;
        Fri, 24 Jul 2020 13:34:47 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 12/12] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list
Date:   Fri, 24 Jul 2020 16:33:54 -0400
Message-Id: <20200724203407.16972-13-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724203407.16972-1-james.quinlan@broadcom.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the support is in place with previous commits, we add several
chips that use the BrcmSTB driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 87a6f51d821a..49cbbc1405a1 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1187,6 +1187,10 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
+	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{},
 };
 
-- 
2.17.1

