Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F452247944
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgHQVyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 17:54:22 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48022 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728911AbgHQVyF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2020 17:54:05 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id B336F30C21D;
        Mon, 17 Aug 2020 14:51:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com B336F30C21D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1597701102;
        bh=MVKnHofXfl3a/kwmlp3uLEypAC3F0RQCdnCsruku8/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyA9UF2uUljdCPwop32CU+FXwOTtjirxpypmyN+g6lyOEO+e6wAkd57/pxB7xHiPw
         stciXlOZNcq4YLW2VmFMzzVIIHTo3mzW69GKLWKDEBqUXFBxGS7NFPQuT9/YHdSheM
         HDKB5yPzRbfLenijYN1OipXG2OfGCE0+3X5bH9qY=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 0615A14008C;
        Mon, 17 Aug 2020 14:54:03 -0700 (PDT)
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
Subject: [PATCH RESEND v10 11/11] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445, bcm7278 to match list
Date:   Mon, 17 Aug 2020 17:53:13 -0400
Message-Id: <20200817215326.30912-12-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817215326.30912-1-james.quinlan@broadcom.com>
References: <20200817215326.30912-1-james.quinlan@broadcom.com>
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
index acde92d595e5..d961794fb5a0 100644
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

