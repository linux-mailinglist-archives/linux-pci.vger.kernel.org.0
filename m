Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52FC50318F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 01:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354273AbiDOVJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 17:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354219AbiDOVJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 17:09:00 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81A6583F;
        Fri, 15 Apr 2022 14:06:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d9so7188857qvm.4;
        Fri, 15 Apr 2022 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=UIS6nEYV876W1JKuUDEuDbByxmB/7R5cDelxgi4Ovs+fITSNRC5S1j5B4zbzT/wJFi
         1go3afHNJL5XdHxnCBIuOeaUBiuJCoEbhKq56kwEn0XeSFI17Sws6upWDj7keaU4ZA4p
         gITZ1rhyzHuq97xfFj4b+Simpfb75aYz5l6719+px6T+iG+4P/FLcLZNOXCCk7jwSLbs
         A9TE0k6t7uQyZ8VuNQkR7YlTfHuRo/OE8YMfMywsZF7VLggLzV9sIX4SOorH3aw6xCul
         AT7JiI4OK3QOT2oM6WT4Ot5QN5/hUEKz3HIGPKGlErFONOUg8JuDYZ/dVuDCHQpBIlIT
         WDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=3p77Z+lVUqr0PekZ+d+WEUdV5Gx5Rr4PpAJNlkliKq0mZXCZYRMZL0SwvVXHrYANn6
         QClAMrgMmP9BkzcMVpOvca92TCiigI+ovKQrO/S/grVBLiBlDUWgMtStekXBm1fn28f8
         hAGLKDpQyMGoPb02gKNfxecf/uotGWdLZA9rk+RNTHdi3aCIM6b3O+1zk7a1VhwS4aSZ
         vA+IyYUKnDWkWQAOIMTK/qpLiqk2YSbBS00AumnS0GdjuwCgp4mlPffS8gjG0frZ5Z29
         ThPGpbb9mz6xuzX823tezhm3nChEiCSk1Krcemkb9vzW6iDjtDtYR5WlpUj1GYoaHOHt
         Fgpg==
X-Gm-Message-State: AOAM5329eTWNSCfxXzKoa5iTOERRJBWIxgS5S/unQd10+1XbhdfzWehL
        s+q2t64JP8OtRCYjocZD2epEe9fxxgHkE+rY
X-Google-Smtp-Source: ABdhPJxtIoCNjPfeYIhAHwp2nGZHXPCq/PY9qqdGmTI826FnopPkrXNcQOzQt0W4F/Qc9fWsjLyjnQ==
X-Received: by 2002:a05:6214:2342:b0:42d:7c8b:9eac with SMTP id hu2-20020a056214234200b0042d7c8b9eacmr763410qvb.5.1650056789619;
        Fri, 15 Apr 2022 14:06:29 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b0069c4884c990sm2838664qkj.108.2022.04.15.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:06:29 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Fri, 15 Apr 2022 17:06:20 -0400
Message-Id: <20220415210621.538109-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415210621.538109-1-pgwipeout@gmail.com>
References: <20220415210621.538109-1-pgwipeout@gmail.com>
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

