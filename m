Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF765BB6D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 08:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjACHtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbjACHti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 02:49:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF7DEFF
        for <linux-pci@vger.kernel.org>; Mon,  2 Jan 2023 23:49:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w3so157581ply.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2023 23:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UK7YFXk4569dzdxh4KbKdmm7jq8EMlrS+pPCmhUndQ=;
        b=XDzlCQKQP7cwi2YOhJd1r6+8fWXBSxLqj1d91S6NVRw2GvouAuIrW11piBS0LbVASB
         xhYe0r8UzoBgjuvzds8MZzmpfZr9jCHfjRcdhXOffIdKPFSAHvqTcJ99+1itBH4jCzrD
         Gg941FAUFxgIJcvmFImp/IoLscUKwKnuKP8vzCmCAqKnf55xuF9dE9/kLxQiDHUeGZ7g
         myJuTPLZspUnJ2QRZFDFQ+v81mzvniVeuZLDlbsRjMNPlVyGVxwylXM2ArIRXvDPvfMT
         fQEM/uOWRB6G/PDDa/ilwX61QKrszuQXi+Vo1e7LHBGQ24J5OkIpZ1YxZcQfiFuJNGb0
         N2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UK7YFXk4569dzdxh4KbKdmm7jq8EMlrS+pPCmhUndQ=;
        b=3VIHMDoUnL3nV5bCUomej1RRt8TfcY+/K21zfSQ7dazrDVLOCDIPF+MXyLOpDaYVON
         ZToPw4O/qvlbkBvTGKsnMJTJJMrudm9/eNYqOrkKl72Qef82/ZtiZVEJMu5Z3+NrPs1W
         p2w8dHCI8PEoXhGqCZitGhNNEVz0zLAooFkxD/rvSuZKeA4sKyAyfwmk2oMFDR0pvlRL
         dZXCMqYdcL84hQnHvldNUzqZ43x6nUJSt+zU/KN1QZTzJTXLcTpcFzvszSXh7XrE+GiK
         txtvoNxR9pT7USOLwacVdApWIsHeTrIvKy11pdUJHZgMgfJB6UwYiOlts7HnL28+nHV2
         pzvA==
X-Gm-Message-State: AFqh2kqqNrcERxMcNJN1GZAE8y5j1sO7b+iJ2lwZ83/haTSwYB4FCzvv
        jYBRDR+d2FRuGGTy3kBEUcYs
X-Google-Smtp-Source: AMrXdXtFMktovzCOg4tFENrBTa3mQYE51u9xwXWiIO3ejRqkE6tgE2Jfd7tcUcaULuWXniEveqh/JQ==
X-Received: by 2002:a17:902:e1ca:b0:192:caf4:4661 with SMTP id t10-20020a170902e1ca00b00192caf44661mr6241295pla.15.1672732175859;
        Mon, 02 Jan 2023 23:49:35 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.30])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00189f2fdc178sm21488305plh.177.2023.01.02.23.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 23:49:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Date:   Tue,  3 Jan 2023 13:19:07 +0530
Message-Id: <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
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

During the system suspend, vote for minimal interconnect bandwidth and
also turn OFF the resources like clock and PHY if there are no active
devices connected to the controller. For the controllers with active
devices, the resources are kept ON as removing the resources will
trigger access violation during the late end of suspend cycle as kernel
tries to access the config space of PCIe devices to mask the MSIs.

Also, it is not desirable to put the link into L2/L3 state as that
implies VDD supply will be removed and the devices may go into powerdown
state. This will affect the lifetime of storage devices like NVMe.

And finally, during resume, turn ON the resources if the controller was
truly suspended (resources OFF) and update the interconnect bandwidth
based on PCIe Gen speed.

Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5696e327795b..48810f1f2dba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -227,6 +227,7 @@ struct qcom_pcie {
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
+	bool suspended;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1835,6 +1836,52 @@ static int qcom_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int qcom_pcie_suspend_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = icc_set_bw(pcie->icc_mem, 0, 0);
+	if (ret) {
+		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
+	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
+	 * (sub)states.
+	 *
+	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
+	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
+	 * config space for masking MSIs.
+	 *
+	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
+	 * will be removed and the devices may go into powerdown state. This will affect the
+	 * lifetime of the storage devices like NVMe.
+	 */
+	if (!dw_pcie_link_up(pcie->pci)) {
+		qcom_pcie_host_deinit(&pcie->pci->pp);
+		pcie->suspended = true;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_resume_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+
+	if (pcie->suspended) {
+		qcom_pcie_host_init(&pcie->pci->pp);
+		pcie->suspended = false;
+	}
+
+	qcom_pcie_icc_update(pcie);
+
+	return 0;
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1870,12 +1917,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
+};
+
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.remove = qcom_pcie_remove,
 	.driver = {
 		.name = "qcom-pcie",
 		.of_match_table = qcom_pcie_match,
+		.pm = &qcom_pcie_pm_ops,
 	},
 };
 module_platform_driver(qcom_pcie_driver);
-- 
2.25.1

