Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D136600E10
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJQLsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQLsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 07:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406550709;
        Mon, 17 Oct 2022 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90C36103E;
        Mon, 17 Oct 2022 11:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC82C43470;
        Mon, 17 Oct 2022 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666007279;
        bh=E8/ccenRKIQU903OsMdJb6fnp8/h0tN8tiOOLCxh+7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pULQbl7yb4gPO7W1STGg2ilF21YSi1fuD9KxrcifsXTsweYK8p13GYFOPkR2OnTSX
         Hv7Nf4WtEn2GG0Ew5lwvFOfgn+JFjEqDFazmo02IGEusel1n2y34m6Wa8ygCmi7nA0
         PlRyCrJ+puDKf0gnTmDzK99ZVMKXHwjMXqwkRVMRU5oNuRRswHY0eO24r/AcsjwYre
         In4NXB80v5gVcjQmAoAflIRcBW6bB/jhSZHDu2z18EbEZhSz/6j6Ybc/ugahjMzAMc
         BtZ+trUeU57s6sE05Il83XlCjpXsVCzpRjel1M+igNxcRTKBlwqYZYmblox7FlwiuJ
         tIu8zL1CeQHUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okOay-0002B3-RD; Mon, 17 Oct 2022 13:47:48 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/2] PCI: qcom: Add support for modular builds
Date:   Mon, 17 Oct 2022 13:47:05 +0200
Message-Id: <20221017114705.8277-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017114705.8277-1-johan+linaro@kernel.org>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow the Qualcomm PCIe controller driver to be built as a module, which
is useful for multi-platform kernels as well as during development.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..230f56d1a268 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -168,7 +168,7 @@ config PCI_HISI
 	  Hip05 and Hip06 SoCs
 
 config PCIE_QCOM
-	bool "Qualcomm PCIe controller"
+	tristate "Qualcomm PCIe controller"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 417be4d225ed..699172c22ed4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
@@ -1820,6 +1820,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_remove(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	dw_pcie_host_deinit(&pcie->pci->pp);
+
+	phy_exit(pcie->phy);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1841,6 +1856,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_pcie_match);
 
 static void qcom_fixup_class(struct pci_dev *dev)
 {
@@ -1856,10 +1872,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
+	.remove = qcom_pcie_remove,
 	.driver = {
 		.name = "qcom-pcie",
-		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
 };
-builtin_platform_driver(qcom_pcie_driver);
+module_platform_driver(qcom_pcie_driver);
+
+MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
+MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

