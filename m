Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BD65FC83
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjAFIMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 03:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjAFIMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 03:12:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084780AC7
        for <linux-pci@vger.kernel.org>; Fri,  6 Jan 2023 00:12:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so581156wrn.10
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2023 00:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZChit4SZ+t74Z1lauaylK93+vgHZQXN9aZ0NlWhuSs=;
        b=HpBtQu2GClSSM2B7TEgboivQH02ii0IoAFcgvZNsqHtkZSBJ7FSQYKgzEZ7lxmZ7Jx
         ewJoVsNhj3rBJOqtzs1Kan/1Yjyu/n826wfVWG21GS9SH/yfAppou18TH1nxySieuu2p
         Ca99wH9PXRPIc2Y5kh/8ysVX793jwqKkNVrCx2lFE87hKaNmL/33ddR2HyS0MI8qvs/M
         zsasO4MqvBgY0Gg8QeW8j58AKUpRgRmsc5NXxP2P399+ov7HGTWpXN9YDKteswx6WtQE
         FEPN0Rbwe8pG97B/9xmpL3x6GvsfZ4obzK05nG1VsaAuH8c8mjetJDqY4J3X04Pq+zLn
         z8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZChit4SZ+t74Z1lauaylK93+vgHZQXN9aZ0NlWhuSs=;
        b=kVEk2UD8gqDLNHgLvCq16RGdwp9rD6t1PrUMvbJeK+lEXKFFASZe8pssqNHLkXMvYP
         HdOk58RCEKIn8qFvF71MtJVvvvLGUG/ousFiZWN+GVLYyO/J8dKcs2c+ZVSg3zsZpzMB
         Wlj4137DBvumi6AUDc0Ks9yZvJaLSgaIEMTxKyOwyDwVthMD9WTz8gGCOsyEgHQq8AQJ
         sA8Uz+PcM6nM7uLk9wc1MPw5wSTo0ab2n8ijR8TFPsZJTJYGSYefEUm76ZPAYLJl6tA4
         ezMqBrDhUzIBpL4nu2MT4K53d96dIbQnGuRNc7t3xqB7KUtZkrg7+m/BsIIRqiQReTic
         t11g==
X-Gm-Message-State: AFqh2kpkmS1YYaEvlzLvHDpGA6tnS/qR0+xKYfV6WKll1NDwVk+wKdR/
        bwSEWZ0XPQGHjtYTbLFrE/KdGw==
X-Google-Smtp-Source: AMrXdXsG2zv9lit5Hl81g3vtSOCu3Zp+W7x3IscChnM+Q5qA7PUkTJz6g+QkCH6Yn5zPD2nBgGOB9w==
X-Received: by 2002:adf:f0cf:0:b0:291:ab:1a43 with SMTP id x15-20020adff0cf000000b0029100ab1a43mr13729612wro.40.1672992727847;
        Fri, 06 Jan 2023 00:12:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t19-20020a0560001a5300b002362f6fcaf5sm451545wry.48.2023.01.06.00.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 00:12:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: PCI: qcom: add oneOf to compatible match
Date:   Fri,  6 Jan 2023 09:12:01 +0100
Message-Id: <20230106081203.14118-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Prepare for extending compatible list by adding oneOf keyword.
No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Split from previous patch as Bjorn requested.
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a5859bb3dc28..09a4e3c330f1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -16,25 +16,26 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pcie-ipq8064
-      - qcom,pcie-ipq8064-v2
-      - qcom,pcie-apq8064
-      - qcom,pcie-apq8084
-      - qcom,pcie-msm8996
-      - qcom,pcie-ipq4019
-      - qcom,pcie-ipq8074
-      - qcom,pcie-qcs404
-      - qcom,pcie-sa8540p
-      - qcom,pcie-sc7280
-      - qcom,pcie-sc8180x
-      - qcom,pcie-sc8280xp
-      - qcom,pcie-sdm845
-      - qcom,pcie-sm8150
-      - qcom,pcie-sm8250
-      - qcom,pcie-sm8450-pcie0
-      - qcom,pcie-sm8450-pcie1
-      - qcom,pcie-ipq6018
+    oneOf:
+      - enum:
+          - qcom,pcie-ipq8064
+          - qcom,pcie-ipq8064-v2
+          - qcom,pcie-apq8064
+          - qcom,pcie-apq8084
+          - qcom,pcie-msm8996
+          - qcom,pcie-ipq4019
+          - qcom,pcie-ipq8074
+          - qcom,pcie-qcs404
+          - qcom,pcie-sa8540p
+          - qcom,pcie-sc7280
+          - qcom,pcie-sc8180x
+          - qcom,pcie-sc8280xp
+          - qcom,pcie-sdm845
+          - qcom,pcie-sm8150
+          - qcom,pcie-sm8250
+          - qcom,pcie-sm8450-pcie0
+          - qcom,pcie-sm8450-pcie1
+          - qcom,pcie-ipq6018
 
   reg:
     minItems: 4
-- 
2.34.1

