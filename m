Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE71938E3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 07:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgCZGt0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 02:49:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZGtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 02:49:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so6335450wrc.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2020 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dqPVl/H6tR+MiJPl05QKxIz0P0jfSZuaHPi1asTV90=;
        b=WUHiihEUH0lElsZ9NJHrJqQ421HHol3h7BqdPKEKB4XM8ztXYl9yb9D44b7U5zQKtE
         S7rLRKDtlmTJcFlhCcLPc7DoNWeXy7OWWlxbRROTuRdOZfXNyAyjQgHanlUbE6CVneDk
         dITLx4EJK9UHLBpBweL8IWT+qJbZIOPYFkSOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dqPVl/H6tR+MiJPl05QKxIz0P0jfSZuaHPi1asTV90=;
        b=WR4YBiiVy1Yf2IQwXUlNzbeOLgYeg1Ofbn+F84Tl39/l2+gdiox/KyHPNjG+VsXP1l
         sy5NUSw+aDMkeMsBfjGa7acKxlASaPZje0VV9Mg0gwuKMYfLck+Gzp+iS8hHmXU27IiA
         WvyULoUi01uL86uRUkJvLJnYVGOMOk0dAe+WVuSBqrGiRmUWPurkOs9Lf0kcXSv8fL0J
         7ijFPCp/XgynR+7+iuCzw/VLXYCB0K0fUSorgBdgo92mFTk2LE7odJ9elpigTF1eKTyV
         bQPZind1FwGEuD/lnc1Whucr/so+n78ZH0JqSk170dKOjj1JoAniMZjp/gTzDKoSpDb+
         El9Q==
X-Gm-Message-State: ANhLgQ1Kkiewzx4LE2NwrN/P+mQ2tgW0Dl8efmca37ej0QYAOy7hXyHS
        2Pxnfxwhz7Z5hSoCkieFPnUZ8g==
X-Google-Smtp-Source: ADFU+vuaCkfq0b0wW8UmvZep91KWyv+2QNaLZlSlESaU3JAZep7YouX21pCUM8nvv5xBRVAzdtkeeg==
X-Received: by 2002:adf:c64e:: with SMTP id u14mr6700306wrg.113.1585205360347;
        Wed, 25 Mar 2020 23:49:20 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v21sm2069137wmj.8.2020.03.25.23.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 23:49:19 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 1/6] dt-bindings: pci: Update iProc PCI binding for INTx support
Date:   Thu, 26 Mar 2020 12:18:41 +0530
Message-Id: <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Update the iProc PCIe binding document for better modeling of the legacy
interrupt (INTx) support.

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

