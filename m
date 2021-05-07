Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013293763CA
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhEGKb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbhEGKbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 06:31:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB1C061761
        for <linux-pci@vger.kernel.org>; Fri,  7 May 2021 03:30:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 124so12088529lff.5
        for <linux-pci@vger.kernel.org>; Fri, 07 May 2021 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beBOO2e9LBlqWNSPs81mS1QwysR1XMwYJL5ldmakWMs=;
        b=PEmhT5Tkxv0eG+GMGVbBbXkRsRqXoYrMomfqdRUXs/KIg+R8vK4ic7o67o9NTbz71M
         viPhB8pMffqmc2dLVHH8WtgAZIh4eTm7X3EM0d6p6VzXN2TvrGkWjRJ/CoXZFCqKx6ba
         JmK1vpchZvPugJ4Uz2nBfkCHUF/nAoHxhq/vxNziYJvrLgi3JGA8Xm8NNeZlkVePeyDq
         XhdzcIepzuWQTGzAgZC2MImPDniZ9ZBpPqaFhiI86AwIAlBH5oZ4nKOoxY5OTdh9YWsC
         lEKCCPSNXfj3MyJox6gbqFOvLox+8XvrjOP/hy5bWS+uKyf3xOD/w0wDj6/OhyHEQvAW
         LrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beBOO2e9LBlqWNSPs81mS1QwysR1XMwYJL5ldmakWMs=;
        b=uUdV+WqtlrYVw1VLlxlyyd/hT0nMThnZdSRqDJqTR0Rr8rTP+aqivBJHKwlj+PxGdT
         sauAnVMHMsmG1FryMJOA2jqOJg1yzNEM9REauzqtgu2Tmo2UWYo/lP0TSI9sjrtnIUXI
         NOSiqe4cuXKjtFzcroRT/CzuD+DfhkjD+/PSdfUSkccDaGEXLRrVycuX9UGeMagmfhtA
         B1GmukDHYRQKFUQSfIPmh7Vt0GSRhpnYunA9L2DYe/V6pjBTbDPUUR8i5AnW1/sJXvKk
         qqIOuCC0ZQ+swTe/vd6cCX5B6gGUz52k8tI/T8zcjh1ErO0qOdJ0RpCE6vhDyjl5bNbk
         ZBhQ==
X-Gm-Message-State: AOAM531y3cGZxZH7qRmajdWAou12fcmw1EBYJ/KRurExM829dZuJhXoP
        wJINm1j4AKf4Vl7nuJ6WDzYlMw==
X-Google-Smtp-Source: ABdhPJzMXVr8DWSF49SHfZIKi921rzt1EEUZaPyY1nRRkewBrLnNBJeYvBkJ4pYhNgL4SygU3p6ztA==
X-Received: by 2002:ac2:58e7:: with SMTP id v7mr6167405lfo.505.1620383451518;
        Fri, 07 May 2021 03:30:51 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y7sm1314218lfb.62.2021.05.07.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 03:30:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4 v2] PCI: ixp4xx: Add device tree bindings for IXP4xx
Date:   Fri,  7 May 2021 12:30:39 +0200
Message-Id: <20210507103040.132562-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507103040.132562-1-linus.walleij@linaro.org>
References: <20210507103040.132562-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Add the three controller interrupts to the binding.

PCI maintainers: mainly looking for a review and ACK (if
you care about DT bindings) the patch will be merged
through ARM SoC.
---
 .../bindings/pci/intel,ixp4xx-pci.yaml        | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
new file mode 100644
index 000000000000..12c9be2ac118
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
@@ -0,0 +1,102 @@
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
2.30.2

