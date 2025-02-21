Return-Path: <linux-pci+bounces-22015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB0A3FD74
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EA73BE3FC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA62500C0;
	Fri, 21 Feb 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewkQ1nnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3E2505CE
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158609; cv=none; b=fZvzsWgSTPahq8n2fmqX50yNI5qyCCIlBno4v4aid+b48ib+v4jKx+yAaHzQlMuD4XUPsSgWPYbhoU5cQicNFRCm5yrSQ1wFj5pgzFwounjOSlUk4j37ZrtYOW94Q0cwR4NeFt2ElDNGhqpSHwVJv6chljPWKEigpjQrdJoU/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158609; c=relaxed/simple;
	bh=432o3LdSfGr+97dz21dol2E2CpCbQLWX6ldZdo4avtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPV+Wh5Y/EJCNqPTv1yijzuTtbHClQcsuoHsQ423pIuP9M2vIk+EfMmPueylZ/vCEEnqDgS334fJY/i5s3cyKcaQM8fl5NM7TVk4K5Uo7CFOwymNbmpYnkIm8s6ROMFYSXE8JPTereZK7BrC1ImuHpBtyMAlSz0brPs6FP4DIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ewkQ1nnX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ec47991aso33566415ad.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 09:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740158607; x=1740763407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4hJLC9ezjmzckiqXS2j2AvB+5mvndIMa9rBZc/aOjo=;
        b=ewkQ1nnXlyFvB5zHIFJ3t2AhzjOOJD7JfijAw1ZaYFA9RbjwVBT/Bq5dX6GfP+oZ17
         KmHWDOXfxzY3RZbpyvC6948sd54K9LPznvGYUazLVujEtSWiZX4i3pnwGw+TdsqzCgI3
         yoOirIIsWGUUGm3X4s+qL7VA9DITv4ArA6DKuUkjdH18nObD7ZErc18Pm6EWVAIWpMS9
         zsrKOqxJQvqKXSS/n/uEPsGtHPrrBnjJ8hsMy7DV9VJPI/X6OoOyeVM1no2kIidX55nV
         EeQEyFPrPL4gDqlT+Tz/ncXO6+hMp7uEiyQ+BPar4jTZw2D+/8rBTJvCXhz/Nwy98De5
         ZOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158607; x=1740763407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4hJLC9ezjmzckiqXS2j2AvB+5mvndIMa9rBZc/aOjo=;
        b=JLCnyr+lmVei3/6DmgiiXCBNP6lDWbzkgNTjKZq0IEIJpKEmbW/NRUkrVtHpiBVLCb
         TLz9R9Camh7WgxSIvlhzdMUxkD4wOCmX052iap10lmw+HT4M6iakyygK/LG1gc3BFeLL
         t45EMprj5FudVe5aY8sRK5C0oW4tgH4CiY9TH//a8UW5Sc1P1WrERfKmpk7UEECWJkvr
         ELURc1G7WzW05j7XfMbKsXF670TIIh8bmVSWh4ec0SDAd6rmJc2U3bapUT+o4XYc/xSL
         eRu4kRjGBpxeXxiuARd7/+k8uut6tMR6SK75hm/VI9NZQflXuOkBDlMoN41PnAYtylVD
         yEog==
X-Gm-Message-State: AOJu0YwZLxGkGWFObX1onuDmpkXcmvzAWieB7rIf7rNH3ybWlKwNcQR2
	DkyqsdAN4QQa5cF3YqRSiGgmx2dfiPOZjGXBqlD9GC824deM2JkjnycoRBuH1A==
X-Gm-Gg: ASbGncuFPqSOHc6qCtiVpVaBClT+odDLP3+Ehv9umWVe/N7btKbjb/9Dsz64evyo1Nn
	zsQdKXgVjcfJxcZhyAFXKeICnWcD0q1b3yDp0i+KGCyUv7d0BliG0DP9rM2lw2wGbeVrQY8EEqp
	4ewRA3nvlQ8lHc9FENKgDEj42wOa0o91jelqJwF9zofNcZRKDtfNBW9chhF2TcR44TPAqWjPHWx
	8kVZuPSU070R2evu4lkTijzqKXKTM386rH8cE0nXG0sIOKKzXtX0IsQXzPvslKejgR/sqxpFt83
	qLuNFOfBjBDDSLzzPL/rPapss6hgaIVspwrBCFtga46/6SH9ABsL
X-Google-Smtp-Source: AGHT+IFFxw0nkRkM5smllKdWbGW6yYHFF8V3927Y2RR95VX56SRlzaDxW8xBfx5wbngEvMWxjPsqAA==
X-Received: by 2002:a17:903:2349:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-2219ff28ef8mr66227175ad.2.1740158605605;
        Fri, 21 Feb 2025 09:23:25 -0800 (PST)
