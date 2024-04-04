Return-Path: <linux-pci+bounces-5661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60633897EDC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1FB22047
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD471753;
	Thu,  4 Apr 2024 05:01:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE66FE16;
	Thu,  4 Apr 2024 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206874; cv=none; b=VefA8qG4m9+PeIJQjq+Jc0XoWrOFiN1+DiNPtEqBjkjw913KnE+ieVdaXPwgLeqz+Qz/rPg3JwKZsoOnn7uUDoxMrJ6xomb9rxQVYvwR0rGeS0yBrtG6+WCpAa4ZSbdF93/tExQLlmVU/b38jXGxanZxg6dZORcgD+DBBBPtLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206874; c=relaxed/simple;
	bh=7IdyKC16TiRcoV3/cW/Zd7MaUktUAv9ffK9AZ3hzcao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnHajU+JjJIPVRyLwRKzyZHjN9iWC8CjSMODOuZz0/cVfoNwt245+aY6WR/hmLE+gyEBGOhe9XbI5jMaJ/wwHjXfRxCNgKN90gbsPATrZYo83AZii9iAeywlsu5mQr7d3gEjq0fJVFhjOXQqsRXnbXZuUaw1zP+FT2rG6uTf92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id D6F881C0AA6;
	Thu,  4 Apr 2024 14:01:10 +0900 (JST)
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
Subject: [PATCH v7 19/37] dt-bindings: interrupt-controller: renesas,sh7751-irl-ext: Add json-schema
Date: Thu,  4 Apr 2024 13:59:54 +0900
Message-Id: <8d8dec2d75890f3a14632c9606c332fb11d89a95.1712205900.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712205900.git.ysato@users.sourceforge.jp>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas SH7751 external interrupt encoder json-schema.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../renesas,sh7751-irl-ext.yaml               | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
new file mode 100644
index 000000000000..fc174c0467e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH7751 external interrupt encoder with enable regs.
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description:
+  This is the generally used external interrupt encoder on SH7751 based boards.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,sh7751-irl-ext
+
+  reg: true
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  renesas,set-to-disable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Invert enable registers. Setting the bit to 0 enables interrupts.
+
+  renesas,enable-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      IRQ enable register bit mapping
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - renesas,enable-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    r2dintc: interrupt-controller@a4000000 {
+        compatible = "renesas,sh7751-irl-ext";
+        reg = <0xa4000000 0x02>;
+        interrupt-controller;
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+        renesas,enable-reg = <12 9 10 3 0 4 1 2 8 5 6 7 15 15 15 11>;
+    };
-- 
2.39.2


