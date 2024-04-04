Return-Path: <linux-pci+bounces-5684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840B89801F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B231F21D7D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA080611;
	Thu,  4 Apr 2024 05:15:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EE58AC5;
	Thu,  4 Apr 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207721; cv=none; b=URqhkTLaq5bv84ddDgrOXwPjXC+jqiLTRXt35zCYa2vc3RDEHgxORykPyguIRqpt2n+eX1+JI1W+3/hPDp1aImmC58FVRBHnDzDBBmU2R05QSYtzvx9KXMNSgzEaI4uutC5XploBJlI8kqlUwyhx8d4OMVxgCbsgEvT7oyBnY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207721; c=relaxed/simple;
	bh=1xMW4sZCG05RmqUl4sfWusbiwrMTmOWImJT9AqMcM98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY3t8HeWfufgW1V495EPpKVtErkpYRpmEFsrvXQPbQbgfzenYE08X3/yIvaoO6UOkA7TFWxl4ZPti91FYTyBB5wBRIFy6lNQVhEP4XhT1Gl4N0+tRIJUXMrD+SSKYXB1T53579u2JcBRRl/VmzTVBgKj9wwqTlwFqW9x+qLcyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 4B34F1C0FDB;
	Thu,  4 Apr 2024 14:15:17 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
	Shawn Guo <shawnguo@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [RESEND v7 13/37] dt-bindings: clock: sh7750-cpg: Add renesas,sh7750-cpg header.
Date: Thu,  4 Apr 2024 14:14:24 +0900
Message-Id: <1db8627e4ca50b9d2d27e95d245518cac1cd62dc.1712207606.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712207606.git.ysato@users.sourceforge.jp>
References: <cover.1712207606.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH7750 CPG Clock output define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/clock/renesas,sh7750-cpg.yaml    | 105 ++++++++++++++++++
 include/dt-bindings/clock/sh7750-cpg.h        |  26 +++++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
 create mode 100644 include/dt-bindings/clock/sh7750-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
new file mode 100644
index 000000000000..04c10b0834ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,sh7750-cpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7750/7751 Clock Pulse Generator (CPG)
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description:
+  The Clock Pulse Generator (CPG) generates core clocks for the SoC.  It
+  includes PLLs, and variable ratio dividers.
+
+  The CPG may also provide a Clock Domain for SoC devices, in combination with
+  the CPG Module Stop (MSTP) Clocks.
+
+properties:
+  compatible:
+    enum:
+      - renesas,sh7750-cpg             # SH7750
+      - renesas,sh7750s-cpg            # SH775S
+      - renesas,sh7750r-cpg            # SH7750R
+      - renesas,sh7751-cpg             # SH7751
+      - renesas,sh7751r-cpg            # SH7751R
+
+  reg: true
+
+  reg-names: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: extal
+
+  '#clock-cells':
+    const: 1
+
+  renesas,mode:
+    description: Board-specific settings of the MD[0-2] pins on SoC
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 6
+
+  '#power-domain-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,sh7750-cpg
+              - renesas,sh7750s-cpg
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: FRQCR
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,sh7750r-cpg
+              - renesas,sh7751-cpg
+              - renesas,sh7751r-cpg
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: FRQCR
+            - const: CLKSTP00
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sh7750-cpg.h>
+    cpg: clock-controller@ffc00000 {
+        #clock-cells = <1>;
+        #power-domain-cells = <0>;
+        compatible = "renesas,sh7751r-cpg";
+        clocks = <&extal>;
+        clock-names = "extal";
+        reg = <0xffc00000 20>, <0xfe0a0000 16>;
+        reg-names = "FRQCR", "CLKSTP00";
+        renesas,mode = <0>;
+    };
diff --git a/include/dt-bindings/clock/sh7750-cpg.h b/include/dt-bindings/clock/sh7750-cpg.h
new file mode 100644
index 000000000000..ec267be91adf
--- /dev/null
+++ b/include/dt-bindings/clock/sh7750-cpg.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SH7750_H__
+#define __DT_BINDINGS_CLOCK_SH7750_H__
+
+#define SH7750_CPG_PLLOUT	0
+
+#define SH7750_CPG_PCK		1
+#define SH7750_CPG_BCK		2
+#define SH7750_CPG_ICK		3
+
+#define SH7750_MSTP_SCI		4
+#define SH7750_MSTP_RTC		5
+#define SH7750_MSTP_TMU012	6
+#define SH7750_MSTP_SCIF	7
+#define SH7750_MSTP_DMAC	8
+#define SH7750_MSTP_UBC		9
+#define SH7750_MSTP_SQ		10
+#define SH7750_CSTP_INTC	11
+#define SH7750_CSTP_TMU34	12
+#define SH7750_CSTP_PCIC	13
+
+#endif
-- 
2.39.2


