Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385E045C8FC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbhKXPpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344461AbhKXPo5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 10:44:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6934160FE3;
        Wed, 24 Nov 2021 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637768507;
        bh=6tDf7XJQIJvtSbp9viQfuVz7wDd2WfE7mXusR8/VED8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pvhol1Ht81T34h17oByeGlEXxfM2tonYSzmIX43HESR6gMDHEIckCw4JaBtcvazJe
         elCaAg+GzntUtRo4XYbAqLgKE+rfDQWd6I7TkB1OdNM47rsIWK4Bzqr2Te5h80NtTv
         PN66gaFwWvKCOsWciD5cxa8asipHRnIeqco+vYaMMKo3Vr0sGiYPVWWlxYDGBK6EZx
         sAuS+otIAJB4VHm9bx1/gBy8z4ojFDLn84+Lfo5d/xivt8r3mkx8uGROlJHBKK7c5O
         1aq292rOQYMeW7s0H0J/AlN+h9tqEtcOEhUluhti0ZcCC4PMcBFm6403VjgKQw1DLp
         GAf6ee1a1IooQ==
Received: by pali.im (Postfix)
        id 28DAD56D; Wed, 24 Nov 2021 16:41:47 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] PCI: mvebu: Remove custom mvebu_pci_host_probe() function
Date:   Wed, 24 Nov 2021 16:41:14 +0100
Message-Id: <20211124154116.916-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124154116.916-1-pali@kernel.org>
References: <20211124154116.916-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now after pci_ioremap_io() usage was replaced by devm_pci_remap_iospace()
function, there is no need to use custom mvebu_pci_host_probe() function.
Current implementation of mvebu_pci_host_probe() is same as standard PCI
core functionn pci_host_probe(). So replace mvebu_pci_host_probe() call by
pci_host_probe() and remove custom mvebu_pci_host_probe() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 41 +-----------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a55b8bd5eb62..f2180e4630a1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1005,45 +1005,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 	return 0;
 }
 
-/*
- * This is a copy of pci_host_probe(), except that it does the I/O
- * remap as the last step, once we are sure we won't fail.
- *
- * It should be removed once the I/O remap error handling issue has
- * been sorted out.
- */
-static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
-{
-	struct pci_bus *bus, *child;
-	int ret;
-
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		dev_err(bridge->dev.parent, "Scanning root bridge failed");
-		return ret;
-	}
-
-	bus = bridge->bus;
-
-	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
-	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
-
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
-
-	pci_bus_add_devices(bus);
-	return 0;
-}
-
 static int mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1118,7 +1079,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
 
-	return mvebu_pci_host_probe(bridge);
+	return pci_host_probe(bridge);
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
-- 
2.20.1

