Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6110F688
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 05:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLCE57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 23:57:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54434 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfLCE56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 23:57:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1551549wmj.4
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2019 20:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5EQ9rGer61vl3gVciY+E78pOpw9FBgHKH9v/WyZesyU=;
        b=NnXC6a+YemKnNQ13CElebpttdTTNKjemUS6z48obW+5NMCOJia26Zab9+aqXpyc5IY
         h8msHprLS+2yUh3iy6vYhIwf7f6IWZcA2dIkxx/I0jlUjABfqOUm+1ZQQgjEMolcnDOx
         +Khj7F5LsrE4AtZz4TUBoFartiHt7hqXeM1dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5EQ9rGer61vl3gVciY+E78pOpw9FBgHKH9v/WyZesyU=;
        b=CbrCOG1Xy4zyQuUnqFgWopbbTpStKVviMPvnHQhuafwWxhoMk+AfrEHFMY+g3jsWyz
         XKV5ukldZbxy++jayyshFyJp83Tk9HEUPQsW76ubnPO3E65xBi2SIqs0gsfcX1eWng36
         WfsGJniAB8YpAhNJsu2uZHlaZHaIapGnNyGDgvucDrjEtGOTcjQkLoAO7mJbrDRnK9WR
         I7KRbE/62/+18PBVN7NJdWELqa1GRWXhy2P3zWCeDgRPXzH4uPCnrR5KLaBBW366fogE
         f1sYK39ll28VlGWLVtkt2qKzVxRdj+L3xvB2WWZBok8+vxUqOm2bT7WcX6UCEFdfLaCQ
         Bqqw==
X-Gm-Message-State: APjAAAW4bq9JR/3er8Hc1dbG3j6GxAXMtV/ZySaRCBe2nfAkn3Ij4E+O
        DvZWhLN4UbNXU3jAVlUNyUtz2g==
X-Google-Smtp-Source: APXvYqxuBmmbVXH5kPj4wkVybb17DZ3Mwc0TM2Ex1DRaelK67SP9KvNgI9mZObMnqdnPhJo3CgfQJA==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr17775306wmk.113.1575349076962;
        Mon, 02 Dec 2019 20:57:56 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm1667807wmk.26.2019.12.02.20.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 20:57:56 -0800 (PST)
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
Subject: [PATCH v3 5/6] arm: dts: Change PCIe INTx mapping for HR2
Date:   Tue,  3 Dec 2019 10:27:05 +0530
Message-Id: <1575349026-8743-6-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
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
 arch/arm/boot/dts/bcm-hr2.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index e4d4973..d840190 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -299,8 +299,11 @@
 		reg = <0x18012000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -328,6 +331,14 @@
 				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie1: pcie@18013000 {
@@ -335,8 +346,11 @@
 		reg = <0x18013000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 1>,
+				<0 0 0 3 &pcie1_intc 2>,
+				<0 0 0 4 &pcie1_intc 3>;
 
 		linux,pci-domain = <1>;
 
@@ -364,5 +378,13 @@
 				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie1_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.7.4

