Return-Path: <linux-pci+bounces-1886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F329828111
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29E3284A86
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2638DF9;
	Tue,  9 Jan 2024 08:24:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE638DDE;
	Tue,  9 Jan 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id B02801C05AD;
	Tue,  9 Jan 2024 17:24:09 +0900 (JST)
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
Subject: [DO NOT MERGE v6 17/37] dt-bindings: interrupt-controller: renesas,sh7751-intc: Add json-schema
Date: Tue,  9 Jan 2024 17:23:14 +0900
Message-Id: <bc794e2165244bd0cee81bc0106f1e2d1bef1613.1704788539.git.ysato@users.sourceforge.jp>
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

Renesas SH7751 INTC json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../renesas,sh7751-intc.yaml                  | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
new file mode 100644
index 000000000000..beb29b225ac2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 Interrupt Controller
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-intc
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ICR
+      - const: INTPRI00
+
+  renesas,icr-irlm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If true four independent interrupt requests mode (ICR.IRLM is 1).
+
+  renesas,ipr-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      IRQ to IPR mapping definition.
+      1st - INTEVT code
+      2nd - Register
+      3rd - bit index
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#interrupt-cells'
+  - interrupt-controller
+  - renesas,ipr-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/renesas,sh7751-intc.h>
+    shintc: interrupt-controller@ffd00000 {
+            compatible = "renesas,sh7751-intc";
+            reg = <0xffd00000 14>, <0xfe080000 128>;
+            reg-names = "ICR", "INTPRI00";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            renesas,ipr-map = <0x240 IPRD IPR_B12>, /* IRL0 */
+                              <0x2a0 IPRD IPR_B8>,  /* IRL1 */
+                              <0x300 IPRD IPR_B4>,  /* IRL2 */
+                              <0x360 IPRD IPR_B0>,  /* IRL3 */
+                              <0x400 IPRA IPR_B12>, /* TMU0 */
+                              <0x420 IPRA IPR_B8>,  /* TMU1 */
+                              <0x440 IPRA IPR_B4>,  /* TMU2 TNUI */
+                              <0x460 IPRA IPR_B4>,  /* TMU2 TICPI */
+                              <0x480 IPRA IPR_B0>,  /* RTC ATI */
+                              <0x4a0 IPRA IPR_B0>,  /* RTC PRI */
+                              <0x4c0 IPRA IPR_B0>,  /* RTC CUI */
+                              <0x4e0 IPRB IPR_B4>,  /* SCI ERI */
+                              <0x500 IPRB IPR_B4>,  /* SCI RXI */
+                              <0x520 IPRB IPR_B4>,  /* SCI TXI */
+                              <0x540 IPRB IPR_B4>,  /* SCI TEI */
+                              <0x560 IPRB IPR_B12>, /* WDT */
+                              <0x580 IPRB IPR_B8>,  /* REF RCMI */
+                              <0x5a0 IPRB IPR_B4>,  /* REF ROVI */
+                              <0x600 IPRC IPR_B0>,  /* H-UDI */
+                              <0x620 IPRC IPR_B12>, /* GPIO */
+                              <0x640 IPRC IPR_B8>,  /* DMAC DMTE0 */
+                              <0x660 IPRC IPR_B8>,  /* DMAC DMTE1 */
+                              <0x680 IPRC IPR_B8>,  /* DMAC DMTE2 */
+                              <0x6a0 IPRC IPR_B8>,  /* DMAC DMTE3 */
+                              <0x6c0 IPRC IPR_B8>,  /* DMAC DMAE */
+                              <0x700 IPRC IPR_B4>,  /* SCIF ERI */
+                              <0x720 IPRC IPR_B4>,  /* SCIF RXI */
+                              <0x740 IPRC IPR_B4>,  /* SCIF BRI */
+                              <0x760 IPRC IPR_B4>,  /* SCIF TXI */
+                              <0x780 IPRC IPR_B8>,  /* DMAC DMTE4 */
+                              <0x7a0 IPRC IPR_B8>,  /* DMAC DMTE5 */
+                              <0x7c0 IPRC IPR_B8>,  /* DMAC DMTE6 */
+                              <0x7e0 IPRC IPR_B8>,  /* DMAC DMTE7 */
+                              <0xa00 INTPRI00 IPR_B0>,      /* PCIC PCISERR */
+                              <0xa20 INTPRI00 IPR_B4>,      /* PCIC PCIDMA3 */
+                              <0xa40 INTPRI00 IPR_B4>,      /* PCIC PCIDMA2 */
+                              <0xa60 INTPRI00 IPR_B4>,      /* PCIC PCIDMA1 */
+                              <0xa80 INTPRI00 IPR_B4>,      /* PCIC PCIDMA0 */
+                              <0xaa0 INTPRI00 IPR_B4>,      /* PCIC PCIPWON */
+                              <0xac0 INTPRI00 IPR_B4>,      /* PCIC PCIPWDWN */
+                              <0xae0 INTPRI00 IPR_B4>,      /* PCIC PCIERR */
+                              <0xb00 INTPRI00 IPR_B8>,      /* TMU3 */
+                              <0xb80 INTPRI00 IPR_B12>;     /* TMU4 */
+    };
+...
-- 
2.39.2


