Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA44BEC33
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiBUVEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 16:04:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiBUVEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 16:04:20 -0500
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD723BCD;
        Mon, 21 Feb 2022 13:03:55 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nMFqW-0000u1-RF; Mon, 21 Feb 2022 21:03:48 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nMFqW-005bIY-9j;
        Mon, 21 Feb 2022 21:03:48 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     paul.walmsley@sifive.com, greentime.hu@sifive.com
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCHv4 1/2] PCI: fu740: fix finding GPIOs
Date:   Mon, 21 Feb 2022 21:03:46 +0000
Message-Id: <20220221210347.1335004-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The calls to devm_gpiod_get_optional() have the -gpios at the end of
the name but the GPIO core code is already adding the suffix during
the lookup. This means the PCIe driver is not finding the necessary
reset or power lines to allow initialisation of the PCIe.

This bug has not been noticed as if U-Boot has setup the GPIO lines
for the hardware when it does the PCIe initialisation (either by
booting from PCIe or user command to access PCIe) then the PCIe
will work in Linux. The U-Boot as supplied by SiFive does not by
default initialise any PCIe component.

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

