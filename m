Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9051570B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiD2VqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiD2VqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:46:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F378FC2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h29so8971944lfj.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=iW4TNdHLyHzXcPi4VLCW6Sz2TKzurTiVg0O02wKqiXFLSPkVyH5IFjUsfNGGWqRs/u
         wYwS15qOlhNhzp8Yj7Pbg4j2VY2a/NlI6dSLcUiKdGIvZSY2SWbzG+LAzaYFXfclgMHp
         6ZbYwqkIQ2vlxPcsCKRcvlvTta48fppTnXVemt9lYhAGYFn2ttxgNRymbeLhIuhBenxC
         KbhYVEMh1fH8AFzZJ+dFiuHwlj5VFWyPMPoSrl1+B5unNsWSzRAoTnBH5vy6+0p57QGW
         YM8vAAIPYUa1NyrUrFq6fcenrbZUvUGf0NQnvweigLKCH7+itYWatV6wVpEfJYXo3RFk
         Wyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=45FPho3fDtrB29NJdyqkJKgqgCZjGNswly+dOY1lq7V9EgQCT02PIAHAVe4PvWkG0e
         sW75HYGoGoiAwcI/KlAH6zbjNHhc4NFbFItrwwtSA/JUN8v9kmGVvy89vfmLbD+0NKPd
         5D2vbJfgc+Hu3nnlv7XW/k63j1gonIASNorqPHkLK5yfXcobab7u7bn4Z1rUPmQxHnwp
         /9pFoAbn0SRbdj6QY9rTT7/c6GIullObyUszPr/zn7LxbxHw2tvOSsXq3X0wnXFt0cDZ
         9WkRlFAgAcUolskd0yjkGEogjhNh9bBNnYwEj61T1+62uoz4UnWW1tnCsuoCNNeHcQ9z
         KVMg==
X-Gm-Message-State: AOAM533mhtsPDIff50eaQGOMi088y/v+csFkIMn4YNHxNeZoHU3axWaU
        MrMkJjpDHUswu+jl/xb9wW/sLw==
X-Google-Smtp-Source: ABdhPJzT18W8uQw5100LqsNduJi9rN7BOJl409PG9JDFmblhx5R5bbh8zkb23a4nJjAR9qhDr/Bdgg==
X-Received: by 2002:a05:6512:3f1f:b0:44a:a85d:a0e0 with SMTP id y31-20020a0565123f1f00b0044aa85da0e0mr897347lfa.170.1651268572038;
        Fri, 29 Apr 2022 14:42:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f6sm30520lfc.293.2022.04.29.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:42:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 1/7] PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8 endpoints"
Date:   Sat, 30 Apr 2022 00:42:44 +0300
Message-Id: <20220429214250.3728510-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
References: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
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

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. Additional research pointed to
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt.

Without these changes specifying num_verctors can lead to missing MSI
interrupts and thus to devices malfunction.

Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c940e67d831c..375f27ab9403 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1593,7 +1593,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
-	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.35.1

