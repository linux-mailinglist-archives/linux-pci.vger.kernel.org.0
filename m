Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1266260E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjAIMyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 07:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjAIMxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 07:53:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A491649B
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 04:53:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o15so6173909wmr.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRoLsjyY/qf2Mb569g+NlHCALe/agKv6TWaWZecCXbM=;
        b=PtAZ9sogJ7D4ak5aTWeShdIBpAojseUr1St7O+JcXvW9KypuHN2Tf5W1eVB8HsoPF5
         Qc5AYGcZBGHgvHxrR3P6gpgTinKrkUnuy5LEDPE03vAR78m1vUv3J7o9Zs8EkLiokWFG
         C5+WI1eABYMDkQ5QEoKydR/Me0T2WGlkuMYQfCLahG/XOli4iTy+Rn+agbzFJXwgJjhY
         fQR1MEQz3dhs6YPpglpZflbvBSoAWJOLMZKoVKR9KOP9UnbpyVI8cbcw38XnxxrIevb5
         gAPqB1nL5xVr+w5BIPh5+EWDCP9351eyJjxkEPdFQmPvKJPhGUQwh+0uzz7LAv35bZsI
         uYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRoLsjyY/qf2Mb569g+NlHCALe/agKv6TWaWZecCXbM=;
        b=kv47KMhyhY7exjPxVe4ZWnZAri0pNq1YDzABeJ6Z6eHRciU1eOFWWitXXMRIkEezIR
         MsBDKIwvRObP2ca05MLYYHRYsIHAE2fq0HOqatFGNzGwbes46iN/57OxYvhTMndTm9ri
         +DnLBkqrTw1oF6NsbqynZmWlne0vXLBjjOKPmsM9p0s2nIywctLOnxJ5IBJmm66w/Je0
         TkPRTwz8dobHJ6qQKusBYRxeiJb2duM4dA3r9SmxMCjbtVUUhJRl/rPuXr0wga1UdPKi
         aJVBQhRVKh1M0F7G7mTAhSMPViTlw96tXjO+N5RB4twNZfCf3Jg+uvbe9CaSw1XOUYtK
         +Isw==
X-Gm-Message-State: AFqh2kqW4gQ5Q/3O9STiBbzJP1fa3nMF7oOx4JwHhrXNeeArhMzIKz+p
        DYURnV7F3y7Zfu3tT2KmiEuQ9iYsRbZREQ+1
X-Google-Smtp-Source: AMrXdXv0Bdf0Epz6SrHpPBay5WK9tEtRPRH405V8jHfx2VRO9KsOFVi+7uQvyzocCrT86ySajHKxRw==
X-Received: by 2002:a05:600c:d2:b0:3d2:2b70:f2fd with SMTP id u18-20020a05600c00d200b003d22b70f2fdmr47240724wmm.21.1673268816880;
        Mon, 09 Jan 2023 04:53:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y7-20020a7bcd87000000b003d997e5e679sm12805667wmj.14.2023.01.09.04.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:53:36 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 13:53:28 +0100
Subject: [PATCH v2 04/11] dt-bindings: watchdog: convert meson-wdt.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v2-4-36ad050bb625@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.11.1
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
