Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074A50362D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiDPLHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiDPLHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 07:07:49 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401715A06;
        Sat, 16 Apr 2022 04:05:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z19so7321790qtw.2;
        Sat, 16 Apr 2022 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHb/kWKkyUoMSq3gKmql5I0wP4N+nhBclwmCSXeGOCA=;
        b=DeSr22RKUsgQpJKim6SJmZdEax2iP8VQJMrxoFEpH17Sfn3Gc6Y3mGfrqn2pgEhPMd
         tCdM968xmSZ5NvLk5optsYY9Ha6I1ySvwiQNfUTxWU97yf8lXGqREsx7K42vagDsYS3m
         5nsqAuHdS16X6qLysAmxwvf591wagOYDS0US8VWnea2cKnNzHmvlOOB2BV7nTZPasX63
         clP9YgMpOh0Fb7doH7qgprEdPSthlVYRilkLZtvD3YdFeTBmPHs8vUN1c6keVvm/aG7y
         bo7fgnWU3GpSevUpeXGW3t/siZodwHLNnTLzsObW2kX7Q6ZHznUmCvULhmNlaolfUTFL
         kusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHb/kWKkyUoMSq3gKmql5I0wP4N+nhBclwmCSXeGOCA=;
        b=s6Vod9twxFYyc7gBwqSXlSPblBUDCYKtCNlwWOcttqzjB+QN0G1SzoUWMeqysz5wSh
         lfCYMtd0vexWw4bPa+TuIayhDXRNL6f6Y0sYhfPf+a5qu2c6Pgnh5fi+GYaDrKbR4Iiv
         eY7vDDkXOk9AVz0U0oIWHV3ZzVvu1WqV+K2HMaAJnntHDitBAUlJ75W++JHwFt+emtmL
         /7zMBf0EddgM4LIKncrW2czEYxo73A/76HMp/XvCrzTpF/1am5k/RU2/Zcs7zlz0n0q2
         E6hsUw5DxeE0R+f9lZHhDvYClof8ap1e4B3zzElT+odWgudqrLe8MxWjBgkK/QO7qOwd
         9fcA==
X-Gm-Message-State: AOAM5327rYuFTPpJBV6Ygz+IYl2e9v5NLos+qrzVUNi05/FOzngyrBl1
        aBfO5J/V0Vz0qAKq4LSfgzU=
X-Google-Smtp-Source: ABdhPJxG6E7fIu49tzkJ5bJeXmAzZsUQjvjD8ZS4FiBSmkWy8B5OREubKBHRVnYg7JsCT6oFLCDdsA==
X-Received: by 2002:ac8:7f4b:0:b0:2f1:effa:6175 with SMTP id g11-20020ac87f4b000000b002f1effa6175mr1864999qtk.555.1650107113973;
        Sat, 16 Apr 2022 04:05:13 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm97026qtc.22.2022.04.16.04.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:05:13 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Sat, 16 Apr 2022 07:05:05 -0400
Message-Id: <20220416110507.642398-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416110507.642398-1-pgwipeout@gmail.com>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
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

The pcie2x1 controller is common between the rk3568 and rk3566. It is a
single lane pcie2 compliant controller.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index ca20d7b91fe5..bb08633332c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -722,6 +722,58 @@ qos_vop_m1: qos@fe1a8100 {
 		reg = <0x0 0xfe1a8100 0x0 0x20>;
 	};
 
+	pcie2x1: pcie@fe260000 {
+		compatible = "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
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
+		msi-map = <0x0 &gic 0x0 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3568_PD_PIPE>;
+		reg = <0x3 0xc0000000 0x0 0x00400000>,
+		      <0x0 0xfe260000 0x0 0x00010000>,
+		      <0x3 0x00000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
+			  0x02000000 0x0 0x02000000 0x3 0x01100000 0x0 0x3ef00000>;
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

