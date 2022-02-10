Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D954B10CA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 15:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbiBJOsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 09:48:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbiBJOsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 09:48:03 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FBD6B
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 06:48:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l9so405493plg.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTlhzilwZJ+GV0G2sShDk8AU6wcwqOk4GnRwj06CIc0=;
        b=Yl5VNVAN/O18uDWiOHZoyJaHv8Yj2hrpvi9Ai+sn/m8cHmMi3G/uOE7DuKDKtX/Eik
         jV7mgLokb+hr+I90QsDfmFWsrOvAsm1JZFxwN0ai68h6ekLNQ8L0NG/P3eBQBhLbaCD+
         mivFLnVauQDBJSFZIY4MGoRFJQFp6MM0ob9CMOneu/uA0OfUG4odyKXaLhcm4AjdUFXC
         woeCqSWUNhX098pO/ko1m2rnp1n9iSzZaO+gXYbJ12/21rblVvhJdWDI3aDleljLpYmB
         0OlGek5ROehPCw/ZUGRXIUs0QtTlN7AiUIEyQbDNlOxv5l3jWmYpyixt4ivSBPRBjm0g
         rMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTlhzilwZJ+GV0G2sShDk8AU6wcwqOk4GnRwj06CIc0=;
        b=sG4/c79BfEzfCwoNy9yaEnRWalo0OLSoLspdLugW1tlJxq4sRi8KaIozIBPv0Lge6h
         FgKq7cTa5YBdbm0q/cVk4fmRY00e+9helyHF7Yt3/OP6iPEqyS7PbkC0NKTAibACsax/
         Wzq2VFCDVnb8GNoIkLehfc6t5/VHj5RweFMCQYWISYALUM8WoCLCYmxFmd9PuuAvgvHX
         bbqHMMZjrsz4Lsh1hBBV2rpxOhaqrjGYxmm9UMFfBCifwPGIakNYhqtilu3vWN5eY5t+
         Mev2DvCgUTPqLe3rzQc/UpiBzUM9Ii/uEJBMHIg9Rpz5sFKlmkhXXHUInqhGB4vT9JrD
         ga4Q==
X-Gm-Message-State: AOAM530Dde9M3+UQHJR7OGAFVBqOWrbMe0L0S6IKEuo2syPTEm9f4Ti8
        MyljqcmRZYvhKPRRLwAlgZod
X-Google-Smtp-Source: ABdhPJzNPs7oJuxf+RGN9n4bAwd3UkaD8iV0GSwuukEFfop8/LTWoR3TpFFs+XL+xfJqsfA3hcVDWw==
X-Received: by 2002:a17:902:b684:: with SMTP id c4mr8126073pls.122.1644504483364;
        Thu, 10 Feb 2022 06:48:03 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.88])
        by smtp.gmail.com with ESMTPSA id p11sm15960117pff.45.2022.02.10.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 06:48:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] PCI: qcom: Add support for handling MSIs from 8 endpoints
Date:   Thu, 10 Feb 2022 20:17:45 +0530
Message-Id: <20220210144745.135721-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The DWC controller used in the Qcom Platforms are capable of addressing the
MSIs generated from 8 different endpoints each with 32 vectors (256 in
total). Currently the driver is using the default value of addressing the
MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
num_vectors field of pcie_port structure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Rebased on top of v5.17-rc1

 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..03e766f6937e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1556,6 +1556,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.25.1

