Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF40630652
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 01:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiKSAJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 19:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiKSAJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 19:09:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF79E978
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 15:32:53 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d3so8657096ljl.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC1JYQfoCecKGmw1NdVlsiCw+iUTbqYNq5AbGPIxayA=;
        b=MfqoiRzTYofGQVZcXORPTFGdr+9epJSWOEQ13gaxNazT7QanZDmp4LLgDgidpnPcQY
         akKWPRoBlV3bahOt75lUbrUbbMCEwrqAhEXfDLsuoLrTmnCDzJyEg66xAlTYO8/uIf0L
         AlTJ54umFdfW+fLeJenG6JoMyOJOy0jKicQJTY2BA0Nwm6LlLblhOP1JpcV2KTrqcbw/
         oX2mDAliNvMwyAfT1I1Qzin0/XqJl6+MC2w1lmaRqreCPasgcG9rkp4L7uq1BsQl2aiA
         zsmi3rzwoQy8jhMUI0CTN3vUTEeG3VZl0VLqv9MZFxRVZVlcmcKf4oErMbSFrS3Z0gvH
         +wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC1JYQfoCecKGmw1NdVlsiCw+iUTbqYNq5AbGPIxayA=;
        b=oWHTtGPG18Bk4rrlw9+usmI09GxMyho7jpb6uNCNhADQOp6By/Hu8HIYU9bpmmDeZJ
         2RLIwCTUoH8p5qGUe4q9t5gWaeFZHhA7hgKrpct99rhCnC9VjT3irFAEeLAsQ6AL773z
         2tHyKeFweg5Qi5z7R7Gu32IamXzjaQdaIH8kxhVjfbUguybt/Umr5VcJvFWkQ3cvACKB
         NJ6kzY46yhYd1/+912DisxRfjHMZDCei3SJNhot2WSNrLpV2bZMWyHM4hkHZQdYA02EY
         a5F0S2sAst2xaez9XajDwdzrXEoo9+Wdk+1YAw7g0wIai7LTyO3tRvNtJKCusIiupV+Z
         lOBA==
X-Gm-Message-State: ANoB5pnXhcKUbICrgZpqqmol3fPPOwRCobu6/CU48cKjAap83TFDo3Wu
        nwIM0j3dxB0OYezYBiTw8T92Tw==
X-Google-Smtp-Source: AA0mqf5xkJVLCJ8TjZTzGV/e0MJTNmp6C8bsXgT51CxSeQ+sAETlolX3RqJEn0Mfc1sx9IOsrJ8TCQ==
X-Received: by 2002:a2e:bd8a:0:b0:277:b4e:6286 with SMTP id o10-20020a2ebd8a000000b002770b4e6286mr3225209ljq.279.1668814371902;
        Fri, 18 Nov 2022 15:32:51 -0800 (PST)
Received: from eriador.lumag.spb.ru ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b004947f8b6266sm843900lfo.203.2022.11.18.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:32:51 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/8] PCI: qcom: Add support for SM8350
Date:   Sat, 19 Nov 2022 01:32:37 +0200
Message-Id: <20221118233242.2904088-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
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

Add support for the PCIe host on Qualcomm SM8350 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77e5dc7b88ad..b9350d93b4ba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1826,6 +1826,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ }
-- 
2.35.1

