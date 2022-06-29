Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5A56023E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiF2OMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiF2OMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115832E9FC;
        Wed, 29 Jun 2022 07:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC0E61EF2;
        Wed, 29 Jun 2022 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA1C341DF;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=RzV9WoW/wVhCUJ1SeVlcZLX/bhXZa+s9p20TuF8bp6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5S/p55QvOe8QAcheqPSPRPpCc04mcV1/47atDTMRzuZwN4wOYmDgxEon1KJDxTRG
         OmcPwpeP7sSfpk2xzGH8FrTSy3PYX3FZrpIcvwgoW644Zz6HtA3CUymTsh1Yd38Dju
         hk+z2LEo//GiUD9fuZETvrMewzAiDswH450f8riFjApl69F0VaYNZtnx4ZqH6/9Axs
         x4deDFHAq/Tyrv2llnBtgRnakABfHmy7YnUS1jSzJM178RBFkDTKlaaabKj8llYE7Y
         qsKOmR57o7Wx9BTGaFpTNQOzPqvA/I1A4l634zqMpIHxL/TjdFAJJq9oAwbQoi6aea
         c27oQuRFsAb+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQf-0004lX-6h; Wed, 29 Jun 2022 16:12:29 +0200
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
Subject: [PATCH 10/10] PCI: qcom: Sort device-id table
Date:   Wed, 29 Jun 2022 16:10:00 +0200
Message-Id: <20220629141000.18111-11-johan+linaro@kernel.org>
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

Sort the device-id table entries alphabetically by compatible string to
make it easier to find entries and add new ones.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 567601679465..093f4d4bc15d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1572,23 +1572,23 @@ static int qcom_pcie_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
+	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
-	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
-	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
-	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_match);
-- 
2.35.1

