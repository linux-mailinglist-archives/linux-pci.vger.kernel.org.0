Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A68409C26
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbhIMS1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236669AbhIMS1V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 14:27:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB607610E6;
        Mon, 13 Sep 2021 18:26:05 +0000 (UTC)
Received: from [198.52.44.129] (helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mPqea-00AYPD-3V; Mon, 13 Sep 2021 19:26:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v3 03/10] PCI: of: Allow matching of an interrupt-map local to a pci device
Date:   Mon, 13 Sep 2021 19:25:43 +0100
Message-Id: <20210913182550.264165-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.52.44.129
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just as we now allow an interrupt map to be parsed when part
of an interrupt controller, there is no reason to ignore an
interrupt map that would be part of a pci device node such as
a root port since we already allow interrupt specifiers.

This allows the device itself to use the interrupt map for
for its own purpose.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/of.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d84381ce82b5..443cebb0622e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -423,7 +423,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
  */
 static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
-	struct device_node *dn, *ppnode;
+	struct device_node *dn, *ppnode = NULL;
 	struct pci_dev *ppdev;
 	__be32 laddr[3];
 	u8 pin;
@@ -452,8 +452,14 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	if (pin == 0)
 		return -ENODEV;
 
+	/* Local interrupt-map in the device node? Use it! */
+	if (dn && of_get_property(dn, "interrupt-map", NULL)) {
+		pin = pci_swizzle_interrupt_pin(pdev, pin);
+		ppnode = dn;
+	}
+
 	/* Now we walk up the PCI tree */
-	for (;;) {
+	while (!ppnode) {
 		/* Get the pci_dev of our parent */
 		ppdev = pdev->bus->self;
 
-- 
2.30.2

