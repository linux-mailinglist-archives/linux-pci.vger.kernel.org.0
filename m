Return-Path: <linux-pci+bounces-6859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041068B6D2F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D8CB22A0B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEA1C0DEB;
	Tue, 30 Apr 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a1xRvzFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D751BF6D7;
	Tue, 30 Apr 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466377; cv=none; b=WcDmRhc/MTUm5oUZu+SrIok13oVAe40FqzpHslSEZDiyrnf46MP5sITLVW8jrTbdVfcwPPXekYblqyVCgUxxb3akROSZAXvjE9sg+NLNafz2pfeMery44a8/jhmp7T8KxIilFOWOMERH+N3hIaTJSBrBL5Jp0hq1sdfteacJJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466377; c=relaxed/simple;
	bh=wDWXPuQPX0SK7eCiZC1Dda7dfb6gfYPOkdHIxbXuONY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQaUJesp0Vlzd+6ysaeCNsBY3zSfmZdQQd0fvbvqHlAAVovzWt/a9x3MlBw9Cjmx/FaJKq5M1OfxQuNFKfNfZUUyy/T27dL3pfWRutcL2I0xZnNUv+ZQ5Vo1L3oGCLEHhSp2OWbqBbaTv/l6OFezysOU6ZZRiNGB1KYIobcvia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a1xRvzFe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 331C320014;
	Tue, 30 Apr 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL/+wWthdbbXpsMfHadEqQrahJY+3VcTmg9gLeOEcoI=;
	b=a1xRvzFeeKIKQGG0I7FiPVUgVyIrQwZl8MJm/CPkMjOEjYyT9Ie0Umir5GpeC47xIn0y/Z
	yLGkaqdm3WCC0uX/WrU2T1flH87ngShPmFcd8QL75pDHdbngjKiwUYkt3Sy80J8OzKn7Md
	1XHxJ9mqrv4sbtLXSy8KgpRLlFCogcZFyfSo06fmkfGmhLf/yJgAQTne7vUgEV59l+trvl
	aKhvnI9PDh9/XBwZ4e4fQ1lBevOlWcl9KProlh5ZBfDDioNS5bDakrHdtkB2rN+gJMw+KQ
	+8jybgwR+4yDjCxRTs6Jlsz87DdhrYHfDqHE7i0VuW9w9zkJtlHQn8KwYVuc+A==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH 15/17] pci: of_property: Add the interrupt-controller property in PCI device nodes
Date: Tue, 30 Apr 2024 10:37:24 +0200
Message-ID: <20240430083730.134918-16-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
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
phandle to the parent interrupt controller is needed.
On systems that are not fully described by a device-tree, the parent
interrupt controller may be unavailable (i.e. not described by the
device-tree).

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
index c2c7334152bc..9f8b940029ed 100644
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
@@ -334,6 +354,10 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
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
2.44.0


