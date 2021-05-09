Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91D43778FE
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEIWWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 18:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhEIWWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 18:22:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420EC061573
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 15:21:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 7so43886lfp.9
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjNmqgcstGAxj0Xo8lZD7LTDFmxFM0Yqxj4VjUg9Qdw=;
        b=bHKoczEPIMs4+OuEfUaeip+Kx4QcMrQRhH1/FpV85lJgzzgdMedlKhBPf074UYfLXT
         yAuzfmjaqjz/jNdg4XUgVKAXJ+xR0F0GQ6fx0fQE7onCHFb2cOE0QDcduG3phiVWb3ta
         wNR5Fmxbm4wXPSCmpr222cLSxbQ3uA7RtL9uFNAW4dhzAziKqKHTe5/ZYMbq9pvNTuHT
         3J3jcOMat4gxGNc03EJvYmzShUEOOM+jrqqw5PPyFPugSE++IImG/5VXpLuEJ5Scg+uZ
         NWwWu2or1nv3u9ShsCDAdR7MBP17UnpV5dRGhF3XzGZ3w6XLsNZK3i/i8AsYQQmwg3vB
         IV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjNmqgcstGAxj0Xo8lZD7LTDFmxFM0Yqxj4VjUg9Qdw=;
        b=qKHwpcfwF9facukQef6HgAyvqUs/GYAgOZJ/wICu5UWS07w2N3LOqQZaARkc11iYpu
         OeLvtX5Glr6DxJtjXjEigBWeiI3xgnl0+gbJCF1A6N2c0rVvJKi2thyDJa1zwM12F8K3
         lIydjWaz+TKrW0DclnwFi16LM5wU/YX/YgqoWmdqM2gvqfgojNz62277My15evxCeoiD
         M+uo7bm3QNnm2GRwynBS9S5hgWAHCdgEyKzPhVg/GIE9L0ufct+MJ1WqIha7SVbVlG4g
         7RkAUnIEhbVpRmYQXM5ILnV1dqaD7N+4xHcveqCoWSgCD2qThyO4C+V6XpJA5wS3Emh8
         vlFA==
X-Gm-Message-State: AOAM530ZNyrHdlIT42YWjuOs9q6OS58z7kHPvNflUcpx+Bp/A5iz/Hrv
        uf3wqWDg8neJ6WX6nmj/D6KWNw==
X-Google-Smtp-Source: ABdhPJw6BKQQGcIDZdsMlJ9qaiNbzUsRzwi01N8Yn7U0BfQ91i9Ou6kqCQL4toNmGMfOdugqMKV50A==
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr14168468lfu.408.1620598865621;
        Sun, 09 May 2021 15:21:05 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u12sm2978012ljo.82.2021.05.09.15.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:21:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4 v3] PCI: ixp4xx: Add device tree bindings for IXP4xx
Date:   Mon, 10 May 2021 00:20:54 +0200
Message-Id: <20210509222055.341945-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210509222055.341945-1-linus.walleij@linaro.org>
References: <20210509222055.341945-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds device tree bindings for the Intel IXP4xx
PCI controller which can be used as both host and
option.

Cc: devicetree@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Zoltan HERPAI <wigyori@uid0.hu>
Cc: Raylynn Knight <rayknight@me.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Drop ranges, these are part of pci-bus.yaml
- Drop status = "disabled" on the node
ChangeLog v1->v2:
- Add the three controller interrupts to the binding.

PCI maintainers: mainly looking for a review and ACK (if
you care about DT bindings) the patch will be merged
through ARM SoC.
---
 .../bindings/pci/intel,ixp4xx-pci.yaml        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
new file mode 100644
index 000000000000..debfb54a8042
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/intel,ixp4xx-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel IXP4xx PCI controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: PCI host controller found in the Intel IXP4xx SoC series.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - intel,ixp42x-pci
+          - intel,ixp43x-pci
+    description: The two supported variants are ixp42x and ixp43x,
+      though more variants may exist.
+
+  reg:
+    items:
+      - description: IXP4xx-specific registers
+
+  interrupts:
+    items:
+      - description: Main PCI interrupt
+      - description: PCI DMA interrupt 1
+      - description: PCI DMA interrupt 2
+
+  ranges:
+    maxItems: 2
+    description: Typically one memory range of 64MB and one IO
+      space range of 64KB.
+
+  dma-ranges:
+    maxItems: 1
+    description: The DMA range tells the PCI host which addresses
+      the RAM is at. It can map only 64MB so if the RAM is bigger
+      than 64MB the DMA access has to be restricted to these
+      addresses.
+
+  "#interrupt-cells": true
+
+  interrupt-map: true
+
+  interrupt-map-mask:
+    items:
+      - const: 0xf800
+      - const: 0
+      - const: 0
+      - const: 7
+
+required:
+  - compatible
+  - reg
+  - dma-ranges
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pci@c0000000 {
+      compatible = "intel,ixp43x-pci";
+      reg = <0xc0000000 0x1000>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      device_type = "pci";
+      bus-range = <0x00 0xff>;
+
+      ranges =
+        <0x02000000 0 0x48000000 0x48000000 0 0x04000000>,
+        <0x01000000 0 0x00000000 0x4c000000 0 0x00010000>;
+      dma-ranges =
+        <0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
+
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0xf800 0 0 7>;
+      interrupt-map =
+        <0x0800 0 0 1 &gpio0 11 3>, /* INT A on slot 1 is irq 11 */
+        <0x0800 0 0 2 &gpio0 10 3>, /* INT B on slot 1 is irq 10 */
+        <0x0800 0 0 3 &gpio0 9  3>, /* INT C on slot 1 is irq 9 */
+        <0x0800 0 0 4 &gpio0 8  3>, /* INT D on slot 1 is irq 8 */
+        <0x1000 0 0 1 &gpio0 10 3>, /* INT A on slot 2 is irq 10 */
+        <0x1000 0 0 2 &gpio0 9  3>, /* INT B on slot 2 is irq 9 */
+        <0x1000 0 0 3 &gpio0 8  3>, /* INT C on slot 2 is irq 8 */
+        <0x1000 0 0 4 &gpio0 11 3>, /* INT D on slot 2 is irq 11 */
+        <0x1800 0 0 1 &gpio0 9  3>, /* INT A on slot 3 is irq 9 */
+        <0x1800 0 0 2 &gpio0 8  3>, /* INT B on slot 3 is irq 8 */
+        <0x1800 0 0 3 &gpio0 11 3>, /* INT C on slot 3 is irq 11 */
+        <0x1800 0 0 4 &gpio0 10 3>; /* INT D on slot 3 is irq 10 */
+    };
-- 
2.30.2

