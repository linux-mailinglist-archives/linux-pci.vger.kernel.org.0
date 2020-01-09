Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A291351EF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 04:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgAID3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 22:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgAID3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 22:29:03 -0500
Received: from localhost (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF77206F0;
        Thu,  9 Jan 2020 03:29:02 +0000 (UTC)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jun Nie <jun.nie@linaro.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/2] PCI: histb: Correct PCIe reset operation
Date:   Thu,  9 Jan 2020 11:28:51 +0800
Message-Id: <20200109032851.13377-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109032851.13377-1-shawn.guo@linaro.org>
References: <20200109032851.13377-1-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe reset via GPIO in the driver never worked as expected.  Per
"Power Sequencing and Reset Signal Timings" table in
PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, the PERST# should be
deasserted after minimum of 100us once REFCLK is stable.

The assertion has been done when the GPIO is being requested, and
deassertion should be done in host enabling rather than disabling. Also
a bit wait is added to ensure device get ready after reset.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pci/controller/dwc/pcie-histb.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 112254619ed0..67c27a8036c7 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -219,9 +219,6 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 	clk_disable_unprepare(hipcie->sys_clk);
 	clk_disable_unprepare(hipcie->bus_clk);
 
-	if (hipcie->reset_gpio)
-		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
-
 	if (hipcie->vpcie)
 		regulator_disable(hipcie->vpcie);
 }
@@ -242,9 +239,6 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 		}
 	}
 
-	if (hipcie->reset_gpio)
-		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
-
 	ret = clk_prepare_enable(hipcie->bus_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable bus clk\n");
@@ -278,6 +272,20 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 	reset_control_assert(hipcie->bus_reset);
 	reset_control_deassert(hipcie->bus_reset);
 
+	if (hipcie->reset_gpio) {
+		/*
+		 * "Power Sequencing and Reset Signal Timings" table in
+		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, indicates
+		 * PERST# should be deasserted after minimum of 100us
+		 * once REFCLK is stable.
+		 */
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
+
+		/* wait 1ms for device to be ready */
+		usleep_range(1000, 2000);
+	}
+
 	return 0;
 
 err_aux_clk:
-- 
2.17.1

