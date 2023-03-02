Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE046A7CD7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 09:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCBIgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 03:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCBIgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 03:36:41 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92220551
        for <linux-pci@vger.kernel.org>; Thu,  2 Mar 2023 00:36:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso3123572pjv.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Mar 2023 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmxYusaZZcaCSm0sR5ZUszZ82Vp7I8hpbdJ8Cb+CdPo=;
        b=r9craTUyVx3uiDtRuxr4/PsO6K1XvUWzzxWl78/dUjOl/L8wD227JYgVbaPKALXV7d
         AwT7JyTJwWwqbbltakIJvLX7CLUB9tmZ1FAl26xyS0zQ4e2XWy2rNSyswo+znHykXIiC
         L64ErgYtW/eym+pT0buE046/tPbGvVYkktuAY8B6bPd8sNrozAnmkfHC/vmZLEAOoMp3
         M4qfTRtDIzP6p9xtkg40jGtlNXciUo0Qs2fXCIdEmBrglff/9oNBHZIWaxlkD1cMMpzg
         c2+DVFhE+Ma6GV881wTGMjyGitPtrtUuS8A3BgZf7ykT6iVpDyqmxJh1+m01dAvEkO4M
         JaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmxYusaZZcaCSm0sR5ZUszZ82Vp7I8hpbdJ8Cb+CdPo=;
        b=0flxpeY5MbLMa1tvDkMIPirB/xq5jdV1bP6y0fHCPeyN9ZGoje9ZDMXYS+C2Qn4Tji
         blWQjA1yP5sprWU0OQBMHHLOgQ4rQVf1lYEqds3T3QV2qP7ROld77vSPLm/QyKvdPUPv
         UK3lNG0j2/EX+ERZonBF4fAiLsTI13lKOt8T17ebVynlv40MxqLaC0lvPDk/RUDTmYr1
         pd06vYedq8IeXO/R4EWFshnQQlm3aNWASY+OlSy1p8XtyAsA2mLWJpw0G/NQMpZPqn5V
         lvIBFlsDAdS6n5E17S8ogVB0uwjD8/p3mgInu69yDb0mvYQ1l+3ewy4yYbHH3a4TMwTp
         uKbw==
X-Gm-Message-State: AO0yUKX7lHD7yFaWbpU0Cm7kOccy4GukmDl4EUbRuOhGrbZ7/cJn6K4v
        h6e8F3lSQqbd6eOKlsMQZDtB
X-Google-Smtp-Source: AK7set/z9bTIY3KHWMDcd0q6mvDWU2SD8PHHfPO+bvu6xJYNkMZLXx5iYVwJ6PLrvUr0JyNNI9Jlzw==
X-Received: by 2002:a17:902:da90:b0:19c:e405:4446 with SMTP id j16-20020a170902da9000b0019ce4054446mr10433381plx.30.1677746199325;
        Thu, 02 Mar 2023 00:36:39 -0800 (PST)
Received: from localhost.localdomain ([59.97.53.52])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b00198ef93d556sm9791912plo.147.2023.03.02.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:36:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v2 1/1] PCI: qcom: Add support for system suspend and resume
Date:   Thu,  2 Mar 2023 14:06:25 +0530
Message-Id: <20230302083625.188482-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302083625.188482-1-manivannan.sadhasivam@linaro.org>
References: <20230302083625.188482-1-manivannan.sadhasivam@linaro.org>
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
Acked-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..7147f0103026 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -227,6 +227,7 @@ struct qcom_pcie {
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
+	bool suspended;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1820,6 +1821,53 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_suspend_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	/* Set minimum bandwidth required to keep data path functional during suspend */
+	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
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
@@ -1856,12 +1904,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
 
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
+};
+
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
+		.pm = &qcom_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(qcom_pcie_driver);
-- 
2.25.1

