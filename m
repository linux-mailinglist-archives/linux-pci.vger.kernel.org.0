Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C26AC565
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCFPfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCFPe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A4628D11
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:34:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u5so10764854plq.7
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnPVqWv6iSzBmDnxQc4VtSAKgeV8Xu0ZVFuxyGJ5/8Q=;
        b=h9uEWO6MOAu8R7oW01Eab9sj4rXAsIZfUU+xWyhcxB366lWeKzn7pv00CfbimSIrtX
         EeTW/z/YBT96JZGC68KsI+78UQXq+NXbC+9dxjwQYZOey5o251mVzlhzboseG/WerupV
         j/XdbgssE/pY1Z5Un3yjPGc2nHKiql3Cxkm4M58qHBqPIMEcZ53C3jDk87gomYNqLf8z
         bgc/I7GVjZAH07Nkk1tOLE2u60mK3kY58mG6IRHK4cpLQdwhZEz83CufpWPjC+Vrt+aX
         mq8z9eclucGOenuw9arhwubVCliOorgA7cRF5MCn3Ft8BxcB2zd4e95rlQXCrhHQFEmp
         IHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnPVqWv6iSzBmDnxQc4VtSAKgeV8Xu0ZVFuxyGJ5/8Q=;
        b=r0LkYBC5bxFNt8Do6lrESu5HimkvaJ2w8egMdzL0dAGHD+09FiNnivkWre3cokP25a
         3s3SWmUVTJpBDJN8MC+EQ0AsMZEgpQdvh04t/vr5h3ERuzPlbNEOcr7cRzCCNtPFeXbg
         RTCSGzz9IMtyoiYEDJvNdIlsF9Xm1nXKTzRr7hdA9V1/IEQ5PwjhkpEvBRBm2QtWNNrw
         APFqRST45BFsgQEuZQLMYbx35/7lSJFRsmcpYi2q0qiA3SPw1UWEjOSXYqz4D2zleGkz
         5SRG/fObBNpw25h9Xsd0ViMaUmjMFPoi5JdDzQfEvkBq8hnyE1BdovOOHmYfk4r5TBHJ
         Bc8Q==
X-Gm-Message-State: AO0yUKUSwDuYHxrfzVRy4vrEzMu8EA0dB9ziaYbIPv4L8SBLbNrybbBQ
        inAegdR6twWXxg+syMQhwZzy
X-Google-Smtp-Source: AK7set9zmvGkTRpSH11+q0AiJ5xXaYFf56ZC5NPxNyiv0IgCyLPG7CKjLpDvo4xSVw5x4EHOQctamA==
X-Received: by 2002:a17:902:ec8d:b0:19a:a9dd:ed3f with SMTP id x13-20020a170902ec8d00b0019aa9dded3fmr13880439plg.49.1678116831680;
        Mon, 06 Mar 2023 07:33:51 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 17/19] arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
Date:   Mon,  6 Mar 2023 21:02:20 +0530
Message-Id: <20230306153222.157667-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..1987ec97546a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1821,11 +1821,12 @@ mmss_noc: interconnect@1740000 {
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x01c03000 0 0x1000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
 			      <0 0x60001000 0 0x1000>,
 			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -1930,11 +1931,12 @@ pcie0_lane: phy@1c06200 {
 		pcie1: pci@1c08000 {
 			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c08000 0 0x3000>,
+			      <0 0x01c0b000 0 0x1000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
 			      <0 0x40001000 0 0x1000>,
 			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
@@ -2038,11 +2040,12 @@ pcie1_lane: phy@1c0e200 {
 		pcie2: pci@1c10000 {
 			compatible = "qcom,pcie-sm8250";
 			reg = <0 0x01c10000 0 0x3000>,
+			      <0 0x01c13000 0 0x1000>,
 			      <0 0x64000000 0 0xf1d>,
 			      <0 0x64000f20 0 0xa8>,
 			      <0 0x64001000 0 0x1000>,
 			      <0 0x64100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
 			linux,pci-domain = <2>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

