Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17836473BCF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhLND6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhLND6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AEC06173F;
        Mon, 13 Dec 2021 19:58:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id np3so13353319pjb.4;
        Mon, 13 Dec 2021 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I29Mrl2gY3yVZRhsDU0nn+w9NcIdUUWqTMaLCgYegnY=;
        b=ptqCGE1e6njd33+17p6NU6po4c326qL1KVufyz45DISajBMzqa5XSLsDUCrLvy5lv/
         EYsCzVI1OhLE6wKFpDK1EemAMgRT2BtBiNUgP+cTy32L84HR/XT682NDyNL1ZFHp+PXz
         lIPbz/CwEqUtW8xjMXi1oKIs2lqPT0/Eevy9INfnQqz29CrZr3R6tcK7rNKvv5g49gR+
         iExmtn56WRuHf7eOE+IOcqNb5nR2lao444nLGY4d3X0ZR/6qgVF+ED8Z4hBOQOD8PPDy
         NcYj97jF1eK76aj08UeOiNphDrGAHGe7FZXK/yYDHNyTVoWp7NxeJIugLMhCjkSwYf/5
         Bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I29Mrl2gY3yVZRhsDU0nn+w9NcIdUUWqTMaLCgYegnY=;
        b=vGTDF47LOlkzM2zHjVO1R1Wj8UQB5SR7rCOHyMESflLkWuSxPpcFYc7dM7FGGE77xp
         /eJfN0fLxSzmVb+y5SKy0b7g+dLsDDixiW10fyxu3RpSW0QZVTvianUe6ujR34ivCCpj
         YC7bupEF/iPJe4AnvKQs/oWcOYJpRru5o8kj9pp4M6cQXcBP+4+U5in/I8Ju6+NdZrap
         /qRwIuNz/cxuoTW/wA04grG/ayMwSk4juRk9jawsOe/R8k1Tcvbb2qp7HbGJef5W5C55
         o0kiqJipDK0dTc8xPd+hHl8OtiF8Brf4hqB89IUqfnaYTr2A3KW/c6j2UA9Qs1cKV61O
         +jjQ==
X-Gm-Message-State: AOAM532nrzJQ4l3rUXkNROBljR3ie7AxWCQOARawK9jHJhGbvB7b6y2U
        S9ZhTc8tM2MFI1kIWwAB3CQJs+eG91Q=
