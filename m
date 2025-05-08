Return-Path: <linux-pci+bounces-27428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8381AAF46F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2E03B902B
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14560226D04;
	Thu,  8 May 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmbThB9r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB59221D96
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688245; cv=none; b=fh54Gzjq0M0aOG+Oho5W9vnbK/V5JtEE+la6xnhfevJEPRvHdxUSEvOS/KPQLPDRoPjtdxzlVhGhSbT4H45W7kzppzYSBp+iBvsMnr/aFfQzfpJB/ehjSLFusl5RzGFUh3Vl+wkeVK1QMAFteQjCPIYdjS6iwzdQMK1q2SeZvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688245; c=relaxed/simple;
	bh=Xhfd2aLgY7EkLO7Pad4MqFaMxVqdKEiC/l5bXSdXFT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji/DNIdkCQaVU1OzIE1CFUb1HgVZjkPa+yxC9wBJlDPcVtprqMoLX+NsW56sulPOZB7bKevYpNfNFtjCm3XdFbE8N9b4EIMeiW4rQTOvOGDxRI1MFCQ4iJq/sNPpsEBA8zW+3yLhCSmcjvwyFAXjG0GSt76psRVWz/NYZi1MWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmbThB9r; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso4112055e9.2
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 00:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746688240; x=1747293040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxqvv2kVznygyMpPQhBBuZdHRKOaCwcOHj02WM+6aCA=;
        b=NmbThB9rpv9kLKCziymX/D1Ys27ghz/K1q9W+3PENBOFY3S8ejfih5uprAVr/yOxwE
         8cXhtfuVu2fGMcB0cH+vSkIoOjgpwXkd49PGRLk6+RTUWcNWxF4IYMEKqbElt3heEatU
         RI9xvtLmKo9xelfEXWDkDJ6kyLYHaaUm1ZTWaDy11kpXAoz++Q9sohZ8jLYsoIxyoyy9
         Yls4JdtamQS2QGA00r7OIEomJt7QXMBcr5R++EfW9LyqxEb4QvxKoqiI8xtDpXTUN6s2
         B7WyGJis2jhlhHrWwWyd69Pm6+Y9FMmoP36shhRTO7v3LjcQOImfFF3sOcjaawtHl5oZ
         Bssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688240; x=1747293040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxqvv2kVznygyMpPQhBBuZdHRKOaCwcOHj02WM+6aCA=;
        b=N7NT5xcXAx4lKD+t4CUntTtobpOGhr03RCiASImsP11DD1t6pQRp2rtNJcnBKSc1hh
         OW/iMsCeNTlY8RyQnp/Vs61taad6UVbY6ljiXvnVJzHDnOWcMUhCbv2P8dKFtonCWTvs
         dCkiziqz+pb3AitJOUFJyfUZcdsPnV4I5mjoxj3Ua3dY+MmIYt8cmTfgbfu/9MR6xj1q
         VCGGohM0BGqjdq0l1CahrKcHqtfuDFMkeMaQ9Mn3RH5tDGKuoP9hZTBbjjgwbr3eXeNS
         OhQAnBlGqPoev3UlyE4mLo4u2jp5mkyicZ3Dda42tFqfY/k6+K38kuzw8fdnkaaLUeSp
         Y2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS6SJ4DYbaATOMme+aoSKG/WdyMpcJAplQHE1zl9ncvKa+XN4Ml1xzKEFHYkAz3Cep3U3jQz2NIWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8a+pYECU0HlGteOh27nPZ+y/etGZMiLZ4vOSilnB9UKR4qP+
	k+Il7zN8MJY0BDBCysI59WVla0ph5M9xBzGAYoMGG6RSuvQPuk3yz+ntdaqTyw==
X-Gm-Gg: ASbGnct9B1zlIBqxxJsa0INzxHGgHMYNhUqI/dWwloAyjKtJDxeRtv2gVumP7dDgvwJ
	UzQ6aT/rW/FuZh8jRfIm/mEN9ChBRJv0q5xTGLLEVhtKtEbtYO1ciDDF0Sa946eLgMbdYXn3XMd
	oFv+FDz8/9U9XueU1U+gx2GavDjMW1Rv4R0Lq1tvi8nOVfFDKlf7A+r6YgXxT1fSbUDySfnKrnA
	K6n9tQoBau0EdGZRi5vbr5tZoNaOGoEz29IjnlFaGMvQu4MVt2MntZzX27sPplMmLUZ6UgqgSZ7
	qpVut1GS80NaF3TcjzioaqKxQwRrxU9n4cRz9cwlAzd7WxMX1Y8sDT/G/VJQI+bE/syCmaSTPIz
	nyxD8BaCuiQYlTI2Yaj8RZkrdqm8=
X-Google-Smtp-Source: AGHT+IGgtnss5GpWiojDUKov4jA59LAJatPG58Yl1qISK3zZp6/FyC3f5EypTaesaAZKtavZpNaRbA==
X-Received: by 2002:a05:600c:4454:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-441d44c439dmr52550855e9.10.1746688240344;
        Thu, 08 May 2025 00:10:40 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b178absm19500236f8f.97.2025.05.08.00.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:10:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 08 May 2025 12:40:34 +0530
