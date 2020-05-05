Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF141C5EF6
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgEERgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 13:36:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35293 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgEERgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 13:36:40 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jW1Sk-0000yL-9Y; Tue, 05 May 2020 17:34:35 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] PCI/ASPM: Enable ASPM for bridge-to-bridge link
Date:   Wed,  6 May 2020 01:34:21 +0800
Message-Id: <20200505173423.26968-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505122801.12903-1-kai.heng.feng@canonical.com>
References: <20200505122801.12903-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
power. On Windows ASPM L1 is enabled on the device and its upstream
bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
power.

In short, ASPM always gets disabled on bridge-to-bridge link.

The special case was part of first ASPM introduction patch, commit
7d715a6c1ae5 ("PCI: add PCI Express ASPM support"). However, it didn't
explain why ASPM needs to be disabled in special bridge-to-bridge case.

Let's remove the the special case, as PCIe spec already envisioned ASPM
on bridge-to-bridge link.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Remove the special case completely.

v2: 
 - Enable ASPM on root complex <-> bridge <-> bridge, instead of using
   quirk.
 drivers/pci/pcie/aspm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2378ed692534..b17e5ffd31b1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -628,16 +628,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
-	/*
-	 * If the downstream component has pci bridge function, don't
-	 * do ASPM for now.
-	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
-			link->aspm_disable = ASPM_STATE_ALL;
-			break;
-		}
-	}
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-- 
2.17.1

