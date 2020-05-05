Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3411C556B
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 14:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEEM2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 08:28:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50795 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgEEM2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 08:28:19 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVwgB-0006Vr-46; Tue, 05 May 2020 12:28:07 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Wilczynski <kw@linux.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI/ASPM: Enable ASPM for root complex <-> bridge <-> bridge case
Date:   Tue,  5 May 2020 20:27:59 +0800
Message-Id: <20200505122801.12903-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504070259.6034-1-kai.heng.feng@canonical.com>
References: <20200504070259.6034-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
power. On Windows ASPM L1 is enabled on the device and its upstream
bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
power.

Currently, ASPM is disabled if downstream has bridge function. It was
introduced by commit 7d715a6c1ae5 ("PCI: add PCI Express ASPM support").
The commit introduced PCIe ASPM support, but didn't explain why ASPM
needs to be in that case.

So relax the condition a bit to let bridge which connects to root
complex enables ASPM, instead of removing it completely, to avoid
regression.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2378ed692534..af5e22d78101 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -629,13 +629,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 	/*
-	 * If the downstream component has pci bridge function, don't
-	 * do ASPM for now.
+	 * If upstream bridge isn't connected to root complex and the
+	 * downstream component has pci bridge function, don't do ASPM for now.
 	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
-			link->aspm_disable = ASPM_STATE_ALL;
-			break;
+	if (parent->bus->parent) {
+		list_for_each_entry(child, &linkbus->devices, bus_list) {
+			if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
+				link->aspm_disable = ASPM_STATE_ALL;
+				break;
+			}
 		}
 	}
 
-- 
2.17.1

