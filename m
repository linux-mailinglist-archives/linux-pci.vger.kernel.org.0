Return-Path: <linux-pci+bounces-13638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8998A263
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5BB2AB97
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221A192D60;
	Mon, 30 Sep 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iPyFyaZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43218F2DD;
	Mon, 30 Sep 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698574; cv=none; b=OlqGuq2bvGOL487OPRCtBa5M3bRXpr/TG/YGwRGCsaZEziVBnjpzs8p6uZ4Zr7S1X2f+ka9ttNuvHsrQ6JhnW0hrHj8ssv015g+EjX8IYvZ/91IVMNc0p7WrN0leLBo7MuqjMuHtwKim5FmWkHeqFmo5WJbYk2j544aupzfHZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698574; c=relaxed/simple;
	bh=Rr5pYzPzILVGLFfUKpS1kwrZ9OqlvXpyVlGyV3RDDoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCxQqSDosYo3kz/hqop/P4DngrVIkBgYuuD8Wf8Xjwy9ahgc7t8FhsEbHyweJz+2M5rdRobDcxKtfPuNtrnwZeLjKsUJye3sv6QHvjIU+tF3pUYzCDfRBLvuI1x6hZbmngrX1bwhELWdI35npB3bzqVIXrAB8Gtyc11PyxnyZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iPyFyaZB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0AA661C000C;
	Mon, 30 Sep 2024 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727698570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIUXvhb/6k8yqNTOTdXI2a7OI1BOudVjy0G7Tj0oLuI=;
	b=iPyFyaZBRSQHcfBM6plb3imzKRhhMZ4pFC5Ep0FBPNoxVtqEe8QOoJoGX7g31p359cFOs+
	PtJyHi7tDuUeGPzmfM7TCUBL59DNMosUcny6kK2gtQAfO1KGKEhj96Z1jvR0z8pRIwDy/+
	rp750AIK/2X+TicfiPuwSresKuFoqlwDrbZ0rq/UV95Kwj+J3xP4VJiRMLqc0YSS03xv0w
	k/CNAMqIi75Irf6cpzqzIjUCSoUK04+o/CmFn+YDm9O+V/WuhfA8NNsj0TPZ/CFNyKUOCg
	Cb8Edr4NGRYkfH01GAA+EC9sx9aAqtq+r1MMhy8b2Sf+nxi1+765dDeVYmGQZg==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 1/7] dt-bindings: reset: microchip,rst: Allow to replace cpu-syscon by an additional reg item
Date: Mon, 30 Sep 2024 14:15:41 +0200
Message-ID: <20240930121601.172216-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121601.172216-1-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In the LAN966x PCI device use case, syscon cannot be used as syscon
devices do not support removal [1]. A syscon device is a core "system"
device and not a device available in some addon boards and so, it is not
supposed to be removed.

In order to remove the syscon device usage, allow the reset controller
to have a direct access to the address range it needs to use.

Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/reset/microchip,rst.yaml         | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index f2da0693b05a..5164239a372c 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -25,12 +25,16 @@ properties:
       - microchip,lan966x-switch-reset
 
   reg:
+    minItems: 1
     items:
       - description: global control block registers
+      - description: cpu system block registers
 
   reg-names:
+    minItems: 1
     items:
       - const: gcb
+      - const: cpu
 
   "#reset-cells":
     const: 1
@@ -39,12 +43,29 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: syscon used to access CPU reset
 
+allOf:
+  # Allow to use the second reg item instead of cpu-syscon
+  - if:
+      required:
+        - cpu-syscon
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
+    else:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+
 required:
   - compatible
   - reg
   - reg-names
   - "#reset-cells"
-  - cpu-syscon
 
 additionalProperties: false
 
@@ -57,3 +78,15 @@ examples:
         #reset-cells = <1>;
         cpu-syscon = <&cpu_ctrl>;
     };
+
+    /*
+     * The following construction can be used if the cpu-syscon device is not
+     * present. This is the case when the LAN966x is used as a PCI device.
+     */
+    reset-controller@22010008 {
+        compatible = "microchip,lan966x-switch-reset";
+        reg = <0xe200400c 0x4>,
+              <0xe00c0000 0xa8>;
+        reg-names = "gcb", "cpu";
+        #reset-cells = <1>;
+    };
-- 
2.46.1


