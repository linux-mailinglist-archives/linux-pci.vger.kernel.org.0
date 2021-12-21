Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C385E47C1F6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhLUO4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbhLUO4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 09:56:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A61C061574;
        Tue, 21 Dec 2021 06:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DBB761642;
        Tue, 21 Dec 2021 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86465C36AFB;
        Tue, 21 Dec 2021 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640098608;
        bh=GN5jKZEodCfeZz6pv/k5h1jk1jhWdZrxDcJsdMUC48E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzSpo5/3vAT9c3YzIf6tWgRlrYUm0hDpposd0f4C7oA+n5ZQWEyMwdgt+aFKQb1ii
         f2mzl8K0g4yEZ+IAd2BxAdR69TT2a2xA/fRULXXaG+P2oyy7mGSt5l9wW43yWa9/l4
         LjvyAWHeDW7uKM8diu851K6taRP3OcMYugnnPzeZGElH61nY6N+FsuRNY9eKTA+CO9
         5efYElAR1xwawFQJjpMPytbw4mHAu+walgbPqQ2m0N0Y2WOCWsNrvxXobH3MBSHGg2
         fiMppdAiyeBg1GY4Wtn5BMfqmVXyutId4PtxlhJmJWd+aVBEwBlRHA03vP9Bm5dgMM
         GrdQ6r1U4fo/w==
Received: by pali.im (Postfix)
        id 222672AC1; Tue, 21 Dec 2021 15:18:17 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated bridge
Date:   Tue, 21 Dec 2021 15:14:55 +0100
Message-Id: <20211221141455.30011-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221141455.30011-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for reporting PCI_EXP_LNKSTA_DLLLA bit in Link Control register
on emulated bridge via PCIE_STAT_OFF reg. Function mvebu_pcie_link_up()
already parses this register and returns if Data Link is Active or not.

Also correctly indicate DLLLA capability via PCI_EXP_LNKCAP_DLLLARC bit in
Link Control Capability register which is required for reporting DLLLA bit.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index dffa330de174..a075ba26cff1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -548,13 +548,18 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		/*
 		 * PCIe requires that the Clock Power Management capability bit
 		 * is hard-wired to zero for downstream ports but HW returns 1.
+		 * Additionally enable Data Link Layer Link Active Reporting
+		 * Capable bit as DL_Active indication is provided too.
 		 */
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
-			 ~PCI_EXP_LNKCAP_CLKPM;
+		*value = (mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
+			  ~PCI_EXP_LNKCAP_CLKPM) | PCI_EXP_LNKCAP_DLLLARC;
 		break;
 
 	case PCI_EXP_LNKCTL:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
+		/* DL_Active indication is provided via PCIE_STAT_OFF */
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) |
+			 (mvebu_pcie_link_up(port) ?
+			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
 
 	case PCI_EXP_SLTCTL:
-- 
2.20.1

