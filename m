Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1233A304E01
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbhAZXeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbhAZVfv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 16:35:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F371420449;
        Tue, 26 Jan 2021 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611696907;
        bh=zcZQevOuYk1dSkQEEwXDEI9s1fVns2ruOe9zrnulgqk=;
        h=From:To:Cc:Subject:Date:From;
        b=Nr+cwa92DF8z6p8HS1r6Rc6IXemGULA3Soz5QiGkWo1zYdVzPd/roYSsZMI7/ghVd
         Lr6GZbEIc1UfcspRjC8cUBjUrZF3KS/JKtYZv6Bi3/ZVRvUsdX8MhWCxusjoUbBQrL
         Jnu8UC6QfaDhFkcxlDLrlL4mUz83a9D3BVB1hd8yyFY4yaYMwmNJ5Pda+MwvR0vKyc
         nZW/Z4+zZy4TyA1TsAYuBqmsEyzv1I4UFJF7RvzhSKQk2zk8UZfISZ1xeulD3QwrZC
         tGOPGDPPQJVz9KMAJLAz6HNEehxjZYky8GvrrgN+lC9cFUGtmjSWYdpCsWVsfxzmTk
         kHqGrN/QmyAqg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: xgene: Fix CRS SV comment
Date:   Tue, 26 Jan 2021 15:35:03 -0600
Message-Id: <20210126213503.2922848-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Configuration Request Retry Status ("CRS") must be supported by all PCIe
devices.  CRS Software Visibility is an optional feature that enables a
Root Port to make CRS visible to software by returning a special data value
to complete a config read.

Clarify a comment to say that it is "CRS SV", not "CRS", that can be
enabled.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-xgene.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 85e7c98265e8..2afdc865253e 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -173,12 +173,13 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 
 	/*
 	 * The v1 controller has a bug in its Configuration Request
-	 * Retry Status (CRS) logic: when CRS is enabled and we read the
-	 * Vendor and Device ID of a non-existent device, the controller
-	 * fabricates return data of 0xFFFF0001 ("device exists but is not
-	 * ready") instead of 0xFFFFFFFF ("device does not exist").  This
-	 * causes the PCI core to retry the read until it times out.
-	 * Avoid this by not claiming to support CRS.
+	 * Retry Status (CRS) logic: when CRS Software Visibility is
+	 * enabled and we read the Vendor and Device ID of a non-existent
+	 * device, the controller fabricates return data of 0xFFFF0001
+	 * ("device exists but is not ready") instead of 0xFFFFFFFF
+	 * ("device does not exist").  This causes the PCI core to retry
+	 * the read until it times out.  Avoid this by not claiming to
+	 * support CRS SV.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
-- 
2.25.1

