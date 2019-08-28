Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AB9FD9D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH1Iz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:55:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40981 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfH1Iz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:55:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 196so1273953pfz.8
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4tt2ENFTFe5Eg7RyJm4kt1zaNDOy/8f5U31zRIZv65I=;
        b=LcHIw+CZEXfRVziiWwb83Rl1r0BaJKLJakpIRvePqp2801Yn93HplPf6SiE/BVp/Ni
         vPMFtI6MmuAgfVgSw+q3wnDjR7AVJ/DgNgi3zPk5YBJOOWaHu/B401LK4sGIeWjixoAg
         35ksrf4zhBW6+Xndf50EnsM3qn6pSX8bcSSQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4tt2ENFTFe5Eg7RyJm4kt1zaNDOy/8f5U31zRIZv65I=;
        b=KoGruNzQQD/3KBY6ZVJ1yOEjfzbhii6QBihOCKXYvx91TtQLgMykV4diB6nMxdYqk+
         FVUHUdKXytAkXDV79Xjedny3x88nXhisRLx3IDm9hxdyACy0K0u4yz92G7cfZsWo6q+Z
         MHGM4+kVr0ntVTCIEwsDcVGH/7czVJkZCOPacaYVgsglr8x6LiYZfB5tPUDtjc0hqIQi
         JYg7tUejxyVl+5+iG1YBQ3BCA7DlueccsIRFYBLIKss3fThp35n3x8spLWSY75OAKGIv
         /xfiVe5dilGejcOZLH5yrqlNchCuJld34yBYMRTl4DT1oPj6l6irPatkxLyBYrSlIUNJ
         yfdQ==
X-Gm-Message-State: APjAAAVEpmKOorbHA8yLG8SfpuRurJnQ7K8LyROpFslpQGoEKUH2BZ/8
        65e9Db1CTfJqoNnamnYQYRGiFg==
X-Google-Smtp-Source: APXvYqzjmQDEnBY8EF8T2/7xO0+gEVIbuaFzBwd9SxiFVr28UeDbwHgrG+kry4Vz/9vqLf89/lFf4Q==
X-Received: by 2002:a62:83c9:: with SMTP id h192mr3280891pfe.57.1566982526310;
        Wed, 28 Aug 2019 01:55:26 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:25 -0700 (PDT)
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
Subject: [PATCH v2 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date:   Wed, 28 Aug 2019 14:24:48 +0530
Message-Id: <1566982488-9673-7-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
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
index 15f7b0e..d639928 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -117,8 +117,11 @@
 		dma-coherent;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 1>,
+				<0 0 0 2 &pcie0_intc 2>,
+				<0 0 0 3 &pcie0_intc 3>,
+				<0 0 0 4 &pcie0_intc 4>;
 
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
+		interrupt-map = <0 0 0 1 &pcie4_intc 1>,
+				<0 0 0 2 &pcie4_intc 2>,
+				<0 0 0 3 &pcie4_intc 3>,
+				<0 0 0 4 &pcie4_intc 4>;
 
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

