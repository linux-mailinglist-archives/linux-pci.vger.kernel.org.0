Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33846CBEC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbhLHEIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhLHEIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:16 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0AFC061756;
        Tue,  7 Dec 2021 20:04:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k64so1292703pfd.11;
        Tue, 07 Dec 2021 20:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=FD8jk+RGxtkV5gLd8PNnst18NdpASQ+oqiVppQhVBHHlQjvKC5t0g9/eReu9F0pFwl
         TQ4L1GlZB51VECXEbj7JfhAE4L7gleM0eF1sZMIQdnLFmAglipuCFlzOZyL/1kUUde7x
         Deb2XYeje5su0L9LYdejYVIF9L0aE6jl8kPRwl5BO+tdhTQIok31IAzTIhgc7y1JTR03
         c2KcYuyD4KJ5AWJn/jYWrJRtaX9E7gCCr+v76lwvox6gmJU31s9cCVhRJD/yFpef06+e
         Lh3zQNYeyVfJ6jU6pLRbuvLNLRuFwA2UKGzfCO+zrtLZ8xeORH8omTyMxpciRqzwVq5M
         0Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=4kyQ7KHlCd0DVyNtBEsD63VOBIA70epmR9fqs3ajpNzA6jqEoBTaWIzE3Bbz/19ogi
         xvOLnXvfg6lzUEiO2566eXC2e7TLhdTXXLfK/tN14NKt12OAn48Y/7d4RzPX952Zm4Iy
         HsWqOD1bGlID5ZMIfi+bwgbsJdwVZdSoXeJtGw9D7ktDJgb8e+QL1Vk8ZRD/10tbg4F/
         8IX25B7yU5EZS3VoZksKeDbYyuE4TY9l1QLZfeWRwP9mVuKmfb3cQAj62Jj2pa7JadHc
         98xW/cHnSEV0Im2uAKq24RjRce5o2QYY96HWTHtm+kEH0cxG7AyeUORhIqTh+bYO/LJX
         5pAQ==
X-Gm-Message-State: AOAM5339fFDfuZAS8wY7hjcz9Iv2wz4EduQCIMo1mJK4nbt5Fg/Pbv2w
        W3n9yO81BRHAFae/+5PV0YiDwWmiuM0=
X-Google-Smtp-Source: ABdhPJzfOnYFR8mgGOmbEWPXYM9+Iqwkas0/pMPuHNBApD/gbRwxD7NUtSaQ8YnelpBkf3dFGyYpQA==
X-Received: by 2002:a63:4f22:: with SMTP id d34mr26659724pgb.415.1638936284540;
        Tue, 07 Dec 2021 20:04:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:44 -0800 (PST)
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
Subject: [PATCH v3 5/6] dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
Date:   Tue,  7 Dec 2021 20:04:31 -0800
Message-Id: <20211208040432.3658355-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208040432.3658355-1-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
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

