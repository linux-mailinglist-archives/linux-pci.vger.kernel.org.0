Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5B372254
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhECVRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 17:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 17:17:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF8C06174A
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 14:16:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p12so8614215ljg.1
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxi/xMMGJqV7UoX2rYd8j1MY3pfk8Gq2PEylFD9T6K8=;
        b=y7OupY+e/6RARMk8sDxPGtRVk6ynzzdFqYm2m1/mY4BxU3ro2OoGuUSR5v/w/OVBn+
         Mf2gvXkPu73yfswkN88T/C/BgM2exaZZdCnSNQGkYQwfW0GccjkA8reli01dhVYaF69Q
         DZWWAhOupzAxw3Qe6vCHZ4MWvCtvWkduTB+R764WB7mwnQLzkzk0axwaoPQK6WQZwrKo
         /l1tBbz1Rpm9Gu3WVJBFEkJluT5rG++JypiqwEfJqx+cRUqQt/kE2JPEGxnag9vHNge+
         cVZvHUw75XOm3mc+lACHPldlH5lIyak0wd+t2uoebVRacFr62ZNfQFLYUyPI7WraDMLt
         W+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxi/xMMGJqV7UoX2rYd8j1MY3pfk8Gq2PEylFD9T6K8=;
        b=sMcxosaQfmQDhymmkGygFcpGgtgq8l/JuQyEhi3UG+44a59p7B0uTI7ds8r3oaIGhs
         P63rSk/i7MfdyfXuEoN++wGtDCslZ0oYBQGvAUoIX+ex0XMuM15pqUA2Dvtw3/kFWG3q
         /Ga8bHE2DpgwDLXXVdbzXWpdSlsQa+OEB+l8UBRaMAkWIfuDYAeBfPJSPiyzPuKlQaTT
         Hy3oXmerw39XGnLJQgPwkXhoyBHeZSAaL1YscFVI4vYFLnCOSGUWwJFqAiox3ZfLQGGq
         2ltyn5mKEC9SyQm4QrMpo0hRPyE1YrW9dKFqoMOWmgtfHEpny1q3FoFjHyZhxm6Fn4L7
         iUvw==
X-Gm-Message-State: AOAM533+9MWgCOAUfMQKUunj3bLea5pNixQP041z4G0feuOOt6DjxxIX
        /5k7gB/YHf46L1NYoZtBi3UIZA==
X-Google-Smtp-Source: ABdhPJwjJ5v6IlL9XgEILDChrs9KXqs6ohxsuU/GUL291m3kpFUU7tdOIHuPKVxPNwEjZqp7MscLrg==
X-Received: by 2002:a2e:bc22:: with SMTP id b34mr14776708ljf.392.1620076616829;
        Mon, 03 May 2021 14:16:56 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m12sm67676lfb.72.2021.05.03.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:16:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] PCI: ixp4xx: Add device tree bindings for IXP4xx
Date:   Mon,  3 May 2021 23:16:48 +0200
Message-Id: <20210503211649.4109334-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210503211649.4109334-1-linus.walleij@linaro.org>
References: <20210503211649.4109334-1-linus.walleij@linaro.org>
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
PCI maintainers: mainly looking for a review and ACK (if
you care about DT bindings) the patch will be merged
through ARM SoC.
---
 .../bindings/pci/intel,ixp4xx-pci.yaml        | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
new file mode 100644
index 000000000000..5b6af2f5c2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
@@ -0,0 +1,96 @@
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
+  - ranges
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
+      status = "disabled";
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
2.29.2

