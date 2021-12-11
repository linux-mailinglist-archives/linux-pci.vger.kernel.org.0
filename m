Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1014710B8
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhLKCVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbhLKCVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:21:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FEC0617A1
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l22so21168160lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVTN7b5L6Q8M7Gakr2H7R8BmSqA0Ma7LEj299lemVJw=;
        b=fX7/mVf1mpwhGeYX8NJmDHnFlvT8Ji0EZbFJlVGZtA88DN00jWmZ5yjlUVXGRYI8N7
         Mkvj+pJEBZ5fR+fel3eMyYZoziraTQBSkcJqo5t8VslNjm26git837WGBEzo6TWTgr2q
         wFSeDU5FYShbKFhSRw9eqhi0WNc9qiBMFhL+Cm1ldXBBRRquE2GphhZnk53xFfl3np/C
         8PgkH/HP06SzG+88LtRodKSAaDvKIu6Uww8bx07/GgCk9y2Om1Vr1jxGOQ9eRwl1F0AB
         wHTXzBhq+PSAS5ZMLPKdd5xrD2/9JTHpCNuScN5Nsaqhzzw2YRbEtlBbA82yzi81HKWc
         z4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVTN7b5L6Q8M7Gakr2H7R8BmSqA0Ma7LEj299lemVJw=;
        b=qKeRfa9DByScHDJ0INbF3W5aXhj8khx50ozp+smV9cS7jvXixzFQ1eP+8pGyP9tQ2H
         1yhYJw8aCQcQb2Whc4qaWuHcl0mTR8k/er4+hlJQiJg3soSfnT3sGKbR8/fEJCez4Gg7
         BEyPxvVHWoM4DNRXPCt8CxgUZZNCJnLa9DGf3PKHl7F/ydr3nImwsT40VeS21d5EgP64
         m1WgcoMZZkRt3rRugBJNs3R8nmbTGtPmXkLOBjoVQNSrg6vqoQnrCCpbeVCLTGqFjMfg
         u01JeRdVArt//qAVxSqirf+709ckzpdYRkIuLLl1JaZ4cvTVAz8oWchYvVZy3sXZnRI/
         UwKA==
X-Gm-Message-State: AOAM5320lHvLfPD4eEjhw7NCyo4JLZ7fFSeRXsZ4o5/O2jEM71dbU4ZX
        o0gZL7kcDFNRxax4G3DAIoxuFA==
X-Google-Smtp-Source: ABdhPJxI/E5VB6V/tJQHzMswPN2CPUgf4CckzS9pZ5XYaNYsLVnnRoLc9eY44Gd2DH6oNUvTkTsjWQ==
X-Received: by 2002:ac2:4d97:: with SMTP id g23mr15876898lfe.200.1639189086568;
        Fri, 10 Dec 2021 18:18:06 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y7sm504663lfj.90.2021.12.10.18.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:18:06 -0800 (PST)
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
Subject: [PATCH v3 05/10] PCI: qcom: Add ddrss_sf_tbu flag
Date:   Sat, 11 Dec 2021 05:17:53 +0300
Message-Id: <20211211021758.1712299-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
References: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
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

