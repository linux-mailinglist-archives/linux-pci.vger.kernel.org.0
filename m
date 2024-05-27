Return-Path: <linux-pci+bounces-7878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E18D0853
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21611C228B8
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD416E877;
	Mon, 27 May 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TJPz/QjW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3A16DEB9;
	Mon, 27 May 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826532; cv=none; b=L0QP4JKrXXKwwJq+IQakLjfJKL73oBB5KKfLDImmjgSRq5zYVLcl0QDdiENwdvlvzEWllZ4/P+02n5v+f5pvCAH9IvbbkxGXgkTlupO6CaErTvD/vAX/64/V3q+UmvDBwnSRhRdpRjuOwug1gZiN3M37abKoosHyJqF5wG9j5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826532; c=relaxed/simple;
	bh=KWOkIyivWuA9wtmoHY37AqxHkQB6/jl+LFLPFAwKWV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpnWV3flipiMK6PkF3Y8/v9a/wBxkBTE887m7Flv5sHFG304Mh2ez/K6dwWt4vNJHdP3zXIi/jm4PewofvvUh+NQiNyv9YCHkge6j3HfUsHBNM0lu4dIxIkVNaQdWsV+iLjAftx93XYng1ps0tTllt47o2YsEsh+UXgQzUtKLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TJPz/QjW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DE74FFF806;
	Mon, 27 May 2024 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1yRwle+HAvHy0Q0ReS5EoL1LVn7psuAz06A8wMDIfo=;
	b=TJPz/QjWh5ObhtAJXMw2B5yn/g+zKAMRCug48RsKHLX6szEZmkNH40hLcmTmQM5LpKx+iO
	NhAUv/qW7RQz5ttxUjjFdPudhvC3e0n9QPNRlzJaa2ICSipozqa5c+lQHYBNnPtYQqp6dW
	TwZWQi+BgEeYdYZf/+WOoV/wUki2vvF9UyyaE1UbDIgKUzRwi+uDB8dOnnolZKw5usgZ3r
	tizf41FgBHIUCnetK/4liNaxe3KoAyDGJ2N/HKWKDojw86XyyX1aFrRg/wzMHU2sydH1GH
	0wACs6RTe5zk8nux47hz6lvkLkfn0aYxgExj+o46a/n9kWMKmqDLjko5hPs9bg==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 17/19] PCI: of_property: Add interrupt-controller property in PCI device nodes
Date: Mon, 27 May 2024 18:14:44 +0200
Message-ID: <20240527161450.326615-18-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

PCI devices and bridges DT nodes created during the PCI scan are created
with the interrupt-map property set to handle interrupts.

In order to set this interrupt-map property at a specific level, a
phandle to the parent interrupt controller is needed. On systems that
are not fully described by a device-tree, the parent interrupt
controller may be unavailable (i.e. not described by the device-tree).

As mentioned in the [1], avoiding the use of the interrupt-map property
and considering a PCI device as an interrupt controller itself avoid the
use of a parent interrupt phandle.

In that case, the PCI device itself as an interrupt controller is
responsible for routing the interrupts described in the device-tree
world (DT overlay) to the PCI interrupts.

Add the 'interrupt-controller' property in the PCI device DT node.

[1]: https://lore.kernel.org/lkml/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 03539e505372..5a0b98e69795 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -183,6 +183,26 @@ static int of_pci_prop_interrupts(struct pci_dev *pdev,
 	return of_changeset_add_prop_u32(ocs, np, "interrupts", (u32)pin);
 }
 
+static int of_pci_prop_intr_ctrl(struct pci_dev *pdev, struct of_changeset *ocs,
+				 struct device_node *np)
+{
+	int ret;
+	u8 pin;
+
+	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+	if (ret != 0)
+		return ret;
+
+	if (!pin)
+		return 0;
+
+	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
+	if (ret)
+		return ret;
+
+	return of_changeset_add_prop_bool(ocs, np, "interrupt-controller");
+}
+
 static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 				struct device_node *np)
 {
@@ -336,6 +356,10 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 		ret = of_pci_prop_intr_map(pdev, ocs, np);
 		if (ret)
 			return ret;
+	} else {
+		ret = of_pci_prop_intr_ctrl(pdev, ocs, np);
+		if (ret)
+			return ret;
 	}
 
 	ret = of_pci_prop_ranges(pdev, ocs, np);
-- 
2.45.0


