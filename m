Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA16CA620
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC0Ni6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjC0Niq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 09:38:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFB59D6
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 06:38:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u10so8450133plz.7
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679924320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlUhxZtTocfXELpvEKmzZqrwx3UgsE37/RP0AJKegdQ=;
        b=X5+yPGerKGUvVqU1BxVZnvCpGawgV7XhiAR2mK8UUv9lQIFnBiqh39gQg269ZE6OB2
         wFFGi+NXsOwuF3sVuHXozgNz2VK4PHZtAB8+Y7YcfcEX/ec63ML0qsW/JDRVLUUkrcf/
         iqLj7XTLRyBatYSIZhQfpE5xPO+QQbIzymWnlZhcmJ4UNhPXC3O7BhhUdN+m46jK6Prk
         OnmJ1xGc8kijdV3KrYdgGaYKcETSvgj8MbsBjWyI3jR0cL+yDDtV9G4eW71QZH48o1C/
         dRcba60Ny9CEfxv9bZ/cLsg1pvhl+EyfM6XWthg4kSxhuRK/NvBrXIMwJXagJnRnTGQP
         Q7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679924320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlUhxZtTocfXELpvEKmzZqrwx3UgsE37/RP0AJKegdQ=;
        b=hNoxONpOttkaJRvs55WJ/144OIjNSMwINvn1fxkDCg5OKd+XgK74oXhwLuyyrQxorT
         bzxSJolsoFk8wOccB+jirB1QBP417XaOZJb5bHPYD/4lT3CLR7TM9ew4jYKFYUsSvL1X
         vCzkEDWOevFsMzayAZlIRHOOAEFIyyNpH34GOswMs4WWKLI4sT3sI7SS/jIatkOKZ3ub
         OBiPsbhO8OkttqHahD3PoOhvNQWFmAWh0YNnx6xliTD/mABcYpoTuXVQXAzdgdhGh2Mz
         xjUVcK/x8IyP6RsEXE23167xW+1X9LVhWArsrm13FE4ZpjUCHjT4QCKl0rLF/QoB626J
         JsMQ==
X-Gm-Message-State: AAQBX9f8qFFN7nvLLT+you9N/PF9FLNumEMDugjwr5x0cjLrwHIIu+Vv
        VnvEY2PSM72nJO3veWXtrFax
X-Google-Smtp-Source: AKy350bH0Ne6ntCWly/rerByN7MgS/5gUCbKt3pHvbZ0h+Bnd/tYsp/HB9lhC7tJCPWa/0QqRDZbtA==
X-Received: by 2002:a17:902:fb08:b0:1a2:1fb9:3b2 with SMTP id le8-20020a170902fb0800b001a21fb903b2mr9573410plb.11.1679924320374;
        Mon, 27 Mar 2023 06:38:40 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.38])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709028a8600b00194c2f78581sm19187668plo.199.2023.03.27.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:38:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and resume
Date:   Mon, 27 Mar 2023 19:08:24 +0530
Message-Id: <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..f33df536d9be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -227,6 +227,7 @@ struct qcom_pcie {
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
+	bool suspended;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_suspend_noirq(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * Set minimum bandwidth required to keep data path functional during
+	 * suspend.
+	 */
+	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
+	if (ret) {
+		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Turn OFF the resources only for controllers without active PCIe
+	 * devices. For controllers with active devices, the resources are kept
+	 * ON and the link is expected to be in L0/L1 (sub)states.
+	 *
+	 * Turning OFF the resources for controllers with active PCIe devices
+	 * will trigger access violation during the end of the suspend cycle,
+	 * as kernel tries to access the PCIe devices config space for masking
+	 * MSIs.
+	 *
+	 * Also, it is not desirable to put the link into L2/L3 state as that
+	 * implies VDD supply will be removed and the devices may go into
+	 * powerdown state. This will affect the lifetime of the storage devices
+	 * like NVMe.
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
+	int ret;
+
+	if (pcie->suspended) {
+		ret = qcom_pcie_host_init(&pcie->pci->pp);
+		if (ret)
+			return ret;
+
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
@@ -1856,12 +1913,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
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

