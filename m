Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7462CD12
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiKPVtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiKPVtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81042627E1;
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so381558ejg.6;
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YHxYmic2BMW4CGYYVCcf0TtkyGIao9/HDkKDNLiz8s=;
        b=pZBB47yGuOielmLjy0irT5NM0KlG0FFviLYcGd/nm7+CmIWBicP3esYqyXOZa1i1Cg
         gfoU3ckEK8iG8kbFS4sDJQ2mSQRjVMNV/jF50y7Nd7ucOnjbIO9DbQeJ4LF/yKuQiaK1
         WPKDQjsnlOommYeOfiCjpQIHYW+6JY2E6YAFRceQ5/CzbpCMS+EvU1CNm6GAvnbd2sa0
         iFiDuE4umXqm2nEQkuTMM7vAB5xW5Wsg7ZEPor9DhtsxK/ZHXYtrT0CrIOH1VwdtxMG5
         QuRMGyvg4aXluxTMuAPi/bOzMg/tewwKrUXQ/0ntJ8YwGHNXppjK+vN6QA+KaUBqFTHd
         r0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YHxYmic2BMW4CGYYVCcf0TtkyGIao9/HDkKDNLiz8s=;
        b=m7OlPMrY9SYMSG54fWgRbdB7HTPKMSvpdoi/pbKMTO/f8GkCDXvxXXbQDbIhJak7gn
         sPUnMACWSuGEGheKcd/HKauqqeWPIXv+qoaSq+Ti4wxucLvB5AE2Lgt9G/RRS9ihs+Bj
         dCza9jXs7sa2nEA3KAcOPsbIzBZNf01/4fVOn4/6wMh0NQ572qzMnxaEDTHFGl6vTLDC
         WRpJXXC1k5MM8IYsx5CS0GN+fWfqoM+zmQUIRHrURRtdB5sP9+Rf0staoAYTeRYwwnpg
         E7S3cBNS/BMnpcMIkHcTj3sHWUx+yatdzByOlGqgU1ZQw38gDLpOZZvNglDTr6wkmeIf
         H7kg==
X-Gm-Message-State: ANoB5pn6X+IK1dwmwFcYqqMh8hTYABidYXayRO4VzZbh2jIawmIkCGJo
        j3MglpB/9W5q8GYees80B24=
X-Google-Smtp-Source: AA0mqf62EV/dQqavBEDsTPUc3RhrMd4c+BbjV467l/afyROWQLUIiSxvSt+Rx+LLAdx62dqPT5zs3Q==
X-Received: by 2002:a17:906:4acb:b0:781:d0c1:4434 with SMTP id u11-20020a1709064acb00b00781d0c14434mr19229361ejt.756.1668635331142;
        Wed, 16 Nov 2022 13:48:51 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:50 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 6/9] dt-bindings: PCI: qcom: document IPQ8074 Gen3 port
Date:   Wed, 16 Nov 2022 22:48:38 +0100
Message-Id: <20221116214841.1116735-6-robimarko@gmail.com>
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

IPQ8074 has one Gen2 and one Gen3 PCIe port, with Gen2 already supported.
Document Gen3 port which uses the same controller as IPQ6018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 1e94c210429a..59f4c9990f85 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,pcie-ipq8064
       - qcom,pcie-ipq8064-v2
       - qcom,pcie-ipq8074
+      - qcom,pcie-ipq8074-gen3
       - qcom,pcie-msm8996
       - qcom,pcie-qcs404
       - qcom,pcie-sa8540p
@@ -151,6 +152,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8074-gen3
     then:
       properties:
         reg:
@@ -371,6 +373,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8074-gen3
     then:
       properties:
         clocks:
@@ -662,6 +665,7 @@ allOf:
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
+                - qcom,pcie-ipq8074-gen3
                 - qcom,pcie-qcs404
     then:
       required:
@@ -744,6 +748,7 @@ allOf:
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
+              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
               - qcom,pcie-sa8540p
     then:
-- 
2.38.1

