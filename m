Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248DC695EAD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjBNJPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjBNJOf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:14:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE423D8D
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 01:12:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id rp23so38381192ejb.7
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 01:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpI7lJpz9IKYSko58dc/btZymelWFdQOcnxveP1xg7I=;
        b=dD2jB4Fsd3SIPlFoFZzG7Y0uZBgUHbB3eiCoJslbjVc9DBX313snP6H9+VUyfuPAdh
         DgIIJBQ6iTIwRdnGynm1bNLubaYb1EV98zHn8Ywg5XK1oFG5ASNAXy3FWl1aLGpfSi6H
         lJ0x5GZBga78HX2l7twvr9oMIYPtbqnn4NbFRbuHWuYRTFv9eROSagd70iCAGprWDkfx
         wJ8ydsLdSXuZdgnTu9vfj+dLPZs+UtuEaMAc1t8OoyvoFlVecXrMxaZW/t23Aq1nRmYO
         hIeF2qMqOUuWztPv+noflahkOflT1p+pRj9zI23zGIS24MNGitPxOVklNQY4TbxnKhye
         YgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpI7lJpz9IKYSko58dc/btZymelWFdQOcnxveP1xg7I=;
        b=aHpiRPjPc8Q+wbnhsyK6tRJKQ7oLQJBi9Y5iAeXlg/mBp6X0mh+muM5pbTFXmnRW0B
         CLwuUxWSv3Lt1Y2Ywqi6LnykVu13Be7JJcdHLweZNFbUezPBUyc22WR4b6FuCVRHLl4B
         tCrcNW3zYzis1FVsEM+BbqmB2R7gBX7JWmZOCC+x5rnpPUwgg/zRYW9djG+MT93uJ93z
         1J4wzWT0CRJagEWInzuUmapN5OO2zKNoZdLbl2LFn9ohehx4/nmwflS+0YYjQXJ31yQG
         gA/YaVogUKwjGRUxj4S2/VG1MnWDxjZLliyhnHmT+7DVatRYNDIju33tGO3l2xupldkL
         0Dpw==
X-Gm-Message-State: AO0yUKWTvlA5qjFxTYkkJsw9Sv6OtsuzWqOqqiMAy3zhzo8MYo8txPNi
        CVxa0NO7tkDoKRf6otNUoT0nJg==
X-Google-Smtp-Source: AK7set+te8laFy8cWhZo7mQQMHGl64Fub1y53xPaJoVyUEJtB9MBk7YBkP8AFinVGRa6+PskmqlovA==
X-Received: by 2002:a17:907:7210:b0:8b1:2998:6474 with SMTP id dr16-20020a170907721000b008b129986474mr3134749ejc.16.1676365925662;
        Tue, 14 Feb 2023 01:12:05 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906c00600b008b0fbcf4b11sm3677282ejz.66.2023.02.14.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:12:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: PCI: qcom: Fix msm8998-specific compatible
Date:   Tue, 14 Feb 2023 10:12:02 +0100
Message-Id: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

In the commit mentioned in the fixes tag, everything went well except
the fallback and the specific compatible got swapped and the 8998 DTSI
began failing the dtbs check. Fix it.

Fixes: f86fe08ef00f ("dt-bindings: PCI: qcom: Add MSM8998 specific compatible")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 - > v2:

- Use the correct commit in fixes

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 872817d6d2bd..fb32c43dd12d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -39,8 +39,8 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
       - items:
-          - const: qcom,pcie-msm8996
           - const: qcom,pcie-msm8998
+          - const: qcom,pcie-msm8996
 
   reg:
     minItems: 4
-- 
2.39.1