X-Google-Smtp-Source: ABdhPJw18UpjWL3FtMOouU3d7F/bneYFRGRoE04q7bN3x59dr+zF7FkgtLtqdbRD/8fWT3IBgCNjHg==
X-Received: by 2002:a17:902:7c88:b0:142:5f2f:182a with SMTP id y8-20020a1709027c8800b001425f2f182amr2699202pll.72.1639454313306;
        Mon, 13 Dec 2021 19:58:33 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:32 -0800 (PST)
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
Subject: [PATCH v6 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
Date:   Mon, 13 Dec 2021 19:58:20 -0800
Message-Id: <20211214035820.2984289-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Conver the iProc PCIe controller Device Tree binding to YAML now that
all DTS in arch/arm and arch/arm64 have been fixed to be compliant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
 .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
 2 files changed, 184 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
deleted file mode 100644
index df065aa53a83..000000000000
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ /dev/null
@@ -1,133 +0,0 @@
-* Broadcom iProc PCIe controller with the platform bus interface
-
-Required properties:
-- compatible:
-      "brcm,iproc-pcie" for the first generation of PAXB based controller,
-used in SoCs including NSP, Cygnus, NS2, and Pegasus
-      "brcm,iproc-pcie-paxb-v2" for the second generation of PAXB-based
-controllers, used in Stingray
-      "brcm,iproc-pcie-paxc" for the first generation of PAXC based
-controller, used in NS2
-      "brcm,iproc-pcie-paxc-v2" for the second generation of PAXC based
-controller, used in Stingray
-  PAXB-based root complex is used for external endpoint devices. PAXC-based
-root complex is connected to emulated endpoint devices internal to the ASIC
-- reg: base address and length of the PCIe controller I/O register space
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map, standard PCI properties to define the
-  mapping of the PCIe interface to interrupt numbers
-- linux,pci-domain: PCI domain ID. Should be unique for each host controller
-- bus-range: PCI bus numbers covered
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions
-
-Optional properties:
-- phys: phandle of the PCIe PHY device
-- phy-names: must be "pcie-phy"
-- dma-coherent: present if DMA operations are coherent
-- dma-ranges: Some PAXB-based root complexes do not have inbound mapping done
-  by the ASIC after power on reset.  In this case, SW is required to configure
-the mapping, based on inbound memory regions specified by this property.
-
-- brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
-by the ASIC after power on reset. In this case, SW needs to configure it
-
-If the brcm,pcie-ob property is present, the following properties become
-effective:
-
-Required:
-- brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
-address used by the iProc PCIe core (not the PCIe address)
-
-MSI support (optional):
-
-For older platforms without MSI integrated in the GIC, iProc PCIe core provides
-an event queue based MSI support.  The iProc MSI uses host memories to store
-MSI posted writes in the event queues
-
-On newer iProc platforms, gicv2m or gicv3-its based MSI support should be used
-
-- msi-map: Maps a Requester ID to an MSI controller and associated MSI
-sideband data
-
-- msi-parent: Link to the device node of the MSI controller, used when no MSI
-sideband data is passed between the iProc PCIe controller and the MSI
-controller
-
-Refer to the following binding documents for more detailed description on
-the use of 'msi-map' and 'msi-parent':
-  Documentation/devicetree/bindings/pci/pci-msi.txt
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt
-
-When the iProc event queue based MSI is used, one needs to define the
-following properties in the MSI device node:
-- compatible: Must be "brcm,iproc-msi"
-- msi-controller: claims itself as an MSI controller
-- interrupts: List of interrupt IDs from its parent interrupt device
-
-Optional properties:
-- brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
-require the interrupt enable registers to be set explicitly to enable MSI
-
-Example:
-	pcie0: pcie@18012000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18012000 0x1000>;
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
-
-		linux,pci-domain = <0>;
-
-		bus-range = <0x00 0xff>;
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
-
-		phys = <&phy 0 5>;
-		phy-names = "pcie-phy";
-
-		brcm,pcie-ob;
-		brcm,pcie-ob-axi-offset = <0x00000000>;
-
-		msi-parent = <&msi0>;
-
-		/* iProc event queue based MSI */
-		msi0: msi@18012000 {
-			compatible = "brcm,iproc-msi";
-			msi-controller;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
-				     <GIC_SPI 97 IRQ_TYPE_NONE>,
-				     <GIC_SPI 98 IRQ_TYPE_NONE>,
-				     <GIC_SPI 99 IRQ_TYPE_NONE>,
-		};
-	};
-
-	pcie1: pcie@18013000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18013000 0x1000>;
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
-
-		linux,pci-domain = <1>;
-
-		bus-range = <0x00 0xff>;
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
-
-		phys = <&phy 1 6>;
-		phy-names = "pcie-phy";
-	};
diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
new file mode 100644
index 000000000000..0972868735fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/brcm,iproc-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom iProc PCIe controller with the platform bus interface
+
+maintainers:
+  - Ray Jui <ray.jui@broadcom.com>
+  - Scott Branden <scott.branden@broadcom.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # for the first generation of PAXB based controller, used in SoCs
+          # including NSP, Cygnus, NS2, and Pegasus
+          - brcm,iproc-pcie
+          # for the second generation of PAXB-based controllers, used in
+          # Stingray
+          - brcm,iproc-pcie-paxb-v2
+          # For the first generation of PAXC based controller, used in NS2
+          - brcm,iproc-pcie-paxc
+          # For the second generation of PAXC based controller, used in Stingray
+          - brcm,iproc-pcie-paxc-v2
+
+  reg:
+    maxItems: 1
+    description: >
+       Base address and length of the PCIe controller I/O register space
+
+  interrupt-map: true
+
+  interrupt-map-mask: true
+
+  "#interrupt-cells":
+    const: 1
+
+  ranges:
+    minItems: 1
+    maxItems: 2
+    description: >
+      Ranges for the PCI memory and I/O regions
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie-phy
+
+  bus-range: true
+
+  dma-coherent: true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  device_type: true
+
+  brcm,pcie-ob:
+    type: boolean
+    description: >
+      Some iProc SoCs do not have the outbound address mapping done by the
+      ASIC after power on reset. In this case, SW needs to configure it
+
+  brcm,pcie-ob-axi-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+       The offset from the AXI address to the internal address used by the
+       iProc PCIe core (not the PCIe address)
+
+  msi:
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: brcm,iproc-msi
+
+  msi-parent: true
+
+  msi-controller: true
+
+  brcm,pcie-msi-inten:
+    type: boolean
+    description: >
+      Needs to be present for some older iProc platforms that require the
+      interrupt enable registers to be set explicitly to enable MSI
+
+dependencies:
+  brcm,pcie-ob-axi-offset: ["brcm,pcie-ob"]
+  brcm,pcie-msi-inten: [msi-controller]
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,iproc-pcie
+then:
+  required:
+    - interrupt-map
+    - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+   bus {
+      #address-cells = <1>;
+      #size-cells = <1>;
+           pcie0: pcie@18012000 {
+              compatible = "brcm,iproc-pcie";
+              reg = <0x18012000 0x1000>;
+
+              #interrupt-cells = <1>;
+              interrupt-map-mask = <0 0 0 0>;
+              interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+
+              linux,pci-domain = <0>;
+
+              bus-range = <0x00 0xff>;
+
+              #address-cells = <3>;
+              #size-cells = <2>;
+              device_type = "pci";
+              ranges = <0x81000000 0 0     0x28000000 0 0x00010000>,
+                   <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+
+              phys = <&phy 0 5>;
+              phy-names = "pcie-phy";
+
+              brcm,pcie-ob;
+              brcm,pcie-ob-axi-offset = <0x00000000>;
+
+              msi-parent = <&msi0>;
+
+              /* iProc event queue based MSI */
+              msi0: msi {
+                 compatible = "brcm,iproc-msi";
+                 msi-controller;
+                 interrupt-parent = <&gic>;
+                 interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
+                         <GIC_SPI 97 IRQ_TYPE_NONE>,
+                         <GIC_SPI 98 IRQ_TYPE_NONE>,
+                         <GIC_SPI 99 IRQ_TYPE_NONE>;
+              };
+           };
+
+           pcie1: pcie@18013000 {
+              compatible = "brcm,iproc-pcie";
+              reg = <0x18013000 0x1000>;
+
+              #interrupt-cells = <1>;
+              interrupt-map-mask = <0 0 0 0>;
+              interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+
+              linux,pci-domain = <1>;
+
+              bus-range = <0x00 0xff>;
+
+              #address-cells = <3>;
+              #size-cells = <2>;
+              device_type = "pci";
+              ranges = <0x81000000 0 0     0x48000000 0 0x00010000>,
+                   <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+
+              phys = <&phy 1 6>;
+              phy-names = "pcie-phy";
+           };
+    };
-- 
2.25.1

