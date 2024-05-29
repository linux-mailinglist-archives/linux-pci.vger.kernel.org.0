Return-Path: <linux-pci+bounces-7966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911308D2F7A
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49C91C2496C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239DA16F291;
	Wed, 29 May 2024 08:01:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB416F0E8;
	Wed, 29 May 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969714; cv=none; b=fP0PQqnh4NgiXtg0mj7pjvNady2R8fG0NksG21pSdqa1QiHw2jCj2+rxBSXozxv4OPzAkgPqEvMKIn0YglLUogzD7eK/Sf0AYNyv4rpjXL0NkMKpqkVqYsWSF1wC2lMdFfCP4vf0RVgir2mpoR8UsO12NRxRsFZxSM4EYelAr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969714; c=relaxed/simple;
	bh=MMEjeyCSEvlBnkE0HuddEvDMuSlTKCNs+hpF8pPNwDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oo1FpDUI11HADi2Szupx2g+DnrwW3hb3sVO8GOO8fEISZiDrUgjAsTofH2yylp+nYm75hQwCrJ2ljK90D8eef704cZHoqqZc7kR05BCg81uxukwSYbJju30qF07Y0yRpfzJi8ymCgf8UCDzl4qWT2uaxMuFLM89uOoXafGOMDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 779261C0BDE;
	Wed, 29 May 2024 17:01:49 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
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
Subject: [DO NOT MERGE v8 12/36] dt-bindings: pci: pci-sh7751: Add SH7751 PCI
Date: Wed, 29 May 2024 17:00:58 +0900
Message-Id: <587a2968539690a240f157ff860e148dea2bd167.1716965617.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1716965617.git.ysato@users.sourceforge.jp>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
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
 .../bindings/pci/renesas,sh7751-pci.yaml      | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..3c3e8f9253c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,75 @@
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
+  interrupt-controller: true
+
+  renesas,bus-arbit-round-robin:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set DMA bus arbitration to round robin.
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
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
+            dma-ranges = <0x03000000 0 0xab000000 0xab000000 0 0x00000001>,
+                         <0x02000000 0 0x0c000000 0x0c000000 0 0x04000000>,
+                         <0x02000000 0 0xd0000000 0xd0000000 0 0x00000001>;
+            reg = <0xfe200000 0x0400>,
+                  <0xff800000 0x0100>;
+            interrupt-map = <0x0000 0 0 1 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 2 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 3 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0000 0 0 4 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 1 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 2 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 3 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x0800 0 0 4 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 1 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 2 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 3 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+                            <0x1000 0 0 4 &julianintc 6 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-map-mask = <0x1800 0 0 7>;
+    };
-- 
2.39.2


