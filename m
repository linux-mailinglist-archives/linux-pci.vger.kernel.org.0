Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC3249990
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHSJnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 05:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgHSJnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 05:43:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85206206FA;
        Wed, 19 Aug 2020 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597830184;
        bh=eQfdoB63wdKPPwQKDY/l7Z1OnRZwiyuLG2TBV1XF/ug=;
        h=From:To:Cc:Subject:Date:From;
        b=oTtCwPnCyX7AXZ5deKcl0ylPWh4hsAbWdc6VVFHGPIFzKZggRNOlfKISY6gZfzMKA
         2z3aqXCQIPT8QgiUY+OXkN/3jkj0GleL54IVej5nyCAYJ/ct6priOa6uiq58oEwzQW
         //AguAVc6yros8+HkbnrXSFPHY8EDxAxbAc9toSE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8KcZ-0049nd-22; Wed, 19 Aug 2020 10:43:03 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, kernel-team@android.com,
        Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2] of: address: Work around missing device_type property in pcie nodes
Date:   Wed, 19 Aug 2020 10:42:55 +0100
Message-Id: <20200819094255.474565-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, kernel-team@android.com, frowand.list@gmail.com, jiaxun.yang@flygoat.com, robh+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent changes to the DT PCI bus parsing made it mandatory for
device tree nodes describing a PCI controller to have the
'device_type = "pci"' property for the node to be matched.

Although this follows the letter of the specification, it
breaks existing device-trees that have been working fine
for years.  Rockchip rk3399-based systems are a prime example
of such collateral damage, and have stopped discovering their
PCI bus.

In order to paper over it, let's add a workaround to the code
matching the device type, and accept as PCI any node that is
named "pcie",

A warning will hopefully nudge the user into updating their
DT to a fixed version if they can, but the incentive is
obviously pretty small.

Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/address.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 590493e04b01..b37bd9cc2810 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -128,15 +128,29 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
  * PCI bus specific translator
  */
 
+static bool of_node_is_pcie(struct device_node *np)
+{
+	bool is_pcie = of_node_name_eq(np, "pcie");
+
+	if (is_pcie)
+		pr_warn_once("%pOF: Missing device_type\n", np);
+
+	return is_pcie;
+}
+
 static int of_bus_pci_match(struct device_node *np)
 {
 	/*
  	 * "pciex" is PCI Express
 	 * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
 	 * "ht" is hypertransport
+	 *
+	 * If none of the device_type match, and that the node name is
+	 * "pcie", accept the device as PCI (with a warning).
 	 */
 	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
-		of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
+		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
+		of_node_is_pcie(np);
 }
 
 static void of_bus_pci_count_cells(struct device_node *np,
-- 
2.27.0

