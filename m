Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584D15A2E57
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiHZSVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiHZSUd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1F6CD1F
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c24so2049332pgg.11
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7Z3u13rYQpnMB98SibwD18Rv6bC0Tn7F50N9xepOERw=;
        b=kIFIo75w279aJv2ofl4iO/HUsPyAG7Rq/DvHSJwplXANqZaq8sSUsFmXBWYqBUyxmk
         qj5YzQUw41E1un0dHclsYhP5pcjMqL0XHHbUCxtCuVqjaP8Q4Wdpn1kYU/5/0Xb3SEa4
         Yow2X0F/8jjBaV+At6tCjlW/pIS+wh28tpzsobR+l81iHFYDHCxG2UgTleg9AgC/Qx2A
         +37/f0KfBpcV+CmJ2H85LX9/DR62gMxsaNZ67GUfuu2cfgaA8cn6ySIHKMRw1wzGSiJ9
         tuGhtG2VyBcuntiJkNrNm1MoLL47z9+cP1+Fkm/qUPEJmdoT7FCxPlT9toBFkThpiHdo
         wFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7Z3u13rYQpnMB98SibwD18Rv6bC0Tn7F50N9xepOERw=;
        b=ylHWHKRrAKjSjpGN7NW/nlH3KDj7B0IkOaatKelG+yPyVoCkjrf50Hu8kDmb1IkiZy
         pFWJNP0FAygqjMs2jYXplud5Nv4SJAKX8biTRVYirM3FE8pKe2imFTs/ZFHQTrgOq1od
         8JNm8FLZd2ruou4dchrClYYyCTkXFfCwGoVjS0mWjS0aeeZ3P2nnh7wjrpscpvNVrhG+
         tedSEdoKiUX8J4p15NvC2ACbPwzIjNvXhZMXHUzBUe3lJ3qQFCPIRkKpxxzA2AUgffcI
         fiulE6zmJF21EZKmjQTLzgya1L1d5qHt9AoEQ1KHFBQVjrMWIteuK7+VbVBQDUMn9x17
         fCQw==
X-Gm-Message-State: ACgBeo38wbBvPSAi315NJobf2Lv5k3FwxOKjwyGM4ypI7sTBYgPq/fh0
        ZHHTgjeiNaoIuA7qB1pVdRo0
X-Google-Smtp-Source: AA6agR48unRdWK6EPo21Jrmr5DkiUFVV4duWI4IrF9S/zpKSwhAgilNnw7tNsYK62QKTToiG+L5/4w==
X-Received: by 2002:a63:90c1:0:b0:42b:77aa:55df with SMTP id a184-20020a6390c1000000b0042b77aa55dfmr3159556pge.558.1661538030654;
        Fri, 26 Aug 2022 11:20:30 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/11] PCI: qcom-ep: Add support for SM8450 SoC
Date:   Fri, 26 Aug 2022 23:49:23 +0530
Message-Id: <20220826181923.251564-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index 4908f08bd90b..fa1819c9f667 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -775,6 +775,7 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sdx55-pcie-ep", },
+	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
 };
 
-- 
2.25.1

