Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C14FE854
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358818AbiDLTAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358805AbiDLTAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:00:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCF43EF7;
        Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bk12so14504066qkb.7;
        Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=kRX7Utmi5sQeJOdNV5GhibPVbi+R8T1CXlL4HB67wg+pJJQ2aPRD2MFBzwsvjXua64
         6zu1TEp7uAPQoS29pn7ndo6GaHiDMD2v9+H8xitmT0fXat0jXYgEUrpZztAeBCp+h7Pr
         j6PIF5OLcbNU6fjOClZDd/WHXjK3+qA1zBnqk3wCIPGC28N6ebjTFyswcFhZbcMOw7e8
         RDfRf5BolneaTvspYK40EFE0EIRbvRT9GJakQhVNYHFX6vDttuG+wi94dhWgsRqMq2vr
         vFdHrYA3QJkpdpuk6Z0AXQ9/rZBMR11J1N9jn/fZoOjib//84gVb+t9cHpScZ3HSO9kK
         hbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ukbT/4wlnr3bIKYOPfr/n68CEs+SDNJ8K2aJyw0K+g=;
        b=gaU2OaS0SjiRJNWK3luHpuo0BotL6ltSUVOz4vwPmdrSS+7NR+aMe1emBcCJXLwqz0
         MO96Ti1BGD0nIhIXHsbKWBEQTTTMyTlWYwRS84Z5grBwEIC4w23APhzAIzTYVFuzOZlI
         ChJckumZ9+Szw9pyOBpawJMhzKjecRNcYgdjzb7WWnDru9o1xAttk5gs8lfh52wL9Vgm
         64xt/rneT0JbIGvUq6F4RlnaNWLVgDul1J/KKdN8rIrlQ63SaVCnvNuMkCoXgqBDeipr
         chxm+K5w2Fr0N4fNbe7pjGzVwiVx6cHAFmt7zHPjCCSYGG7b35LzUYp89R/gvCYQthJY
         Hphw==
X-Gm-Message-State: AOAM532Cy3OFUkIlEeUSp7/ZA5bv8NwOLKxPuHP8/Q+4SYakEzoZGjI9
        kSlLsvQ4uZl2sWU65GRZ5S8=
X-Google-Smtp-Source: ABdhPJxMin6i5rA2NeoQXHQ9qwN32ld+Qy9ePRO3wMgKyKQRQvIEYC0jvp+o6YDuaSBUH1LeVlUvRA==
X-Received: by 2002:a37:f519:0:b0:69c:29e0:f740 with SMTP id l25-20020a37f519000000b0069c29e0f740mr4234784qkk.652.1649789882726;
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1820610qtb.46.2022.04.12.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Tue, 12 Apr 2022 14:57:50 -0400
Message-Id: <20220412185751.124783-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412185751.124783-1-pgwipeout@gmail.com>
References: <20220412185751.124783-1-pgwipeout@gmail.com>
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

