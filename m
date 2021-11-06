Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E426446F6C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhKFRrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:47:39 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:61781 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhKFRri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:47:38 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jPkMmPfIJ2lVYjPkMmWPFM; Sat, 06 Nov 2021 18:44:56 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Nov 2021 18:44:56 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, pmaliset@codeaurora.org,
        swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: qcom: Fix an error handling path in 'qcom_pcie_probe()'
Date:   Sat,  6 Nov 2021 18:44:52 +0100
Message-Id: <4d03c636193f64907c8dacb17fa71ed05fd5f60c.1636220582.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If 'of_device_get_match_data()' fails, previous 'pm_runtime_get_sync()/
pm_runtime_enable()' should be undone.

To fix it, the easiest is to move this block of code before the memory
allocations and the pm_runtime_xxx calls.

Fixes: b89ff410253d ("PCI: qcom: Replace ops with struct pcie_cfg in pcie match data")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c3d1116bb60..baae67f71ba8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1534,6 +1534,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
+	pcie_cfg = of_device_get_match_data(dev);
+	if (!pcie_cfg || !pcie_cfg->ops) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1553,12 +1559,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie_cfg = of_device_get_match_data(dev);
-	if (!pcie_cfg || !pcie_cfg->ops) {
-		dev_err(dev, "Invalid platform data\n");
-		return -EINVAL;
-	}
-
 	pcie->ops = pcie_cfg->ops;
 	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
 
-- 
2.30.2

