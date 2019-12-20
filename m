Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11B127455
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTDzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 22:55:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36331 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTDzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 22:55:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so2776333plm.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 19:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovwMqTunBsTOC/CqSHDUi6kBW0F5coIGszg1T7U+mmc=;
        b=Ugw/aAKctEDVCy2E9Jnvv9tHDoIpDDehFz+T8+8aZI9cywj2KBlcwfzfh7mdCYik2O
         6IN4WKFXJzHgEZIa2XxRDQevv8ZJskvQehHtPy9eq3eJlXbnv3s6NMVIoQgcemtvFC0g
         OpT1biszj6pl06q1BV41iz/vpa/x0wDxPxovw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovwMqTunBsTOC/CqSHDUi6kBW0F5coIGszg1T7U+mmc=;
        b=nTHrUQ62LjAQUF6H/TwbumWAGg7GQv5bufsT3zc5cRX05Dlwsdf7GDvK5TWwX/xvop
         pB+UHSpnpqOp3WtQU/j/AZKbEpYFKlQ5SwNpwHR5Lvaw3FHWuY+yLF3f+qXYKcjyEiVZ
         2UaOcZpWYths0M78a5yV42lRIqBfnfxReyUFyonxSm56iKY998KUbPOlSGRN+2zMA7oV
         SBUC0B+P7y+dClG9FNDxDS5HoZXLJphQi+78o1hhH2P3DZo5LIMUfrCiz3N4/s43516w
         nQpIwyO4ROPY38w/CI9dyXv1pmifQTh3B/Cu8kXXZPfdTgiBvmWYDvHxu7LyKQeKP+XH
         7Wug==
X-Gm-Message-State: APjAAAV1vBKLtOawDNaaEAzeQzS8Vdt0eiC2tJO/6X820T5RVNdjuHKW
        3gQdr3kcXDaxDp2Y01oCNq4j1w==
X-Google-Smtp-Source: APXvYqySAxX6cI6Csq/zjMK84YWQHTPp16rdaC7UvgT0ndq3+F8fteQB9Vwa78q2KJtTGR3xyfygWw==
X-Received: by 2002:a17:90a:bf0c:: with SMTP id c12mr13085792pjs.112.1576814105379;
        Thu, 19 Dec 2019 19:55:05 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t65sm10522205pfd.178.2019.12.19.19.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 19:55:04 -0800 (PST)
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
Subject: [PATCH v4 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date:   Fri, 20 Dec 2019 09:24:18 +0530
Message-Id: <1576814058-30003-7-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
References: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 28 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 15f7b0e..489bfd5 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -117,8 +117,11 @@
 		dma-coherent;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -140,6 +143,13 @@
 		phy-names = "pcie-phy";
 
 		msi-parent = <&v2m0>;
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie4: pcie@50020000 {
@@ -148,8 +158,11 @@
 		dma-coherent;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie4_intc 0>,
+				<0 0 0 2 &pcie4_intc 1>,
+				<0 0 0 3 &pcie4_intc 2>,
+				<0 0 0 4 &pcie4_intc 3>;
 
 		linux,pci-domain = <4>;
 
@@ -171,6 +184,13 @@
 		phy-names = "pcie-phy";
 
 		msi-parent = <&v2m0>;
+		pcie4_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie8: pcie@60c00000 {
-- 
2.7.4

