Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E86C157F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCTOuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjCTOtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 10:49:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C127982
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 07:47:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so47619019edb.13
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679323641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD7ylI6TVHUGdBJgMovYJYcYKC/vfqGxmwJNLbiL6ds=;
        b=PkVWnB6X3c63HHvavZdeVbDn3Tx36qitT0fT6ic0Its1qN+eoMlxng6rqKjwWQDFyY
         whXJcFWvxPa9cqiHXs2Kkgw3YrCnW03UTs96YcZpLxXHD3EgHAON0LddK5jOZAmlXcV7
         S9TN/x2Y7cv1gHcJglVbmEyqWwlz2yXkcnC4r9WjqwFifBQedcDJYrO1AGJCARZfhjqX
         PXXPU2e/kM7Srb3kfYIwp/us0ZjYp7bu3xKgggdzmKmV3S5jR6vkd+locDC4tnj3GWVH
         +QD3N6tKee/XwzPoBx3DbsqIaq5j8jZqKJsewEm+i2QKDgyqR3WwCp6wH0ZURIYb7YbN
         oEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD7ylI6TVHUGdBJgMovYJYcYKC/vfqGxmwJNLbiL6ds=;
        b=A3CEPbpplX6GdTgrn04o/fu7W18VWZXuFBepy/iRNDd+TT6PesPNDg+JeEgLhoDP5P
         Q5Yw3XRzMjTMmkGoVfSVAVwpM8wkvKbxllgCaav7h9sK8MjxjcAuiyDI9P0c5bSAKL79
         8lbK1N4B/uyu2n585/GmLsVkyOGylQ/akxahI6EDudcQ6vUOA0FyVhUxSw0VXZ385vcJ
         kIyEgb9tD4JZ+k70jAcvFbgYn621Bcl9a9qhOgC24O1ROwHeifKQFNZU+bs0+5wVWheo
         aB3gI3QHI/XehQwe6JZ/eeC+JkZ7jKLMQHhK7T0ZcOTyMToH8jzRXcskS40qL095Njxn
         GvWQ==
X-Gm-Message-State: AO0yUKXHNP7dZSO2V46GtGfqHD/CfQRvcBqhjuj0F3qirAV7wVKMG2sf
        BL9pvsaxn21E1KrPWbJTcAGedA==
X-Google-Smtp-Source: AK7set9AXmDHkrfGSpB3Wj9T0K1GNyabMNZ0AJIw+bnZjLcG3lQNkav0xtkhhLFt0gjqJA/tL7ycxw==
X-Received: by 2002:a05:6402:7c3:b0:4fa:4b1c:5ea3 with SMTP id u3-20020a05640207c300b004fa4b1c5ea3mr12880116edy.23.1679323641641;
        Mon, 20 Mar 2023 07:47:21 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x2-20020a50ba82000000b004fb30fc1dabsm4913172ede.96.2023.03.20.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:47:21 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: [RESEND PATCH v9 2/2] PCI: qcom: Add SM8550 PCIe support
Date:   Mon, 20 Mar 2023 16:46:58 +0200
Message-Id: <20230320144658.1794991-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320144658.1794991-1-abel.vesa@linaro.org>
References: <20230320144658.1794991-1-abel.vesa@linaro.org>
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

Add compatible for both PCIe found on SM8550.
Also add the noc_aggr and cnoc_sf_axi clocks needed by the SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

This patch is a resend of the following:
https://lore.kernel.org/all/20230208180020.2761766-11-abel.vesa@linaro.org/

No changes since then.

 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..6a70c9c6f98d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[14];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
-	struct reset_control *pci_reset;
+	struct reset_control *rst;
 };
 
 struct qcom_pcie_resources_2_9_0 {
@@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	unsigned int idx;
 	int ret;
 
-	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
-	if (IS_ERR(res->pci_reset))
-		return PTR_ERR(res->pci_reset);
+	res->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(res->rst))
+		return PTR_ERR(res->rst);
 
 	res->supplies[0].supply = "vdda";
 	res->supplies[1].supply = "vddpe-3v3";
@@ -1205,9 +1205,11 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[idx++].id = "ddrss_sf_tbu";
 	res->clks[idx++].id = "aggre0";
 	res->clks[idx++].id = "aggre1";
+	res->clks[idx++].id = "noc_aggr";
 	res->clks[idx++].id = "noc_aggr_4";
 	res->clks[idx++].id = "noc_aggr_south_sf";
 	res->clks[idx++].id = "cnoc_qx";
+	res->clks[idx++].id = "cnoc_sf_axi";
 
 	num_opt_clks = idx - num_clks;
 	res->num_clks = idx;
@@ -1237,17 +1239,17 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		goto err_disable_regulators;
 
-	ret = reset_control_assert(res->pci_reset);
-	if (ret < 0) {
-		dev_err(dev, "cannot assert pci reset\n");
+	ret = reset_control_assert(res->rst);
+	if (ret) {
+		dev_err(dev, "reset assert failed (%d)\n", ret);
 		goto err_disable_clocks;
 	}
 
 	usleep_range(1000, 1500);
 
-	ret = reset_control_deassert(res->pci_reset);
-	if (ret < 0) {
-		dev_err(dev, "cannot deassert pci reset\n");
+	ret = reset_control_deassert(res->rst);
+	if (ret) {
+		dev_err(dev, "reset deassert failed (%d)\n", ret);
 		goto err_disable_clocks;
 	}
 
@@ -1841,6 +1843,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ }
 };
 
-- 
2.34.1

