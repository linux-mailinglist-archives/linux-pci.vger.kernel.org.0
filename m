Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3445A5B44A8
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIJGda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIJGcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:32:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D00B1B8A
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:32:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bj14so6534250wrb.12
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hFaMhiJ2smTY3tKW4XMPUKWJJb1/OofcwoKHsMVmwSo=;
        b=o2anOs2Q2VroHG5wz70Ofe7YBNn0OmrnSLsTKtY2Xe9gulO4fILMMGIbv23+MoYP3T
         dDHkWbC2cuZsuIf68xyFwRoaeYjWQ9SJmWqtcbfe81RDtg5PG6eUCKAfNfPbZ9+ex2+I
         3OVxhwdqUSInN/vfgoaExzHwr7ByZ+Vx6KJzkcfD93hP9JqR20qdGexnidFHzuaqtpEQ
         ndLfeKbufe4gHKIWUQn385HMeQiMVmuI25o8bHr1zNeusBWM2v0sMQuu3DLVlb0B0Dgh
         Yu3QJY1lZttHJRna+PA8h6NInUWzg8x66ojb3YIiGWYk0X39vIY9e7tz2CgM3P5z3B71
         MN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hFaMhiJ2smTY3tKW4XMPUKWJJb1/OofcwoKHsMVmwSo=;
        b=FfwkywAA9avd1jO4gzgG1Qe9mvEXQ8I7RtTULgELYG0oyyaA8i+X7WZDt8VV8Sh0Ok
         juidUlDLrW8cyHc7YHvZC+BdW5TvgSDbs/CNlV3TOWwCw4Iatb07OSR0ivM1Px8W9uZ4
         dSaCo9sO2lZ9jMw//8B7GY5ku8LQZxW9CbthijB3OM9Q3m1UqK92VyBQaYS0y3/qjhhl
         NQJJZ2/FzEyvoa7nZhMfChmZjztHhNeBESpEX9UgAltae6Y14EsdGzLfhD+/L45dBM9s
         0cqeIBJsJ457YBkDSPJC8fFOPm/8/aGSsck/DVfCS0scDmXP/Xfi5mGUEz3fPTfIxy4+
         YlDw==
X-Gm-Message-State: ACgBeo0pZvIMJl85QQ1wHcIfIqnd3stgP1LueYonjRu+bj4Z1FV4CH8E
        XCC8zr3vxoQGh6PCwFnpiDGr
X-Google-Smtp-Source: AA6agR4Z10iWlqJ86QU2gjMalZBEweVgqa+WdXv2zKRkU4TqxEoOOH7EISzHhzglLNEWx0l1uhMFAQ==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr9901777wri.388.1662791556316;
        Fri, 09 Sep 2022 23:32:36 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:32:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 12/12] PCI: qcom-ep: Add support for SM8450 SoC
Date:   Sat, 10 Sep 2022 12:00:45 +0530
Message-Id: <20220910063045.16648-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

Add support for SM8450 SoC to the Qualcomm PCIe Endpoint Controller
driver. The driver uses the same config as of the existing SDX55 chipset.
So additional settings are not required.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 92140a09aac5..16bb8f166c3b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -789,6 +789,7 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sdx55-pcie-ep", },
+	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
 };
 
-- 
2.25.1

