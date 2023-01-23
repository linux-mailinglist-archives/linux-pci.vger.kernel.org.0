Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFC67789F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAWKKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjAWKKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:10:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7168B126E7
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so10232979wrz.12
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBPBzdh3eujGMqwSAewcH2FPtNMnZTECjtcDhfAnWzg=;
        b=ymzD+yGXpHJi0tfrmqPtik9lx2Mlk/0PNwaPiH9Q9khXzZxqU5PGx0viHREBD7vxeJ
         q1jin0Wjjzpbd7v+GCY5aZJwOhSktEsAu9W+P/PVDPtCX/4tc0d5gCTOUC+IQ6Rk3htI
         lwD9ECIVq22K0aIpwCpQq7GEqnblHxzQ7ffWzHEwPP2XKbLI4Lt8oWOKFWeC9zxvRV7h
         pM/ZsvDiK4JYGOUf7Cdh5JCggARPgDrV6ow/G17RRV9WVe9gtdlqkrJtrffzbT7LhE2K
         X2F1kRP29Aw6VFF7bOCkAnPg+90D3OEItWeiOfvp63XYJ3MqX9697GTwMrD7Z1JPqwHo
         rG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBPBzdh3eujGMqwSAewcH2FPtNMnZTECjtcDhfAnWzg=;
        b=2lEqfBKnCs2Z8XP75/sJ0P0/d282YwRzqxa01MNwtpiCJgMAX8taW67Mqv6PIyBGTz
         p1UetbuVJJnM3ToXimeJSXXMOCxy16MP06jpV7BaCV5kJ88E6TtFBYrWfTrQqr6n8bVQ
         8HmOPTPn7c8yfBY/8QivcVWk7LDM3CB2H1vJKLZghqJukMNtG69rtsd861epu/PqDgry
         NshNKIy1ak1NTiMz2S/J1ubwZbKk4OrqcM8a+VuYi0kcjFpL22nhFWpRukvrMg1niLvc
         yAnJJ/P9GOCI9yPxxa5B9wSbYd5F3toqfVOJvA8hm1S+jbJksgLfhS8ani28ueg0wHmB
         jqhg==
X-Gm-Message-State: AFqh2kpztptAmXmNzRuz8ec6+B3FEKexbrnsRkidrTegse9SrcDmobPj
        tYDeDXSThn6+g5DiGeWQdjAuAg==
X-Google-Smtp-Source: AMrXdXugJ1sMcdhxjgP48Nuvn2UCKsloEQfCtKPBr4p4UBBaVywjhDB3rMRURjonU2yP79qKNZEkvQ==
X-Received: by 2002:adf:d22c:0:b0:2bd:f95d:4457 with SMTP id k12-20020adfd22c000000b002bdf95d4457mr19441166wrh.69.1674468604815;
        Mon, 23 Jan 2023 02:10:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:04 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 11:10:00 +0100
Subject: [PATCH v3 3/7] dt-bindings: watchdog: convert meson-wdt.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-3-e28dd31e3bed@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Amlogic Meson6 SoCs Watchdog timer bindings to dt-schema.

Take in account the used interrupts property.

The "amlogic,meson8-wdt" representation has been simplified
since there's no users of this compatible used along the
"amlogic,meson6-wdt".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/watchdog/amlogic,meson6-wdt.yaml      | 50 ++++++++++++++++++++++
 .../devicetree/bindings/watchdog/meson-wdt.txt     | 21 ---------
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml
new file mode 100644
index 000000000000..84732cb58ec4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/amlogic,meson6-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6 SoCs Watchdog timer
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - amlogic,meson6-wdt
+          - amlogic,meson8-wdt
+          - amlogic,meson8b-wdt
+      - items:
+          - const: amlogic,meson8m2-wdt
+          - const: amlogic,meson8b-wdt
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    wdt: watchdog@c1109900 {
+        compatible = "amlogic,meson6-wdt";
+        reg = <0xc1109900 0x8>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
+        timeout-sec = <10>;
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
deleted file mode 100644
index 7588cc3971bf..000000000000
--- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Meson SoCs Watchdog timer
-
-Required properties:
-
-- compatible : depending on the SoC this should be one of:
-	"amlogic,meson6-wdt" on Meson6 SoCs
-	"amlogic,meson8-wdt" and "amlogic,meson6-wdt" on Meson8 SoCs
-	"amlogic,meson8b-wdt" on Meson8b SoCs
-	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-- timeout-sec: contains the watchdog timeout in seconds.
-
-Example:
-
-wdt: watchdog@c1109900 {
-	compatible = "amlogic,meson6-wdt";
-	reg = <0xc1109900 0x8>;
-	timeout-sec = <10>;
-};

-- 
2.34.1

