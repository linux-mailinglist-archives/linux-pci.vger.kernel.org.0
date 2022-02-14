Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B682B4B4555
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbiBNJPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 04:15:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbiBNJPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 04:15:07 -0500
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92A60078
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 01:14:59 -0800 (PST)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nJWcG-0007ZZ-Cs; Mon, 14 Feb 2022 08:21:48 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nJWcG-004vz3-2K;
        Mon, 14 Feb 2022 08:21:48 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        david.abdurachmanov@gmail.com,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] PCI: fu740: fix finding GPIOs
Date:   Mon, 14 Feb 2022 08:21:43 +0000
Message-Id: <20220214082144.1176084-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214082144.1176084-1-ben.dooks@codethink.co.uk>
References: <20220214082144.1176084-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The calls to devm_gpiod_get_optional() have the -gpios at the end of
the name. This means the pcie driver is not finding the necessary
reset or power GPOOs to allow the PCIe devices on the SiFive Unmatched
boards.

This has not been a noted bug as the PCIe probe from u-boot has been
required to get the PCIe working due to other issues with the system
setup. It could have been broken since the driver inclusion, and not
been noticed as it is not necessary for the driver to funciton.

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

