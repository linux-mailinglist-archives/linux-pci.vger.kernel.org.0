Return-Path: <linux-pci+bounces-6853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A598B6D15
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F305A1C2276D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD51A0AE4;
	Tue, 30 Apr 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZrW8MfNX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBA199EB1;
	Tue, 30 Apr 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466367; cv=none; b=B00SJwtle1uclKBEy5r/gvywDXJg25SbSX3xRI8zSZZMXF1X2AFCXrB1VmxFFTLcbd/OLL+LrirMyuPzpjdLYUvgG5jJzwTgbqBWO8gjIbUfVoUn/SklZOYCoJXl3X5U+SjVMCLYaR0BxnlsR5ypIC6a+/VnvozbZOu/lTnn+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466367; c=relaxed/simple;
	bh=BmIPRrPsWExE/bvNJkt/S/QgFBuICgJGLZOGqiYJQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ml46xtuzGIToI21HABDXn2TSMTzJJc6G3S2Xskld5HyKI3MjVoRrHcBfav49uIXM2AZWMijLok93JBioQh3g0gmrHRg6VNWnDoZDGUHJ5QxCWbi5qcIopMJJdSBvx6rnSYdOtVx88ntJJ9+Ucq+c56+HRls+qckcaLmNqjJinLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZrW8MfNX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2156720017;
	Tue, 30 Apr 2024 08:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nJGaOl0FeqlO/nJG1uJcVNnq20e1Q7cPnBeXIjZqf8=;
	b=ZrW8MfNXswi6w4Sw9CbwPmY76PE29Aj3BQ7N1U/LH7sqHw1sHivT3CQ9v9vYY3FkVovjTv
	VOMY7PlGhWAvLItJ2pRHdgSwfFeDHqZzwMVsKlh7XWg2/S9kTF8bWnUmN3rj1cb0Q/c4IZ
	TiQmQeMzWnPcaNEsjQdkZ7mMNjmew7DBSpzYVCqh3I92HRHB2lH+7L/Qi4+4Z9S7ii3KmF
	B9fGO67kPYYkpCpZw9mVV7vYTQEYGRA9kbmshlxrvZno/j/ZQePJxD8fyUPNaQGfp9r07O
	lqn8MnG92Kp18n0ErZcFfutRfKQoiUl8Uh8o4QE71M5e7KAObu/oxb14cfM8xA==
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
Subject: [PATCH 09/17] dt-bindings: interrupt-controller: Add support for Microchip LAN966x OIC
Date: Tue, 30 Apr 2024 10:37:18 +0200
Message-ID: <20240430083730.134918-10-herve.codina@bootlin.com>
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

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../microchip,lan966x-oic.yaml                | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
new file mode 100644
index 000000000000..b2adc7174177
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x outband interrupt controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
+  interrupt sources of the LAN966x device to an external interrupt.
+  When the LAN966x device is used as a PCI device, the external interrupt is
+  routed to the PCI interrupt.
+
+properties:
+  compatible:
+    const: microchip,lan966x-oic
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@e00c0120 {
+        compatible = "microchip,lan966x-oic";
+        reg = <0xe00c0120 0x190>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        interrupts = <0>;
+        interrupt-parent = <&intc>;
+    };
+...
-- 
2.44.0


