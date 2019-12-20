Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49786127443
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 04:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTDyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 22:54:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTDyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 22:54:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so4273275pgf.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 19:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8eqGO3e+YlWd2ITnGshI//smKmblV0XTNcfdq+TYMgU=;
        b=cJaO9WZOkbkG7juQ89G9NsORAsUIiCXAkd3Q2MEokvMKStb/yDOkhlRNzU6TAvjN9S
         ZZrGniP+P94AL/GyIXY404p+00yENTXLFvIKxbFlsYS1APO/EVnySJYqR7anxdbnYnc9
         Kdx9IMpug12jI35Wg6c6MSLATg9ifBJecQjxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8eqGO3e+YlWd2ITnGshI//smKmblV0XTNcfdq+TYMgU=;
        b=so1F6OkGIcipWr1bfT0lvNSJCgGBRkPUmvWx1z0iSz7JxhB0wQ08fCixTWnh+tZncg
         hW6aPCsNH/FKacGmpz5DVV7udJMYqhN1gQxiJzJ2KBGCxDsxsa0qYK1/59u0dWGH7Qeo
         k4TcMaL/jEUpyh81qB+NhBSR+NjIa/QDvSqlSmhwTbzG5QMrq1VgOypOMrikQnAHCS2N
         eAkFDuZct/dE+LswWGoR+Un98072d82hsk1o/vIXtDGpU5kGbvRNstgegl89iJtltWCd
         FdqwCQmTyazWZHIZSJvGicgaWg4y7TXa8NMT3pvibm7d1iGVarsnigvSsyAj2wCOiWqC
         k44g==
X-Gm-Message-State: APjAAAV453QbfgAs7/JrkOLFmOQQJIkb9FKNLy71YoKQpYJ6bLE19CtQ
        NAtGAvzj7Na0fINcHCT583Fbhw==
X-Google-Smtp-Source: APXvYqzliOle0cHj6Nw6lZ4cm+lDLYjzQceDtMHClvbgwuNZNbZkk+N6zYQ+VXMfaRQ0BNa4fpD2vg==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr12550840pgi.241.1576814079819;
        Thu, 19 Dec 2019 19:54:39 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t65sm10522205pfd.178.2019.12.19.19.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 19:54:39 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 1/6] dt-bindings: pci: Update iProc PCI binding for INTx support
Date:   Fri, 20 Dec 2019 09:24:13 +0530
Message-Id: <1576814058-30003-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
References: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Update the iProc PCIe binding document for better modeling of the legacy
interrupt (INTx) support

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

