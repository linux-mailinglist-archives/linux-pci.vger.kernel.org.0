Return-Path: <linux-pci+bounces-15292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEA9B02C4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE35B22510
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251571FDFA8;
	Fri, 25 Oct 2024 12:45:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108441632FD;
	Fri, 25 Oct 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860332; cv=none; b=K2tJUzx8IPLDXuXhvr5NB3vDuvZlldyUeBHgyf5VjTHzcr0bp9r4KiYvIHtnAJe6pDRGrqg4sUremQ8m8ImDg13T9BMz2ttyX3gf+X4D6DbASe9kTw4FWvA0uAGM23HhOhXbDbK799YUmeGfMqtJROGHkJXyGGVbJc5vu+1AaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860332; c=relaxed/simple;
	bh=Cmneyx02bgk2/0oKWKPHTewXjWjLfNFKIK0odlNOA/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcCQ4mC7Dc/2VA9BcFyFlCRqG6oN/wRjVf/3zHEElG5Dtp732HU8VcPcZeTphDAQ8r9BdyC0214zM+jFgnUn1mzQdKI+bOdRhX2MEgKkS9D3WN9mM+tXyJMAvrHxEfFxMQi9HGBAEO/yxArysHEUtKo0RH0hE+7CSRfBiSl8gtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49D771FE0C;
	Fri, 25 Oct 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392F513B16;
	Fri, 25 Oct 2024 12:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0NqAC+eSG2fzOAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 25 Oct 2024 12:45:27 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v4 01/10] dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
Date: Fri, 25 Oct 2024 15:45:06 +0300
Message-ID: <20241025124515.14066-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025124515.14066-1-svarbanov@suse.de>
References: <20241025124515.14066-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 49D771FE0C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3 -> v4:
 - Added Reviewed-by.

 .../brcm,bcm2712-msix.yaml                    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
new file mode 100644
index 000000000000..c84614663b5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm2712-msix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom bcm2712 MSI-X Interrupt Peripheral support
+
+maintainers:
+  - Stanimir Varbanov <svarbanov@suse.de>
+
+description:
+  This interrupt controller is used to provide interrupt vectors to the
+  generic interrupt controller (GIC) on bcm2712. It will be used as
+  external MSI-X controller for PCIe root complex.
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm2712-mip
+
+  reg:
+    items:
+      - description: Base register address
+      - description: PCIe message address
+
+  "#msi-cells":
+    const: 0
+
+  brcm,msi-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Shift the allocated MSI's.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - msi-ranges
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    axi {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        msi-controller@1000130000 {
+            compatible = "brcm,bcm2712-mip";
+            reg = <0x10 0x00130000 0x00 0xc0>,
+                  <0xff 0xfffff000 0x00 0x1000>;
+            msi-controller;
+            #msi-cells = <0>;
+            msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
+        };
+    };
-- 
2.43.0


