Return-Path: <linux-pci+bounces-5696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37E89808A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD351C268AC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626C129E6D;
	Thu,  4 Apr 2024 05:15:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C58129A71;
	Thu,  4 Apr 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207744; cv=none; b=Wpxxi6TlmVTd75YzT+sPJR1NLfWXwcG1XKu92wltAdVAtkOTzKPlBv/11dM0Uu173k/zxI3ihWIjiaplPtAGYvGZWFOFrGo1N2xmy/7eAi9sRRTWXyW0/+ctnQqOrPZop5KMdWskRDrVkmkEhAmqThF8B7BgNaYrv9N9ZGKxdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207744; c=relaxed/simple;
	bh=4YGIn39v8DYFC1ATnliyljpzF5TdwdgS1LibAF3LgY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt7PYgM5rxJXRnPbC+XdVifKe3K/WVDfGJGmj8vfXUSfsQT5EXWMpQdIYFsogsCJyrtvLO3rLrsux0RGuQCEZ7NYOt7pZMGAR47tYnCYwkisIIyVmaL8fY8l1hfEUqOzH0giWbuQ/foQWk1Zqrsw0j6OxNKewR9Zx7MGf5UTu3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 2EED51C0FF9;
	Thu,  4 Apr 2024 14:15:40 +0900 (JST)
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
Subject: [RESEND v7 25/37] dt-binding: sh: cpus: Add SH CPUs json-schema
Date: Thu,  4 Apr 2024 14:14:36 +0900
Message-Id: <7731111c9e383c41173ac08f3a040a18449ac542.1712207606.git.ysato@users.sourceforge.jp>
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

Renesas SH series and compatible ISA CPUs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/sh/cpus.yaml          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sh/cpus.yaml

diff --git a/Documentation/devicetree/bindings/sh/cpus.yaml b/Documentation/devicetree/bindings/sh/cpus.yaml
new file mode 100644
index 000000000000..9e5640793d76
--- /dev/null
+++ b/Documentation/devicetree/bindings/sh/cpus.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sh/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SuperH CPUs
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description: |+
+  Definition of CPU core with Renesas SuperH and compatible instruction set.
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+          - enum:
+              - renesas,sh2a
+              - renesas,sh3
+              - renesas,sh4
+              - renesas,sh4a
+              - jcore,j2
+          - const: renesas,sh2
+      - const: renesas,sh2
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  device_type:
+    const: cpu
+
+required:
+  - compatible
+  - reg
+  - device_type
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/sh7750-cpg.h>
+    cpus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpu: cpu@0 {
+            compatible = "renesas,sh4", "renesas,sh2";
+            device_type = "cpu";
+            reg = <0>;
+            clocks = <&cpg SH7750_CPG_ICK>;
+            clock-names = "ick";
+            icache-size = <16384>;
+            icache-line-size = <32>;
+            dcache-size = <32768>;
+            dcache-line-size = <32>;
+        };
+    };
+...
-- 
2.39.2


