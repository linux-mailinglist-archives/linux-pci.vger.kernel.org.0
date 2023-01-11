Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48224665B5F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjAKMaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjAKMaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 07:30:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF24183
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 04:30:20 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g68so9323913pgc.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zABXTqnOS+sR0VK+tpmly/TmJdJD8fpPZyXdF/Osuvk=;
        b=ZpVtu/tC+7kESiiDpzePypwP/SBHfWV1Q1lpfMXwgwfHUHxxOIpgU6N4lpj9p4Vsfa
         QT9RcdK8fosGAKDoNV2xikqckVNwHSKqpJSt2tA70diYHYlyLBjjacnWmxDnFBUOju7g
         7nXCyuxkiI0Gz3OlJUA/SWBo4hdMAVBo5TNNWCOmRbPANq+jnQ2YILIYxX4WWVBzuzwt
         qwKTu/uQ88wYL7O3Ux6PjfF70p/5qNbHmvjJOMLFjPw1tnf3FCk2SBfwMTOe/vu6P2N9
         k/ZMLSgOfephCGiu3HL/rG4S+Al7DAYP4PI/5KAAcHobyVD76szr9sm6i/u5jaOhtLvH
         /9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zABXTqnOS+sR0VK+tpmly/TmJdJD8fpPZyXdF/Osuvk=;
        b=SE5kV0mIi47HR5/nLcvDkyiA68txkwNVq4Cku1ZNTwwSLf1cDjSgub7F0k9GxpJ/kn
         EDBRIFi/VLSJV2734IVFnat62PRlwwHAq9Ysis7PbGED2T5B38BW1Hih+TfQfmnykIyk
         urjdliNNg+9H3uH0IwK2T71taz3vgtdAVobYwVGwDSLgjWphFdR/02/hKAUvkIVzSp9+
         DcWk1/I0yuRgo+ltGaqpo4eSLLVanNFGVjWaz7VVqLppdrwoTxt3Rsr/0bVTrPRLA779
         22GYzOdq/Rp3+eQcX/+SYi6TTqQLCwjGkwVTaNuY18IjDA2E3tjUQfIaeDDt+EWWjQNY
         Egcw==
X-Gm-Message-State: AFqh2kqNkXf0vS9W6GQ4tIUoTN4P938UKnGfD6nter5KgHO5wY0OpPA2
        NLdWXGav4sQmFas38e8LTd5/
X-Google-Smtp-Source: AMrXdXuEZXSoRWhbdC7h8lpHjLHieghHad2OGWe1QGcJ68zuacvSMxcyChFDucfQfzbarERJw7DJ5w==
X-Received: by 2002:a05:6a00:a1d:b0:581:73c4:f0bb with SMTP id p29-20020a056a000a1d00b0058173c4f0bbmr65449291pfh.2.1673440220454;
        Wed, 11 Jan 2023 04:30:20 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b005747b59fc54sm8719594pfp.172.2023.01.11.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:30:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: PCI: qcom: Allow both GIC-ITS and internal MSI controller
Date:   Wed, 11 Jan 2023 18:00:03 +0530
Message-Id: <20230111123004.21048-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The binding should specify both MSI implementations and the OS/driver
should choose the one based on the platform requirements.

Fixes: 2b0d557419cd ("dt-bindings: PCI: qcom: Allow both GIC-ITS and internal MSI controller")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 01208450e05c..e106bdf93f09 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -119,7 +119,7 @@ required:
   - clocks
   - clock-names
 
-oneOf:
+anyOf:
   - required:
       - interrupts
       - interrupt-names
-- 
2.25.1

