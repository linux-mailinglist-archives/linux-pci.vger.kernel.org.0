Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB750CBC4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiDWP1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiDWP1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582F3585F;
        Sat, 23 Apr 2022 08:24:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b68so7921148qkc.4;
        Sat, 23 Apr 2022 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAdcJDVWazZX4dXGCD7+iF7myvUA+4bRuij6vVerXqI=;
        b=VLmOkuSGPNxi+Bn0Kbd99h+1Ub83VpbQRYo3/rv6mYfYEZi/ENANpvI/EwS2wP9x6b
         hPNLPLHtXUz/t2yDzPPYRzWimvosVq+qWWm87ajW/TO/otWvkRSXxZmoabpG7F6vmJsb
         18PpUrzBFh8F6x3viJJREgJKizPpXI/4jmRjw1tNFbcgAreAJQcp67r8H1HjOZ3BZICj
         oPd1uTyuM8Yx+zxJViSL4hLYPQJmB6V62ehwutaER2CcRqOH0UPawH63EsYR4DM8Ywzc
         5tpwxpMQTbmQwByJouPv+yPDos0Iyq49bpCWbpCiWRBIwwWmNb6BGEsKkogxdeLbmK7n
         av/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAdcJDVWazZX4dXGCD7+iF7myvUA+4bRuij6vVerXqI=;
        b=1fKo1ZU4ELg+exsizDmDBGPcHtC3HyE0UQWUzSk3l9dp3DuGNDlYEp7Qaz3UCGsC4u
         XssTGZE9b2ZoLyVPX/G7Bx2CbA6F0xZBVigDVrAUgAbNGenO3ILb4LNApp8IY1AKxPgi
         n3s69W7UrlwsjKvrh9+8J1jVf5Qfk2QYoITSD6AeUjwYnS4k+3vhtp46SyF/ZY0V7f7s
         5ri4qDFWQ/78pqN7GH+Nuo0i5e0AovD2oOB+IHR4yxmJDHHR5JQ0l1yVJUr+40XHSc46
         Eb/RuTWPclbevxq2PS9F7HzjUtYqJlY6bhaDPujm29exlj5lEuWUw3o34SFLVOgG9zvP
         Bhmw==
X-Gm-Message-State: AOAM533VZSI5SOauJOY1rTwdmSvxvccePQrhACwtU+moZxcHdOC/PhGP
        4QQ1Y09+uZyDqD3QrYe8tWg=
X-Google-Smtp-Source: ABdhPJyia0XabZnmUlsN995dOAIz25vVgGiXhUoSyZce7ayaDdE6Gq3gIaVnQ2tH4qNuYDr4ii7LSA==
X-Received: by 2002:a05:620a:2909:b0:69f:6e6:8d9c with SMTP id m9-20020a05620a290900b0069f06e68d9cmr5487902qkp.51.1650727450863;
        Sat, 23 Apr 2022 08:24:10 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:10 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] arm64: dts: rockchip: add rk3568 pcie2x1 controller
Date:   Sat, 23 Apr 2022 11:24:02 -0400
Message-Id: <20220423152403.1681222-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7cdef800cb3c..aea5d9255235 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -689,6 +689,58 @@ qos_vop_m1: qos@fe1a8100 {
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

