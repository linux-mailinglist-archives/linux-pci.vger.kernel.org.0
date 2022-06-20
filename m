Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E955173F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiFTLUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiFTLU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 07:20:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8EE13F13
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c30so11520002ljr.9
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MvVCHkA9nZFkLH6XXvcaT5WkDeOWl8XVZeIyd8n1Yk=;
        b=CulldKOJpOtpShxeUYlAUyYarzDWE14QelKr4WMkBsRBFEdSyN+VkpwuLW2vQSN1Qm
         CswcXpGes34vQEP3+etT0TDvkNwIOyTCrjkJpLRMyVy8BGgxZI7wV3mVQd+ydfqNr2k/
         t+3YscIoC8qG9pNrHe7NZmHbiYylvo0euP3e4Ez9CUb+MKQ4BmZnoXMy5+/ELcOH8t2P
         ZlQSmE3tvXHHqL3fSQedG/PyJJFsxawl+PA4B1Ae8Wbsw4QvKRQW/mqAieXniSLutHXx
         4ZROjuNtSuqhfSrEpC5GnPbZVcwDHwaoi7vnUBKRFuko8isdlmoA89T0y4LMD4Vl8qI9
         wH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MvVCHkA9nZFkLH6XXvcaT5WkDeOWl8XVZeIyd8n1Yk=;
        b=q2dsoihCnpJPJRXglHSu2Gx1bItdnqmzTwP6j2FFmzprlFmBetl0AgsqiAUFw7nOCm
         y/LZa3/sJjpVcn90+tCKG4s/xjt17ZiexCe0RTGjHpYtMEUQXPetXEZVB3vq+HyXDghW
         71uCYXOp4ilxeKMDdpcizDVD85N2wvuWzXr8129SYNnT85Vim28jkb9UYZkL1iLwOv70
         HjqG2u1bbfUCzy2icJ+/T6m5RE4E5ZkTAmqUEjxhQCJbLCLqrCNPQh1zw1JaqAWDosPo
         C0ZY1PQsXUQTN94DZTCmlfkchVtqceP/S2Ed4GRtgiLnC3z9A58j1O9hQk1kLV2hY8kI
         Qv/g==
X-Gm-Message-State: AJIora/SIDVNAk1SfM/OckAMWk8Z3G9mdWXMSeT3z+RbXEBTnCl0d8sf
        G2SvYIc6ZqpP0Miu/qvqq4iCTQ==
X-Google-Smtp-Source: AGRyM1vk0zG6jCrCmPOlM9h//sqCUjKHCr7KcW048YXLCOnfzjSsh+/hfhdqy/JQQpftZgjGTkpH8w==
X-Received: by 2002:a2e:9781:0:b0:24a:fb54:31d3 with SMTP id y1-20020a2e9781000000b0024afb5431d3mr11513165lji.242.1655724026680;
        Mon, 20 Jun 2022 04:20:26 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b00478f5d3de95sm1727270lfr.120.2022.06.20.04.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:20:25 -0700 (PDT)
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
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v15 7/7] PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8 endpoints"
Date:   Mon, 20 Jun 2022 14:20:15 +0300
Message-Id: <20220620112015.1600380-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
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
index 8523b5ef9d16..2ea13750b492 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1592,7 +1592,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
-	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.35.1

