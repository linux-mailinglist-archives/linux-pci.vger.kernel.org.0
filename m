Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0A25DB00
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgIDOKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 10:10:04 -0400
Received: from foss.arm.com ([217.140.110.172]:51062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbgIDOJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 10:09:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 588711045;
        Fri,  4 Sep 2020 07:09:14 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D123F71F;
        Fri,  4 Sep 2020 07:09:13 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()
Date:   Fri,  4 Sep 2020 15:09:04 +0100
Message-Id: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The root bus checks rework in:

commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")

caused a regression whereby in rockchip_pcie_valid_device() if
the bus parameter is the root bus and the dev value == 0 the
function should return 1 (ie true) without checking if the
bus->parent pointer is a root bus because that triggers a NULL
pointer dereference.

Fix this by streamlining the root bus detection.

Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..9705059523a6 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -71,16 +71,13 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 				      struct pci_bus *bus, int dev)
 {
-	/* access only one slot on each root port */
-	if (pci_is_root_bus(bus) && dev > 0)
-		return 0;
-
 	/*
-	 * do not read more than one device on the bus directly attached
+	 * Access only one slot on each root port.
+	 * Do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
 	 */
-	if (pci_is_root_bus(bus->parent) && dev > 0)
-		return 0;
+	if (pci_is_root_bus(bus) || pci_is_root_bus(bus->parent))
+		return dev == 0;
 
 	return 1;
 }
-- 
2.26.1

