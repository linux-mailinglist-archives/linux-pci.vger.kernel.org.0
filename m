Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82DB127451
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLTDzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 22:55:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41445 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfLTDzA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 22:55:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so4455534pfw.8
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 19:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=80PtSg1u55ZhNt7+LPSiTJ6+bt+JAt6rBXPSWmOI82I=;
        b=aUmizb0+zD2VcF7lVovq9TPL4D8F6LNSEt6ce6NUu7ySDS0BLO+D5uvb/boR8VojnY
         MNPbpURDE6dxA6eo7U7qmqaS8GsEJH7igohDdsMyh0cb/uWsWX5kFlaovnOf39aSRVDt
         n85lQ6jfnibKHAzN8tlhk23kON8Qm1kDhKQlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=80PtSg1u55ZhNt7+LPSiTJ6+bt+JAt6rBXPSWmOI82I=;
        b=ZnlHiYjsl3wGOLYdtMy1ZZDl5WW5tvrWMd2h8nHpiV38G/HZvhjxcXmXBE1F18IRtT
         1GF4BbnYYDkw/BqGXREmwt5GgCuxwPgoFkGrp4U019d78p0JLxvNtenVwErGeL4dwINf
         nPB4Qn5/iqYTxVUipdPiuUpCz24BlNnUx+lnBk8oXaaHlJH0u+Ck/hH51VFGrtWkZqgw
         Hgp0iA2gaRm3i1OSTvXn5ZlUpH0q59S+rXkS7BWP3cFmD3L1MBz1sLF/sNoeTCj4QE0f
         zPu3X05IGO1RG2OhF1S8B0euPjDPh9t/yntoAZqQEfSD38t6KhKtIB8ezOpgCHML1a+w
         Nt2Q==
X-Gm-Message-State: APjAAAWB4nQuPurmIp6ndE7r/NCcb1xt4q5YoBIYE2c3xNPIZkxev/6s
        nswcP/OsPpQryKzCSFuLXM/3hw==
X-Google-Smtp-Source: APXvYqxzHyYq4HR2GieaJsANZq1/5hn644qXmZ9mOkkCrPxU3HigyJ4QjjOEY1zrZWBhHYCfOWJewg==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr12536799pgl.230.1576814100194;
        Thu, 19 Dec 2019 19:55:00 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t65sm10522205pfd.178.2019.12.19.19.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 19:54:59 -0800 (PST)
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
Subject: [PATCH v4 5/6] arm: dts: Change PCIe INTx mapping for HR2
Date:   Fri, 20 Dec 2019 09:24:17 +0530
Message-Id: <1576814058-30003-6-git-send-email-srinath.mannam@broadcom.com>
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
 arch/arm/boot/dts/bcm-hr2.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 6142c67..80c3add 100644
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

