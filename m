Return-Path: <linux-pci+bounces-6850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24218B6D04
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420441F23F65
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94D17799F;
	Tue, 30 Apr 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="auirbtCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AD13D29F;
	Tue, 30 Apr 2024 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466362; cv=none; b=WQhf7yqpUqEVHCjWdATgyL1S7XfpCw2/UKisXQphRP5gW45cEkSF6/kSRgOhkJAiKOFkPvxop6hNvURoMo+tzAmpulyM8qHgbTu+HyQn20Jeqawz7ga1XVMd6fgFpJJ8OKU0AnArErWyWcFdw5Zg9cm0jA1rhVkAkcgK6t1VZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466362; c=relaxed/simple;
	bh=AJFmHIGOkJRAYhf/8wonVpIevTwCpu2sASdLQiX0x/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4rWTlhktDbIeHxM32LB2zeT5yMWhSbgBC+MyZh7uCWVg/vRgemFo8c/4yGIWYRTyqFKD8ol0ExaKIqT+20dhRuXlYCQb66HTfz6drQe/jTuEg5/FdwntozzOAaqO66HysjO/jTXAxSVR1mkcA7/Dv08LOtgfZrw136yhP3xWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=auirbtCm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0E4AF20005;
	Tue, 30 Apr 2024 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=db+xWsJmRVlLKMGx3o8SQOd/IsogiIOXl7irmhHKbrQ=;
	b=auirbtCmhKrJ3MS1CoWMnj+iHFN5vu2m8v7E/kBLL6w/9xgStDbnVEw4fPZBwINtiVpyxd
	EFCRQG8AByYI+G2XYFeCDvnUsh3QTTYzmboURPgFw3FqF+buIdGgv2r3T2DESpaJMS3J0P
	wJwpHfPgdbhY1TGUtKCSPzdZ8x6qOXInQPYaR3FGdQBJXAMSe5h39PFhHLMeHRtDAHWfwT
	Gd68S6JDJ8Cn6cKkFPKdlmDMQN6NpjGYIUTwpLIXYPpU2bSjZQ1K7GLhmeh5UUy0tw2N5Q
	T/JvY+jJie+Dp12w+9UrxOMkQ79b9aehEaNtNYB0mitxjJ1EpAPxxKT5oz4XuA==
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
Subject: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Date: Tue, 30 Apr 2024 10:37:15 +0200
Message-ID: <20240430083730.134918-7-herve.codina@bootlin.com>
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

Add the (optional) resets property.
The mscc-miim device is impacted by the switch reset especially when the
mscc-miim device is used as part of the LAN966x PCI device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc,miim.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 5b292e7c9e46..a8c92cec85a6 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -38,6 +38,14 @@ properties:
 
   clock-frequency: true
 
+  resets:
+    items:
+      - description: Reset controller used for switch core reset (soft reset)
+
+  reset-names:
+    items:
+      - const: switch
+
 required:
   - compatible
   - reg
-- 
2.44.0


