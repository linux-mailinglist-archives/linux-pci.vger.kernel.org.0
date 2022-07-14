Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333285745B1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiGNHPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiGNHOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE464F3;
        Thu, 14 Jul 2022 00:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4750FB823B6;
        Thu, 14 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BEEC385A9;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=IdSAK22OC80TwPDl5qaqEIwjKFxH2GdguGqGtvJC310=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/t8NbN98OuPq/ffv7okmWtX/yCwl9pS5PvcCe+UvuUiPP7du2JGpxYTOwO70j9YC
         ahlB/998iWqBJ9dlsFnDsEZiTDAW9JNkRtf+0ZMTf43f15NZ6YW2zm+QFxHH5EB7f5
         QIXDbAa8/pSiaYMjHyKbGNr6aVJTj+wY4om4keP2FeiV4ej7IC4Xkv+LYibc9ej/fQ
         txGJxHk9cupoxyJ1Zo6qm9zAh48tlCTsSytrgVoGfHYAl+isxvUgDD6HBS/JCkKbDo
         jxmFl6xx95QrS8ncaV4AMnMkPb+GfBarbmp+EY2uqWD7vkYrhI5SWcEmJcyf+47FnG
         1TIF+BLErMDcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001mF-E4; Thu, 14 Jul 2022 09:14:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/8] PCI: qcom: Add support for SA8540P
Date:   Thu, 14 Jul 2022 09:13:45 +0200
Message-Id: <20220714071348.6792-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Note that like for SC8280XP, the SA8540P controllers need two or three
interconnect clocks to be enabled.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a79bec81bba..699cd8b0f38e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1634,6 +1634,11 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
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
@@ -1803,6 +1808,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
+	{ .compatible = "qcom,pcie-sa8540p", .data = &sa8540p_cfg },
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
 	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
-- 
2.35.1

