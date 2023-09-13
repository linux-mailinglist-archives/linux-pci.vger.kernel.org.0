Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57D79E3F1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbjIMJkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbjIMJkQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 05:40:16 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392F196
        for <linux-pci@vger.kernel.org>; Wed, 13 Sep 2023 02:40:12 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 0126560d-91a5-47c6-b1a8-235dee256e54;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 963BF1C00A0;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org
Subject: [RFC PATCH v2 09/30] Documentation/devicetree: Add renesas,sh7751-pci binding document.
Date:   Wed, 13 Sep 2023 18:23:34 +0900
Message-Id: <701db4418652fc2ed36570ac20d57117ec6941c5.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/pci/renesas,sh7751-pci.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
new file mode 100644
index 000000000000..17a24e24c393
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,sh7751-pci.yaml
@@ -0,0 +1,57 @@
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
+properties:
+  compatible:
+      - items:
+          - enum:
+              - renesas,r2d-pci	         # Renesas RTS7751R2D board
+              - iodata,julian-pci        # IO DATA DEVICE Julian board
+          - const: renesas,sh7751-pci
+
+  reg:
+    minItems: 3
+
+  interrupt-cells:
+    const: 1
+
+  address-cells:
+    const: 3
+
+  size-cells:
+    const: 2;
+
+  range:
+    description: |
+      The PCI bus memory area and I/O area.
+
+
+required:
+  - compatible
+  - reg
+  - interrupt-cells
+  - address-cells
+  - size-cells
+  - range
+
+examples:
+  - |
+        pci@fe200000 {
+                compatible = "renesas,sh7751-pci";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+                         <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
+                reg = <0xfe200000 0x0400>,
+                      <0x0c000000 0x04000000>,
+                      <0xff800000 0x0030>;
+                #interrupt-cells = <1>;
+        };
-- 
2.39.2

