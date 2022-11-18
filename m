Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F4362F770
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiKROdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 09:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242391AbiKROdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 09:33:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE93E081
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:33:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g2so5851953wrv.6
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y27Dxuej0JJOzYqREuZ7buGqEQSIRreRsNAzFXY30l0=;
        b=or9xiwYvnOBoUw+/IBUWQko0HRB0n/YeH7CUxy44N4SxiFrHZnEJKIE2DPEbYWoUXk
         ZZmCWNBh5KbAvGw90Y4UgrJcZc+UlXC2CPjxHgm0FkkqNmtWFEDa7u6qtTGVTpTnPfA9
         ubG0wkELzgV2gRQCCool5kNX4GooCiy4HVWdtyXmtdcVUeXyXNYeQxIwiSIsIhxJRk9i
         KZKoHyK25p+bVfA4TvjcWIxqNg3os2kNiaLU6I6sE27++JX5UWb7yU/HnZLEaJrP3a1w
         I22lUfa6AUCe5UEAzemXMt83a7n/HSnGusArdBOYRU5BluvmOoDBpuBG4wiU2n3oF11M
         RGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y27Dxuej0JJOzYqREuZ7buGqEQSIRreRsNAzFXY30l0=;
        b=3AtmrYBJwL6psSTequUtchrh20VNEiNAN5cL9MbjzppRC+m2N0GYKzNn76otr8SjsS
         /1XahrVnfe+q5i6sGHO+95jm5W4wHd4dkNTYfBqB5ttQ74l7TsdcAJ+aCi3AayU5PNkg
         Rn7Tq0MBTRHcg8SyyC7R2kGzvEKZm6v2ejaimEmnuPLOAUpI6kfX+ZuimgZhPv3SyXSG
         UvywvDgmjrrG25vFROklM/69D7oqRX8jT6VxnWOlfXCxhpfUqidngv+kXZ3EWAj5Hi4V
         dPa5B/Rd975VJ5gmqufgv80PI9JkVOOgU9r9EoAG87dLxbGOmo4Lsl3vjQbPb3F+LLxT
         bXzA==
X-Gm-Message-State: ANoB5pkbwCbXjxtau8PQLggbRbcUZECts2OFW/lGwsoWxFkuFjabzkYe
        tOUbC7Nrpw7d4ALcRI6FJX+fjQ==
X-Google-Smtp-Source: AA0mqf7812T75JmU1RK3dUswEj+nSB6pF/2V/PIu/zIN4QQtJ/ZBP39Rfn1JU4+7LgOWa59FP8nB0w==
X-Received: by 2002:a5d:56c2:0:b0:241:94bc:2796 with SMTP id m2-20020a5d56c2000000b0024194bc2796mr4281152wrw.184.1668782012260;
        Fri, 18 Nov 2022 06:33:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003cfb7c02542sm5436726wms.11.2022.11.18.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:33:31 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 15:33:27 +0100
Subject: [PATCH 01/12] dt-bindings: firmware: convert meson_sm.txt to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v1-1-3f025599b968@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Amlogic Secure Monitor bindings to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/firmware/amlogic,meson-gxbb-sm.yaml   | 36 ++++++++++++++++++++++
 .../bindings/firmware/meson/meson_sm.txt           | 15 ---------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/amlogic,meson-gxbb-sm.yaml b/Documentation/devicetree/bindings/firmware/amlogic,meson-gxbb-sm.yaml
new file mode 100644
index 000000000000..33d1408610cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/amlogic,meson-gxbb-sm.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/amlogic,meson-gxbb-sm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Secure Monitor (SM)
+
+description:
+  In the Amlogic SoCs the Secure Monitor code is used to provide access to the
+  NVMEM, enable JTAG, set USB boot, etc...
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    const: amlogic,meson-gxbb-sm
+
+patternProperties:
+  "power-controller":
+    type: object
+    $ref: /schemas/power/amlogic,meson-sec-pwrc.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        secure-monitor {
+            compatible = "amlogic,meson-gxbb-sm";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
deleted file mode 100644
index c248cd44f727..000000000000
--- a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* Amlogic Secure Monitor
-
-In the Amlogic SoCs the Secure Monitor code is used to provide access to the
-NVMEM, enable JTAG, set USB boot, etc...
-
-Required properties for the secure monitor node:
-- compatible: Should be "amlogic,meson-gxbb-sm"
-
-Example:
-
-	firmware {
-		sm: secure-monitor {
-			compatible = "amlogic,meson-gxbb-sm";
-		};
-	};

-- 
b4 0.10.1