Subject: [PATCH v4 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-pcie-reset-slot-v4-5-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
In-Reply-To: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8188;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Xhfd2aLgY7EkLO7Pad4MqFaMxVqdKEiC/l5bXSdXFT0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoHFjqE6NUL0GQ03l5Ef29uZNrbNS1bDnMhx8cr
 lsEHGkeSamJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBxY6gAKCRBVnxHm/pHO
 9Tv1B/4koilg8iRNvCXVqQRwOxyYvaueq2dMyvXrQNYllkSrcD/o3052unTWYPESlsa5UOWEvaj
 2y+HRo5lOulNl50qrUg8NWJ8W2yVYT0MrBR3cu1uCsyXcMibs3heRmjgGb+BIWbDAbsRg++uwYX
 Zj9pWydtNgT5VIdMeywoHG5gVG9pxDo5IKX2feIE/EYC8VvejRC1cZlGud4yf4jwwQTu6jAgbdx
 JaneNTS/ekYtNYM3H/rLGFXJa5LLrzBkFh2mIVfRJMJMUvNFBcVwaW+oEPIwOaJiXyQQCuX986o
 mJAxemkQmzkhYW2XafVUWnkimHGGHOnNpiV98tIh9c2WmK/N
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The PCIe link can go down under circumstances such as the device firmware
crash, link instability, etc... When that happens, the PCIe slot needs to
be reset to make it operational again. Currently, the driver is not
handling the link down event, due to which the users have to restart the
machine to make PCIe link operational again. So fix it by detecting the
link down event and resetting the slot.

Since the Qcom PCIe controllers report the link down event through the
'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
bit in PARF_INT_ALL_MASK register.

Then in the case of the event, call pci_host_handle_link_down() API
in the handler to let the PCI core handle the link down condition. Note
that both link up and link down events could be set at a time when the
handler runs. So always handle link down first.

The API will internally call, 'pci_host_bridge::reset_slot()' callback to
reset the slot in a platform specific way. So implement the callback to
reset the slot by first resetting the PCIe core, followed by reinitializing
the resources and then finally starting the link again.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 112 ++++++++++++++++++++++++++++++---
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..ce04ee6fbd99cbcce5d2f3a75ebd72a17070b7b7 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -296,6 +296,7 @@ config PCIE_QCOM
 	select PCIE_DW_HOST
 	select CRC8
 	select PCIE_QCOM_COMMON
+	select PCI_HOST_COMMON
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362db0422384b1879a2b9a7dc564d091..e577619d0f8ceddf0955139ae6b939842f8cb7be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -34,6 +34,7 @@
 #include <linux/units.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 #include "pcie-qcom-common.h"
 
@@ -55,6 +56,7 @@
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
+#define PARF_STATUS				0x230
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_DBI_BASE_ADDR_V2			0x350
@@ -130,9 +132,14 @@
 
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
+#define SW_CLEAR_FLUSH_MODE			BIT(10)
+#define FLUSH_MODE				BIT(11)
 
 /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
-#define PARF_INT_ALL_LINK_UP			BIT(13)
+#define INT_ALL_LINK_DOWN			1
+#define INT_ALL_LINK_UP				13
+#define PARF_INT_ALL_LINK_DOWN			BIT(INT_ALL_LINK_DOWN)
+#define PARF_INT_ALL_LINK_UP			BIT(INT_ALL_LINK_UP)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
 
 /* PARF_NO_SNOOP_OVERRIDE register fields */
@@ -145,6 +152,9 @@
 /* PARF_BDF_TO_SID_CFG fields */
 #define BDF_TO_SID_BYPASS			BIT(0)
 
+/* PARF_STATUS fields */
+#define FLUSH_COMPLETED				BIT(8)
+
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
@@ -169,6 +179,7 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
 #define PERST_DELAY_US				1000
+#define FLUSH_TIMEOUT_US			100
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
@@ -274,11 +285,14 @@ struct qcom_pcie {
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	int global_irq;
 	bool suspended;
 	bool use_pm_opp;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
+static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
+				  struct pci_dev *pdev);
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
@@ -1263,6 +1277,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_assert_reset;
 	}
 
+	pp->bridge->reset_slot = qcom_pcie_reset_slot;
+
 	return 0;
 
 err_assert_reset:
@@ -1517,6 +1533,74 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	}
 }
 
+static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
+				  struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
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
+	if (!dw_pcie_wait_for_link(pci))
+		qcom_pcie_icc_opp_update(pcie);
+
+	dev_dbg(dev, "Slot reset completed\n");
+
+	return 0;
+
+err_host_deinit:
+	qcom_pcie_host_deinit(pp);
+
+	return ret;
+}
+
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 {
 	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
@@ -1559,11 +1643,20 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	struct qcom_pcie *pcie = data;
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	struct device *dev = pcie->pci->dev;
-	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
+	unsigned long status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
 
 	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
 
-	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
+	/*
+	 * It is possible that both Link Up and Link Down events might have
+	 * happended. So always handle Link Down first.
+	 */
+	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
+		dev_dbg(dev, "Received Link down event\n");
+		pci_host_handle_link_down(pp->bridge);
+	}
+
+	if (test_and_clear_bit(INT_ALL_LINK_UP, &status)) {
 		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 		/* Rescan the bus to enumerate endpoint devices */
 		pci_lock_rescan_remove();
@@ -1571,11 +1664,12 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_unlock_rescan_remove();
 
 		qcom_pcie_icc_opp_update(pcie);
-	} else {
-		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
-			      status);
 	}
 
+	if (status)
+		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
+			      (u32) status);
+
 	return IRQ_HANDLED;
 }
 
@@ -1732,8 +1826,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
2.43.0


