Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D186B013F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCHI0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCHIZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:25:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F9B1A5C
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:25:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l1so15851511pjt.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfPfJbuBCr/z6UPf30LbgTiprhegyjugmOR3U4nPOZw=;
        b=JzrgFsMkZEbo/x9XSaSLYAe3Xh0Ys+qsISvV8tYJb1YGAkQL1+CAgyekEEDsUIsPI6
         iaegsZRji2odfHxrMAnzaRtslPruxPs/i3tMqJoMrKFfL6ADGXfB5UvR80s6BXm8tK7U
         CjNyNJdShcE0omGpLz+KWJPgCaGD1Rvn5fmd3PEYED9ZSrr7sGaLvpl/D/hB5HHEDNvz
         Kxtu6WNVa0GjT3O4TtJP59xFfzguORhj2CzPWkLxhYmHTph8qGeH+uPRMsKF58SyHDbC
         yG7tpeWMzXzcT3Tx7GKIFC0kSL4FfmMbnXJG71GP6oQIZ+8sffc9ykpKGql0zCiBN0NR
         a9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfPfJbuBCr/z6UPf30LbgTiprhegyjugmOR3U4nPOZw=;
        b=MrFKizHCDghFBq30ob78aCdm/rSu3zVxUvC1p7kz0g64FzZrCVNyu3kxD7Lwlisqja
         qtf+ZUWks7AhBTWbWxMTthy0fP/POiGf/9z99Igv6gCmnsmrPXxbNBYZQCdriysiB/pi
         X2BEVLbwDcHV62kDiSbvDN6zWfTvRq1TYiEVIYVhhpJ5bH/XHoZh+nX+uj6wAf+dE0Kw
         jw+Sef6Hz9Qd/PGkTqUHDeJsHlrPPBqKMVxFnA81+DSbhergRjz65ZjF4gNDBmjrsKNI
         A7+GRTKW8axJnuY167FBPPlZlUD2fLaSKawEe9YaJMI/MXT3GUlZxgtP6SEUdpwz8VWI
         MXPA==
X-Gm-Message-State: AO0yUKXNIulPtmYX5ULdQBMIoe0d+Vqy47HisFV6M69SfB7u76ywSS7A
        0MPzU58J8AZ4ihEMo80h4Dgr
X-Google-Smtp-Source: AK7set/L1dsF97m39ajoh8yMTStHAFCR7t7AZ4VJpnF8cskdN97rs2QONWSB8stY+iDUtg3E0onT5w==
X-Received: by 2002:a17:903:441:b0:19a:b5cd:6e73 with SMTP id iw1-20020a170903044100b0019ab5cd6e73mr13939201plb.3.1678263911955;
        Wed, 08 Mar 2023 00:25:11 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:25:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/13] ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
Date:   Wed,  8 Mar 2023 13:54:20 +0530
Message-Id: <20230308082424.140224-10-manivannan.sadhasivam@linaro.org>
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

Enable PCIe RC support on Thundercomm T55 board.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index d5343bb0daee..5edc09af8e0d 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -242,6 +242,23 @@ &ipa {
 	status = "okay";
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
+	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
+
+	status = "okay";
+};
+
+&pcie_rc {
+	perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &qpic_bam {
 	status = "okay";
 };
@@ -265,6 +282,31 @@ &remoteproc_mpss {
 	memory-region = <&mpss_adsp_mem>;
 };
 
+&tlmm {
+	pcie_default: pcie-default-state {
+		clkreq-pins {
+			pins = "gpio56";
+			function = "pcie_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio57";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+		       pins = "gpio53";
+		       function = "gpio";
+		       drive-strength = <2>;
+		       bias-pull-up;
+	       };
+	};
+};
+
 &usb_hsphy {
 	status = "okay";
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
-- 
2.25.1

