Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4A26CD00
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIPUwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgIPQy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 12:54:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F4C014B50
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so3892030pgl.6
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzh3CCoDGDGxlJkIFINWNZPt3A03jNDSiJwS6iizMo8=;
        b=RCEplKr8uDjcljvZ75VbCIa+p/+u4kUxxw6sEcyQ+2NGKEsEH+ntw6DyCxLRdB5zVm
         sjDa9nnEwtj6aa9p2J2s2XiTnDIyxinKebyl4P6pWm85dT1HDyWQVe1IBnAw0KMvW4F4
         rn4HhM2kq7gXCcI9Oj6X0RDLz7cfY3uuYpzGqyQc4L5qaL5bEwqROAnl7nu4vXWVNkfn
         3Floefia3Tb7VSEzeUSabjkovoL6og9b4ZPeXnzW8VLdZNibtfm7EQN1GHiSyo32F34x
         TthB5zLph8KkJyo7boKf4Ys6LSD7wJPgxlmkGlGfu417DfcTKgHDv8j8sl84OHEQC8i/
         /ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fzh3CCoDGDGxlJkIFINWNZPt3A03jNDSiJwS6iizMo8=;
        b=E1LQUd8T5Eb7olzbr07P2UwOmzUra6/Vno1YsH8PF8c5jdUEMV5sv7E4RsW5lcj8sA
         y8xAABcMs/f5AHPS2YUn8dsl1bZaEBvjFaFrjutNKMU8kZUJeHU/c0YP5sJtP5/emW3q
         8Irwqd1cD4e+NERV0CNWF3kmYl1I+RWDSKh61/YTccijr3ae4P9emhPdMMi1nuzP9Go5
         Li6i29JS+qhjF2PZIEwAYoMvhoxOczLo1ENmfEWeZ/Idy63Ix2bRmzV84+JPNBn6yjRn
         RmuPyBe27QJ5KIxKTXrdFUhdhGLmUBTxYV2E+DJQoj6furh4S3EJo/uzp9KX1Z0Ta/nj
         5rag==
X-Gm-Message-State: AOAM530lFDyjMef+uku0jv3rzB2SqnUA+UC2qsnxy88zCO6xrGAvBwU+
        y+JYA9qpmbbnMwsXGDOaQICh
X-Google-Smtp-Source: ABdhPJwQ0usWP+6ckIvXgjvXplFm4b8ypNnW3E3eT7izCSuUzjz6qpcS3c+maK/Sdj6ujQr7IT/LwQ==
X-Received: by 2002:a63:e144:: with SMTP id h4mr18900959pgk.161.1600262439051;
        Wed, 16 Sep 2020 06:20:39 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e123sm17615726pfh.167.2020.09.16.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:20:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] pci: controller: dwc: qcom: Add PCIe support for SM8250 SoC
Date:   Wed, 16 Sep 2020 18:49:59 +0530
Message-Id: <20200916132000.1850-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe IP on SM8250 SoC is similar to the one used on SDM845. Hence
the support is added reusing the 2.7.0 ops. Only difference is the need
of ATU base, which will be fetched opionally if provided by DT/ACPI.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..ca8ad354e09d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1370,6 +1370,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
+	void __iomem *atu_base;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -1422,6 +1423,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	/* Get the optional ATU region if provided */
+	atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
+	if (!IS_ERR(atu_base))
+		pci->atu_base = atu_base;
+
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie->phy)) {
 		ret = PTR_ERR(pcie->phy);
@@ -1476,6 +1482,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-sm8250", .data = &ops_2_7_0 },
 	{ }
 };
 
-- 
2.17.1

