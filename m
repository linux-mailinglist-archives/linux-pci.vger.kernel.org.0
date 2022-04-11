Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5134FBB4C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiDKLvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiDKLvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 07:51:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271973150B
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 04:49:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q189so3168758ljb.13
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eESjoF/yD4mP6nt9I6fZ9Aubyo4jKSZWl7CbAxzr1/M=;
        b=smrvIM+Bfh5TSXLvKCzzLs2rdgyVfJ5mmbqUmdTkDBUqKF7RNrQ+Kfn1A5l2LZz9OS
         qgLO9AGsBxJU/r25QGDZEBAxP5EkeZOMJnam27a6FbFo/jAS54S48Kjx9/6BzrpCBOAC
         C6YFlBT/T2qr6mtoyI3ecizHLMm1mIzeocwNKaWvoKa7nZ2IHSZahJtqLv2r8PBExHXG
         YwmCFV3Pns6goP9aWGEhxi2y9kgtk55nyZAN04NXrqdOwcdoCfNFsbxmYK38OhH/plQb
         us0qWaXwtqnqpdvUSBPI0lvp8TKNwfAhPo8SdDPg1j6VVRphj4LiZ0zzNyKfomWRFVa9
         DBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eESjoF/yD4mP6nt9I6fZ9Aubyo4jKSZWl7CbAxzr1/M=;
        b=Ch3DES4zCt9U6LI13sDwVw1S5xAxMprauVDu9dKmtrS+WH1zWujpde8HbsvU8F994m
         J3kNq8e/jeam729z2PcHblXGI/miTB9hWUvey+ijJ02N5VZDRNERZb0sH8qVX453hLMl
         p2mvW49hWltP/xLwMuPAtEQo9IjFOu2ZmIWGTaF74hWkKsKb/9CoygbuCubL9lEyX1BM
         DNIdpb9jxFkMGPoGNSs9OjOTAvN4l/2p6kCnxg622w6odMPa5tI4nDnh+trPaubwdp6B
         kC46PFKi5eweJ34LAfbPY2z+Mgjpq7FPk+oB3XZzIMKjjwr+JOiwmUaJf/MspJhNl1M7
         WoaA==
X-Gm-Message-State: AOAM532QqtacGyMddp0oqmjQ7AfADVaKPFV9m40HVYb7iuiU79mj/XCf
        xY1URArz4huVJ5PCqLoTx8ybWw==
X-Google-Smtp-Source: ABdhPJxIK0qZTCFCLW26vzSaRI0RzmjUiuSoXche75zHJY6tQMFGWiHN6fIOu+wi8RWw4oOSgMr+8g==
X-Received: by 2002:a05:651c:d4:b0:24b:44f6:9558 with SMTP id 20-20020a05651c00d400b0024b44f69558mr13155987ljr.26.1649677770425;
        Mon, 11 Apr 2022 04:49:30 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y21-20020a05651c021500b0024b5d56484dsm587973ljn.83.2022.04.11.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:49:29 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250: remove snps,dw-pcie compatibles
Date:   Mon, 11 Apr 2022 14:49:25 +0300
Message-Id: <20220411114926.1975363-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411114926.1975363-1-dmitry.baryshkov@linaro.org>
References: <20220411114926.1975363-1-dmitry.baryshkov@linaro.org>
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

On SM8250 PCI controller bindings are not compatible with snps,dw-pcie
binding. The platform doesn't provide second (global) IRQ, it requires
additional glue code. To prevent it from probing against the dw-pcie
driver, remove corresponding compatible.

Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c45e5bde4284..a7a7375893cc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1790,7 +1790,7 @@ mmss_noc: interconnect@1740000 {
 		};
 
 		pcie0: pci@1c00000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c00000 0 0x3000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
@@ -1889,7 +1889,7 @@ pcie0_lane: phy@1c06200 {
 		};
 
 		pcie1: pci@1c08000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c08000 0 0x3000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
@@ -1995,7 +1995,7 @@ pcie1_lane: phy@1c0e200 {
 		};
 
 		pcie2: pci@1c10000 {
-			compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
+			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c10000 0 0x3000>,
 			      <0 0x64000000 0 0xf1d>,
 			      <0 0x64000f20 0 0xa8>,
-- 
2.35.1

