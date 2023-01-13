Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614B669E99
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjAMQru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjAMQrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360BB78A6B;
        Fri, 13 Jan 2023 08:44:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id v6so10606510ejg.6;
        Fri, 13 Jan 2023 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97SxF/mOuJXLVnQXR3aT6mXxy12CiY85FHycSGN5Oi8=;
        b=LrRbpIk9cBXGhme0Gl5YjV5U6TFOgD6XR7SMEkM7OaNrAmMDbke6kBdVhPbOfyMLjP
         dke4nrIR8GQ76qoFJar7pgFZUHlaNpAc4Y5q3kLnBl8z0RYc1Md8jka34WRjgWlRLAdI
         f2XdxL6A7AfNystl0GVu/lLo1ykmAggOpCcoh1mUyctV5gPD/CjdOUjFo8v7u4y6nP/Z
         si/KRYXpcSkoQ6KAUsCz7GEqb6HbhxToRsFtJAkpHg2IGMP0ZZXNblw5GmaMPC/K8hfb
         QFT4Ye1odE32Bi3u5hb+CZW2HFSvsBxx67PJgVkszzb0iQ8b3ueogd2nx8W6+/x57nXv
         zy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97SxF/mOuJXLVnQXR3aT6mXxy12CiY85FHycSGN5Oi8=;
        b=ufgaPbY2JSiZig+yzF+S0O5JfcDxVMqWjichNkp60A/XVt9ub+WmyWgckPQEidxDDp
         1YY/qd112fwJh/QCIkEp2pR5KKZ2pZHvUnixnObKciwKoWA9XyxqY9ZM3bE5iSSWGyfC
         LI97bGh69HeEpvgdO7nOGwWen3KevIkviTQ8q4PpCIY/sK6CJWsQiN+XL7jKoF2cFdfC
         JVtMe+y2ZEmbhHl5S7iOSa/emvAL+2IIsuROwPw/GBTMD4d5MALvUmCHR322mg8IGysR
         mUGY2pM7HW4Wnub++DHl8IwakRuI9rWAA1UcgKRZa9++uwO7VKBtQcthwbXcdcDkSevz
         k3gg==
X-Gm-Message-State: AFqh2kpHN3UgT5TU3FGQ94u6xzZqshUy8Ol3RmdtOFfgrXnHECe0mFJ1
        j3WmH9LM8CMVW0B5ULf3c86KQ/oUhoBaxg==
X-Google-Smtp-Source: AMrXdXtpXosjr6RtpX3eDD8bM9d/ghpUdScwg1OtRW67fQgh0ukScTJ0LvN5dFlX3Mlh3Mwk7VKIcw==
X-Received: by 2002:a17:906:2886:b0:7c0:fd1a:79f0 with SMTP id o6-20020a170906288600b007c0fd1a79f0mr3178305ejd.21.1673628297691;
        Fri, 13 Jan 2023 08:44:57 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:57 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 5/9] dt-bindings: PCI: qcom: alphabetically sort compatibles
Date:   Fri, 13 Jan 2023 17:44:45 +0100
Message-Id: <20230113164449.906002-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113164449.906002-1-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8da8ece1d4d7..19580350db11 100644
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
@@ -35,7 +36,6 @@ properties:
       - qcom,pcie-sm8350
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
-      - qcom,pcie-ipq6018
 
   reg:
     minItems: 4
-- 
2.39.0

