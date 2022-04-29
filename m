Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD785156D8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiD2VeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbiD2Vd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:33:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80C3EF10
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:30:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h29so8932186lfj.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=CZa6IlHM6sDWYwNhSiCpej3A4HOjIyS5Jr1tuYKmMfrebr7nCc6l0aHxpy+t9zJ1lW
         Tk3VCfehWJdgleDI0Rg615ShpDYV0ZF/sDiDAyMQ1+9ftzOOmzumGmhPqJ+5sJPHoQNU
         B4f8DRCGrFV7JBufEiQ0LwNkOq9BnyCtcye7vHs5Tp1XElcJ5qPVEDgk5zaOk7grHgAi
         GSib1aEOZi/BvSMAg3h3V4WJG3YqGf3cP/W4xBYSFmHkIDfZFUNFubVku+C7AMp129XH
         /XT8GeOIb7JPTPgJPSxXRyEW/cEMLVTXr8lHcY4VroKQwA3BkZbXYPsa2jmeS9yFje6E
         iPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=ijevsYprpwfjASC9spIXqBEwkb0ZS8UEzHhWV5zO/SEBrfaRrBPgN5jBPWoXEFSeVY
         6Lk++SA7wakkEDLRD4EDM7cLNGD3Ux9N0B5jDXN+zCeHqGSZo41W8BXEDu+2RIsM8GPx
         8gMJH1J3VdmfM1Jv0jl+1xhBW0KB4HBQKqF2MLMFIH0tUJpl1NIFMxwA+gmjpFlJDYhl
         lKkxAaQt4exBVMV4ocIWvMzoS3wfjzW2EZmw5Gell5mJKAfCH8rc9IX9NatsThSHd4XP
         RmaQnGITYfWint/iDsxtLUeoDp7K3OR48VlujYVVDHMo4jbYxnglB5InjNvkVNcUVfGV
         eqvQ==
X-Gm-Message-State: AOAM5320VaNom/elTrgzCAYt3oQfhbZ2x8Y9J4gfnlMwTLcJWdMMKOz3
        cOcRnD6rTeXHuuF0Cc/2rSJp1Q==
X-Google-Smtp-Source: ABdhPJy9d0lOHXenQekeWcRpWYrCSeoA5+q/jJO3QjP/AI5sqHBJOqEgMm/Lid173+xj5lzx/IBokA==
X-Received: by 2002:ac2:4a78:0:b0:472:2106:4b94 with SMTP id q24-20020ac24a78000000b0047221064b94mr837454lfp.632.1651267837692;
        Fri, 29 Apr 2022 14:30:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 11-20020ac2568b000000b0047255d21182sm28589lfr.177.2022.04.29.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:30:37 -0700 (PDT)
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
Subject: [PATCH v5 6/8] arm: dts: qcom: stop using snps,dw-pcie falback
Date:   Sat, 30 Apr 2022 00:30:30 +0300
Message-Id: <20220429213032.3724066-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429213032.3724066-1-dmitry.baryshkov@linaro.org>
References: <20220429213032.3724066-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

