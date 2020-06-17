Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7491FCAD3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFQK0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFQK0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:26:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA98C061755;
        Wed, 17 Jun 2020 03:26:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so1745577wrv.4;
        Wed, 17 Jun 2020 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/9cfu2y0gUm+qAaNBhnFdIEQLZfDLxCjAKkGlm5DYM=;
        b=tjVwfMzfezRS9AAHD0xn4ivcVdZGg3r8D9CRl1RnfK1KyELblhj6SXxCQ5kk48mYMH
         xcmrHXWHJCQfLz2hjOLYgsmtIDFIOwolDGx0vscnJiM2AtwdNFs6fIM7tqiudIlrhTqm
         +zHHnaVd5xscisFBy9wVpM4cox7afR+leCajS/7sj4fIhtS0WPPhlc3J7k83sajh7O9w
         A4xVgX4OfQMrMjnVKiN3z9tNxeXwMYQ9ljsJrBn7oN4nK76jTzOIuGwT56f7j//a2EWZ
         bN2Sag1m22Do6GYU3jfzXtMY9YPGpTf290fQh+bIrBOSXt2Buafp7FAocQ3tKFWR428r
         Jmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/9cfu2y0gUm+qAaNBhnFdIEQLZfDLxCjAKkGlm5DYM=;
        b=sWxgP87vppnLYh1VY7DtjwAy+RUCRIvjbC+HLmoWFdFCOzjnIUpRBvoEZgoZoSegtR
         3UwpN9chbesjsJKr3XVqDsww5R7F90/Le6LiWrJ5doWQkJassKe8TS5PFdlzfFVGwGmP
         jGjf+2jMlzAA0b17J/V5ok6FNtmDQs7OqIDERL6EQw5aCMCtA6hZ0yiVF74luqN02DKK
         w2VmdXCjfzO4mUPd4XrHIrQyXvdGOLHw2ZW8H04mxqmI+hfVPasRUA6EVaLc6Euaqm8X
         aWX6z1kc6hHhEYsf7KJ6zWXPYXPRF+/Dz19rmT3HvP8LoAIw9MykS40JIDXqK0qJWz1b
         37jA==
X-Gm-Message-State: AOAM533aL17Xze2Ljwcmq8F/LHimt6mCn92tiFk65eMLd/REGWM2mD+m
        DOryRTF//5y3tTQenxGO4ho8tRBIv6Vg4Q==
X-Google-Smtp-Source: ABdhPJy/ZiXL9BtAh/Bj2+9q7KbP8dvVZ/6Ktgmt9Jva703q36iZ6hOovQyjRd+xQXH7qdkRqiCpZg==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr5274061wrp.412.1592389560920;
        Wed, 17 Jun 2020 03:26:00 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id z206sm7569847wmg.30.2020.06.17.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:26:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        jiaxun.yang@flygoat.com, paulburton@kernel.org, info@metux.net,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de, jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/3] dt-bindings: Document BCM6328 PCIe Host Controller
Date:   Wed, 17 Jun 2020 12:25:55 +0200
Message-Id: <20200617102556.3792821-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617102556.3792821-1-noltari@gmail.com>
References: <20200617102556.3792821-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 .../bindings/pci/brcm,bcm6328-pcie.yaml       | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
new file mode 100644
index 000000000000..d2bd4933a5fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/brcm,bcm6328-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM6328 PCIe Host Controller Device Tree Bindings
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    enum:
+     - brcm,bcm6328-pcie
+     - brcm,bcm6362-pcie
+     - brcm,bcm63268-pcie
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pcie
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map-mask:
+    maxItems: 1
+
+  interrupt-map:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: pcie
+      - const: pcie-core
+      - const: pcie-ext
+      - const: pcie-hard
+
+required:
+  - brcm,serdes
+  - clocks
+  - clock-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - ranges
+  - reg
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serdes_cntl: syscon@10001800 {
+      compatible = "syscon";
+      reg = <0x10001800 0x4>;
+      native-endian;
+    };
+
+    pcie: pcie@10e40000 {
+      compatible = "brcm,bcm6328-pcie";
+      reg = <0x10e40000 0x10000>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+
+      device_type = "pci";
+      bus-range = <0x00 0x01>;
+      ranges = <0x2000000 0 0x10f00000 0x10f00000 0 0x100000>;
+      linux,pci-probe-only = <1>;
+
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0>;
+      interrupt-map = <0 0 0 0 &periph_intc BCM6328_IRQ_PCIE_RC 0>;
+
+      clocks = <&periph_clk BCM6328_CLK_PCIE>;
+      clock-names = "pcie";
+
+      resets = <&periph_rst BCM6328_RST_PCIE>,
+               <&periph_rst BCM6328_RST_PCIE_EXT>,
+               <&periph_rst BCM6328_RST_PCIE_CORE>,
+               <&periph_rst BCM6328_RST_PCIE_HARD>;
+      reset-names = "pcie",
+                    "pcie-ext",
+                    "pcie-core",
+                    "pcie-hard";
+
+      power-domains = <&periph_pwr BCM6328_POWER_DOMAIN_PCIE>;
+
+      brcm,serdes = <&serdes_cntl>;
+    };
-- 
2.27.0

