Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E367789B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjAWKKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjAWKKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:10:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA74FF06
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so10232808wrz.12
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmEi8wNJscjPO+bec5z+80AcbDQKdl+RtO68ZSQp6ss=;
        b=ndSG6YwuKGUm1NBBI5B2jrBEPmsadx3GhgXVtdQLFuTTIKzv3a+092eRqnmoizygnu
         6K2WY8xrHmMdhe1zjHYD5rxceTGCddHjU0Uutwbumopsv2JgOzB+sftmjkobCnwRGKNS
         yOUEaWRKRbcpFUh1Kp57/juCnhSaxbjSjYdoeasNcT16mGwH14TDfXipkSPrZcjiQCdP
         7mklc2riDlU3X+rN5zPycg2zIZ4+k5+Ss5EnCYwyZq3AGZaN56GtxGg0/z71+dFOLAhB
         fRYExkqmJuM63t2yQxToWbBPMz6lTGD3lZEFd+F7oO2FV0baGA6f44+gmDl4TSjB7Jsy
         Hjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmEi8wNJscjPO+bec5z+80AcbDQKdl+RtO68ZSQp6ss=;
        b=Dv3MOtMQO/wrw1C7cms+RnLwx6xV5i53Y+5HTGXlbc6LVczA52RWTMWYsKeTAL39+L
         Ku6h8F55GOzLvAOhY6jJZUfLId5w4X/+K2zwswxr4hsE9vxsHLGwAoBv+WArlgt69DYM
         sRn6HOZ3YhB1XdCBRw9sJZ2KKzy5cU7eY0Xd+UWlMJ3q5YvvgOZwD2vMDUxsF68Jxxai
         78DWJvXUAVJW9zsI5A3iKj+Rg5A4NtkusY5bQzTY8eY1mwhtRgjrD+ZyCeXOo9exBTVZ
         1nigUojlPnXPhya8dX8Pe5e35OXd669k+1M4dB3TpHK/5aek4n2BeWJukG3XjFiYTy6M
         iSVw==
X-Gm-Message-State: AFqh2kqjgUFqsBxJZTv/qIRc01AV2V7/sRmtm2c6muvoYGkYJZ7UWyeP
        NfWtkTx2JzqpYlCFd2n/2DHc4Q==
X-Google-Smtp-Source: AMrXdXvD0HP5hamztDDRdNXHMoglhMKY7c9LQN2DMC1tyUK9QXhaL4t4ntooZHJ90+r2HEQwbTQcdg==
X-Received: by 2002:a5d:4e04:0:b0:2bb:31dc:2d62 with SMTP id p4-20020a5d4e04000000b002bb31dc2d62mr19830641wrt.67.1674468601723;
        Mon, 23 Jan 2023 02:10:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 11:09:58 +0100
Subject: [PATCH v3 1/7] dt-bindings: nvmem: convert amlogic-efuse.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-1-e28dd31e3bed@linaro.org>
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

Convert the  Amlogic Meson GX eFuse bindings to dt-schema.

Take in account the used variant with amlogic,meson-gx-efuse.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   | 57 ++++++++++++++++++++++
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    | 48 ------------------
 2 files changed, 57 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
new file mode 100644
index 000000000000..e49c2754ff55
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/amlogic,meson-gxbb-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson GX eFuse
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-gxbb-efuse
+      - items:
+          - const: amlogic,meson-gx-efuse
+          - const: amlogic,meson-gxbb-efuse
+
+  clocks:
+    maxItems: 1
+
+  secure-monitor:
+    description: phandle to the secure-monitor node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - clocks
+  - secure-monitor
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse: efuse {
+        compatible = "amlogic,meson-gxbb-efuse";
+        clocks = <&clk_efuse>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        secure-monitor = <&sm>;
+
+        sn: sn@14 {
+            reg = <0x14 0x10>;
+        };
+
+        eth_mac: mac@34 {
+            reg = <0x34 0x10>;
+        };
+
+        bid: bid@46 {
+            reg = <0x46 0x30>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
deleted file mode 100644
index f7b3ed74db54..000000000000
--- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-= Amlogic Meson GX eFuse device tree bindings =
-
-Required properties:
-- compatible: should be "amlogic,meson-gxbb-efuse"
-- clocks: phandle to the efuse peripheral clock provided by the
-	  clock controller.
-- secure-monitor: phandle to the secure-monitor node
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	efuse: efuse {
-		compatible = "amlogic,meson-gxbb-efuse";
-		clocks = <&clkc CLKID_EFUSE>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		secure-monitor = <&sm>;
-
-		sn: sn@14 {
-			reg = <0x14 0x10>;
-		};
-
-		eth_mac: eth_mac@34 {
-			reg = <0x34 0x10>;
-		};
-
-		bid: bid@46 {
-			reg = <0x46 0x30>;
-		};
-	};
-
-	sm: secure-monitor {
-		compatible = "amlogic,meson-gxbb-sm";
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	eth_mac {
-		...
-		nvmem-cells = <&eth_mac>;
-		nvmem-cell-names = "eth_mac";
-	};

-- 
2.34.1

