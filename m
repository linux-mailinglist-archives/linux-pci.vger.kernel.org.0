Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC74A9DCA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiBDRin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 12:38:43 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:58386 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243667AbiBDRil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 12:38:41 -0500
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nG2Xa-0006Bi-R8; Fri, 04 Feb 2022 17:38:34 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nG2Xa-001BJQ-FL;
        Fri, 04 Feb 2022 17:38:34 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     paul.walmsley@sifive.com, greentime.hu@sifive.com
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] PCI: fu740: fix finding gpios
Date:   Fri,  4 Feb 2022 17:38:21 +0000
Message-Id: <20220204173821.281784-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The calls to devm_gpiod_get_optional() have the -gpios on
the name. This means the pcie driver is not finding the
necessary reset or power gpios to allow the pcie devices
on the SiFive Unmatched boards.

Note, this was workng around 5.16 and may not have been
broken? There is still an issue if uboot has not probed
the pcie bus then there are no pcie devices shown when
Linux is started.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 00cde9a248b5..842b7202b96e 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(afp->mgmt_base);
 
 	/* Fetch GPIOs */
-	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
+	afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(afp->reset))
 		return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get reset-gpios\n");
 
-	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
+	afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
 	if (IS_ERR(afp->pwren))
 		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
 
-- 
2.34.1

