Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638162C8004
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgK3Idf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 03:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgK3Idf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 03:33:35 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95222C0613D3;
        Mon, 30 Nov 2020 00:32:54 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so19926488lfg.0;
        Mon, 30 Nov 2020 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQaTKjIL7uyY8gr0YDIKGL8MjTlRYaLcoibNbpV+CJ0=;
        b=b5RN6gP3m+uJd0q3dvPRkDzT2BSNvQcu8NuQynWalyH5PL7FRyMhmoxf9zu/4H5TfT
         BSXDqh2vpo8tUq4FPg9nfnDSUXBW7y0mp81Wk9r5KUv7xWX4h7vrl0At0PCmEgBTdwIC
         DwYaAqJwuo+qV86PDGrkoIUF9YQuLUcsG2MUclN8nZoHxY9T2Np2Sag8rTLZIywOXA3Q
         Qy8tofrCA7mbqRDejQ3mmomI5mA6Yen63f8IrP09KBXOlUeJ/ZZB09DoHlidEfSqcr4o
         tDZVTwgOvEZMAehaYo5eOXq848lYYmsm119SkIlss9VrbpVtmb7j4MUUGKQk/+HgyzU0
         iU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQaTKjIL7uyY8gr0YDIKGL8MjTlRYaLcoibNbpV+CJ0=;
        b=tC3Gt8slm7XerbxUN/SX8qUwESvt39zKGwZzVajJMUTpJwatRgOXwzVaf5wkS3atn/
         nmnTlhei3573ZTR3JQW0AdwFQ+H3oNRco3rUZwGQbn0HGZRGXSinbdv4qq/zlp+tswuv
         ufNMx7VH8yYcVOE1YfpErGhNbvN1qgFbX7HR3/Ld3WcpUEpV+O5mzops3fHH7cwWpU2o
         qkrO695aJASVOjBBbqEYxas1S1VRWb+KCkBSPeIsy52oXEwt6VmCIxMPimkqJpEf4C16
         yroKJaPJ7X/ii7lXRmT4BTpDFwc/cdqv2PP/+idITzVwv4wjnyZDMjHbYE6GykLjakzx
         buaA==
X-Gm-Message-State: AOAM530u9vEFvZOeYm22YsZR6kpyB1EJT7a4+Sx6RjQ7wZXfIOvSn1D+
        VuXZ9VYkm4PucXC90yn28bg=
X-Google-Smtp-Source: ABdhPJyAlEj1+97dD1IxP38BidZhTYxYqRjQz0V0/zWT559D4PacHJzAGdZ1PLwaNnR8Qq1+JJjW7g==
X-Received: by 2002:ac2:46f3:: with SMTP id q19mr8620909lfo.76.1606725173075;
        Mon, 30 Nov 2020 00:32:53 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y81sm2355420lfc.100.2020.11.30.00.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:32:52 -0800 (PST)
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
Subject: [PATCH V2 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
Date:   Mon, 30 Nov 2020 09:32:22 +0100
Message-Id: <20201130083223.32594-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130083223.32594-1-zajec5@gmail.com>
References: <20201130083223.32594-1-zajec5@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

