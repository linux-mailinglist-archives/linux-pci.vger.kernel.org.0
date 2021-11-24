Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E293845C8FB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbhKXPpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344472AbhKXPo5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 10:44:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0CBC6102A;
        Wed, 24 Nov 2021 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637768508;
        bh=B4KwqLhItoYGnyJ9ogfHgJBcg/G5wxI+LrCO4toFBSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smfTHi3C0BGbB+Tqh/ucp+n9eBQJakBTr/g9WyHJT4bHTI+7e7kmHjwDrL3dkZibA
         kvBCQ7h/VfXzR1L/Fjlb2468A7ADDlt+xz/jAqCG39yQpcgRjJiKBlcyDh0UjjfJ7b
         5NcW/WxA1AYwYrsO3rqW6OmI2Dsa2a/gVgDjK6KNl6spgubhlZP1TpbF+Ugp3tInxg
         Ntw+g+mzL/TD9tqwHddURa2qHoValYWcRNdInuqPKPhWt6o+6g+Z/8dJE8vnerrXXr
         YYrRnmdMLMOBI2bpC1Yx4fnhqoAph1qPZs9Q4qqT0t9C5GmSuVPWBAAXx2ZYY7R1g4
         pt2bs24uzZmDA==
Received: by pali.im (Postfix)
        id 177ECB01; Wed, 24 Nov 2021 16:41:46 +0100 (CET)
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
Subject: [PATCH 2/5] PCI: mvebu: Replace pci_ioremap_io() usage by devm_pci_remap_iospace()
Date:   Wed, 24 Nov 2021 16:41:13 +0100
Message-Id: <20211124154116.916-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124154116.916-1-pali@kernel.org>
References: <20211124154116.916-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now when ARM architecture code also provides standard PCI core function
pci_remap_iospace(), use its devm_pci_remap_iospace() variant in
pci-mvebu.c driver instead of old ARM-specific pci_ioremap_io() function.

Call devm_pci_remap_iospace() before adding IO resource to host bridge
structure, at the place where it should be.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..a55b8bd5eb62 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -992,6 +992,10 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 					 resource_size(&pcie->io) - 1);
 		pcie->realio.name = "PCI I/O";
 
+		ret = devm_pci_remap_iospace(dev, &pcie->realio, pcie->io.start);
+		if (ret)
+			return ret;
+
 		pci_add_resource(&bridge->windows, &pcie->realio);
 		ret = devm_request_resource(dev, &ioport_resource, &pcie->realio);
 		if (ret)
@@ -1010,7 +1014,6 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
  */
 static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
 {
-	struct mvebu_pcie *pcie;
 	struct pci_bus *bus, *child;
 	int ret;
 
@@ -1020,14 +1023,6 @@ static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
 		return ret;
 	}
 
-	pcie = pci_host_bridge_priv(bridge);
-	if (resource_size(&pcie->io) != 0) {
-		unsigned int i;
-
-		for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
-			pci_ioremap_io(i, pcie->io.start + i);
-	}
-
 	bus = bridge->bus;
 
 	/*
-- 
2.20.1

