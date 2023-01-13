Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6C669E9F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjAMQrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjAMQrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4364D72F;
        Fri, 13 Jan 2023 08:45:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw16so41767972ejc.10;
        Fri, 13 Jan 2023 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RXpc+qR14+HHZGpeltUoGyeqhas9NSG4qLAjy0buBE=;
        b=LFU15355PqIgpndYz2zO+dJjiMLCOYI/Bh87jnvHGBTYG1F0WRKj2up5rZ4FCUu9uS
         leojmQIOzUl58kE49ZTgFGmokLWB68a31Mhh/0kl7/qgXnBDxGkWgfosXo6IHnihiXU/
         FvM2o4ttMQ94ZoWC5zdlrx11M1shpTXDmUgxkeqYLY4kbCYtPRYy+FD+FeL+lt/qy6wt
         xGqNkxosTkUvSDong4q4pddRpbx9JCqs1ztyRXlsnk1SAHT1Ie/GmMNBmo+/9az77c/7
         k2/dEZg2Pvc5zRuBDLYEtKn/CnavYLoL+I4xnyL0V++bRZEuQXTH4K2tiRryytnMcGcT
         rhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RXpc+qR14+HHZGpeltUoGyeqhas9NSG4qLAjy0buBE=;
        b=JnriOPnmDFYjUa42Fe30rODpiXfrpNze1tN7UvjGi0eFsltYv+eiAxwfqFLp7rzsx9
         20gMFyJkVrRg94Eu6cBnHlTShq6Kzml2DPhW1cICFfV1s412140uLJnxh06vdemuSg77
         SvfOmmDrZCOLHXXxO6XxG+gPot0l0Efot7C6sjHly6gpFOBp37FZqRgSS8GFbL5c8dbF
         2ZrEJ169xO4krv/SFGYKYa5LfcXf06di63smJiXnXKkfaaWlN1RXrN76Fp7CHhW+wbbs
         Il9oxDO3sNrfSfxGsHhR9k23IdJ8CQdbq22jgjWmS58xTAbeSpGmoXLKrhKs5aQik9ai
         VlmQ==
X-Gm-Message-State: AFqh2kqGIPd6cUrk5liLygTRlKbeiREOogBxKSwpxmKiMeV4JFojj8U7
        uQG+6RQwCfZGsCM+ntIYoKU=
X-Google-Smtp-Source: AMrXdXutMuO6pW1i7X03FZZXzNxKvY5bHBnsJx9AxrMrz3iwT946EqLjMMnIXQJjLv+Qj+z667yMdg==
X-Received: by 2002:a17:906:b053:b0:7ad:ca80:5669 with SMTP id bj19-20020a170906b05300b007adca805669mr83559889ejb.64.1673628299120;
        Fri, 13 Jan 2023 08:44:59 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:58 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/9] dt-bindings: PCI: qcom: document IPQ8074 Gen3 port
Date:   Fri, 13 Jan 2023 17:44:46 +0100
Message-Id: <20230113164449.906002-6-robimarko@gmail.com>
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

IPQ8074 has one Gen2 and one Gen3 PCIe port, with Gen2 already supported.
Document Gen3 port which uses the same controller as IPQ6018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 19580350db11..0f258aa1bfaf 100644
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
@@ -154,6 +155,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8074-gen3
     then:
       properties:
         reg:
@@ -375,6 +377,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8074-gen3
     then:
       properties:
         clocks:
@@ -695,6 +698,7 @@ allOf:
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
+                - qcom,pcie-ipq8074-gen3
                 - qcom,pcie-qcs404
     then:
       required:
@@ -778,6 +782,7 @@ allOf:
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
+              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
               - qcom,pcie-sa8540p
     then:
-- 
2.39.0

