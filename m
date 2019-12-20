Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4699B12744E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 04:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLTDy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 22:54:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfLTDy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 22:54:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so4471523pfb.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 19:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HjO9w3K+DhLv6DGPP4CnPl74iRTy3HmYOjIjOtLnJCY=;
        b=NLVU8mmMh0OuZFo5FioB+xL49a7TXbGb0l0JnlM0+44ShP/xZdIwLQJROJbINm/JHX
         lZHzpUgMh6JPoUHS98DWiguUctdzmFIv0PQwccHe/I8qeAqQQQq7gyB2tHNkC0gNXtM8
         RC1p+dyU6TbsP3cVgnxT6m5ewlPOr4SzS/3wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HjO9w3K+DhLv6DGPP4CnPl74iRTy3HmYOjIjOtLnJCY=;
        b=mPkbIKAakzTU9cdYm6VD6yFSsvSaCHl4obyfX0ac+oQmsl7pGeVf3JT//wC5djyoQ8
         IlUqyqG6omAeYyKbw/SGt2o9Sn5aA4VO7jACJAdQZupju/VkGwTvwqm6mpmS4ooGOQxq
         m3YihzcSZ8GiSuo8puZd3pZdowIgpstTFiLmjp6LkKzqVG0YT99qiXGRskf+S0eviQML
         NZWforq3qbnG86ZXHOa5VS0DhPGdwkv6x94IZ4nMqTFB2T3jNnmQ4tIZP9ct2jajQBQA
         bDIusQI/sncZeqxCcSB68KiPjiHVrmBVkN8JEF72zdhgisnwjMjJKyEurv9ChvBAKhUe
         bbvw==
X-Gm-Message-State: APjAAAVon65/Ov0MvF9BoOqjsdLe/nALhtWdyvfS9BvogndHMvz+0HPD
        5HC7nlvqCIVD7MUQMb97kUkhyw==
X-Google-Smtp-Source: APXvYqzuOoyic8K2nHA/j78B4PNAtlCcRmLYgMDR9oD0rHduorOa5hz7OMRLWUc/enOsuSJhIO5Rzg==
X-Received: by 2002:a62:8602:: with SMTP id x2mr13760012pfd.39.1576814095155;
        Thu, 19 Dec 2019 19:54:55 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t65sm10522205pfd.178.2019.12.19.19.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 19:54:54 -0800 (PST)
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
Subject: [PATCH v4 4/6] arm: dts: Change PCIe INTx mapping for NSP
Date:   Fri, 20 Dec 2019 09:24:16 +0530
Message-Id: <1576814058-30003-5-git-send-email-srinath.mannam@broadcom.com>
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
 arch/arm/boot/dts/bcm-nsp.dtsi | 45 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index da6d70f..6d73221 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -529,8 +529,11 @@
 		reg = <0x18012000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -559,6 +562,14 @@
 				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie1: pcie@18013000 {
@@ -566,8 +577,11 @@
 		reg = <0x18013000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 1>,
+				<0 0 0 3 &pcie1_intc 2>,
+				<0 0 0 4 &pcie1_intc 3>;
 
 		linux,pci-domain = <1>;
 
@@ -596,6 +610,14 @@
 				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie1_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie2: pcie@18014000 {
@@ -603,8 +625,11 @@
 		reg = <0x18014000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+				<0 0 0 2 &pcie2_intc 1>,
+				<0 0 0 3 &pcie2_intc 2>,
+				<0 0 0 4 &pcie2_intc 3>;
 
 		linux,pci-domain = <2>;
 
@@ -633,6 +658,14 @@
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie2_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	thermal-zones {
-- 
2.7.4

