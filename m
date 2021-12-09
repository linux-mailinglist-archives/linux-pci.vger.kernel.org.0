Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9F46F532
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhLIUvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhLIUvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:51:12 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B9C061746;
        Thu,  9 Dec 2021 12:47:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 8so6516846pfo.4;
        Thu, 09 Dec 2021 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T9mp4S9URZd2whYj8+GZ4xQxrEVWGa/TYrA1JtcjfBY=;
        b=Fe7Qo4bQc2KPHNx5eyzEY+lEQB8TKseg9xpX/BqRO1FA19R6oayEAtyck/gEZRk774
         BwKA0H3EUNWZYektRDk0MqmodtmTjTt6ibxtTTciBQDhZKlp6EaC6FtIXOEjFKv/3XbY
         DQ5vI1NdktLfYyVNO5LGvx/vi/8IFiY3Z57297tZGTsacvf+W6lcoACCBRbZbYqr+OA1
         f6xTTQgcamuY2xflUZLUM9pvj0HHPk1hzbJ7GkW8EE7j8xIS5xgYGSXVBNo5rInmKO7I
         79dfNIM+r4ZOmeyg+6eJQlWp+oOw11AiwyRs5m5bioXQ8ypTzkRhgYHsSSvofAdS0+gf
         JOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T9mp4S9URZd2whYj8+GZ4xQxrEVWGa/TYrA1JtcjfBY=;
        b=zFqU7+fMWi6+YBkhJvFgbmXc8dHhTXiU57qqip154QvUnCTWcoA86xo0pxqZUIbMQz
         vthHWrSRBokOpCswz1NLOldgabsXakUeXB02jqnRJh9RByQe3zoeLAfs7SwMLhUsOP7U
         eip3/waEI4sh7asrG8wixDCX/cmf7iygqjK6vwdcCLpCW7zYWv1itEJbcWLTiHBLlXki
         lttnPwPWhTnM/AhJBJfI68hKpGQ7h9SV9RsDtE+GTeE6N0DmCJYOPeK0HeTN9eRxJlkJ
         Yt+eryIu1YlVTrIl2Vk8uxDWR83XuCItDHHbITBxD2EzM0CRbvHF2obomqYWpv+S6VVg
         Z0zQ==
X-Gm-Message-State: AOAM533FcAlzVfHKiMx3l9PiuBcvjCcOUOZbwU388EoZ+HuSblE4sd43
        6M2LS+el688RRbwhsp8pxHQ5MdKnH3g=
X-Google-Smtp-Source: ABdhPJy6Gu2pMOGPHkTszgCnu1SktZoNSDdYp/Zj6Z3Zxxmhm5GNJv2PLSuX/P/7RguNtV/QGFCttQ==
X-Received: by 2002:aa7:9586:0:b0:4a2:78b4:a402 with SMTP id z6-20020aa79586000000b004a278b4a402mr14065456pfj.21.1639082857632;
        Thu, 09 Dec 2021 12:47:37 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id f185sm568370pfg.39.2021.12.09.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:47:37 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/4] MIPS: bmips: Add support PCIe controller device nodes
Date:   Thu,  9 Dec 2021 15:47:23 -0500
Message-Id: <20211209204726.6676-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209204726.6676-1-jim2101024@gmail.com>
References: <20211209204726.6676-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For Broadcom STB PCIe HW. The 7425 and 7435 are MIPs-based SOCs.  Not much
difference between the two for the DT properties except that they have
slightly different PCIe interrupt assignments.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 30 ++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 30 ++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  9 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  9 +++++++
 4 files changed, 78 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index aa0b2d39c902..62588c53d356 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -584,4 +584,34 @@
 			};
 		};
 	};
+
+	pcie_0: pcie@8b20000 {
+		status = "disabled";
+		compatible = "brcm,bcm7425-pcie";
+
+		ranges = <0x02000000 0x0 0xd0000000 0xd0000000 0x0 0x08000000
+			  0x02000000 0x0 0xd8000000 0xd8000000 0x0 0x08000000
+			  0x02000000 0x0 0xe0000000 0xe0000000 0x0 0x08000000
+			  0x02000000 0x0 0xe8000000 0xe8000000 0x0 0x08000000>;
+
+		reg = <0x10410000 0x19310>;
+		aspm-no-l0s;
+		device_type = "pci";
+		msi-controller;
+		msi-parent = <&pcie_0>;
+		#address-cells = <0x3>;
+		#size-cells = <0x2>;
+		bus-range = <0x0 0xff>;
+		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+		linux,pci-domain = <0x0>;
+
+		interrupt-parent = <&periph_intc>;
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		#interrupt-cells = <0x1>;
+		interrupt-map = <0 0 0 1 &periph_intc 0x21
+				 0 0 0 1 &periph_intc 0x22
+				 0 0 0 1 &periph_intc 0x23
+				 0 0 0 1 &periph_intc 0x24>;
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8398b7f68bf4..8c001b944c8b 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -599,4 +599,34 @@
 			};
 		};
 	};
+
+	pcie_0: pcie@8b20000 {
+		status = "disabled";
+		compatible = "brcm,bcm7435-pcie";
+
+		ranges = <0x02000000 0x0 0xd0000000 0xd0000000 0x0 0x08000000
+			  0x02000000 0x0 0xd8000000 0xd8000000 0x0 0x08000000
+			  0x02000000 0x0 0xe0000000 0xe0000000 0x0 0x08000000
+			  0x02000000 0x0 0xe8000000 0xe8000000 0x0 0x08000000>;
+
+		reg = <0x10410000 0x19310>;
+		aspm-no-l0s;
+		device_type = "pci";
+		msi-controller;
+		msi-parent = <&pcie_0>;
+		#address-cells = <0x3>;
+		#size-cells = <0x2>;
+		bus-range = <0x0 0xff>;
+		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+		linux,pci-domain = <0x0>;
+
+		interrupt-parent = <&periph_intc>;
+		interrupts = <39>, <39>;
+		interrupt-names = "pcie", "msi";
+		#interrupt-cells = <0x1>;
+		interrupt-map = <0 0 0 1 &periph_intc 0x23
+				 0 0 0 1 &periph_intc 0x24
+				 0 0 0 1 &periph_intc 0x25
+				 0 0 0 1 &periph_intc 0x26>;
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 9efecfe1e05c..f38934934349 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -152,3 +152,12 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie_0 {
+	status = "okay";
+	/* 1GB Memc0, 1GB Memc1 */
+	brcm,scb-sizes = <0 0x40000000 0 0x40000000>;
+	dma-ranges = <0x43000000 0x00000000 0x00000000 0x00000000 0x0 0x10000000
+		      0x43000000 0x00000000 0x10000000 0x20000000 0x0 0x30000000
+		      0x43000000 0x00000000 0x40000000 0x90000000 0x0 0x40000000>;
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index b653c6ff74b5..a0cf53e23c07 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -128,3 +128,12 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie_0 {
+	status = "okay";
+	/* 1GB Memc0, 1GB Memc1 */
+	brcm,scb-sizes = <0 0x40000000 0 0x40000000>;
+	dma-ranges = <0x43000000 0x00000000 0x00000000 0x00000000 0x0 0x10000000
+		      0x43000000 0x00000000 0x10000000 0x20000000 0x0 0x30000000
+		      0x43000000 0x00000000 0x40000000 0x90000000 0x0 0x40000000>;
+};
-- 
2.17.1

