Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07287479B37
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhLROKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhLROKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:10:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE0C061574
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l22so10758765lfg.7
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJD3i4LNvk3j5OqCXxhWKJZIrOos2jbPnsDYbhu5cbY=;
        b=U/R7IWDRxahH18MdtRwF1v9VXaR3mzszn8X43svfJb1nwJX4gSSZS66Buu+X2CJNem
         nJC+ETkBAGgaPp2SUTT/+cb63z+jg2Yu8BbFdP9kYrV38lpDDKbLdHf+WZxkxNbv3hTo
         x4RyY1tned1wjtXGViDgUSrrEJ7MWqJQBRAhxDCA64m5JsW673nXb30N8eAJIlShnt1C
         ZOUaymbwDFfpcAxawL1efw1k5IgxP6i0xVjG14urMNrIGb6UbsWK2mL20qdiw6xJ0iro
         5HIwts5KQuOYzLdS4RfZquG49xfAchug4+pXbG1OEOU77jT4JZ7yTkUWDfkCOIC6DyJn
         PEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJD3i4LNvk3j5OqCXxhWKJZIrOos2jbPnsDYbhu5cbY=;
        b=DdPmuaose4/Z9agly/L8W3ADB+joykvbLGixh2bvhLj28Hfs0egxs71RDpxXH0o9/6
         hv3e+Eh634Fi8n9qdUcARQ/cVSBBABV5RqyKceWZ8u8v4wdkIUTHDwDGW+O4GEz2dEQH
         m0oO5x+L4RxYVca4QdMJHg93WJHFk2lm7EpzBlI9ph2ZFULG5Ydr4GX1isJxCgin42vA
         4msZ8VKv+fQtf14TEJCT6tgjtENnSKZor3p21dZSBSM6NcyRy9FLrS3b4RNYFkfk3HW7
         kuzhwJN0oHLhObUTbMTdQQOsGsRYqikRRnmMz6o8Ueb10W9YxQWQQE+OwMx3ReDHfCCY
         Ddcw==
X-Gm-Message-State: AOAM5314vFQPr87Q9W4AG/cNZC7HsHumbQYvECs6vtS7M8Pe0dUzOkol
        5583fYWagz+0yNBKf9eLfy/REg==
X-Google-Smtp-Source: ABdhPJw4gmIsvWUIkTGVcUvJG7SDQCnhLHlVHWepghCKwDrLGuvKEp1/vSo8nQG5IhhVw7MYZRa6ig==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr7065881lfe.503.1639836636089;
        Sat, 18 Dec 2021 06:10:36 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id c2sm145789lfh.189.2021.12.18.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:10:35 -0800 (PST)
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
Subject: [PATCH v5 4/5] PCI: qcom: Add interconnect support to 2.7.0/1.9.0 ops
Date:   Sat, 18 Dec 2021 17:10:23 +0300
Message-Id: <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
bandwidth according to the values from the downstream driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8d400423a0a..55ac3caa6d7d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
 	struct clk *pipe_clk_src;
 	struct clk *phy_pipe_clk;
 	struct clk *ref_clk_src;
+	struct icc_path *path;
 };
 
 union qcom_pcie_resources {
@@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->pci_reset))
 		return PTR_ERR(res->pci_reset);
 
+	res->path = devm_of_icc_get(dev, "pci");
+	if (IS_ERR(res->path))
+		return PTR_ERR(res->path);
+
 	res->supplies[0].supply = "vdda";
 	res->supplies[1].supply = "vddpe-3v3";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
@@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
+	if (res->path)
+		icc_set_bw(res->path, 500, 800);
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+	if (res->path)
+		icc_set_bw(res->path, 0, 0);
 
 	/* Set TCXO as clock source for pcie_pipe_clk_src */
 	if (pcie->cfg->pipe_clk_need_muxing)
-- 
2.34.1

