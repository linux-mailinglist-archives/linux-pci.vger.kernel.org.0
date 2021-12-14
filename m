Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5357474E4F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhLNW7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhLNW7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:59:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A54C06173E
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m12so30597090ljj.6
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVTN7b5L6Q8M7Gakr2H7R8BmSqA0Ma7LEj299lemVJw=;
        b=u25SOxCO3JB/utRYmekawJl9xgJ5rEi0zDDqVP5yErMJ0+rZL0mqcwEVoEjbUWK8er
         iskKeDvf/3xrXLW9XhYUogdFqxgVcVttf66xFVFor6veUwmn/WUMX6gPTbtMuOdqIK3G
         g95lgiuGMY70Q9eC4SB2i3GXbOVTgFhnSu3+joM6YUsOOyhSVb0V71K7TF7u5thBL44J
         3ilmgAcYacoqe/T3+yEQzT6Gd1PigrEr6ajV7FYF4Alc4sEGJRRFSpVGAur62HHc6+4X
         0sZvhZEuec3AyhNbVbDLVERcVRg4MvftfieVQ9A73LcXjcnhwh2UoKkhKtr5TbsPhyd2
         qXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVTN7b5L6Q8M7Gakr2H7R8BmSqA0Ma7LEj299lemVJw=;
        b=3bbezeABIaM8bnGfJGRFFi+HyND19hzAk/uEEnWirlZ6v9WBCgWzMHogh2ZVepaczM
         yR+QJwPXfsjhFfVQNaa6uOZyI86POekrKqBWh4aKlGwgTlVHOnG9u8JiorF1QD++dbhP
         2oagR8eOxmGccicDCezgJGgclrJxc6LMbWBnOcIORF3o0oYuZliakktuM3wlkRXEOxb1
         88CxzcrAg7Y2G5FUid69T548y+G44jEqm94D8lXhJDhfX2VPlJ21cI2m0mBERC1MVws0
         Mav2T9dYyY1+Wm2LwjtIesIHcDLYHxKPC5NnP5Zmp2Y4TKann54U+UyC+FCKjJFJ/aSQ
         N2Sg==
X-Gm-Message-State: AOAM5317JSVwSM2neBgccKl67U6YPOUZO0sPG39AX0ZcyW1aLXIA8Ji1
        bNKoZH5IeLiWHF8hQZKlzzJe+ze1yMohopcH
X-Google-Smtp-Source: ABdhPJx6msu2NmfNxTTO83aq/yuWL5QYRT5KBGPxUFW+4cP+SYRDslDr94tHFjMioTpxWIqZ8/xSQw==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr7744708ljc.460.1639522741463;
        Tue, 14 Dec 2021 14:59:01 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:59:01 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 05/10] PCI: qcom: Add ddrss_sf_tbu flag
Date:   Wed, 15 Dec 2021 01:58:41 +0300
Message-Id: <20211214225846.2043361-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe driver uses compatible string to check if the ddrss_sf_tbu
clock should be used. Since sc7280 support has added flags, switch to
the new mechanism to check if this clock should be used.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 51a0475173fb..2f9a9497733e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -195,6 +195,7 @@ struct qcom_pcie_ops {
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	unsigned int pipe_clk_need_muxing:1;
+	unsigned int has_ddrss_sf_tbu_clk:1;
 };
 
 struct qcom_pcie {
@@ -1164,7 +1165,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[3].id = "bus_slave";
 	res->clks[4].id = "slave_q2a";
 	res->clks[5].id = "tbu";
-	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
+	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
 		res->clks[6].id = "ddrss_sf_tbu";
 		res->num_clks = 7;
 	} else {
@@ -1512,6 +1513,7 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
-- 
2.33.0

