Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED452CFAE
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiESJsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiESJsI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 05:48:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DD6970F;
        Thu, 19 May 2022 02:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 215EFB823D1;
        Thu, 19 May 2022 09:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A86C34115;
        Thu, 19 May 2022 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652953684;
        bh=57BVf0E0AW4jg42qrBzZjFie9oQ3lk6GdIX4iZM+xc0=;
        h=From:To:Cc:Subject:Date:From;
        b=EjYKQHD5vZbV/WE575LbKi5vNrbR3Rr9gDl7yghC7vaQ+c5Wx1etsL8kokUYhDXy6
         7/xrFpVo1z62Ht48NVoW3QmPQ+bmQUJXT8207va7qXUUdTONzgps9ZQkK7ZAVoeLOR
         z4rsCqwp6TPPNJpt8nLdTHUu/ZmnN6yX4Q8ubGP7PeyPV3gYbdVgVRWp2RWhiqY45h
         NnEhUga/pss3k50AQMcEnp7IMkR0wTMCwBgQXMvqD6sH4GVFumo3Vlll5xwPvlzXOL
         TqkfBGKKQc4Gxo6Fad1ah4I7H1jmBtYH5I6ZB4+qHMC8+VoxznrQtUXhU9NXgl9mNM
         YIS7ZzfoVWHFg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nrclJ-00060Q-K5; Thu, 19 May 2022 11:48:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] PCI: qcom: Add support for modular builds
Date:   Thu, 19 May 2022 11:46:46 +0200
Message-Id: <20220519094646.23009-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow the Qualcomm PCIe controller driver to be built as a module, which
is useful for multi-platform kernels as well as during development.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 4 deletions(-)

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
index 8523b5ef9d16..e25d5c09657c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
@@ -1425,6 +1425,15 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
+static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
+{
+	qcom_ep_reset_assert(pcie);
+	if (pcie->cfg->ops->post_deinit)
+		pcie->cfg->ops->post_deinit(pcie);
+	phy_power_off(pcie->phy);
+	pcie->cfg->ops->deinit(pcie);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
 };
@@ -1651,6 +1660,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_remove(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	dw_pcie_host_deinit(&pcie->pci->pp);
+	qcom_pcie_host_deinit(pcie);
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
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1669,6 +1694,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_pcie_match);
 
 static void qcom_fixup_class(struct pci_dev *dev)
 {
@@ -1684,10 +1710,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
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
2.35.1

