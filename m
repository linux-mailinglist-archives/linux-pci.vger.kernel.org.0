Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FA51DBC8
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442780AbiEFPY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442763AbiEFPY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 11:24:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAF6D18D
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 08:21:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so9642572ljb.7
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P98aaXGwL3b1m6mq4eFpKJwxnMXt6/C7TocV0oqvV0=;
        b=knuo8wqF5pqzn+4NAPgwyOqQ1rwNbSkCHcqfHq5jqhD1/l2ceZYWmK+dCv3h8WnMyv
         HFoaOwCMd5yTANPk8DG/RiJ4nShWOCr0kcdtMkT6vJYKKfiZlQGs0HT+yx1WkuSssYFl
         NDQ8gzAj9n/E+dANMt87WIv4LXp5d1iJUGXgfpmZ4xun2gDKRaxWXOst3ksYC+czXSvQ
         3i/iEfSCXtPRO3Sh4nEVHREUY8K/BoDxueVbO90DqmdTGYNITgEd4c0SK4UuzA9DFhM0
         TTkonUC/APfi8pFWbvtj75zJ2FMdVMt1k+THO6p3hDhDDK3qBX4qfLlPopAJW95Yf1p0
         2sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P98aaXGwL3b1m6mq4eFpKJwxnMXt6/C7TocV0oqvV0=;
        b=e5yh2cO6JstTDrNb+WLWv+PznS6bqSb5M6JMoNNBe0Bw5Gym0fO0sXx3wokc3y+YbO
         KY9s0PtOTWkHO5btTy4mIHUxKnGec/EvQHZWQf0jt0QZfxVI8GZSSEwM9Y5+uoFYuonL
         i/uOWDjLTXCsscDD7IH+4q08XlF+umH6k0A5hi3uKUzm+IwiTWfEpDOtbFyF2M+Scy1i
         6bYSDPfKpVRnFPKXHdJkSBNpnV6CwOsl8fjkWFMG8dNnR6KflygV/xwMrkxKeNlRfKma
         Lsh2VBRBCmdMdy1XrB52PvDAuAnhhW24ygjvZiH1Hf2pLC7MYpQ9tMQ8rcZuZbOS11P7
         myKA==
X-Gm-Message-State: AOAM531oz0TYn+aq5BtHbWJf2CXZ0VET7nlKUWZdC4XDJi3Q0g06rgF1
        echxEd0I5+8WxO8LvEY9kPBRrg==
X-Google-Smtp-Source: ABdhPJweEOnMbZ1HD5lGU7pRgs0TWF6sKxuvH1Bk9MEcZ0O2Z1iLtnKqy500GoFPGwT1w9zFeMFZNQ==
X-Received: by 2002:a2e:a911:0:b0:24f:41c7:81d7 with SMTP id j17-20020a2ea911000000b0024f41c781d7mr2305828ljq.309.1651850470737;
        Fri, 06 May 2022 08:21:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0047255d211e6sm716757lfu.277.2022.05.06.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:21:10 -0700 (PDT)
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
Subject: [PATCH v6 2/8] dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
Date:   Fri,  6 May 2022 18:21:01 +0300
Message-Id: <20220506152107.1527552-3-dmitry.baryshkov@linaro.org>
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

On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
resets. So move the requirement stanza under the corresponding if
condition.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 16f765e96128..ce4f53cdaba0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -114,8 +114,6 @@ required:
   - interrupt-map
   - clocks
   - clock-names
-  - resets
-  - reset-names
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
@@ -504,6 +502,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      not:
+        properties:
+          compatibles:
+            contains:
+              enum:
+                - qcom,pcie-msm8996
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

