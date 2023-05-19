Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5427099D6
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjESOcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjESOcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:32:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671C10F5
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:31:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53202149ae2so2282466a12.3
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506714; x=1687098714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvVFJ4eRpjyBD7o1HP/7PTjD9zFytoFdbjvNe70Jf18=;
        b=AdxIfjDB8oHYMT8BNQcI8I8vVWjb1AfM/+816qqd/x0qvfPR2KXnBKApE6Q+FBrr0U
         r37dmu4filLwW+pM9i1TioIViH5fShG18gOY65UmdFI8igf//YL/9C1KoORjmUqINm0S
         zx4OCwg7YHS+5CRb7SBwRaT0VWuHBCYNJPPCn8TPhJcQTb3ERTAZnM2OOYUFp2jhW4j6
         TbPljLSL6rU/vToH98Y7X5O5Aag/trWty75RKQYIpm8ip3B4ruUNdQdP8LKQoWWg3d1O
         1BxEP/RIjvo8J1aKZgHfbTbZ7FbbZLggU5FHxT4928Y2qiBB4WtkENX2IBSi0MWHfzlS
         tl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506714; x=1687098714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvVFJ4eRpjyBD7o1HP/7PTjD9zFytoFdbjvNe70Jf18=;
        b=NsgqHKNQ1kpXiHtx+8EYbSOJauHRn8sTcoylgKavNdf8IfSjNDIl9xsPAxaOtxROOn
         pb4Voed1s3TVDCHlkaQeaBO8E1rpkkox6F6iy3hnOm78p5QjEUJv9FYpLsse5QUPQuxd
         vzpLfUf/4wfdq0hB1R7iiws/ahiWMegEYUp2pNjAqxS8moUTFZ7a4Fuucb9pwUW3yIbt
         kKtmNhRIG/kxIT62jrOvebktwKgGVlkYeCM5XqbOpoNaeCCNuNyAga3n+8OR4Gv1WWYT
         76aHUDO1W5W8CygtREnuSoK+vz47mg4w5VBzCkZr8h1Q8zSblC3gCPv3B73r0KvN1TXs
         oJjQ==
X-Gm-Message-State: AC+VfDzPUyjdBIjtqHb+12cX69ig33XzXrAae+4tzUMZCTy1EKFpo7rj
        4ZwekpLLTxSpZwSKZ+2xKzJK
X-Google-Smtp-Source: ACHHUZ7E1a9GbFAcdbXSe8hjVHZf4mW3gGhaUwfI0CuwaigRcszwE7CIoDDzn8pXQ4cqXxoM4JJhHw==
X-Received: by 2002:a17:90b:3d6:b0:24f:13ec:ecac with SMTP id go22-20020a17090b03d600b0024f13ececacmr2383045pjb.26.1684506714700;
        Fri, 19 May 2023 07:31:54 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00250d908a771sm1634845pjo.50.2023.05.19.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:31:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/8] PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
Date:   Fri, 19 May 2023 20:01:15 +0530
Message-Id: <20230519143117.23875-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The post init sequence of IP v2.4.0 is same as v2.3.2. So let's reuse the
v2.3.2 sequence which now also disables hotplug capability of the
controller as it is not at all supported on any SoCs making use of this IP.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

