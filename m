Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCA50B684
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447177AbiDVLvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377515AbiDVLvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:51:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7C56411
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq30so13853096lfb.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKXTtjYFcEQgI7OAk+AWDIKyBY3JD30G/f2vgibUKRc=;
        b=G1RmDSwcEXWaf6CLdiuS25imj1oTo1y3LajZ9q5tiLycYgie5G43xpSReOQXuv6vA7
         Ys5+PszyP9TnQNtRyAHCozPPuVuX5/LS1ZaU57WDtRIopEJQA0CEs3MHMdNVT1HhxjmC
         Wm7M50uzjUtoYYHgrKqf/+xiX5LC4YJp8kPG4wOKd6UnQWVlcJw60XWWD8bJW9OM8e3y
         Qa4+Mm98DBXbqLJiPZPvaw/pAwvn1efJz1rpd4oHw4ojZ/fTyGvDOJQrFOdV1DZ+sb5N
         bCWOb31kQAgFLCugJqi7IkUOhGzy4oPAUsInDJAuR5HZGCpZQTMXy2hVJbFWxm8SsykR
         BuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKXTtjYFcEQgI7OAk+AWDIKyBY3JD30G/f2vgibUKRc=;
        b=Sr8wRjrtZEXcyfDizDkH9nw/SxZRqFKob7xZfEy65RLsolI78naWpYqqOT/X4Dan6G
         +pQl7VrfV7UZfoENhye0iQwKEtmxDXpEa8bcmGhZxoA6O+RzUSnAGsIy4bM7+gj7h+AC
         QtYIpd/E1WH3xy1/lwD9GsknzKWIRcRAqsY3T3BDX+Uj8bhTkEB06QA9aQRskF3t0Wd2
         Zwypkz5bRcCbRkLRLqOX9sD9/SOpZJYr38XMtEFRdzMaqAcDc0BBUACF+Hx3vlhq1VtG
         3ahFkK9gcRGSPfJG5MO5vVtxXjLX7kqx1gDqbxHrObdTmWw1BO290leIsr+xOvoVLOo+
         axiw==
X-Gm-Message-State: AOAM532m0Oq13dEHvb2M53N+cGRMKD3us+buPw47Rhm1mYj16QFQyEGV
        xFt4kOXjtic2naNcqGc9xmpQLw==
X-Google-Smtp-Source: ABdhPJxJlRycBOH0SGbmLkwM5l8/ghLzeYkLfMVbvmWZHm1gzTpFRsw31SkpUA29oEEGuocfYdwLUA==
X-Received: by 2002:a05:6512:b08:b0:46b:a876:3009 with SMTP id w8-20020a0565120b0800b0046ba8763009mr2795050lfu.378.1650628130825;
        Fri, 22 Apr 2022 04:48:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.65.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a19ca47000000b0047014ca10f2sm200695lfj.8.2022.04.22.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:48:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/6] arm: dts: qcom: stop using snps,dw-pcie falback
Date:   Fri, 22 Apr 2022 14:48:41 +0300
Message-Id: <20220422114841.1854138-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

