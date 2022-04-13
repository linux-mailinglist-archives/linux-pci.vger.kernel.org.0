Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE70F4FF7C4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiDMNkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiDMNkX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:40:23 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF995F24A;
        Wed, 13 Apr 2022 06:38:02 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x20so1577984qvl.10;
        Wed, 13 Apr 2022 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=XUAIAMw9S2V928uTmqLYIWLIV4lwhS/XskmlSdJ29LdBhmNKksLHmw1HGydwdozR3e
         bdKZP2E/buiXCezZV8tydFHIrnpBAl9EmC3/eNXmudwJ7190AhzB7PBMmT9RZ5tic6Ne
         eEaUPKexSmOOABvCagElipJe2pKQClPnMjtvzYgT5z3e8s5M0pb7e1g65YrYjP7l5HLR
         rwx1MPiSetCOUe7PP5c9Cqt3czTKzA5fGPdVtDGDWa1FJW2NpvZ1O5QmdAG8oHOrRXTC
         Bgo6MtHLbDomydMXdlJDVKm0et8gZ1hsT/cOz7yYWUsXr5xTXmU/cMvx6/3794RTfzAb
         Uu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=Ffsr4/5RdQcyGHBwYwcwhI2O9v74UW5cowWGeyJYn6KEPyUZMvV6dNwL9cEOwM5Yqy
         WIk9qGHa/98Qf7iNiUqVFGA9kG8lUnTVE1uk/EKu5eKxZ8dD4agnWc9iTZ0QrfD9DALB
         ydThygOkki5gWDPALfgGkg9sU+a6cXn23ps4QtZEWYnCtS+0t5p3V/Pxw2DkKGJS3U79
         vCrBf9hBGiIKrGO72pe01ncK7XdW9rlrfgOmb5KX32O+N6onHDMVniQuck6cXxL4B3/S
         Kskh0+lV1OvfJxEZ5a/q0wWbMd1L7ClFBrYZ46xyYVHH6PO3rkHo9i5PPi785MLUfcKv
         0XkA==
X-Gm-Message-State: AOAM533G1XTH91pot36wVA7OBmsRCFnvyKhEl5Spqx+0PijNMDT9zUNO
        hYfdbYO3XSenabEBcYDSyXQg7Wy8WXQ2/0Wo
X-Google-Smtp-Source: ABdhPJz/KePNJSlcz8aYHVEZ4KgjrAunzkrxnD1+4FJPD9C/60EKr4EhfAeg9cW19bi2ok5YAJ+WHQ==
X-Received: by 2002:a05:6214:f0b:b0:444:5757:87f7 with SMTP id gw11-20020a0562140f0b00b00444575787f7mr7549283qvb.82.1649857081686;
        Wed, 13 Apr 2022 06:38:01 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 143-20020a370795000000b0069c59e1b8eesm790584qkh.10.2022.04.13.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:38:01 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Wed, 13 Apr 2022 09:37:30 -0400
Message-Id: <20220413133731.242870-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413133731.242870-1-pgwipeout@gmail.com>
References: <20220413133731.242870-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie2x1 controller is commong between the rk3568 and rk3566. It is a
single lane pcie2 compliant controller.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 68 ++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index ca20d7b91fe5..d5131f5aaf73 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -270,10 +270,17 @@ gic: interrupt-controller@fd400000 {
 		      <0x0 0xfd460000 0 0x80000>; /* GICR */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
+		ranges;
 		#interrupt-cells = <3>;
-		mbi-alias = <0x0 0xfd410000>;
-		mbi-ranges = <296 24>;
-		msi-controller;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		its: interrupt-controller@fd440000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x0 0xfd440000 0x0 0x20000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
 	};
 
 	usb_host0_ehci: usb@fd800000 {
@@ -722,6 +729,61 @@ qos_vop_m1: qos@fe1a8100 {
 		reg = <0x0 0xfe1a8100 0x0 0x20>;
 	};
 
+	pcie2x1: pcie@fe260000 {
+		compatible = "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
+			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
+			 <&cru CLK_PCIE20_AUX_NDFT>;
+		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
+			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
+			 <&cru CLK_PCIE20_AUX_NDFT>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk", "aux";
+		device_type = "pci";
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		linux,pci-domain = <0>;
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		max-link-speed = <2>;
+		msi-map = <0x0 &its 0x0 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3568_PD_PIPE>;
+		reg = <0x3 0xc0000000 0x0 0x00400000>,
+		      <0x0 0xfe260000 0x0 0x00010000>,
+		      <0x3 0x00000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
+			  0x02000000 0x0 0x02000000 0x3 0x02000000 0x0 0x3e000000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE20_POWERUP>;
+		reset-names = "pipe";
+		status = "disabled";
+
+		pcie_intc: legacy-interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+		};
+
+	};
+
 	sdmmc0: mmc@fe2b0000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe2b0000 0x0 0x4000>;
-- 
2.25.1

