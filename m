Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53E36C25D6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCTXmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCTXmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 19:42:12 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB773C15D;
        Mon, 20 Mar 2023 16:41:15 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17671fb717cso14690702fac.8;
        Mon, 20 Mar 2023 16:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21HT9sJDWhgYo6WmYWK3lY8Tipe7G3+CaUZMPnF6N/g=;
        b=BQuwGywfMNidAVS4TJWUcucezUAdr/msLkXeD7YyH3sLeeg5o72A37qmgzBJZVeQmq
         9du2DShZbOHK4a5hwO3bp20fIBVSxYPSBcTVyt0T60LEr3WeZyVkI77jIdw5oXqxoLgI
         InIk7NvsWym7GhqbTgbX4JJCFeEEXdI7uwRcky7qYngKwH1tJcPsB1YQiooWiB0VZoA9
         Kyw8zYyq9Ckf5GRr+eP7c8wfkVXONElddpCAj7YK/k1WNbIPuBtlValK0l6Hiyyf0SSW
         q+9A79NIPSlp1qvJLxRcvJR6D416ttZw0Yqse6YX+NgwFHgOTvAHVgHejQ2x024qEBXe
         d6UQ==
X-Gm-Message-State: AO0yUKV8ZnKLE7RheUA+6RZV6mhuenwQjNWEbb4A+ebPH9ITaH7kaQOJ
        l3YIv8x60MoiaSXy3voaPg==
X-Google-Smtp-Source: AK7set/k291Ti8/rsVZlnngpXZ3njtM7TFsBjHpHbRudSB+L3eeg+DixNnxKYL81ZT2yr4hv/KWJtg==
X-Received: by 2002:a05:6870:4610:b0:17a:edaa:1cf2 with SMTP id z16-20020a056870461000b0017aedaa1cf2mr15531oao.50.1679355561200;
        Mon, 20 Mar 2023 16:39:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u24-20020a9d4d98000000b00690dc5d9b9esm4516626otk.6.2023.03.20.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:39:20 -0700 (PDT)
Received: (nullmailer pid 2920545 invoked by uid 1000);
        Mon, 20 Mar 2023 23:39:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:39:11 -0500
Message-Id: <20230320233911.2920364-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml        | 2 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml      | 2 +-
 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml   | 8 ++++----
 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml | 8 ++++----
 Documentation/devicetree/bindings/pci/cdns-pcie.yaml      | 4 ++--
 .../devicetree/bindings/pci/intel,keembay-pcie-ep.yaml    | 4 ++--
 .../devicetree/bindings/pci/intel,keembay-pcie.yaml       | 4 ++--
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml   | 2 +-
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 6 +++---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml        | 6 +++---
 .../bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml     | 4 ++--
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index e6ef1012a580..98651ab22103 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: "cdns-pcie-ep.yaml#"
+  - $ref: cdns-pcie-ep.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index 293b8ec318bc..bc3c48f60fff 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
-  - $ref: "cdns-pcie-host.yaml#"
+  - $ref: cdns-pcie-host.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index baeafda36ebe..47a302ba4ac9 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence PCIe Device
 
@@ -10,8 +10,8 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: "cdns-pcie.yaml#"
-  - $ref: "pci-ep.yaml#"
+  - $ref: cdns-pcie.yaml#
+  - $ref: pci-ep.yaml#
 
 properties:
   cdns,max-outbound-regions:
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index a944f9bfffff..a6b494401ebb 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/cdns-pcie-host.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/cdns-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence PCIe Host
 
@@ -10,8 +10,8 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: "/schemas/pci/pci-bus.yaml#"
-  - $ref: "cdns-pcie.yaml#"
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: cdns-pcie.yaml#
 
 properties:
   cdns,max-outbound-regions:
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
index df4fe28222b0..2e14f422e829 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/cdns-pcie.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/cdns-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence PCIe Core
 
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
index e87ff27526ff..730e63fd7669 100644
--- a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel Keem Bay PCIe controller Endpoint mode
 
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
index ed4400c9ac09..505acc4f3efc 100644
--- a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel Keem Bay PCIe controller Root Complex mode
 
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 89cfdee4b89f..523b15428752 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -45,7 +45,7 @@ properties:
     description: Reference to a syscon representing TCSR followed by the two
                  offsets within syscon for Perst enable and Perst separation
                  enable registers
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: Syscon to TCSR system registers
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 10e6eabdff53..62292185fe2e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI J721E PCI EP (PCIe Wrapper)
 
@@ -11,7 +11,7 @@ maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
 allOf:
-  - $ref: "cdns-pcie-ep.yaml#"
+  - $ref: cdns-pcie-ep.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 3d7aee97353a..a2c5eaea57f5 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI J721E PCI Host (PCIe Wrapper)
 
@@ -11,7 +11,7 @@ maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
 allOf:
-  - $ref: "cdns-pcie-host.yaml#"
+  - $ref: cdns-pcie-host.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
index dfce6738b033..34cfc642d808 100644
--- a/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
@@ -2,8 +2,8 @@
 # Copyright 2020 Broadcom
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reset/brcm,bcm7216-pcie-sata-rescal.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reset/brcm,bcm7216-pcie-sata-rescal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: BCM7216 RESCAL reset controller
 
-- 
2.39.2

