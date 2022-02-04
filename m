Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D54A9B38
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359412AbiBDOqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359407AbiBDOqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874DC061401
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id l27so8310695lfe.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEdow9qddiDDi5ISDFCGH7oeKbC5mGu6c1RrTKNWX/Y=;
        b=pxis1hg/jlw5nQXur7Gh7MiTW2H9lfVjjHk8A47b24zGh1f7tHppvK+MIUPUY4OY8n
         Dx05ufn+XyCnJZbceeUFgovtuRPY2k1gDGOhq2ioYQHyomz3Rnp0h9kd5hKVSvBQzfPP
         PL3F0T6kZ2h58IXCz9UMvkAG7VlLVxmBXuQ1KfiIpmjj3DOuDJd9/C+fGcN1xkhG86Ai
         TViDoAn5mTZwF7UdV7ijPvQfKfKC3cSfVYeIiEeWyoHH5RSU23DC7rjz/r1XPqN+1QxX
         8WTg7EHgjBkAbSs/ydMNae2elZdfh8ERGf9tdm9zE+8RPl2czDFrvQk3Ls7ik/DBEYu0
         r/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEdow9qddiDDi5ISDFCGH7oeKbC5mGu6c1RrTKNWX/Y=;
        b=0cX1hbY2Y9d8koPLCT7XmzIDou0sd3YdERf721+q3yxwwoWeG3zkFXPGCgO2Z+U6RE
         j1Oa7up5LqM8PE62c8WRwVz+FcELwTRPJowIzoqwifwHBRrj7VwhOejbpESXfE9g6fCP
         eS34uC8YRNUkC+UFsWXjzyEXsCNgZVP/Q+c5CZsjQYqxGjkp9/Y+g5sOT/xCfFBNTUQ3
         nn6S9vFvo931M67I1WM9bdFQSE/2t2tN/ip02ok1qtrSUC3aMKmEix67LLIAAgwjkzol
         +DD2KeV55FwN1xIlRYcAhTPOoYJvFvVnyB9sMnbhj3uMibdXftaqYb5PpXFe5MaimGPx
         JJOQ==
X-Gm-Message-State: AOAM533pnnT3jWz4ZOaaT95sk2QnfD75vwXg9u0M9th6Nz27CKX/IX+5
        HCPzV8vZqkSyv3c4XOs2Iapfk8PFoPWliw==
X-Google-Smtp-Source: ABdhPJxuroIeSr4dcdPBz5jQ7IC0iZSdzhMqVc+7fGNygeMObTcH4hddM7moDZztQ897nFdhKsNRFw==
X-Received: by 2002:ac2:5095:: with SMTP id f21mr2484888lfm.20.1643986008900;
        Fri, 04 Feb 2022 06:46:48 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:48 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/11] dt-bindings: pci: qcom: Document PCIe bindings for SM8450
Date:   Fri,  4 Feb 2022 17:46:36 +0300
Message-Id: <20220204144645.3016603-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8450 SoC. The PCIe IP is similar
to the one used on SM8250, however unlike SM8250, PCIe0 and PCIe1 use
different set of clocks, so two compatible entries are required.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index da08f0f9de96..65a1fa74e4eb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -15,6 +15,8 @@
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
 			- "qcom,pcie-sm8250" for sm8250
+			- "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
+			- "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450
 			- "qcom,pcie-ipq6018" for ipq6018
 
 - reg:
@@ -167,6 +169,20 @@
 			- "tbu"		PCIe TBU clock
 			- "ddrss_sf_tbu" PCIe SF TBU clock
 
+- clock-names:
+	Usage: required for sm8450-pcie0 and sm8450-pcie1
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"         Auxiliary clock
+			- "cfg"         Configuration clock
+			- "bus_master"  Master AXI clock
+			- "bus_slave"   Slave AXI clock
+			- "slave_q2a"   Slave Q2A clock
+			- "tbu"         PCIe TBU clock
+			- "ddrss_sf_tbu" PCIe SF TBU clock
+			- "aggre0"	Aggre NoC PCIe0 AXI clock, only for sm8450-pcie0
+			- "aggre1"	Aggre NoC PCIe1 AXI clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -244,7 +260,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845 and sm8250
+	Usage: required for sc8180x, sdm845, sm8250 and sm8450
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.34.1

