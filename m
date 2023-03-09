Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEC6B1EE7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCIIw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCIIwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD21DB6C8
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:52:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y2so1457498pjg.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azG6rPTW4OW7MpxRM4BYmIziHm2wpGO0S0WPmax4BIQ=;
        b=VyO2wS084cTzHIL+VWzaZ8BWipwRs8FOF7o0JZPwUb92UBTn7M/ZCXJCQ/+GRd470G
         jB6+qw04l5RtWA7jxVUGB1BT9LcIEcOotiBwjSQ+BBPxFEANnzDXgo4lhIkTy5DWKdEz
         BnvSYTJiDfRclN7FfnQ89/hxxVPh3hVS0t4v2UGZ4PwyMqEy8lAuqzcObDMzTp1Sz0II
         6ep4dvEKHlda9cfsWNkcCSkcqkdDmE3KbcDD52kQGMqs+zY5PvYYtLKWR/co25Ki5FWl
         jkgV/azFnnQFtdv9gNHnRgziU+eBWXB/oQd4uCnVEClXmvhWLX6zSxCHg5LCLfi+xNcy
         2Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azG6rPTW4OW7MpxRM4BYmIziHm2wpGO0S0WPmax4BIQ=;
        b=u+1PCIy435ii7yIZ/GOhPYVUrXsHAV0XMYH5u7tfkFD+kpGbX1dmbD1ZeqaGK+OJ0v
         3/YvWE4ctGtz4CX0ZlzhFhkq0IDc9Vd9g7t+SIQ92Mgb2I9g22lw79ne/EYp6VMH0gxg
         VWK0Dn37f31m/+1y6nYU9rQGBKCDy5UKAHRdTSOgeKu/eXp+MrjljWbVPaKfmOPn4mPG
         7QjhZd8248urh/yocBPPsjDp3NopPXVnfNyQ1JV1AFlVHMdhLzRrHaWQ6507w9hyacHJ
         Sg3EYMsuJaA49XWB1w4GrSCMGCgcFhRMqDSGXm9TukWDepMQcM6ZmhcUXHvUl0FpkVQx
         eROg==
X-Gm-Message-State: AO0yUKULQLMT1Ycmj5CM6Y2Vfe3vb5Zz4Vr2Dx54HWCVXLktj9NVhBVR
        jbjVj7cYqGh22y1a0i1qms63
X-Google-Smtp-Source: AK7set8PYiCnyvJhnsHH8tOo1umPPvBe9UaOiijVqpgb4cjgv4j+dRYQ0/I4/ZUCUh2xSyVKfDjKEQ==
X-Received: by 2002:a05:6a20:7d9c:b0:cb:a64b:71d3 with SMTP id v28-20020a056a207d9c00b000cba64b71d3mr22599598pzj.26.1678351931047;
        Thu, 09 Mar 2023 00:52:11 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 14/17] arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
Date:   Thu,  9 Mar 2023 14:20:59 +0530
Message-Id: <20230309085102.120977-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..46caac9acc95 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2282,8 +2282,9 @@ pcie0: pci@1c00000 {
 			reg = <0 0x01c00000 0 0x2000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
-			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c07000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -2387,8 +2388,9 @@ pcie1: pci@1c08000 {
 			reg = <0 0x01c08000 0 0x2000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
-			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c0c000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

