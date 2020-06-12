Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E71F7C4C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgFLROi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 13:14:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgFLRNp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 13:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86277AED8;
        Fri, 12 Jun 2020 17:13:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi Firmware reset controller
Date:   Fri, 12 Jun 2020 19:13:25 +0200
Message-Id: <20200612171334.26385-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612171334.26385-1-nsaenzjulienne@suse.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
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
2.26.2