Received: from localhost.localdomain ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm141243405ad.148.2025.02.21.09.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:23:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dingwei@marvell.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] PCI: qcom: Add support for retraining the link due to link down event
Date: Fri, 21 Feb 2025 22:53:09 +0530
Message-Id: <20250221172309.120009-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
References: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe link can go down under circumstances such as the device removed
from the bus, reset condition, etc... When that happens, the link needs to
be retrained back to make it operational again. Currently, the driver is
not handling the link down event, due to which the users have to restart
the machine to make PCIe link operational again. So fix it by detecting the
link down event and adding support to retraining the link.

Since the Qcom PCIe controllers report the link down event through the
'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
bit in PARF_INT_ALL_MASK register.

Then in the case of the event, call pci_host_bridge_handle_link_down() API
in the handler to let the PCI core handle the link down condition.

The API will internally call, 'pci_ops::retrain_link()' callback to retrain
the link in a platform specific way. So implement the callback to retrain
the link by first resetting the PCIe core, followed by reinitializing the
resources and then finally starting the link again. The PCI core will
finally rescan the bus to enumerate the devices.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..ebc58e88161e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -55,6 +55,7 @@
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
+#define PARF_STATUS				0x230
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_DBI_BASE_ADDR_V2			0x350
@@ -130,8 +131,11 @@
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
+#define SW_CLEAR_FLUSH_MODE			BIT(10)
+#define FLUSH_MODE				BIT(11)
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
+#define PARF_INT_ALL_LINK_DOWN			BIT(1)
 #define PARF_INT_ALL_LINK_UP			BIT(13)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
 
@@ -145,6 +149,9 @@
 /* PARF_BDF_TO_SID_CFG fields */
 #define BDF_TO_SID_BYPASS			BIT(0)
 
+/* PARF_STATUS fields */
+#define FLUSH_COMPLETED				BIT(8)
+
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
@@ -169,6 +176,7 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
 #define PERST_DELAY_US				1000
+#define FLUSH_TIMEOUT_US			100
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
@@ -239,6 +247,7 @@ union qcom_pcie_resources {
 };
 
 struct qcom_pcie;
+static struct pci_ops qcom_pcie_bridge_ops;
 
 struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
@@ -274,6 +283,7 @@ struct qcom_pcie {
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	int global_irq;
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -1263,6 +1273,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pp->bridge->ops = &qcom_pcie_bridge_ops;
+
 	return 0;
 
 err_assert_reset:
@@ -1300,6 +1312,75 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.post_init	= qcom_pcie_host_post_init,
 };
 
+static int qcom_pcie_retrain_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct device *dev = pcie->pci->dev;
+	u32 val;
+	int ret;
+
+	/* Wait for the pending transactions to be completed */
+	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
+					 val & FLUSH_COMPLETED, 10,
+					 FLUSH_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Flush completion failed: %d\n", ret);
+		goto err_host_deinit;
+	}
+
+	/* Clear the FLUSH_MODE to allow the core to be reset */
+	val = readl(pcie->parf + PARF_LTSSM);
+	val |= SW_CLEAR_FLUSH_MODE;
+	writel(val, pcie->parf + PARF_LTSSM);
+
+	/* Wait for the FLUSH_MODE to clear */
+	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_LTSSM, val,
+					 !(val & FLUSH_MODE), 10,
+					 FLUSH_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Flush mode clear failed: %d\n", ret);
+		goto err_host_deinit;
+	}
+
+	qcom_pcie_host_deinit(pp);
+
+	ret = qcom_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Host init failed\n");
+		return ret;
+	}
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto err_host_deinit;
+
+	/*
+	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
+	 * non-sticky.
+	 */
+	if (pcie->global_irq)
+		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
+			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
+
+	qcom_pcie_start_link(pci);
+
+	return 0;
+
+err_host_deinit:
+	qcom_pcie_host_deinit(pp);
+
+	return ret;
+}
+
+static struct pci_ops qcom_pcie_bridge_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+	.retrain_link = qcom_pcie_retrain_link,
+};
+
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
 static const struct qcom_pcie_ops ops_2_1_0 = {
 	.get_resources = qcom_pcie_get_resources_2_1_0,
@@ -1571,6 +1652,9 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_unlock_rescan_remove();
 
 		qcom_pcie_icc_opp_update(pcie);
+	} else if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
+		dev_dbg(dev, "Received Link down event\n");
+		pci_host_bridge_handle_link_down(pp->bridge);
 	} else {
 		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
 			      status);
@@ -1732,8 +1816,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_host_deinit;
 		}
 
-		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
-			       pcie->parf + PARF_INT_ALL_MASK);
+		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
+			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
+
+		pcie->global_irq = irq;
 	}
 
 	qcom_pcie_icc_opp_update(pcie);
-- 
2.25.1


