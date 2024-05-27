Return-Path: <linux-pci+bounces-7867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40D8D0822
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DB01C22838
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533416938C;
	Mon, 27 May 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HGpU54Uz"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E2168C1B;
	Mon, 27 May 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826512; cv=none; b=L6bq3vcR+4ub2en3aHW6aB2W5olJuBPqewLtKuOpOjE0HyGcn+EKcCoXdhteoSeSX9nwqrA+ztDGpWKRBoIQweGNTzzBIbvqO+xTEYgd4Po2SeAz1KO4dna5oH55+/ay2x19U52C6vih8VYVnIPydc28cz8cvF+FTl3uWhmw9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826512; c=relaxed/simple;
	bh=8rQevD0p2EIlB6l1UzGKlfOUztYoACQa5oVZsG20auo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFLPU5vlkZlHg2MRVf5iDXkySf9wxgwqE2gagt/qqPPMelaY9jypWOAOuxdjOfiQllePxzl5cFWJVC8kGCdkkSEYDqgBsLFzRZwY3MC2z4eMHMorowE1zjlyhDjXTyptBuza7BFD+E6yUCSU7FIZXNOXMhRcTlzAGy66vN9+TLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HGpU54Uz; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4BE5EFF80E;
	Mon, 27 May 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWQ4pALLF6bGmnAFbKQRjFHNe+9gr/WCo0qJyEdw0yk=;
	b=HGpU54UzdbtSbUfc2EUxjmVB0KjJahFF3GnvKVAEiGK87T93BSwa7FlnqITkjQiiOfYsNQ
	0Gk7FKigATJDlt3kWJwQ6eNKB3sWxnuH2ynoxHKaNvexx+ZwGf6MUhnXtjmmAFQiJo3YXW
	wcBhp7lJmxo5kGgZMS/8ncSj5/BIADqLWOWJiySSXxQTwZRdlr77CAU8EPxr7BJ1UdhKgo
	dTitdHIaZ1jy9T8HD4nYngff4qatZseMmIQeSnw9k7dII4cv7jIFPZYSB+QRACjzGBi8TD
	eSaGk0t5ZTyzEKmOi5cZr7lwpgHMD7cvpzruT8DT4YcVyC4U0OQNAMjDys2yHA==
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
Subject: [PATCH v2 06/19] dt-bindings: net: mscc-miim: Add resets property
Date: Mon, 27 May 2024 18:14:33 +0200
Message-ID: <20240527161450.326615-7-herve.codina@bootlin.com>
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

Add the (optional) resets property.
The mscc-miim device is impacted by the switch reset especially when the
mscc-miim device is used as part of the LAN966x PCI device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc,miim.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 5b292e7c9e46..c67e8caa36cf 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -38,6 +38,17 @@ properties:
 
   clock-frequency: true
 
+  resets:
+    items:
+      - description:
+          Optional shared switch reset.
+          This reset is shared with all blocks attached to the Switch Core
+          Register Bus (CSR) including VRAP slave.
+
+  reset-names:
+    items:
+      - const: switch
+
 required:
   - compatible
   - reg
-- 
2.45.0


