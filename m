Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACE02D646E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392560AbgLJSFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392606AbgLJSFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 13:05:21 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C412C0613D6;
        Thu, 10 Dec 2020 10:04:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a12so9542990lfl.6;
        Thu, 10 Dec 2020 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHZq5IcsODsBA+xd+pp9DCxwMsfVs5qrOgu8wwXvBvg=;
        b=ouA21ufznCroJw5M10QYHgbCCH9Q2Bm4UNuYdY1IAYv3enbq3Q4cMbCZ9vxAkYeDNU
         542M5G5XKU1e+qtcKg2nJgOCkvCQ4gNCPOOYKun8CSVQKmIKF59bmlU0j3STg5qENyWo
         YzGPxZXnCfj/4+D818gaTwYaX0Bn0eFiDItdDAWp3cNPkE3k7XzH06sjNxwKTtbrCAon
         9lc7cdC/689tbOmRIY5dbegKtJnehR6kVLRxiZJ+/DhabiOExlbGFxd02r03e0mNaNLM
         qu9Mi8x7J17hvX1n8xzkCRGmPdsiA54WwdX0mg0UgaFI9WGtB8NxbqtS3ak6hBtdqnZj
         A7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHZq5IcsODsBA+xd+pp9DCxwMsfVs5qrOgu8wwXvBvg=;
        b=m+aS1aDewSE3Xyhf4Nulo6pri6ova2pJlJUAj6ttNTtuKFOHDTezaIOHWMEGHbJ//T
         xJBd8rDNFVtrmVK0X/JjCKjNAmoKvrjb3WtK5cG8CoKMCkEIDsod0i7ALmGQziVxStbm
         CUq+ZjBYFbetaZ1BNLHRt2KG0tUhQFJgdhlKLelr578s9Ufjn3V6av74Y5pPoacNd/yg
         uS3+GNjD34abOPZQ0+xJucyf/VqRRyYoMlLei1Ix0pnBh+c1fWkfxv/WQaZV9yk3lfBr
         +VLGeskrfSAyFQqyTKcoeHQ8xV5JqUp/gJQpL1gc+++5HXy5RnqTGQfc6wQRk/w+Y576
         AoYA==
X-Gm-Message-State: AOAM531mghtpGnNVcMMXGHsJrE0zIrPgOs5qjNcH9eJ/yZmIsiXQtg7J
        jcYTObzby7sN1SHCH2ymw7986fDPIe4=
X-Google-Smtp-Source: ABdhPJwGsjmtg3DUvco4+4Cbw+I9+b9OHmtYv69jKIerggLQX3sHF25eD39AKfOrb+JK720caEQd1Q==
X-Received: by 2002:a19:c001:: with SMTP id q1mr2464524lff.55.1607623479567;
        Thu, 10 Dec 2020 10:04:39 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id c136sm601855lfg.306.2020.12.10.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:04:38 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v3 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
Date:   Thu, 10 Dec 2020 19:04:20 +0100
Message-Id: <20201210180421.7230-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210180421.7230-1-zajec5@gmail.com>
References: <20201210180421.7230-1-zajec5@gmail.com>
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
V3: Drop "reset-names" from the generic "properties" - it's now defined as
    "compatible" specific property
    Drop "$ref" from the "resets" - thanks Rob.
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 807694b4f41f..f90557f6deb8 100644
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
@@ -63,15 +64,6 @@ properties:
 
   aspm-no-l0s: true
 
-  resets:
-    description: for "brcm,bcm7216-pcie", must be a valid reset
-      phandle pointing to the RESCAL reset controller provider node.
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-
-  reset-names:
-    items:
-      - const: rescal
-
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
@@ -98,12 +90,39 @@ required:
 
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

