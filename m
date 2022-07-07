Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842056A402
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiGGNp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiGGNp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:45:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB21167FA
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:45:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e12so31202688lfr.6
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J84rYJRxyLS+DUjyXjNuhmSfKGBG7TC7QePHLusbdzw=;
        b=jKkeaRYF23FtZ6HZA6V52In5GCMTZeNH250abFmDRxUhV5M4/kKpjdO+0DVWZQLI2G
         d8NNfPqp9GiGYKehCUVa9HGbegz7nP09LNFxJu69wPyqkHEaokgwWPJBWT9VXOFb1GhA
         CXyptjESVF3ot+2kfHGnYFCWhsQlunFqLzCVsY6XIktGa941d/4PkGvW0HD7tAwSV8tV
         ty3GAzFDeCBfbNNkTFFDdkKOayD/W3HklaCg8pVsZ2TmS5e8XBp1lYKPGWBcIalL4Q+8
         sKxdwsmHcJFYsG64eDRWgkMe/9OZErKRBlK1VWtChjcQItFez2f26JzblV6itPc7i63Q
         eq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J84rYJRxyLS+DUjyXjNuhmSfKGBG7TC7QePHLusbdzw=;
        b=ixQaD3Kxc6oVEF7Z1Vo225aCYClegIMdrmYOliF/CExJwgkwkK2ogpDmzF4jVbNqyZ
         6gvMcCk2Y6603kCcgHRvILTun4rccihLlfCmtAcOsKS7pVo3gdXhN3ToTaMZnT0SVpFa
         ANJFIwjaJSc/2URLUFQsSOlZvkdNqjYcvzqKHgUZex/ioIS1dnHce5AwcI99ksaVXunB
         z3xWXGI0Y/RC0H1mHPFy+CGpvQV20Jzu+YITJSZQfXtF4bcQNPrePb0i6RCWTvXSkNAY
         Y7OrgAfBsI72XQin7g3wQBhXqq72qSiXHq4MMngrxE+XEnGnToIg6sSanrHJDFZy7uXp
         ENow==
X-Gm-Message-State: AJIora8nRO49z1EOZe65RlDYTSc7gVGdI40rK6kNX4gXAnm3Z7gRMIqf
        ee8/w9YFXqVs2RJhAWHYf4aFdg==
X-Google-Smtp-Source: AGRyM1tYRRs62+3BxTdwVevSgyxH22yeW6RRboVvaXprKyowC2dHaOYS/W8Vk9oL8zsZQ2wYPpT8gQ==
X-Received: by 2002:a05:6512:102a:b0:47f:a442:7178 with SMTP id r10-20020a056512102a00b0047fa4427178mr31602041lfr.30.1657201553667;
        Thu, 07 Jul 2022 06:45:53 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k12-20020a2eb74c000000b0024f3d1daee0sm6612652ljo.104.2022.07.07.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:45:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] dt-bindings: PCI: qcom: fix typo in condition guarding resets
Date:   Thu,  7 Jul 2022 16:45:52 +0300
Message-Id: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the typo (compatibles vs compatible) in the condition guarding the
resets being required everywhere except MSM8996.

Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..9b3ebee938e8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -614,7 +614,7 @@ allOf:
   - if:
       not:
         properties:
-          compatibles:
+          compatible:
             contains:
               enum:
                 - qcom,pcie-msm8996
-- 
2.35.1

