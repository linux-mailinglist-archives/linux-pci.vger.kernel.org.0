Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93115509D94
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388343AbiDUK0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 06:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388298AbiDUK0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 06:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D622509;
        Thu, 21 Apr 2022 03:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ABF3B823E5;
        Thu, 21 Apr 2022 10:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3918C385AC;
        Thu, 21 Apr 2022 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650536613;
        bh=mHz5AgVnSrTaGOXojcB9hqQaqAnullRbzrWC0LxA+34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf4bONYIYSzcRnbOsffSWTKg0KeT6uacWY5b7ltg3atcuxm8YaZbk3QeXhQMtW3QJ
         VzAGHV1kO03iO43dr9ete/OH+Dbq9rl54qLBZQ5Tbx5uTJWWcCiZaSz7KNTzrCq0Jm
         sFec/tTzfFT3zYvOWqaV4TgZDfPPYUgrAF5FanPFBY4+CFJpedG3GpDtRx/HlkncWw
         +Nex6h1hUgDbKNgexjx8VJjtBHLdjcdAWf1tBAD6jMPRLMpcT4ZXyPnnv0s9g/59M+
         W115TExH4IGGSKrQAQdARgPSwCYKDKfJuz5HTt0dTFBcNQKlU5e4JCjpex28Sl8mAW
         onPCbXwZCe28g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nhTyB-0004Xg-D9; Thu, 21 Apr 2022 12:23:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Stephen Boyd" <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RFC 2/5] arm64: dts: qcom: sc7280: move pipe mux handling to phy
Date:   Thu, 21 Apr 2022 12:20:38 +0200
Message-Id: <20220421102041.17345-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421102041.17345-1-johan+linaro@kernel.org>
References: <20220421102041.17345-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The QMP PHY pipe clock remuxing is part of the PHY, which is both the
producer and the consumer of the pipe clock.

Update the PCIe controller and PHY node to reflect the new binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c07765df9303..b3a9630262dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1837,11 +1837,7 @@ pcie1: pci@1c08000 {
 					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
 
-			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
-				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
-				 <&pcie1_lane 0>,
-				 <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_PCIE_1_AUX_CLK>,
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
@@ -1849,11 +1845,7 @@ pcie1: pci@1c08000 {
 				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
 				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
 
-			clock-names = "pipe",
-				      "pipe_mux",
-				      "phy_pipe",
-				      "ref",
-				      "aux",
+			clock-names = "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
@@ -1910,8 +1902,10 @@ pcie1_lane: lanes@1c0e200 {
 				      <0 0x01c0e600 0 0x170>,
 				      <0 0x01c0e800 0 0x200>,
 				      <0 0x01c0ee00 0 0xf4>;
-				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-				clock-names = "pipe0";
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+					 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "pipe0", "mux", "ref";
 
 				#phy-cells = <0>;
 				#clock-cells = <1>;
-- 
2.35.1

