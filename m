Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F4473584
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhLMUAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbhLMUAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB21C061574;
        Mon, 13 Dec 2021 12:00:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so15921646pff.3;
        Mon, 13 Dec 2021 12:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=oEz7qbA91b7EL32E744DYI2EKQc++9OsqGVl3wqm1nq0ID0SLoU42GOjWGzRF/0TQJ
         Z5ght3bxwcvCtLUqFvUcGFROCRg3WRX3eMxN4KrRDjytmCLb1HIlDiDBeNTvlbJTpLo7
         HKTnZ0HFJg5I8nqCVmJIMPiXKTxFFM4XvDmLt5UyGL0is6YTcYQheeNaj0RvCza5ii1j
         eN+0ym5RxD3+CxA8DzEwPNFl2sPumhPcsHPVDXQn0D+nRcq3w/W6fCgb2iZ6vfML3gkT
         v3ZMuFay8tnWobQ9ThS7gJ5Ecgw1o3WMFpy2cfrK9JXmHAYIqu02S8ePYQRAK74TeopK
         wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew71xhC4xQ/czNjt0atU4xfLjLk+tfPXgytWCNx3psE=;
        b=WKh3HEmouz3+DX2lsaUH9quxXLbbYoV6uH4JRpfA6AlvH0Q8SCbiJPBtRUTQVKZ41C
         lq/w+5hDT0lfiIwNY+sdnV7gLKXcAcmSqq/1HgfdktuUwHbiwQQseCj01sg4qa+L00qT
         L0NG+MwC3tO0jQ0ChY26O0iczKRJp5+058I2G2UkW21rEsalPNgg+ef1ECbPGPof/8eQ
         CSHp4AHXvtPt67j/GX3135mUcXsJFE75p0CikBvqfhVisftMl+YH15sA20fEpR7pfGdn
         fW+7POVLF7HBhF8/TQfpD1UUJHWeHDBKVby2u9LCHTNUUIZ8aByepMu0u4dUCuRhX0NS
         b+Uw==
X-Gm-Message-State: AOAM531VTx/jXz5fNfQKtgDGC+qJ+mcVUjaKL1PSMWgqncPTBFOX9oeL
        UVIiHrB1cxA7VURJaw5NF+6hMBV8DOA=
X-Google-Smtp-Source: ABdhPJx13a6C921vXH3bFb4F7WMUph9zGPlAxbnd0ECu/IogJfbntaCuGS9Ewf2nJhUoZioschHSHg==
X-Received: by 2002:a63:85c3:: with SMTP id u186mr528580pgd.225.1639425618724;
        Mon, 13 Dec 2021 12:00:18 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:18 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: phy: Convert Cygnus PCIe PHY to YAML
Date:   Mon, 13 Dec 2021 11:02:20 -0800
Message-Id: <20211213190221.355678-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213190221.355678-1-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com>
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

