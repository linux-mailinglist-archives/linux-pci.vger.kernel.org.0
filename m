Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F962CD0B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKPVtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiKPVtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7464A0B;
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ft34so293373ejc.12;
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhziJCTfYAX8UUJF9yrOBjkYfO4Z58hl4/PJ9cRFK4w=;
        b=UUMk7NQBXC5/9LZf7ADWWbk9osjPr8vfYJv38i/fOPerGi9Zoymk2VDn1LhA+rnyaC
         kA/xL3ISUlvrmWQD5kFI0jvHJSAT5rY/uKabJ9sCmePt4MtilwKARl2ts/a79WKL/Xbo
         /SG9UUK18iNE8aczwGzWtwMOVzBkoOIBArcR1FpMe9eoCpBiZSabkLu1s+wCHfPvCEoc
         bZ1EhOYsQTi0MCN6GQHzEXnap+oWDoyUdTCjXQA2IUSpuW9GmCGNpDZPP5fZiOVURRK0
         qFqUc//R4HSFHS+y41NrAqcs4LHMy0Pc5bszP1bjY4Wwyv4SiMqdf5pwnuXIzQF+T5D7
         yNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhziJCTfYAX8UUJF9yrOBjkYfO4Z58hl4/PJ9cRFK4w=;
        b=FD3S3GZq4DnwYiCFvNPrgOGcrh/KEXpcflVhkjPYXCnHx3vICDfEKNd9mpomKtWIw6
         6rmCHkxSZgQOmm9GmeklkhU/5r1cjCk2F7PaotvJ0+kjF8KrsqZA1C2I1GExuiRbCTfH
         n7AIoXOL/vKjC4/Mn39l79Bpng3u/nz0x6OWAtHs2+rvT8731LK1w4ivZgKf8hxNdvTK
         s6ubbJSTJC5UL7obVfCBVBLM/LbzeAbFnTYi82TsnKLBd32RwdzohnQ7uSROj0S1Huea
         8PamERemJyPzRxucphVEUUOP481SEgAfaKY/Q0A4k9orKkE7HUTIKY50bXupHlnw2Ric
         GAUg==
X-Gm-Message-State: ANoB5pnfsqtwjczl3ghT7Il4N9DJJZNuXiJOFVxz9LuP24BIVmrwMno6
        ThCbZWjLWvQ646JRqsxF33E=
X-Google-Smtp-Source: AA0mqf6lf+eRn0xeqmUf15BFfitqsO2LECPSj5DIqQv/ZTymECngkzjTdQU5zcJMIo6ykre2bwOiIA==
X-Received: by 2002:a17:906:b755:b0:78d:b8b3:f027 with SMTP id fx21-20020a170906b75500b0078db8b3f027mr18775352ejb.439.1668635332428;
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:52 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 7/9] PCI: qcom: add support for IPQ8074 Gen3 port
Date:   Wed, 16 Nov 2022 22:48:39 +0100
Message-Id: <20221116214841.1116735-7-robimarko@gmail.com>
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

IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
Add compatible for Gen3 port which uses the same controller as IPQ6018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..97e8510c53fb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
+	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-- 
2.38.1

