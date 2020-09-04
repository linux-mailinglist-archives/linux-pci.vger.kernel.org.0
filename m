Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8725DB87
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 16:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgIDOZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 10:25:45 -0400
Received: from foss.arm.com ([217.140.110.172]:51340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730536AbgIDOVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 10:21:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF5EB1045;
        Fri,  4 Sep 2020 07:21:43 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C2E33F71F;
        Fri,  4 Sep 2020 07:21:42 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: Remove useless msi_controller allocation/initialization
Date:   Fri,  4 Sep 2020 15:21:32 +0100
Message-Id: <20200904142132.6054-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The mvebu host controller driver allocates an msi_controller structure
without assigning its methods.

This means that the PCI IRQ MSI layer ignores it and that after all it
should not really be needed.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c39978b750ec..eee82838f4ba 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -12,7 +12,6 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
-#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
@@ -70,7 +69,6 @@ struct mvebu_pcie_port;
 struct mvebu_pcie {
 	struct platform_device *pdev;
 	struct mvebu_pcie_port *ports;
-	struct msi_controller *msi;
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
@@ -1127,7 +1125,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
-	bridge->msi = pcie->msi;
 
 	return mvebu_pci_host_probe(bridge);
 }
-- 
2.26.1

