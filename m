Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2251F470B6E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhLJUIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbhLJUIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330EC061353;
        Fri, 10 Dec 2021 12:05:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i12so9388303pfd.6;
        Fri, 10 Dec 2021 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=m0C/eGMB6xg3TZlFfjWgn1s+WROFUv583vrLVbOtU+KqhGNvro/JKXX9WmhK4ccHn8
         hGuSeGWiNm16B3AzR3D6KU+N2YulzpTZRiT0YlFXE7aK4Ams8NVHJtY+TcPah2RiHH2Q
         dQ0r5JEKd0/tct2hMUWFnctH/GGp++ooawgFleXvaXmz6xEw8SJTwzaGjK+lcigexdUw
         HoQWXjFHocGPiK2Nfpv1fvuasK3KCflNG9j9aINcEQLZlv2PiBIsPfDYfERyq3/N0CvH
         p5n5VN+1oXVi4fqj6f4axkQpSen4OJIS0PerVZofkAe8vHsg/AKx+6DvEx8H/aRWG+GM
         E9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=Nhs+tVXuXjeKf7lsVYCtSwAVe2GgzU5AOXtX5V91cXmmmMiq3adDldIANAD4YT76zf
         rsfwxglSxdFq+jJEgn7Nw8L/RdwUR7QMXwIBEjrLvHOOXKSVjiuVqiQ8PMeereqpstAN
         Xz1AEq56648oO0L8DA0mPaf1CRKWHhLx8atjhZGXzu5FOHvZmWZIjWHLbcqR3LrJZ6FE
         /e0Ne/USe0CSnWG9ZiKXvy2s/5/4adxNxXvPMAccyXJoWQ31HaPYBo4M32Yr/at0AD+q
         dBZ3LrlJStV+zYZR4KbNdwiL2AP2l77Mhd/1KlDuyz5diw757Wz6SbAPzbL4gbB9cl7q
         +foQ==
X-Gm-Message-State: AOAM531kbsLu02GelPCFT3kTC9kkqIFnkvVsplSmhAzN8MAniDQ1Pzae
        DnpKqmBLG3NDrtdgJXBel/DAHSVgeTw=
X-Google-Smtp-Source: ABdhPJzYbi+J6p2BZva0uFe++shfxY9/2Mf/i0zIVSRO+yDzj6P32rzn/PRFBp7JkuVJzJDBmxmDew==
X-Received: by 2002:a63:1166:: with SMTP id 38mr40800156pgr.368.1639166704925;
        Fri, 10 Dec 2021 12:05:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:05:04 -0800 (PST)
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
Subject: [PATCH v4 5/6] dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
Date:   Fri, 10 Dec 2021 12:04:50 -0800
Message-Id: <20211210200451.3849106-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200451.3849106-1-f.fainelli@gmail.com>
References: <20211210200451.3849106-1-f.fainelli@gmail.com>
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

