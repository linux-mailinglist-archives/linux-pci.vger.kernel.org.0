Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB06B08D6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCHN30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjCHN2s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:28:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63D57D3F
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 05:27:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1277716wmb.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678282056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ant/XgNH9Mz+PQiWqAx1zFtyj2dAe3bMZujLHEh+y8=;
        b=WXqUMYL0a8IT8f5OooqeitOtaiZKJHg8wPd4NN9u3fp4VuS/miAIgSx8HtEwF7qB5M
         eu5IFS2qUvaOeizdzGcRgjLZYgM27pAuhFkkQnIzOGSNbUpQo2g9b7Xc7Aj28EV9jEBw
         f+Jd22UIrdE34dIRSipgCWWC87VkPZmsCesBkxl3L99ECQF1/MSoiZEw+uZuEsCGda+Z
         dVegfJQ4OQnpuAbdq2YvL7WYzKf7s8Q3wWFBvb07KtLyvpC/yaj6ngzMiVMWkQ/FmMXP
         vn41fyHQD0GfRYGFpTKLja+agQpCq7Crd2i9XfmqU0F/tb91Ca352JXdqSZ0NxhurRI+
         NUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ant/XgNH9Mz+PQiWqAx1zFtyj2dAe3bMZujLHEh+y8=;
        b=qym6GphyBPwj90Kqp0tk7LnNxLsyBmWm6ZKzULz7kCNyyUACPuRmJCXhl5GReETzt3
         wLViITfSbcuOrJIh5nz8oRlghdwB7GHmgYKr2JZ/R28fPQVOt5qS5V1+jpBdSjUeNDxM
         7SI7EQZBymue8tLM0DF+wAhodyqzdrlYZcy+/fok7RL3j8R9WEXSX/JqsezxWdI2rHsh
         pd9L9TfOc/+uX6TfC4w7kD+SIqFgPJEWgZ8LA45FrrnQtNxq2f5mtFU+t3+uJKcDE/5w
         jqOByEnmK5vIzAV0ocz2tXgh7JGrlsL/1DtTfZWkIvel5PyGfaxha28BKU68Q18z7HeG
         Z9og==
X-Gm-Message-State: AO0yUKWgQyJbJ4dT0Bzg0OEPwcfpGPBefco4nDTg0KH8m3OVOEhcXIGb
        4VBCp5oQmtzj5uKTd0xvpDOxMg==
X-Google-Smtp-Source: AK7set/1ELme98l5oC0/7/3I/lSuHSYKEShvVU0WSv0ERoWF3Hk/WoJqFegPB1e60qS6nOgwTAkBBA==
X-Received: by 2002:a05:600c:4ecb:b0:3e7:b17f:9af1 with SMTP id g11-20020a05600c4ecb00b003e7b17f9af1mr16783260wmq.22.1678282056158;
        Wed, 08 Mar 2023 05:27:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003daffc2ecdesm20631491wmo.13.2023.03.08.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:27:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 08 Mar 2023 14:27:30 +0100
Subject: [PATCH v4 2/5] dt-bindings: nvmem: convert
 amlogic-meson-mx-efuse.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v4-2-34e623dbf789@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Amlogic Meson6 eFuse bindings to dt-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       | 57 ++++++++++++++++++++++
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      | 22 ---------
 2 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
new file mode 100644
index 000000000000..84b3dfd21e09
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson6-efuse.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/amlogic,meson6-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6 eFuse
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson6-efuse
+      - amlogic,meson8-efuse
+      - amlogic,meson8b-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse: efuse@0 {
+        compatible = "amlogic,meson6-efuse";
+        reg = <0x0 0x2000>;
+        clocks = <&clk_efuse>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ethernet_mac_address: mac@1b4 {
+            reg = <0x1b4 0x6>;
+        };
+
+        temperature_calib: calib@1f4 {
+             reg = <0x1f4 0x4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
deleted file mode 100644
index a3c63954a1a4..000000000000
--- a/Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Amlogic Meson6/Meson8/Meson8b efuse
-
-Required Properties:
-- compatible: depending on the SoC this should be one of:
-	- "amlogic,meson6-efuse"
-	- "amlogic,meson8-efuse"
-	- "amlogic,meson8b-efuse"
-- reg: base address and size of the efuse registers
-- clocks: a reference to the efuse core gate clock
-- clock-names: must be "core"
-
-All properties and sub-nodes as well as the consumer bindings
-defined in nvmem.txt in this directory are also supported.
-
-
-Example:
-	efuse: nvmem@0 {
-		compatible = "amlogic,meson8-efuse";
-		reg = <0x0 0x2000>;
-		clocks = <&clkc CLKID_EFUSE>;
-		clock-names = "core";
-	};

-- 
2.34.1

