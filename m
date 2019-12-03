Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCA10F677
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 05:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLCE5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 23:57:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53399 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfLCE5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 23:57:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so1562888wmc.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2019 20:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNbjBu2ZoQvj/Rdtwyfg9/ny54LKUFtnkpIxH0rGJgw=;
        b=IgneEgiudM4dhaaT84m2HLx76XXFsgx7G+w69ktuYbVN+4NPtabS6SzrKMZeVV/o+0
         IJ1aQAetS7xf6kvwH2UJizjzP3es1gKKH6RB+glnvQAT2HHMa53vqr8OgzDBUfej0Z9i
         2Fypg52a+TW8NLIts/3Eii9AR91WnOK2oxu7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNbjBu2ZoQvj/Rdtwyfg9/ny54LKUFtnkpIxH0rGJgw=;
        b=uar3PdwmpJZ9ZslrzmXhOUOe6CUTb1UijD1Q/3qCfI/0L0Zd9HrrKJerz7ag5XonW2
         rGrV4qad6aj8io8o0hG5fLbsQ3PoxQkRTDk/QIqgEqDOD+BkMpRuOpKygbqzBo6uHUj8
         A3tr0nYIRVbbH87d+QJj5S4EcHDt4kqd6VoScYqeKsjAhd8EiZpg5tu4vNcH2jUG2LfV
         y9WuxyZWzKrLujURh7wJBksnn8WJp+6mMegbvpZ6dY71gCHNttsgVg9syRXajZTnXTey
         SxIjB1x+ZLNcovQ79JXmGc3PjFduCSEKpf0BxTSrf98aSMgyEP0/Clfv59lYmNOefaTG
         +16g==
X-Gm-Message-State: APjAAAU0X+Xz8kJwSXA3njrJ+4bxpXMLuypofqEXcx77B1gyhThxoR87
        vqQySgBLlqqEl7K1GHXmPukkug==
X-Google-Smtp-Source: APXvYqy1L/hk7jc6Vua1eOQ6zF9HW6W5OyAgAMHGiBpjQlMl56SBWkEWvpdI05EBRsPwMIKUCJzloA==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr33613750wmc.34.1575349055230;
        Mon, 02 Dec 2019 20:57:35 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm1667807wmk.26.2019.12.02.20.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 20:57:34 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/6] dt-bindings: pci: Update iProc PCI binding for INTx support
Date:   Tue,  3 Dec 2019 10:27:01 +0530
Message-Id: <1575349026-8743-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Update the iProc PCIe binding document for better modeling of the legacy
interrupt (INTx) support

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 48 ++++++++++++++++++----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index df065aa..d3f833a 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -13,9 +13,6 @@ controller, used in Stingray
   PAXB-based root complex is used for external endpoint devices. PAXC-based
 root complex is connected to emulated endpoint devices internal to the ASIC
 - reg: base address and length of the PCIe controller I/O register space
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map, standard PCI properties to define the
-  mapping of the PCIe interface to interrupt numbers
 - linux,pci-domain: PCI domain ID. Should be unique for each host controller
 - bus-range: PCI bus numbers covered
 - #address-cells: set to <3>
@@ -41,6 +38,21 @@ Required:
 - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
 address used by the iProc PCIe core (not the PCIe address)
 
+Legacy interrupt (INTx) support (optional):
+
+Note INTx is for PAXB only.
+- interrupt-map-mask and interrupt-map, standard PCI properties to define
+the mapping of the PCIe interface to interrupt numbers
+
+In addition, a sub-node that describes the legacy interrupt controller built
+into the PCIe controller.
+This sub-node must have the following properties:
+ - compatible: must be "brcm,iproc-intc"
+ - interrupt-controller: claims itself as an interrupt controller for INTx
+ - #interrupt-cells: set to <1>
+ - interrupts: interrupt line wired to the generic GIC for INTx support
+ - interrupt-parent: Phandle to the parent interrupt controller
+
 MSI support (optional):
 
 For older platforms without MSI integrated in the GIC, iProc PCIe core provides
@@ -77,8 +89,11 @@ Example:
 		reg = <0x18012000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -98,6 +113,14 @@ Example:
 
 		msi-parent = <&msi0>;
 
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
+		};
+
 		/* iProc event queue based MSI */
 		msi0: msi@18012000 {
 			compatible = "brcm,iproc-msi";
@@ -115,8 +138,11 @@ Example:
 		reg = <0x18013000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 1>,
+				<0 0 0 3 &pcie1_intc 2>,
+				<0 0 0 4 &pcie1_intc 3>;
 
 		linux,pci-domain = <1>;
 
@@ -130,4 +156,12 @@ Example:
 
 		phys = <&phy 1 6>;
 		phy-names = "pcie-phy";
+
+		pcie1_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+		};
 	};
-- 
2.7.4

