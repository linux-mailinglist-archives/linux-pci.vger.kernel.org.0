Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96E262CD10
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKPVtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiKPVt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FA654D8;
        Wed, 16 Nov 2022 13:48:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so451992eje.1;
        Wed, 16 Nov 2022 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqP3TbX6KVo39b2lQABBBQ0jY7NpQinCFYzDvvPTOAQ=;
        b=mdrUYfp7OS+HCloH6RN4Nr7RqUwamklaQqaWCmtGE22adN4F/lJv/EHcrJTF8F6NaX
         nGxL1Oa+zTfV8Zk2shVdd1LtChW89F/xX35q0u54Ij5GYa+eI1QQUvpgRYy2q988aRh8
         7PxTB9nzFDt7oOMNJN4R6xftLQ+wb7cqxjpwta2d3UOuayXxuDiM9GHFzXi2/W07ktGR
         0kZDWJ65XwR0Bo2jkGKLkqnzN0eCSnyim+xRoGU3YxyIiYCBuVG86P1fBn4DItbN7zgE
         /q6MXH9ALNY93P/2TAaw6+8FgSAiiYdw+uueF8hwxzb4GEnmozYurzswMjQwAIjHk+A9
         QjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqP3TbX6KVo39b2lQABBBQ0jY7NpQinCFYzDvvPTOAQ=;
        b=TRN3OdqMyZ8zU/LwZcUJdPqDn/DAmudep4/yOpYlEry0vKwPcBoOR9CwX79EPvjQUp
         UMSIDxQexTv2xiKumkT6iK0MxRqsIZliyW/y4ayeUbFxXGgiyTqh5qla/qb6CYCH+4fT
         0CN/LT5mcC5C8IwyFIWNF7koCOiZnQ4+P+uzZhrIFZ7gbvQb1iW+uLd0PvcHfLd56JBB
         b4jxHd3yC7Mrkx/t33j2cbcIld+Ji+6gnANZv+/ms2ill8QSL4wB4biqlrd7jzevviOJ
         NtlEO5teFTWi9zQmLnbg9kStuas25S2pU9Ro0pfYqDO03phzmOGdRaPAXDdxu6++jfVx
         aCKQ==
X-Gm-Message-State: ANoB5pnpakeJnPWF0Qj44+PhF8RM14BcOOpH03X+LoFK+Ar7fGtD0ac+
        gXtsFWfXFKrOByVgX4xgj+w=
X-Google-Smtp-Source: AA0mqf6ZJKmmavc2VY51bOHBnkFJpUPL0hNSI4ljVpbCqDOU3gLiXiYMfHmggsSupfscrevkG7kHtg==
X-Received: by 2002:a17:906:5fcd:b0:78d:4cb3:f65d with SMTP id k13-20020a1709065fcd00b0078d4cb3f65dmr19785456ejv.79.1668635333734;
        Wed, 16 Nov 2022 13:48:53 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:53 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
Date:   Wed, 16 Nov 2022 22:48:40 +0100
Message-Id: <20221116214841.1116735-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116214841.1116735-1-robimarko@gmail.com>
References: <20221116214841.1116735-1-robimarko@gmail.com>
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

IPQ8074 comes in 2 silicon versions:
* v1 with 2x Gen2 PCIe ports and QMP PHY-s
* v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s

v2 is the final and production version that is actually supported by the
kernel, however it looks like PCIe related nodes were added for the v1 SoC.

Finish the PCIe fixup by using the correct compatible, adding missing ATU
register space, declaring max-link-speed, use correct ranges, add missing
clocks and resets.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 30 +++++++++++++++------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 585e5f0a139d..c76c6ee9acb6 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -854,16 +854,18 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 		};
 
 		pcie0: pci@20000000 {
-			compatible = "qcom,pcie-ipq8074";
+			compatible = "qcom,pcie-ipq8074-gen3";
 			reg = <0x20000000 0xf1d>,
 			      <0x20000f20 0xa8>,
-			      <0x00080000 0x2000>,
+			      <0x20001000 0x1000>,
+			      <0x00080000 0x4000>,
 			      <0x20100000 0x1000>;
-			reg-names = "dbi", "elbi", "parf", "config";
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
+			max-link-speed = <3>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 
@@ -871,9 +873,9 @@ pcie0: pci@20000000 {
 			phy-names = "pciephy";
 
 			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x100000   /* downstream I/O */
-				  0x82000000 0 0x20300000 0x20300000
-				  0 0xd00000>; /* non-prefetchable memory */
+				  0 0x10000>, /* downstream I/O */
+				 <0x82000000 0 0x20220000 0x20220000
+				  0 0xfde0000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -891,28 +893,30 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,
 				 <&gcc GCC_PCIE0_AXI_S_CLK>,
-				 <&gcc GCC_PCIE0_AHB_CLK>,
-				 <&gcc GCC_PCIE0_AUX_CLK>;
-
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE0_RCHNG_CLK>;
 			clock-names = "iface",
 				      "axi_m",
 				      "axi_s",
-				      "ahb",
-				      "aux";
+				      "axi_bridge",
+				      "rchng";
+
 			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
 				 <&gcc GCC_PCIE0_SLEEP_ARES>,
 				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
 				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
 				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
 				 <&gcc GCC_PCIE0_AHB_ARES>,
-				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
 			reset-names = "pipe",
 				      "sleep",
 				      "sticky",
 				      "axi_m",
 				      "axi_s",
 				      "ahb",
-				      "axi_m_sticky";
+				      "axi_m_sticky",
+				      "axi_s_sticky";
 			status = "disabled";
 		};
 	};
-- 
2.38.1

