Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEB473BCE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhLND6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhLND6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0FC061751;
        Mon, 13 Dec 2021 19:58:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r7-20020a17090a560700b001b0e876e140so310814pjf.5;
        Mon, 13 Dec 2021 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=EFWvyi8S0sJKUUwbkNAT0LO3Lpgl+AMd6mLuznt1LIEVI01tqP+jUae05VYpHnLBUq
         x2HjU8vDUYMKVmTQg3oFj6vag2ftk3HJQkUQYI5C7PWiJR2jGOz53kE9Mi4xYNRMR8wF
         rtiKVFg+HlZuk4e39IsKMChzGdQZwQ0iqVPhyiQ3kxsTP7jBgHeVpygNkbwSUjGpvG1s
         Dsju1PU8WbX/s7yAW6FbDmX6Hg6mdV54QrvwAl2s28qBI8T4OIRe1fbk1gc/lRCvVXXB
         Vx6CoT/KQxXblzTvo15Igq2YlXArI77tIOOeCBadxqJVmkEMScvQFoVWYE/Yc/Ptlipc
         A9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=7KQgsqQZeJAu127fgWfBjuLsDQM8VFw1Hmzz3S/UFQQAvuUi8/LtV8qlwqRbXtngsY
         WzvOXeFX/pI5/sjRQoILOdZy0hCH2y/1rz4qQmtaLOnaXoZI70/Tw/BCkcOYoz7Qcifi
         dlb/ShVDud5kno6see/NrN080jBqlUjQBgcf10kze2OFamBiuVP4N2vTlxDufca8WJrV
         cAXxNEb64kQyWcZoqEEP+7S10qzO/PZ0zc623EVA4Eligdfd37sZHDAZ2g7zOKJj0SMD
         AANLdxtMNacwH2A6SUlz+GP+u7upQd9UaWcNF0FCltKgbl1PrnSyxZDBzHITIJ/TGcSl
         nlBg==
X-Gm-Message-State: AOAM531lv7XKV556mnKnGdtyC18UrVl4IOicSixNM+9y6FgiKz8yn+/a
        3+IZ0a09EYV01Brwheb250Tnl+08qB4=
X-Google-Smtp-Source: ABdhPJwnfyilRO1XT08sTEPqvPT8W2vHgjvp+LhMypOKQ2ulno0jSvOJhSFaLuPhWDrF+CHK/9FTIg==
X-Received: by 2002:a17:903:2305:b0:142:1bca:72eb with SMTP id d5-20020a170903230500b001421bca72ebmr2666496plh.67.1639454311823;
        Mon, 13 Dec 2021 19:58:31 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 5/6] dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
Date:   Mon, 13 Dec 2021 19:58:19 -0800
Message-Id: <20211214035820.2984289-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Broadcom Cygnus PCIe PHY Device Tree binding t YAML to help
with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/phy/brcm,cygnus-pcie-phy.txt     | 47 ------------
 .../bindings/phy/brcm,cygnus-pcie-phy.yaml    | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
deleted file mode 100644
index 10efff28b52b..000000000000
--- a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Broadcom Cygnus PCIe PHY
-
-Required properties:
-- compatible: must be "brcm,cygnus-pcie-phy"
-- reg: base address and length of the PCIe PHY block
-- #address-cells: must be 1
-- #size-cells: must be 0
-
-Each PCIe PHY should be represented by a child node
-
-Required properties For the child node:
-- reg: the PHY ID
-0 - PCIe RC 0
-1 - PCIe RC 1
-- #phy-cells: must be 0
-
-Example:
-	pcie_phy: phy@301d0a0 {
-		compatible = "brcm,cygnus-pcie-phy";
-		reg = <0x0301d0a0 0x14>;
-
-		pcie0_phy: phy@0 {
-			reg = <0>;
-			#phy-cells = <0>;
-		};
-
-		pcie1_phy: phy@1 {
-			reg = <1>;
-			#phy-cells = <0>;
-		};
-	};
-
-	/* users of the PCIe phy */
-
-	pcie0: pcie@18012000 {
-		...
-		...
-		phys = <&pcie0_phy>;
-		phy-names = "pcie-phy";
-	};
-
-	pcie1: pcie@18013000 {
-		...
-		...
-		phys = <pcie1_phy>;
-		phy-names = "pcie-phy";
-	};
diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
new file mode 100644
index 000000000000..045699c65779
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/brcm,cygnus-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Cygnus PCIe PHY
+
+maintainers:
+  - Ray Jui <ray.jui@broadcom.com>
+  - Scott Branden <scott.branden@broadcom.com>
+
+properties:
+  $nodename:
+    pattern: "^pcie[-|_]phy(@.*)?$"
+
+  compatible:
+    items:
+      - const: brcm,cygnus-pcie-phy
+
+  reg:
+    maxItems: 1
+    description: >
+      Base address and length of the PCIe PHY block
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^pcie-phy@[0-9]+$":
+    type: object
+    description: >
+      PCIe PHY child nodes
+
+    properties:
+      reg:
+        maxItems: 1
+        description: >
+          The PCIe PHY port number
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie_phy: pcie_phy@301d0a0 {
+      compatible = "brcm,cygnus-pcie-phy";
+      reg = <0x0301d0a0 0x14>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pcie0_phy: pcie-phy@0 {
+          reg = <0>;
+          #phy-cells = <0>;
+      };
+
+      pcie1_phy: pcie-phy@1 {
+          reg = <1>;
+          #phy-cells = <0>;
+      };
+    };
-- 
2.25.1

