Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556F560251
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiF2OMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiF2OMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F882E08E;
        Wed, 29 Jun 2022 07:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF32B824B7;
        Wed, 29 Jun 2022 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE27C341CE;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=v0eVaS3PBQTamh6cRAXZ5AqGfuYojlDjnveI93v18rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIPyXyanWiEFs6QCHay6xZzD5iRqofl69DvTGzoudch6PR3bEji/pv1rvqcpm6XvR
         U44YDKBIdgVq2anWg2rlCoX9vZcgsTmXS6aC0MsmpNnb/2tTH6Qz57v1iyZF2QmlOw
         k10EuB5YvWHKBWhwQJezY/93Tat8SxNk9fRLaQPz5/cuHtf1lFWrBmGwkHBfEju1AR
         /RP/U8Q5sp7wvXrCR7274LpHkE8UpYESu+R6EueWYyjh9+Ni9ZdsVsvJ/PWdQvH+Zg
         YFnKZ4x5PpHBwUqJJJjGxwuaYFFTUONX973x1zv2On3eiSpFNLD5aD0bkzK31Wdmpu
         bphks+e7Rx7uA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQe-0004lN-TX; Wed, 29 Jun 2022 16:12:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/10] PCI: qcom: Add support for SA8540P
Date:   Wed, 29 Jun 2022 16:09:57 +0200
Message-Id: <20220629141000.18111-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629141000.18111-1-johan+linaro@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SA8540P platform has five PCIe controllers: two 4-lane, two 2-lane
and one 1-lane.

Add a new "qcom,pcie-sa8540p" compatible string and reuse the 1.9.0 ops.

Note that like for SC8280XP, the SA8540 controllers need two or three
interconnect clocks to be enabled.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index da3f1cdc4ba6..8ab88e5743da 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1461,6 +1461,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 	.ops = &ops_2_4_0,
 };
 
+static const struct qcom_pcie_cfg sa8540p_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+};
+
 static const struct qcom_pcie_cfg sc8280xp_cfg = {
 	.ops = &ops_1_9_0,
 	.has_ddrss_sf_tbu_clk = true,
@@ -1626,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
+	{ .compatible = "qcom,pcie-sa8540p", .data = &sa8540p_cfg },
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
 	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
-- 
2.35.1

