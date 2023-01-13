Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38216669E8A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAMQr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAMQrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF665E1;
        Fri, 13 Jan 2023 08:44:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so53646599ejc.4;
        Fri, 13 Jan 2023 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZtHSB0eCc8lOVuNfyokAmhYTSqa4Jdvmr66zlOUrvk=;
        b=ZrTOQtwAkJSneXkJZLjZKlc/0Nkl52jz7jsKdEpo5HfWRitKDqZKZWDXOMjmyQ5dLp
         9sVVZSdDXRSw7BCWZvdEnoph1YAPOD4UUW3fIN2AM9EAlhDBqd6icKLcGuCarC3cL7qS
         5p1xd7nSKKX1NvdgSksOP4mWvYx6K7RtHIk3Px4IBb7QybQbQ4KVyQLxndy7mKkhn5qC
         fCmuARsE3kttt/xK9Vh0ezsTZjiA6/Q1cN3orCieUyITDFMRxiGOu/M5dQNYZVUWrfXf
         3VMTpWzukj3EVBeDAMYZRmgPKuU8I4PryehGP1OE2DivKkdTmhCVlLZmaNCL/oNU/DOj
         kerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZtHSB0eCc8lOVuNfyokAmhYTSqa4Jdvmr66zlOUrvk=;
        b=wHN4uvtylIA66nbOVhdRTI+vthE7StcVWt2G6qDHwDCkli+KowC5rQt7yOKM6JbUGu
         TT7JOfG264VVNEnvvMyZvxer8U9RFH9vyTLxBMbovAY4a79NZfeWRnJ7D/4rZyf1h9BQ
         dln4yREZuetvb2w76RKJJTM07L8yv0E99diFRUyM6zFuXk0ejlH26e1lEZa8v0y090aa
         nxCXvg0yjr1cCwO7jb9mdGDIsYxDn5OG31FJyPqonMrXnLFnMReicCFnPHE+MTBkf5Kz
         H9rhsbcZ5WxIM3W92HTU9lbRLnBPwFoK9rf6bPieRvcTwyGQ10I1Xsr5HqAWUolYf2mu
         t+gQ==
X-Gm-Message-State: AFqh2krKG10tmSOa2E7fkhyFbvT0wnwQ4fg+YHfNFsdx4AcW8ywRqW40
        U908Lsv6tPti4Z7KHthIaOI=
X-Google-Smtp-Source: AMrXdXv9i5QiJy931McagquuWcZOzuNb//Nlso6EjfyMxHqIRj4RFhCBKMt9Z8Da2FFXnBLkJzBikQ==
X-Received: by 2002:a17:906:99c7:b0:7ae:b637:633f with SMTP id s7-20020a17090699c700b007aeb637633fmr92461686ejn.4.1673628293556;
        Fri, 13 Jan 2023 08:44:53 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:53 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
Date:   Fri, 13 Jan 2023 17:44:42 +0100
Message-Id: <20230113164449.906002-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113164449.906002-1-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
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

Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
by fixing the Gen3 QMP PHY node first.

Change the compatible to the Gen3 QMP PHY, correct the register space start
and size, add the missing misc PCS register space.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 31ec24100213..c93e3f39f33d 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -232,9 +232,9 @@ qusb_phy_0: phy@79000 {
 			status = "disabled";
 		};
 
-		pcie_qmp0: phy@86000 {
-			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x00086000 0x1c4>;
+		pcie_qmp0: phy@84000 {
+			compatible = "qcom,ipq8074-qmp-gen3-pcie-phy";
+			reg = <0x00084000 0x1bc>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -248,10 +248,11 @@ pcie_qmp0: phy@86000 {
 				      "common";
 			status = "disabled";
 
-			pcie_phy0: phy@86200 {
-				reg = <0x86200 0x16c>,
-				      <0x86400 0x200>,
-				      <0x86800 0x4f4>;
+			pcie_phy0: phy@84200 {
+				reg = <0x84200 0x16c>,
+				      <0x84400 0x200>,
+				      <0x84800 0x1f0>,
+				      <0x84c00 0xf4>;
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
-- 
2.39.0

