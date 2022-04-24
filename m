Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5F50D1FC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiDXNXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiDXNXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 09:23:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB0DBCB4
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x33so21931834lfu.1
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=wxjNhxSu1cOAeXUz1NDfA6RurOfh3RxSmKgHuAxyituc/XC7pxYJOSMpPVLl4S39+e
         Z4pgoOIEuis+tSWF4sFFBR/NBtB1oedJHlc6hclUk1xMsD4eSbaTkF61KW1HrTcsSULs
         jKZXQFkQQuedgYxyM4VFH50I6s2CimKXRRo4wM++eez+o4otZdlqEb+ms7ehQXmmdwS/
         fO/VfYRu+V71TWGq28Ijl+0Uubu4pPCm/SOFK+GnzaSUNTtRmM4O1j5HHpmX3/IiiO0D
         2dx/roxjE3GHKWgbnE0d7qqcjhjoiCztfzRp3QXwWi91rStmmfh1HTAIhF6n/9mFyt9a
         EtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugzBs2Kot7nDRgqzctSCPbKbp3TBExEgizD4VqmQZYs=;
        b=4gJEmZWF54HE4627yFV77oFaJZ65OfmSsmwIT0xjb2Wrxpaa4Cl9lMggqWTXYnohjn
         4/LODWYJ0QAH8KbkyYzSSVB2hXhHdd84Tja0RqMkcT8zoDd7IeHFQ/l4YVDsqapg78Qv
         wHQ/qJ06XPjyTEi/gnvsVMO5NWjrP/bX8N/mQOLuSoBvkOxutw4frgw6eHlaN5aeSL1v
         ay4K3WEE0AaPh0+7bd3FuS3FOzHkjBQ0QW5IjSO9tixpf4xcF6jj51UPJx9YPzLLpdrK
         uMSeb75lRRcrW7IjyxDEQ+GjW6nz3/csDt3onAY0SETrL9IYv6CdPyCE2BItKep8RSFH
         KHjA==
X-Gm-Message-State: AOAM531RPXgmZD/+UCtKxLw+H7omCqsJ6saom7pgmi5bHI8XKFJAxx20
        uhBOg+ovzsXdePOBsUTAxOxjhg==
X-Google-Smtp-Source: ABdhPJxAdluRACkgPt3HsP0Oqh6qv7tt5KORnXoVGmItASHTXT2Jr0bM3gIzmZIeVGs7b9k+Wb8djQ==
X-Received: by 2002:a05:6512:238c:b0:471:8af8:7d67 with SMTP id c12-20020a056512238c00b004718af87d67mr9898721lfv.97.1650806440523;
        Sun, 24 Apr 2022 06:20:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512332c00b0046d0e0e5b44sm1015877lfe.20.2022.04.24.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:20:40 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 6/8] arm: dts: qcom: stop using snps,dw-pcie falback
Date:   Sun, 24 Apr 2022 16:20:32 +0300
Message-Id: <20220424132034.2235768-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
References: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
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

