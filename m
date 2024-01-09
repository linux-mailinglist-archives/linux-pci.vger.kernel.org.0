Return-Path: <linux-pci+bounces-1881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34C8280E2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF4B2546C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0512364DF;
	Tue,  9 Jan 2024 08:24:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEE364CF;
	Tue,  9 Jan 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 9DF471C02ED;
	Tue,  9 Jan 2024 17:24:00 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v6 12/37] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
Date: Tue,  9 Jan 2024 17:23:09 +0900
Message-Id: <160ee086771703c951c5522d997662aeac122a28.1704788539.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704788539.git.ysato@users.sourceforge.jp>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas SH7751 PCI Controller json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/pci/renesas,sh7751-pci.yaml      | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..45e5a19e7d0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,sh7751-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 PCI Host controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: renesas,sh7751-pci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: PCI Controller
+      - const: Bus State Controller
+
+  "#interrupt-cells":
+    const: 1
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  dma-ranges: true
+
+  interrupt-controller: true
+
+  renesas,bus-arbit-round-robin:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set DMA bus arbitration to round robin.
+
+  pci-command-reg-fast-back-to-back:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI command register Fast Back-to-Back enable bit.
+
+  pci-command-reg-serr:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI command register SERR# enable.
+
+  pci-command-reg-wait-cycle-control:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI command register Wait cycle control bit.
+
+  pci-command-reg-parity-error-response:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register Parity error response bit.
+
+  pci-command-reg-vga-snoop:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register VGA palette snoop bit.
+
+  pci-command-reg-write-invalidate:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register Memory write and invaldate enable bit.
+
+  pci-command-reg-special-cycle:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register Special cycle bit.
+
+  pci-command-reg-bus-master:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register Bus master bit.
+
+  pci-command-reg-memory-space:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register Memory space bit.
+
+  pci-command-reg-io-space:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Set for PCI Command register I/O space bit.
+
+  pci-bar:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: Overwrite to  PCI CONFIG Base Address Registers value.
+    items:
+      items:
+        - description: BAR register number
+        - description: BAR register value
+    minItems: 1
+    maxItems: 6
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pci@fe200000 {
+            compatible = "renesas,sh7751-pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            device_type = "pci";
+            bus-range = <0 0>;
+            ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+                     <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+            dma-ranges = <0x02000000 0 0xc000000 0x0c000000 0 0x04000000>;
+            reg = <0xfe200000 0x0400>,
+                  <0xff800000 0x0100>;
+            interrupt-map = <0x0000 0 0 1 &julianintc 5>,
+                            <0x0000 0 0 2 &julianintc 6>,
+                            <0x0000 0 0 3 &julianintc 7>,
+                            <0x0000 0 0 4 &julianintc 8>,
+                            <0x0800 0 0 1 &julianintc 6>,
+                            <0x0800 0 0 2 &julianintc 7>,
+                            <0x0800 0 0 3 &julianintc 8>,
+                            <0x0800 0 0 4 &julianintc 5>,
+                            <0x1000 0 0 1 &julianintc 7>,
+                            <0x1000 0 0 2 &julianintc 8>,
+                            <0x1000 0 0 3 &julianintc 5>,
+                            <0x1000 0 0 4 &julianintc 6>;
+            pci-bar = <0 0xab000001>, <2 0xd0000000>;
+            pci-command-reg-io-space;
+            interrupt-map-mask = <0x1800 0 0 7>;
+    };
-- 
2.39.2


