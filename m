Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67D62CD07
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiKPVtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKPVtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84F606BE;
        Wed, 16 Nov 2022 13:48:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so366077ejc.7;
        Wed, 16 Nov 2022 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EGkalAXlOl0NBxY3u6qgvGXD8V2PCW1rraeENgVJy4=;
        b=aKUwugI5mskqa5YPH3g1gI19s3UWD8lZaR5dSzti/olgcPy0DImSlcg3pxj7jBKtxx
         NjIY1Hj247RiMHtGQPY6sL1OeelROOI+W8uKZoURysEZSf2sharXsZinAO+eLcugC+dU
         jyVVXguDhCHzgmRqxf5FTfojf9apGYO8OuUF7dzyka6WEKs+LGaEchvccypDteG52OZF
         37qq49sqK0Nn016eZrEZWWdg+6M4xyuyUIVnzPlj8YHdXBJRsUC3lFWnTFW8ZltRO8Tj
         hw1XotPnfqvXmNAg+l4wVOXNweWqD0vhzrEoNF6T8ZDx/Nnu5HRBWa6a0FBfm0EJZGue
         EWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EGkalAXlOl0NBxY3u6qgvGXD8V2PCW1rraeENgVJy4=;
        b=c5J+G67sdsdPZZTllBUT3iD9/cauSOR4oyxTUQbADTs+7dmWU/5KYatOCfeLfFw5pe
         R/pQtGnuA6EQzRiIh5/mfxqhcTjUA2XqoKFLGONAgKGvKjORfApiF7fw+PctgZUmbJ4l
         DAaPZduEwZpT2x2bdoAkitBqQFf62iMTUHqeFEzDI92GZzwuPRDJwKV6IqWIA3KqqQZB
         1QzZl+oaaOvVxr/zsQEFPmjoCVrOqe8FEo/AnrRl9ZtF06SuLJZubEKwpQBA1ARKO5az
         dsXrsJD+Em8L5ugs/TyLR3JglM1yxyCE1tmwYiIGcDjlw62lr63b+qwqaoR2YXv9aMvf
         wnZg==
X-Gm-Message-State: ANoB5pkRFsud8fkkhFWluvWF16b0qJE0C0LFAGxllLgT+B9esljJUQjX
        9DrYxqQZEJDY442QV/1OqNY=
X-Google-Smtp-Source: AA0mqf6ktQzbxViWEiE+WI9awnLuzAJHFsWq5qxOdtYEsmckhTvf8kQWh1F8U6adB2rtKwlS487qTA==
X-Received: by 2002:a17:906:c013:b0:78d:ff14:63f9 with SMTP id e19-20020a170906c01300b0078dff1463f9mr18717505ejz.516.1668635329595;
        Wed, 16 Nov 2022 13:48:49 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:49 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/9] dt-bindings: PCI: qcom: alphabetically sort compatibles
Date:   Wed, 16 Nov 2022 22:48:37 +0100
Message-Id: <20221116214841.1116735-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116214841.1116735-1-robimarko@gmail.com>
References: <20221116214841.1116735-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sort the compatibles list alphabetically for maintenance.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 2f851c804bb0..1e94c210429a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -17,13 +17,14 @@ description: |
 properties:
   compatible:
     enum:
-      - qcom,pcie-ipq8064
-      - qcom,pcie-ipq8064-v2
       - qcom,pcie-apq8064
       - qcom,pcie-apq8084
-      - qcom,pcie-msm8996
       - qcom,pcie-ipq4019
+      - qcom,pcie-ipq6018
+      - qcom,pcie-ipq8064
+      - qcom,pcie-ipq8064-v2
       - qcom,pcie-ipq8074
+      - qcom,pcie-msm8996
       - qcom,pcie-qcs404
       - qcom,pcie-sa8540p
       - qcom,pcie-sc7280
@@ -34,7 +35,6 @@ properties:
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
-      - qcom,pcie-ipq6018
 
   reg:
     minItems: 4
-- 
2.38.1

