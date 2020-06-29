Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF220D806
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbgF2Te7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733147AbgF2TbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E7FCADAA;
        Mon, 29 Jun 2020 16:18:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v5 1/9] dt-bindings: reset: Add a binding for the RPi Firmware reset controller
Date:   Mon, 29 Jun 2020 18:18:37 +0200
Message-Id: <20200629161845.6021-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629161845.6021-1-nsaenzjulienne@suse.de>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The firmware running on the RPi VideoCore can be used to reset and
initialize HW controlled by the firmware.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---
Changes since v2:
 - Add include file for reset IDs

Changes since v1:
 - Correct cells binding as per Florian's comment
 - Change compatible string to be more generic

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
 .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index b48ed875eb8e..23a885af3a28 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -39,6 +39,22 @@ properties:
       - compatible
       - "#clock-cells"
 
+  reset:
+    type: object
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-reset
+
+      "#reset-cells":
+        const: 1
+        description: >
+          The argument is the ID of the firmware reset line to affect.
+
+    required:
+      - compatible
+      - "#reset-cells"
+
     additionalProperties: false
 
 required:
@@ -55,5 +71,10 @@ examples:
             compatible = "raspberrypi,firmware-clocks";
             #clock-cells = <1>;
         };
+
+        reset: reset {
+            compatible = "raspberrypi,firmware-reset";
+            #reset-cells = <1>;
+        };
     };
 ...
diff --git a/include/dt-bindings/reset/raspberrypi,firmware-reset.h b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
new file mode 100644
index 000000000000..1a4f4c792723
--- /dev/null
+++ b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Nicolas Saenz Julienne
+ * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.com>
+ */
+
+#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
+#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
+
+#define RASPBERRYPI_FIRMWARE_RESET_ID_USB	0
+#define RASPBERRYPI_FIRMWARE_RESET_NUM_IDS	1
+
+#endif
-- 
2.27.0

