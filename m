Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760472C568A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389923AbgKZN75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 08:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgKZN75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 08:59:57 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D19C0613D4;
        Thu, 26 Nov 2020 05:59:56 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so2682634lfh.2;
        Thu, 26 Nov 2020 05:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNjJs0BvJahY/+VGLEXl85C29CGiRgDhT4AZcshOF7g=;
        b=RQoaOkSUEgBdsgNMU3DF2KDmQDYAMhwsfZhgcOOZdK0nRBCfeDn6ZfLYdB/vWA9FJk
         6Lzf/7P0Yhb3xJzgSLlcAhoJ5Ezwnasyv6nSKaCIpP0p7Ml/1dxDu2k3san6f8xFig7V
         N8VmceDeCGhg5kVnW5tsmLV5HZM0wLmDIcKe6J2IpRZ5xIvvD8w2agXiQdJfgDIrB9jR
         urDHDgrAI8ljxPSNKU5SkK8D22v5iUfOQnwe9yQGjaDC3VJS+jWUsqhBqzLGVVEam9aP
         7IS8uHQ2ylM1/MQbPHxvJ87QHzOl2SftOOQIuzJVjuBPWBbKhrP8gxuNZx2mZpYThlBl
         Mv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNjJs0BvJahY/+VGLEXl85C29CGiRgDhT4AZcshOF7g=;
        b=QgUh9Dq82Odrw+3ltskLhuD+eG3FSuptLXisPbUKToeEXwu2bBy6e8zbSMTL+HC91X
         8iZArdJ4xz5fk0PhCLxlBDno2XptZiGB0oxusJQB+nFU4VuNq5fEAkwPAk30e4gqHI+A
         U3mcEsAftkubpN2CK8JGN9BcKGlI3yeRvBsNlhL0+bdCJBso3AIzFpZGogPUyCGB3XHW
         NlUU329+MOY9gasY97FIuUmaM1e4UBNteLqoMUVlavozwprIhc8Lb5vAWjS3Ynts3c+c
         F6tJC//QiI7M8HWpyKfLo9k/gyOGGKZupt0mCr8jIx72ttQzPWegisXnOaca6UslO54a
         WoDw==
X-Gm-Message-State: AOAM530WDBuy8VsWpTl744AI6X93gkJCmgNfpkmDJns+G7nBXmvhCzjG
        pZnuz29IjQz8MZNDIoklgHuFBQjpO7c=
X-Google-Smtp-Source: ABdhPJz6BuNibm7X8+lmf45vtfgvZ1GvQQqxCag013HKa2zESRzygP1d+B0hLlaQBvrUOKQiID67fA==
X-Received: by 2002:a05:6512:3128:: with SMTP id p8mr1326807lfd.13.1606399195443;
        Thu, 26 Nov 2020 05:59:55 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a11sm605188ljj.4.2020.11.26.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:59:54 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
Date:   Thu, 26 Nov 2020 14:59:38 +0100
Message-Id: <20201126135939.21982-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126135939.21982-1-zajec5@gmail.com>
References: <20201126135939.21982-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 is a SoC family with PCIe controller sharing design with the one
for STB. BCM4908 has different power management and memory controller so
few tweaks are required.

PERST# signal on BCM4908 is handled by an external MISC block so it
needs specifying a reset phandle.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 807694b4f41f..d3ab9e22f97c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
@@ -64,8 +65,6 @@ properties:
   aspm-no-l0s: true
 
   resets:
-    description: for "brcm,bcm7216-pcie", must be a valid reset
-      phandle pointing to the RESCAL reset controller provider node.
     $ref: "/schemas/types.yaml#/definitions/phandle"
 
   reset-names:
@@ -98,12 +97,39 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm4908-pcie
+    then:
+      properties:
+        resets:
+          items:
+            - description: reset controller handling the PERST# signal
+
+        reset-names:
+          items:
+            - const: perst
+
+      required:
+        - resets
+        - reset-names
   - if:
       properties:
         compatible:
           contains:
             const: brcm,bcm7216-pcie
     then:
+      properties:
+        resets:
+          items:
+            - description: phandle pointing to the RESCAL reset controller
+
+        reset-names:
+          items:
+            - const: rescal
+
       required:
         - resets
         - reset-names
-- 
2.26.2

