Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F306B0144
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCHI00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHIZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:25:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0FB2576
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:25:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1503258pjb.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQJpuyMO7No6L3do6sf/Hyh8x/cG+HXQS31simvwRLQ=;
        b=dZxg1CAelNmm3jMmmG/QhR2zOCkilkJgVekkRZC2c821qOXoNOX8isPquaa2KibZIP
         FPlFQyiwOLdOsF/f4duejnpaQFSkrORqcxLjb9ckCHIx8TnrrKraEl+HqdO76fNVE/va
         dEuSlnbwF2oXWYj/Yx/Gqe7WkODhRBcBQgftfts1w8NS0uvK+Mn1m0Y+Hw5Vmoggwmm2
         glUnEfZY4IqgfiSQ6Pecv7UOARPnbXEH8XoeFKnHruLkbweH6nRCk5tx3xy/CcygveYb
         j5aBIGg+HTc9+FIPzgasDoOZarDhMoG6kQbIBtT+XJPkKXcS5VzFDyVcMLl7JeArlncd
         Eq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQJpuyMO7No6L3do6sf/Hyh8x/cG+HXQS31simvwRLQ=;
        b=PzKwmPPMF0LzYjmUqjrJxwwpcnqqYnJrGk2cgGrKYOgG9/SuzP7bMnWsN5pAFrulGe
         4OO3FXDlkbyZnVJSSUfG79SaNGzpUZTIosyVhEbshSWgcncRNWwBmPW/+AWuRl6zXt+k
         wbL6SKzoM4so1A7VSFmeL+4/mCYP2p+lA75sspxLEert96ZT5Qe7NizQYq6FMFWZgtAs
         Mel0f5QwpFllUzZI2tCxRU4+W7mwdsdkssV3CPbli95ClzrGsE0khYw+rYfp3IdupgVk
         UonGy8LuIoOpTt7saP4jhjJPjcI3+mql6P/hbT+rdlf7JHLfzT/jew20voJO+2YHXXzq
         xj2Q==
X-Gm-Message-State: AO0yUKVTkr600g9U4reGvTOG/99FfU2b6by+tvrHtbNGapDNb1E9gzX1
        FhX7Fp3mA0Rbz9Pgha8oYCWy
X-Google-Smtp-Source: AK7set/MGu+yLUTnUKn3Isz//Xdy2WvlQQjBxO+mqV0OTaRRoJ+vXI6X/oZgqiccnjZACZAkSO4/9g==
X-Received: by 2002:a17:902:e549:b0:19e:76c4:2d30 with SMTP id n9-20020a170902e54900b0019e76c42d30mr22750201plf.61.1678263916357;
        Wed, 08 Mar 2023 00:25:16 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:25:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/13] ARM: dts: qcom: sdx55-t55: Move "status" property down
Date:   Wed,  8 Mar 2023 13:54:21 +0530
Message-Id: <20230308082424.140224-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To align with rest of the devicetree files, let's move the "status"
property down

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index 5edc09af8e0d..51058b065279 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -278,8 +278,8 @@ nand@0 {
 };
 
 &remoteproc_mpss {
-	status = "okay";
 	memory-region = <&mpss_adsp_mem>;
+	status = "okay";
 };
 
 &tlmm {
@@ -308,16 +308,18 @@ wake-pins {
 };
 
 &usb_hsphy {
-	status = "okay";
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
 	vdda33-supply = <&vreg_l10e_3p1>;
 	vdda18-supply = <&vreg_l5e_bb_1p7>;
+
+	status = "okay";
 };
 
 &usb_qmpphy {
-	status = "okay";
 	vdda-phy-supply = <&vreg_l4e_bb_0p875>;
 	vdda-pll-supply = <&vreg_l1e_bb_1p2>;
+
+	status = "okay";
 };
 
 &usb {
-- 
2.25.1

