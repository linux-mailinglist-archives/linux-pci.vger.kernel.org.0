Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16B531A68
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiEWSjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbiEWSi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:38:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FF4175691
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq30so27035150lfb.3
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFsusYv3a39AFVrKGs8AUQpmcs9BSd1N8sKJb+8VaT8=;
        b=P+p4a0Za9Upx8q04ZUZW3vnwuIWQ8IzeOJmvhuvs2qawsU72EOdNVB9Nv9KufpJrmN
         yKUkDTe2PgT9prQkJFkKYcK1trgbpGvEviJ2LaBoDBQ+Gc6Ty6vscbqlBxZRXidvGOBY
         e3RPnfNMXXbgmBMrnxaPfkY6uJPMe/tqtW5vJuxdm5HWnkJiTAbCk9JikvQpuj/4fpvR
         xWACO98266lJxTojRaMDEYDUl5IR39AcgkFBCe7TTZMvyES/hA66o4KWRV+Y2ARQXX3D
         3ynJW7hRL8sLPb/yk5lHzkqtyzPy60soZ7lb8ZksqNL2hoFbA7HEvZh6YIMI3AiKmi75
         VTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFsusYv3a39AFVrKGs8AUQpmcs9BSd1N8sKJb+8VaT8=;
        b=vr8Mwdx5beT2+9uSiA3PwS+j/Ki7wJ3vvqJq0IE8WMHlnkhjfAskUq3uL5zqi/Ofv5
         N2RHzs+o8OjepcB4xbgj29M6U6ivgCaeLcLOGud40nx3gK/2XzhIOIGSYFOA1AvHE8Ui
         0dHFOylW46Jj+0YeITyfjGgM0qpLKITxKH3dn/iH22jlLKcqR9xQ2tuVSf7WB/kbWtp3
         27wm1AZNCbbswr4bX/EZnaa1kutXLBonMUApMWDpEk2c5Z78fKUDG2VUp8GhJUh3pGJL
         L9ltPRXNtVEsyhapqhG0NspmhKC8xbGa8W3X9vErmvKbl8UqR+j0lO17kNf7v3oM/93n
         zcbw==
X-Gm-Message-State: AOAM533NIadMvNCHp4EJnmVnUT3DTGCsf/CF8xJ0tokifJmDZXOuM4kl
        nhc/iKcdx96daFSd2oCQqwtQ1Q==
X-Google-Smtp-Source: ABdhPJx74MJGw2T96gKVIXtIvtp7gxfwS/ZJMIFI9GPh5T6+xfzthDafANqess2z8uxumoFhnzzygQ==
X-Received: by 2002:a05:6512:10c4:b0:478:7392:a239 with SMTP id k4-20020a05651210c400b004787392a239mr3568789lfg.35.1653329919193;
        Mon, 23 May 2022 11:18:39 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e6e14000000b0024f3d1daedesm1904127ljc.102.2022.05.23.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:18:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/8] PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8 endpoints"
Date:   Mon, 23 May 2022 21:18:29 +0300
Message-Id: <20220523181836.2019180-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that high MSI vectors are not
delivered on tested platforms. Additional research pointed to
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt.

Without these changes specifying num_vectors can lead to missing MSI
interrupts and thus to devices malfunction.

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/

Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f9a61ad6d1f0..2e5464edc36e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1587,7 +1587,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
-	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.35.1

