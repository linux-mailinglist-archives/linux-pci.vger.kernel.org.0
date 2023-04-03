Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F56D4C7D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDCPuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjDCPuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 11:50:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02C1709
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 08:49:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso31018474pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Apr 2023 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680536973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBTkdifLldOoK702yw2O+8amhS0iBYV6kXphjAkmoec=;
        b=Eu12D/azwm9BEw00yO8Gb9FJ9uL2qVrwmMutPMrbv7DuZDl9NjDgUYZ0DVZLRYLDKg
         m745TZpOtf/5V4Ou7+3hByBlx/6v1f8FE0MYnaVRYFb/CcvswncKE3s1SU6ncWcuX6B+
         d9p2ejxbM0h/DQblZQb0Ql3WMkT+j1dvgKdQNScwPx7Ayhk71vh50mdcYnSWDoM9rAoa
         9EDmsWoMSV2fpAdOMNEy5HC3mkYougv4wFeYxqSKoQK8HkC1UOa5xXBaI7wYhz0ijDbc
         tAKKf6eLzx+OP7aa79jh2RtYdzuH7xcqWuUOJtybO47ILBKJEyfcq0VJx+/ZKh/EL+Ix
         Hq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBTkdifLldOoK702yw2O+8amhS0iBYV6kXphjAkmoec=;
        b=8FNzeYgys/SQshpKanQg3ievm0d6hRZ/IneYW8LVWm0CzBCPCgfLa2TRuGnFq+LuQ4
         JKg7MoBBgM+7UQN4wNiGPerigB7ILRr4rlQBa4QFuz1euNoJ9C1TIJif/NfnZM7rnDX5
         jwo8ejYHsZHJUhOb1vOHAb5OnRmDLFBWzOqBSZbEyDNo8KuWLz3v0OBeM82pebig/Ow3
         s6LtR/xUbiQ3LPlbDfke6TyNK1B/4va2PurXcp1ZEpV/g9NQduhCuidUhcV3iFQJswIP
         9/EVEdBfYA6jDVQWmkk3zCg3M3utHm3ep0RzOO/2w8x5sfX32Vq7rhwCCGSFxXDpdJ5X
         PUHw==
X-Gm-Message-State: AAQBX9eyh6VQtst7ykeSVmskF3v8rkV/uCAgPeW2YzOecaO87wpE0Xae
        VKmdAM0Wop9TgWGX83P7/BGu
X-Google-Smtp-Source: AKy350baUUUq+3+L7relPUOphGHPyMY/3J7rewDMI/6skhaWoI4i1ofzSnS7cKu4FEhvRWssY2SNGQ==
X-Received: by 2002:a17:90b:4c0c:b0:233:d12f:f43a with SMTP id na12-20020a17090b4c0c00b00233d12ff43amr38613726pjb.1.1680536973170;
        Mon, 03 Apr 2023 08:49:33 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.109])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0023af4eb597csm9621534pjc.52.2023.04.03.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:49:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v4 1/1] PCI: qcom: Add support for system suspend and resume
Date:   Mon,  3 Apr 2023 21:19:22 +0530
Message-Id: <20230403154922.20704-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
References: <20230403154922.20704-1-manivannan.sadhasivam@linaro.org>
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

During the system suspend, vote for minimal interconnect bandwidth (1KiB)
to keep the interconnect path active for config access and also turn OFF
the resources like clock and PHY if there are no active devices connected
to the controller. For the controllers with active devices, the resources
are kept ON as removing the resources will trigger access violation during
the late end of suspend cycle as kernel tries to access the config space of
PCIe devices to mask the MSIs.

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
index a232b04af048..98d25fcbf512 100644
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
+	 * suspend
+	 */
+	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
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

