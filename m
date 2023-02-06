Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E368C8BF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 22:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBFV1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 16:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBFV07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 16:26:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E72FCF5
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 13:26:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g6so3763100wrv.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez7bc2hM9Q2KuG2DJP6cKQFAIIvaaSgTYSRQvKQGrcM=;
        b=x/5O492HPgenq2vZj6PW59Y3+LmDgpzFp26WiEH8SNnJEPwZdCh8JfufJEhOzhkWAE
         v0ESaSxSdIVe3ZnsJZrUTmmtkpbB1UE433r5s6JaaUnbKvQd9mewehDe9qbBd2mZfBGx
         iXvJ8mL10CXhmJi/ovaVZBqt56WiRva84bwUCd1DsPGdB7O0MDxYGqayO0DfLjMoQcsb
         zMyrJEVwdUiI1mGEJEFUA44EzrF2nIYW6leoGthZoM27jGxBZwm1B9RoqdNmR3wfGfeb
         lW04s352UK1sC3CVLPj2V1qXEtTeVy91YJKD4Q/CrDgNsp5l5LUuxn7v/vZOM3T+BwEy
         9IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez7bc2hM9Q2KuG2DJP6cKQFAIIvaaSgTYSRQvKQGrcM=;
        b=umEO9T4gNHq/Ru63qEHFuB1EghpIDfOywDsN+AvTbiYZ2/84uqAuFYleiRalyC/8Nq
         tVIC1CuVCVZf7nLOAfNP4OJH6pgANVMygGah5r20iErVQIh5foZmtAbG2t92FdPv1SYI
         FoBb+5+fhqH35vGfxeTlQBD/nKHjyAd6Dljk5mUAbh0JeutmfaB2YDkj4o3yhXwp38id
         ECRcPxLNqaqlga63iE64yOC8fB0WboaAqhy2VANaeYD8Y2Q8hMCI9IbXVbf005YpdO1+
         wIm8gERhyrMR2+dPL/kv2hqp1/s++VNu+013ts4O4mrOVn8ekaIOzFmMQ7+iceHC6SLh
         aqGA==
X-Gm-Message-State: AO0yUKWR41IASDLw0auiMRP3s2ocgqHrZ3jWa8Dzl8t1I4mcO+OuoLhG
        vMwd85058sHW5WFYXez1WJD62Q==
X-Google-Smtp-Source: AK7set/SGb98YE+khd54yfvIA6M37cB5LceKV9vcIEkV22StmusBhY3oyp3xLwy8urDU4o+Ol4Lwuw==
X-Received: by 2002:adf:e550:0:b0:2c3:e392:67ae with SMTP id z16-20020adfe550000000b002c3e39267aemr4198494wrm.3.1675718798574;
        Mon, 06 Feb 2023 13:26:38 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:38 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 10/11] PCI: qcom: Add SM8550 PCIe support
Date:   Mon,  6 Feb 2023 23:26:18 +0200
Message-Id: <20230206212619.3218741-11-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206212619.3218741-1-abel.vesa@linaro.org>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---

The v7 of this patchset is:
https://lore.kernel.org/all/20230203081807.2248625-11-abel.vesa@linaro.org/

Changes since v7:
 * Mentioned the noc_aggr clock in the commit message as well, while
   using the cnoc_sf_axi instead of cnoc_pcie_sf_axi

Changes since v6:
 * none

Changes since v5:
 * none

Changes since v4:
 * added Mani's R-b tag

Changes since v3:
 * renamed cnoc_pcie_sf_axi to cnoc_sf_axi

Changes since v2:
 * none

Changes since v1:
 * changed the subject line prefix for the patch to match the history,
   like Bjorn Helgaas suggested.
 * added Konrad's R-b tag

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

