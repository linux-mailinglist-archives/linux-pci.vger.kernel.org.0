Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456CA245412
	for <lists+linux-pci@lfdr.de>; Sun, 16 Aug 2020 00:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgHOWL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 18:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgHOWK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2512311F;
        Sat, 15 Aug 2020 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597495885;
        bh=4asH1gc0Nnf0u9x4UFrqqedNqkxj9rZePIhJClf7JhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxR0uKVy0ZNoswEX9B3zlFjp2tS7XMcR9EgR7LaVuACg0qMzDC8jjdE66fFTtlFIZ
         gmkp1pCfoRVUfuNGo36pVe7F5ikBjkO32VbjSzF8Cdbv71OLOIgtPNblMY5FJrLWcT
         EUYr7Ave7UMiBP6L0xXXpBYVqk2OTKbO20bVkqQ8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6ved-002Kds-Ik; Sat, 15 Aug 2020 13:51:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, kernel-team@android.com,
        Roh Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] PCI: rockchip: Work around missing device_type property in DT
Date:   Sat, 15 Aug 2020 13:51:11 +0100
Message-Id: <20200815125112.462652-2-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200815125112.462652-1-maz@kernel.org>
References: <20200815125112.462652-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, kernel-team@android.com, robh+dt@kernel.org
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

In order to paper over the blunder, let's add a workaround
to the pcie-rockchip driver, adding the missing property when
none is found at boot time. A warning will hopefully nudge the
user into updating their DT to a fixed version if they can, but
the insentive is obviously pretty small.

Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
Suggested-by: Roh Herring <robh+dt@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 0bb2fb3e8a0b..d7dd04430a99 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -949,6 +949,35 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
+	/*
+	 * Most rk3399 DTs are missing the 'device_type = "pci"' property,
+	 * potentially leading to PCIe probing failure. Be kind to the
+	 * users and fix it up for them. Upgrading is recommended.
+	 */
+	if (!of_find_property(dev->of_node, "device_type", NULL)) {
+		const char dtype[] = "pci";
+		struct property *prop;
+
+		dev_warn(dev, "Working around missing device_type property\n");
+
+		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+		if (!prop)
+			return -ENOMEM;
+
+		prop->name	= kstrdup("device_type", GFP_KERNEL);
+		prop->value	= kstrdup(dtype, GFP_KERNEL);
+		prop->length	= ARRAY_SIZE(dtype);
+		if (!prop->name || !prop->value) {
+			kfree(prop->name);
+			kfree(prop->value);
+			kfree(prop);
+			return -ENOMEM;
+		}
+
+		if (of_add_property(dev->of_node, prop))
+			dev_warn(dev, "Failed to add property, probing may fail");
+	}
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rockchip));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.27.0

