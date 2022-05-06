Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1651DBD5
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiEFPZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442795AbiEFPY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:24:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37E6D1A6
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:21:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 16so9636740lju.13
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=Zp2ysFM3Uzv/KuddhYKpFjvz+IuqlgjoCF4JqdXCxAPyM0NEy0l2YchkO9y1yn8ac4
         OCCOZgHKPtr8c9QH8fB3W0+2/yxvMODGOHJ1qIUEygOL/Fje1LBQf4/axm2L+4aTbFkS
         uRhcCe8FeVSL8nXb25g4REipupM+p3tAcIQxJuNpZ5ofc3x6dDoEfVdT7QDWwArbG+be
         GXTJjmNfF7CCC/p41fu6sb183WfQwxlHOVwKz+x50x96sz2WS27ocr58qPB2FjxIIan0
         Fi3FXFS1ApRuMYTp1EyL8fNRD72gCOhwhupg9RGbhhmJvBsysLhRrvJc9+7dgRpbuH/w
         9q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=MaKEXdYPYHTKGu/CXYAWTCPvaco0aYq36KV5q/BLIc3EGLdIXCL88DKsgH803CmhMr
         81tuTHz93I5ZETNwbcT6YkRMkXsZeln7L6S7xGK7vHoBIGns5lL5KnjiWyzdu82DjV+U
         JAQEtllSSg5ClepLlHKl6QOAtSl7B4RReOZ2WONqr/F7+4SR47OgajGc1unmVJhpGysW
         e7glNR2joGcCMNgY8EvNIQdzyV8Zu88Qwso0JdwHXph1a7/fYStF8HqCVTZ7OHvbuk9b
         zGKzRPfgKV+R9dPBi8DkrB89vq9kKYVU1D3VXzlH8nmCbe3y1qNT7WwKBTzGsHvposkM
         Z+5w==
X-Gm-Message-State: AOAM530pzJ2FwaSAvCgHbAx1CkpH4iMgRkyWcNAylBXc5qg2LfA3q6Qc
        +/qvJva6sNu5JAXRD247FsF+aw==
X-Google-Smtp-Source: ABdhPJw64hVS5mtQUWW+M0u9e8RHz3spw0sfuVJEIcsWszSwVq3yDfwdG5lk7cWsiaaGvws5fEBjIA==
X-Received: by 2002:a05:651c:10b:b0:24f:24a3:9dec with SMTP id a11-20020a05651c010b00b0024f24a39decmr2306581ljb.144.1651850474009;
        Fri, 06 May 2022 08:21:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0047255d211e6sm716757lfu.277.2022.05.06.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:21:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 6/8] arm: dts: qcom: stop using snps,dw-pcie falback
Date:   Fri,  6 May 2022 18:21:05 +0300
Message-Id: <20220506152107.1527552-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
References: <20220506152107.1527552-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe devices are not really compatible with the snps,dw-pcie.
Unlike the generic IP core, they have special requirements regarding
enabling clocks, toggling resets, using the PHY, etc.

This is not to mention that platform snps-dw-pcie driver expects to find
two IRQs declared, while Qualcomm platforms use just one.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..ec2f98671a8c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1370,7 +1370,7 @@ gfx3d1: iommu@7d00000 {
 		};
 
 		pcie: pci@1b500000 {
-			compatible = "qcom,pcie-apq8064", "snps,dw-pcie";
+			compatible = "qcom,pcie-apq8064";
 			reg = <0x1b500000 0x1000>,
 			      <0x1b502000 0x80>,
 			      <0x1b600000 0x100>,
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a9d0566a3190..1e814dbe135e 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -412,7 +412,7 @@ restart@4ab000 {
 		};
 
 		pcie0: pci@40000000 {
-			compatible = "qcom,pcie-ipq4019", "snps,dw-pcie";
+			compatible = "qcom,pcie-ipq4019";
 			reg =  <0x40000000 0xf1d
 				0x40000f20 0xa8
 				0x80000 0x2000
-- 
2.35.1

