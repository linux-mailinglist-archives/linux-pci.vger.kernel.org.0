Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027E69FD90
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1IzH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:55:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44227 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfH1IzH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:55:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so1079285pgl.11
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fUJG+KQl5lgajSIMO2GJvUVvp7kIJCWDQTYoxm2KjYk=;
        b=XvwUhq7JSZsttPx2hPdrcPm0+gObdLn+jBkZs595GPAaKmypydWyBXRfhkyB3ClyQa
         5o2iuHxMtf1WS0CjDwLc4W77OJzIpyv0JwWr0J8pbXUWKAiaYvsa41oUNro996MwokiF
         haXeHhGwoFN2IZdqABlrSGDhknljtPZpguC6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fUJG+KQl5lgajSIMO2GJvUVvp7kIJCWDQTYoxm2KjYk=;
        b=sysQeVvYx/QTvIZ7esiemmDsnffqP3fshP5z7xr7nFsPr70kPmGO9sBqdOdlR6J226
         GYtnHtPckOHXOaKxcJP03fYjbaiMhrss8rv51nqXfFevP2F6YCw57JYvULaK67CM6hlj
         JXyTaTKMzIb3EJHXaLhxhYCwQRYAX1PC/KBqGrzGsdfpELo0zNmY8aObKkxexIauljax
         GxPS8E+u/Y+x0mr8WvrGsW9Kj3rEFaWtugN0JyjHDczvfFB2F/NNm+HAiE2JkxF/fi5Z
         vTvXfRZyWSQOZG8Saw3aaJ01kOEm+OhLhEOZEMxKknn1JQKVX68eV330Eoub0TqhjYBu
         vYSA==
X-Gm-Message-State: APjAAAXc3zMnbn4CSxtV0X08MdUn7IuQIJvkXYXDuO9Qdd+ig9XFm1ul
        505JvTzz0WCd4JCmzWVChE9ISg==
X-Google-Smtp-Source: APXvYqyJqeDpJVV7oQCWL2fuFWdhMdjT80lWaPTXxygLugsWHJHbm/I9FNNX0UZVC2VFzogVhw55Gw==
X-Received: by 2002:a62:1703:: with SMTP id 3mr3384211pfx.118.1566982506198;
        Wed, 28 Aug 2019 01:55:06 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:05 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 1/6] dt-bindings: pci: Update iProc PCI binding for INTx support
Date:   Wed, 28 Aug 2019 14:24:43 +0530
Message-Id: <1566982488-9673-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
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
index df065aa..f23decb 100644
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
+		interrupt-map = <0 0 0 1 &pcie0_intc 1>,
+				<0 0 0 2 &pcie0_intc 2>,
+				<0 0 0 3 &pcie0_intc 3>,
+				<0 0 0 4 &pcie0_intc 4>;
 
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
+		interrupt-map = <0 0 0 1 &pcie1_intc 1>,
+				<0 0 0 2 &pcie1_intc 2>,
+				<0 0 0 3 &pcie1_intc 3>,
+				<0 0 0 4 &pcie1_intc 4>;
 
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

