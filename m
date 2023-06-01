Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201071EF41
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFAQkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjFAQjv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 12:39:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099BE61
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 09:39:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65242634690so249441b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685637579; x=1688229579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/GAaoCJDXRESh8SzkgobGj/lkVGqp4sgMGqg7raF+w=;
        b=MFrl8aIwFyl9P9P6sQ88C+Ns1uk7i9NttFfh4NLy1N9jaQa7cCPU682EWWRUPqAfvv
         YaTtDdCRy7k2Bz1OxAgYtFlubz/QRWbOVsL7pPRgyjaUa55D8E49PFa3a2Q07ND5qrtm
         R6uR5kLSzDSQotQ9X0PBZOyR+pyl23p131nDHMIwS/dn4RW5f1Sqc8qUShZ/Yfef9dw2
         +qno9y2PcU0FyzhJYlgy/uTS4Ta7e5nZUwCrvw5YMF0SQuZ7t4HtmNOkbX3FMEA1o+09
         f4WtJrlrQYUpsZEJm17PmqB3y+Lvzd2E88Ou/0nu2UfYKdZMMayjdkUHnfmritKNW1Ir
         bDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637579; x=1688229579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/GAaoCJDXRESh8SzkgobGj/lkVGqp4sgMGqg7raF+w=;
        b=Vvgw028C0/AN7pcJxtfp1JtJ3pGSccOuSHc9XNztoMhN9PuHuQJNG3pL7QfXoFEOlF
         RAXVrLNMuKIB8e1iWVzJa8s68v4HDA81spLk2pzTIMPop8Xhcfo+L487BZH1DfXvQptB
         gWVyGQANMgphGL33rUSPODOb6c78amptk+Di3w2hBSY8kK9uRm1jnyIT3eZyyec2r1a5
         Y7fA4UTFtTQxN7kOnAZU8YLJn8fORcg1BMlY/h7Vl4nBESu9Se0aeNFf2jF1JMTuRO5b
         AmcHmtY+xW1ZrRncpOIDRVSHpyAGDnhTOvZbl4Yut9kF42JdwVEhIRz+IiaOxoOPEaCF
         ktgg==
X-Gm-Message-State: AC+VfDxWdbKrZfgkccYXoYKR2KbH4TyFnHVDKNw9OSlCjkYQmOU6lqxn
        xLbCwUJ+gc9C7OmxFo9BXTV9
X-Google-Smtp-Source: ACHHUZ75Ddp4Do2qUl/1QIKzYGkkVYKYzywKj2vM5yteB3nk0lRQk+Mx2HxVJNWL99DBCyPPcP9jfA==
X-Received: by 2002:a05:6a20:2451:b0:106:c9b7:c92f with SMTP id t17-20020a056a20245100b00106c9b7c92fmr8172553pzc.49.1685637578994;
        Thu, 01 Jun 2023 09:39:38 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm5273630pfo.58.2023.06.01.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:39:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 6/8] PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
Date:   Thu,  1 Jun 2023 22:08:58 +0530
Message-Id: <20230601163900.15500-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
References: <20230601163900.15500-1-manivannan.sadhasivam@linaro.org>
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

The post init sequence of IP v2.4.0 is same as v2.3.2. So let's reuse the
v2.3.2 sequence which now also disables hotplug capability of the
controller as it is not at all supported on any SoCs making use of this IP.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 30 +-------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9c8dfd224e6e..e6db9e551752 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -703,34 +703,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
-{
-	u32 val;
-
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~PHY_TEST_PWR_DOWN;
-	writel(val, pcie->parf + PARF_PHY_CTRL);
-
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-
-	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
-	writel(val, pcie->parf + PARF_SYS_CTRL);
-
-	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BYPASS;
-	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-
-	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= EN;
-	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-
-	return 0;
-}
-
 static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
@@ -1276,7 +1248,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
 static const struct qcom_pcie_ops ops_2_4_0 = {
 	.get_resources = qcom_pcie_get_resources_2_4_0,
 	.init = qcom_pcie_init_2_4_0,
-	.post_init = qcom_pcie_post_init_2_4_0,
+	.post_init = qcom_pcie_post_init_2_3_2,
 	.deinit = qcom_pcie_deinit_2_4_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.25.1

