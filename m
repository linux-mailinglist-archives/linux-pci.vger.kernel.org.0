Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A384851BB8E
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351713AbiEEJQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351836AbiEEJQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658144BFF7
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w1so6445796lfa.4
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=PcJrZNjIBzOY6uCuOZrSTjLjLS0QKWt2UN6H8v8dLSsAjoUjHpsyZ4Qgi1q5VVc4ct
         HqJEQp+wn92GBb3NND9H1W3wEv3tk46O00EXHur/NVTMpbB5cyj03DNIecz7B0SZRar6
         cUULVSRl07B33yQu6LXGPzuBSdyxwp0cg9rKnpCIHL4qcPjVuPngZs4/lahneNOQ1R/p
         uMi28Jj9StylkS8D22WDVzaFK2BetcFayNOUKDbQSbsYm19EfvX50xU6LawcdMYDnxoP
         IUbNw6ED/YdN3VoSVhc+A2PQCiPgRsmWC60ygY5eobNFv4n1gJ7MpZWNf7TDAP8x/+tF
         nPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pL/05pqvORVzFnLhsNkYW/L7SMLwKtI/1exh83l2l2w=;
        b=HPdrupaQQjIJMj/dQpNKbD+WV8pL4NeDahinVXUxExf+uHwVgqcJhsnXr+f1aIVyno
         B33spYDBHX4pBsdfPgKCIEqlmvRdximZRC46VMok0cOSMdxlwwF+jn6REEYGcU+5gb+T
         f7ixkFIF+sEv33rX+upE5Cx8PmjG7OLtE2Bk/myJaZdqWjGTTF3gAXjLr41B0jJsaVEA
         HxObMPb4h13jaFRvCBf3bEngft0XAtWKvMoQeJAbaJL40DrAKR1BpshzyqX1awRiqys7
         bfJ1EEG2xiiB4MDP9WI570JeK5PFwYgPe3SgeKYg2iIe6ah9SyC/lPhVoRf2pKOG/gi+
         RGWg==
X-Gm-Message-State: AOAM5332Lvcw1D7kFsmx3Q8/dr5BZ9FXKYLXISNcVvY8zpV83Chi1ZJ8
        Jev+cdWVzUY0qGvrOB4P/2dgdQ==
X-Google-Smtp-Source: ABdhPJwdzu563dhjl+3cJ2aaAn3xADSLKZwH/Xd4gw0xIPDPGkEWRqD0M4TWktJGH828jf0vOkWEbg==
X-Received: by 2002:a05:6512:2622:b0:448:27b9:5299 with SMTP id bt34-20020a056512262200b0044827b95299mr16741190lfb.86.1651741952706;
        Thu, 05 May 2022 02:12:32 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:32 -0700 (PDT)
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
Subject: [PATCH v6 1/7] PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8 endpoints"
Date:   Thu,  5 May 2022 12:12:25 +0300
Message-Id: <20220505091231.1308963-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
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

