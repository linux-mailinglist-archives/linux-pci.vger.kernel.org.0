Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763106B0132
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCHIZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCHIZE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:25:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9F55047
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:24:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i5so16978673pla.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aUzZ/pcEn/1nxh8BRkcTuBhIuZDyh9nbRz2zlNTCXA=;
        b=I0eH0eUJGUgPuYFk7U7Bwogfp49PNB4wxzP4/mHaym3hSuIZcIwHy1NKuDY1Hlxty3
         p6A/4DNM0lPqRgjwftjltU5HehRa5tuM+Yy85BejL1P60O0Pr19MgHLtPEIYHST7eYir
         10Bt5uV3DCB/pfN368Ck7m1UHBHhiXh2GZpsEpmltUWTkWFHEWqkdsyid4nvjPd18XLi
         ysl1KB7fo+72U02c5GEa/AR32i+GbMmeyRWeMSBODYXD4i5liAb2AE/q4+NtCtELcv7e
         A4hkbK0oy3JCITDtGkR9DTGAOc3IzD7Hvp2QyebVBCbJIEfzDTAivvjOXtd5LpsFjj8n
         /XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aUzZ/pcEn/1nxh8BRkcTuBhIuZDyh9nbRz2zlNTCXA=;
        b=ziDNtfUDNXGKYxFBAu/J/8anV9p46+DKoPuYnDP7bkvtiHrsYJ95XhoiFIOY7pnvR5
         PSvfQvFzza8sE+rpulNoKs46IScH5CUrSTaDpX0Q4aXplI9K5t9VPhyapRvcbAT5luZG
         FsHJ1qNsWYqJ6PJjY4wvTWLLXq1IKeMdDl60kMhL8qhOuOR8d5oIjGy1okH4Xsop7zTR
         rBVVVpJ+hwDpIW1hR7kuxA7qRvyMfRUmLgmU56QXgj7p4M3DF0Ahvca6G94pFaj0Uav9
         Qc4xKvONYF+2K+Llzmr8HRinALDUC1Ly1dnii1WodRafnOb2ENAnbjcX5uWK7xH90Vgz
         rvkw==
X-Gm-Message-State: AO0yUKUqvQwAhc9O7BTsTdUgAk2nyAt8FEJ4mY4KXqG6wHPJSiO23j/Y
        K0QnwoMyE80e8x+TXyK3U6BA
X-Google-Smtp-Source: AK7set8lcYYKxc+Rti7A/p6xxydtFMxw0aHkmXzEtIGShnv1dZ2PUgK6U7iaO/8SC5Zyh7OYcopneA==
X-Received: by 2002:a17:902:c10a:b0:19e:7b09:bd4d with SMTP id 10-20020a170902c10a00b0019e7b09bd4dmr15605723pli.47.1678263898769;
        Wed, 08 Mar 2023 00:24:58 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:24:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 06/13] ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
Date:   Wed,  8 Mar 2023 13:54:17 +0530
Message-Id: <20230308082424.140224-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is only one PCIe PHY in this SoC, so there is no need to add an
index to the suffix. This also matches the naming convention of the PCIe
controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts | 2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index ad74ecc2a196..81f33eba39e5 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -242,7 +242,7 @@ &ipa {
 	status = "okay";
 };
 
-&pcie0_phy {
+&pcie_phy {
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 7fa542249f1a..bd4edceaa1f4 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -335,7 +335,7 @@ pcie_ep: pcie-ep@1c00000 {
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
 			power-domains = <&gcc PCIE_GDSC>;
-			phys = <&pcie0_lane>;
+			phys = <&pcie_lane>;
 			phy-names = "pciephy";
 			max-link-speed = <3>;
 			num-lanes = <2>;
@@ -343,7 +343,7 @@ pcie_ep: pcie-ep@1c00000 {
 			status = "disabled";
 		};
 
-		pcie0_phy: phy@1c07000 {
+		pcie_phy: phy@1c07000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
 			reg = <0x01c07000 0x1c4>;
 			#address-cells = <1>;
@@ -363,7 +363,7 @@ pcie0_phy: phy@1c07000 {
 
 			status = "disabled";
 
-			pcie0_lane: lanes@1c06000 {
+			pcie_lane: lanes@1c06000 {
 				reg = <0x01c06000 0x104>, /* tx0 */
 				      <0x01c06200 0x328>, /* rx0 */
 				      <0x01c07200 0x1e8>, /* pcs */
-- 
2.25.1

