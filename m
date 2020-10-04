Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF511282C1B
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgJDSAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgJDSAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 14:00:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BAC0613CF;
        Sun,  4 Oct 2020 11:00:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ly6so7406483ejb.8;
        Sun, 04 Oct 2020 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gs02NbgCd5FB21Hkn/kwxIv41IHErAydaATdtbYDD4I=;
        b=kI5e8G+zkO74u2qZcEIVukbWW+zm+CHfk5aHaEWFG3f/Z+chFztp85ihWsDNJWgNFf
         2rA5PGBfmIBpuZ5sYrRhd8fbMcMklbTYYESP7UrsBVPk4T5Xdm7F+qFf2v5kQ07o8QbU
         ybCRqtKyuXrS4aq8dYUj71EH/Bx+2lO68jql7BupVeNlCk5I7QRA5bNECRKI/+6zh7kh
         lBT/FJ753InW1jyfVCdU0U+CvbLjObOt/35d/sbe0D7uZ6cIA0jtNpWI1Nh/pAsDJoJY
         8takxZ22uOPLDyZuaKJCMuE4d9FGiuk8MPmHgVimfRAH35PBxFA/9mr7nfZkxYijhbuM
         ViTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gs02NbgCd5FB21Hkn/kwxIv41IHErAydaATdtbYDD4I=;
        b=YMWhM5TlmftIBbj0dmL+vYCSDwNqT6Wbh/8ys4r5t+VW7qcacb383OFq76n8fvEvSu
         TPjAHuA+Wx74lt2jB3X18UxZRowM9ec9CJBJtPAJ8hFr6Ye0jzA1if7T4s1JkS6/C3oK
         H86gaewmp8S6OePLrU3zCCAkPF92k7Aa7Ziwr5NAtg1A0lvJ2+Drv6p2jm1RUQffiRux
         0fZmguDvU83YjdW1Mal8MuTu9yOjNSsf5geOm0eMIdnampyFjA7gYr/MoLVhTkdqoxtY
         N5OREuwXL4XZ36f0YKK7NQb4wKm6XVe8ZORjmijwPr6VJExHhJd/1V+npaS3ki7UtIIr
         asWA==
X-Gm-Message-State: AOAM530dB09NtIFyhPDNEYH3DIkHRnXpUKCASOpU/2aNDob5Y0gw69A+
        2pqEnIZtKJ4dhV1XaByHdn5h2IyLlo8=
X-Google-Smtp-Source: ABdhPJwKdgk1s+7oNMdubtN8XaJr0I+GO/BnWkjo6L8Rp2/5lWBdNl2hp/M9jF8irhtubNBRXPqWug==
X-Received: by 2002:a17:906:ce5a:: with SMTP id se26mr11512137ejb.106.1601834428756;
        Sun, 04 Oct 2020 11:00:28 -0700 (PDT)
Received: from localhost.localdomain (p4fc3e21a.dip0.t-ipconnect.de. [79.195.226.26])
        by smtp.googlemail.com with ESMTPSA id n11sm6065906ejs.38.2020.10.04.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 11:00:28 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH 2/3] dt-bindings: gpio: Add binding documentation for Etron EJ168/EJ188/EJ198
Date:   Sun,  4 Oct 2020 18:29:07 +0200
Message-Id: <20201004162908.3216898-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
References: <20201004162908.3216898-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Etron EJ168/EJ188/EJ198 are USB xHCI host controllers which embed a GPIO
controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/gpio/etron,ej1x8.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml

diff --git a/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml b/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
new file mode 100644
index 000000000000..fa554045bdb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/etron,ej1x8.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/etron,ej1x8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO controller embedded into the EJ168/EJ188/EJ198 xHCI controllers
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1b6f,7023
+      - pci1b6f,7052
+
+  reg:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+      pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        gpio@0,0,0 {
+          compatible = "pci1b6f,7023";
+          reg = <0x0 0x0 0x0 0x0 0x1000>;
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+      };
+
+...
-- 
2.28.0

