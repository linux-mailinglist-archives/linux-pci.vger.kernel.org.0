Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AE5035DA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiDPKHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiDPKHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:07:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307102559A;
        Sat, 16 Apr 2022 03:05:08 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d19so251336qko.3;
        Sat, 16 Apr 2022 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0iQ9ABbCRaGlGa7IaJxgd/TqqdAiwKA2NxXKG7sbVE=;
        b=HFIYkPBC3hOIMq9kn9/xMHKp/ajgBr5nX5njgRv9yVVAamPnopCYrsldLNAtgL6YLw
         vpMU8i4l8FSw1iqq8SiA34xfKAW7THnyBNFK7A7KPqeXNRkWZs0l++4y0Wl1hheRKUwx
         SBqleY9gNpMJWlJq6cPrRfM+hkiHfIsZWQ7tLZ1v/x4EQG+W0jasgtE3iYmUO5CeL4Od
         +fpZjm7GVao/AvK1aU/hYVBC/W9buW5p024xkY08lutKlTeCowc1nkSLnT49A3c4ddTT
         gsI8NWuoehxOnhMAY9lNrWLNTo2E+hlix1pETI1HIQUiLbuxoXuVU7zvrEvwhGZd1cZl
         Fchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0iQ9ABbCRaGlGa7IaJxgd/TqqdAiwKA2NxXKG7sbVE=;
        b=Q91jVtEO1chQKN9oXNFx/i1LWDwCPt+8dVgh3hhPqn2eiHz+//2fSGbr8j53hOFp1u
         OBBfoyli5ZyDpKD9EHpNrYLdA+yetJfVHMQo5WemgjD8pf/B+jOLC01DXIHmlXeXCi1G
         pEIMjgo+glzvq1QR4kkTjfkpWLTDvoSAGu8W2v8bqF/4MSmrxGASo28HbOumV5xMKMFM
         luioqFi6MYUZY0mxfRBMx/4cHLh/EPq4V4g6Ko8x4Ds0HCN6lFMwbjbIV2P0rgyxlhUC
         boAUiSs+LRtC9lPoTjnLYfV9meE4sL0JGkvOlR3Yqt98slQ4SE7xEeS6qFnGbtAH6zxl
         fKjQ==
X-Gm-Message-State: AOAM530pz1MBM6cpvFdcwnvRnOaW9sCLnyNGsNj4SlGZxYRMtsj5qC2k
        wnX8QBnSrlcCuimCB/FkJc0=
X-Google-Smtp-Source: ABdhPJxF0S/ltF1J5/ITjpMAtmH7iSTPGztzj+NFLC5A21kN0oqLUNyc2YkvWCHKcfv0840VdVIVaQ==
X-Received: by 2002:a05:620a:2802:b0:69c:3b5a:b264 with SMTP id f2-20020a05620a280200b0069c3b5ab264mr1556070qkp.668.1650103507353;
        Sat, 16 Apr 2022 03:05:07 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm4263188qtw.67.2022.04.16.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 03:05:07 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Sat, 16 Apr 2022 06:05:01 -0400
Message-Id: <20220416100502.627289-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416100502.627289-1-pgwipeout@gmail.com>
References: <20220416100502.627289-1-pgwipeout@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index ca20d7b91fe5..7408169f2865 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -722,6 +722,61 @@ qos_vop_m1: qos@fe1a8100 {
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
+		msi-map = <0x0 &gic 0x0 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3568_PD_PIPE>;
+		reg = <0x3 0xc0000000 0x0 0x00400000>,
+		      <0x0 0xfe260000 0x0 0x00010000>,
+		      <0x3 0x00000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
+			  0x02000000 0x0 0x02000000 0x3 0x01100000 0x0 0x3ff00000>;
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

