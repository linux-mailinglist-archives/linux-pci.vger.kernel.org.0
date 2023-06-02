Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5857200C6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjFBLt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjFBLtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3B10C3
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:49:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso2830055a12.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706531; x=1688298531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjgpVSwib4nuNHZhdqCSk8pCl93HMUnG2C938yjE0+U=;
        b=LAq7P4MS+/yqmNpbVL0uPeBvicvoYLtU2xroR2Iuc/qKAasgicMvdhYy9aotLXol0X
         nQ/P6yooj5RLyoy5H/JE5sldqZjjzlCnUh4UtcVrl2mb27uCOaO02syL23E+D8H+LyZ+
         vOsGRcQhSMmSAlJL/mDeBW0KBdgTrGSNok245LcnarMyWgI8GCQ4AxeImZ74J7a2z52v
         ZmsZV5ddjc08Rf8bK9csWwBQfGj27KAdm3HBxD2nv/I9U2mJ1/mRAbAywM/J0d61nWs3
         KMTYWK7xAc+0zmbMnDtB6HsFtf4Igp04XdjyJP14ZBWWu1bQoKy5+nuc/7mOelDFTHK2
         X9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706531; x=1688298531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjgpVSwib4nuNHZhdqCSk8pCl93HMUnG2C938yjE0+U=;
        b=WPy2MVQ7fEzIr4kAj9JVfVQpAPWHPeVzN4pEd+Tf+cgnlb3wwj0e9EHMLoe/+3bGcr
         COxSvbXm6e6d3ngGfrMbEy/jbbGnX+hl8+Pkwbv88vkwAhoXnVCEBV5idNgE6P/YuJq2
         Xtq3xPXwopF+XEIFbSRhGI5ocfVx02wHc1bPMJ6H9aZ8+ML2Gy9VGx6lZ5yMxZiFRsNJ
         rtsonRyrsrDP8kF4qOnouRNxwzD6LwtOxCUVSMeY9Ikkg7VQTQ0Xm7DQZ+qOIk2tuJl3
         cnkDcOJsgVQfCN1YXHbML16cWU0vP7RHUkcnUU/MPAhMNgwqyiuh0GaJ7BZPY0BQw3Sy
         qalA==
X-Gm-Message-State: AC+VfDyWQeXf6Ba0I1GNXKCFD29TTMmEhnjBCtKi6hO2CdnhTzMCxvVV
        kFyDRF2+DIyoL4zhbu55okQG
X-Google-Smtp-Source: ACHHUZ4dfCXE8wfVDHdYs6Zk+wbd5/OsxKeKw7hKTDVdTSVI/ttCCg9ZBAn3V2Nu8oS4uetzHRvEsw==
X-Received: by 2002:a17:907:3e86:b0:95e:d3f5:3d47 with SMTP id hs6-20020a1709073e8600b0095ed3f53d47mr11650939ejc.48.1685706531709;
        Fri, 02 Jun 2023 04:48:51 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 8/9] PCI: endpoint: Add PCI Endpoint function driver for MHI bus
Date:   Fri,  2 Jun 2023 17:17:55 +0530
Message-Id: <20230602114756.36586-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
The driver implements the MHI function over PCI in the endpoint device
such as SDX55 modem. The MHI endpoint function driver acts as a
controller driver for the MHI Endpoint stack and carries out all PCI
related activities like mapping the host memory using iATU, triggering
MSIs etc...

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/Kconfig       |  10 +
 drivers/pci/endpoint/functions/Makefile      |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 465 +++++++++++++++++++
 3 files changed, 476 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 9fd560886871..f5171b4fabbe 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -37,3 +37,13 @@ config PCI_EPF_VNTB
 	  between PCI Root Port and PCIe Endpoint.
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
+
+config PCI_EPF_MHI
+	tristate "PCI Endpoint driver for MHI bus"
+	depends on PCI_ENDPOINT && MHI_BUS_EP
+	help
+	   Enable this configuration option to enable the PCI Endpoint
+	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
+	   devices such as SDX55.
+
+	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 5c13001deaba..696473fce50e 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
+obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
new file mode 100644
index 000000000000..0504ee13f692
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI EPF driver for MHI Endpoint devices
+ *
+ * Copyright (C) 2023 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/mhi_ep.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+#define MHI_VERSION_1_0 0x01000000
+
+#define to_epf_mhi(cntrl) container_of(cntrl, struct pci_epf_mhi, cntrl)
+
+struct pci_epf_mhi_ep_info {
+	const struct mhi_ep_cntrl_config *config;
+	struct pci_epf_header *epf_header;
+	enum pci_barno bar_num;
+	u32 epf_flags;
+	u32 msi_count;
+	u32 mru;
+};
+
+#define MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, direction)	\
+	{							\
+		.num = ch_num,					\
+		.name = ch_name,				\
+		.dir = direction,				\
+	}
+
+#define MHI_EP_CHANNEL_CONFIG_UL(ch_num, ch_name)		\
+	MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, DMA_TO_DEVICE)
+
+#define MHI_EP_CHANNEL_CONFIG_DL(ch_num, ch_name)		\
+	MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, DMA_FROM_DEVICE)
+
+static const struct mhi_ep_channel_config mhi_v1_channels[] = {
+	MHI_EP_CHANNEL_CONFIG_UL(0, "LOOPBACK"),
+	MHI_EP_CHANNEL_CONFIG_DL(1, "LOOPBACK"),
+	MHI_EP_CHANNEL_CONFIG_UL(2, "SAHARA"),
+	MHI_EP_CHANNEL_CONFIG_DL(3, "SAHARA"),
+	MHI_EP_CHANNEL_CONFIG_UL(4, "DIAG"),
+	MHI_EP_CHANNEL_CONFIG_DL(5, "DIAG"),
+	MHI_EP_CHANNEL_CONFIG_UL(6, "SSR"),
+	MHI_EP_CHANNEL_CONFIG_DL(7, "SSR"),
+	MHI_EP_CHANNEL_CONFIG_UL(8, "QDSS"),
+	MHI_EP_CHANNEL_CONFIG_DL(9, "QDSS"),
+	MHI_EP_CHANNEL_CONFIG_UL(10, "EFS"),
+	MHI_EP_CHANNEL_CONFIG_DL(11, "EFS"),
+	MHI_EP_CHANNEL_CONFIG_UL(12, "MBIM"),
+	MHI_EP_CHANNEL_CONFIG_DL(13, "MBIM"),
+	MHI_EP_CHANNEL_CONFIG_UL(14, "QMI"),
+	MHI_EP_CHANNEL_CONFIG_DL(15, "QMI"),
+	MHI_EP_CHANNEL_CONFIG_UL(16, "QMI"),
+	MHI_EP_CHANNEL_CONFIG_DL(17, "QMI"),
+	MHI_EP_CHANNEL_CONFIG_UL(18, "IP-CTRL-1"),
+	MHI_EP_CHANNEL_CONFIG_DL(19, "IP-CTRL-1"),
+	MHI_EP_CHANNEL_CONFIG_UL(20, "IPCR"),
+	MHI_EP_CHANNEL_CONFIG_DL(21, "IPCR"),
+	MHI_EP_CHANNEL_CONFIG_UL(32, "DUN"),
+	MHI_EP_CHANNEL_CONFIG_DL(33, "DUN"),
+	MHI_EP_CHANNEL_CONFIG_UL(46, "IP_SW0"),
+	MHI_EP_CHANNEL_CONFIG_DL(47, "IP_SW0"),
+};
+
+static const struct mhi_ep_cntrl_config mhi_v1_config = {
+	.max_channels = 128,
+	.num_channels = ARRAY_SIZE(mhi_v1_channels),
+	.ch_cfg = mhi_v1_channels,
+	.mhi_version = MHI_VERSION_1_0,
+};
+
+static struct pci_epf_header sdx55_header = {
+	.vendorid = PCI_VENDOR_ID_QCOM,
+	.deviceid = 0x0306,
+	.baseclass_code = PCI_BASE_CLASS_COMMUNICATION,
+	.subclass_code = PCI_CLASS_COMMUNICATION_MODEM & 0xff,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+static const struct pci_epf_mhi_ep_info sdx55_info = {
+	.config = &mhi_v1_config,
+	.epf_header = &sdx55_header,
+	.bar_num = BAR_0,
+	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
+	.msi_count = 32,
+	.mru = 0x8000,
+};
+
+struct pci_epf_mhi {
+	const struct pci_epf_mhi_ep_info *info;
+	struct mhi_ep_cntrl mhi_cntrl;
+	struct pci_epf *epf;
+	struct mutex lock;
+	void __iomem *mmio;
+	resource_size_t mmio_phys;
+	u32 mmio_size;
+	int irq;
+};
+
+static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
+				 phys_addr_t *paddr, void __iomem **vaddr,
+				 size_t offset, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	*vaddr = pci_epc_mem_alloc_addr(epc, paddr, size + offset);
+	if (!vaddr)
+		return -ENOMEM;
+
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, *paddr,
+			       pci_addr - offset, size + offset);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, *paddr, *vaddr, size + offset);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
+				 phys_addr_t *paddr, void __iomem **vaddr,
+				 size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+	int ret;
+
+	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
+				      offset, size);
+	if (ret)
+		return ret;
+
+	*paddr = *paddr + offset;
+	*vaddr = *vaddr + offset;
+
+	return 0;
+}
+
+static void __pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl,
+				     u64 pci_addr, phys_addr_t paddr,
+				     void __iomem *vaddr, size_t offset,
+				     size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, paddr - offset);
+	pci_epc_mem_free_addr(epc, paddr - offset, vaddr - offset,
+			      size + offset);
+}
+
+static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
+				   phys_addr_t paddr, void __iomem *vaddr,
+				   size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+
+	__pci_epf_mhi_unmap_free(mhi_cntrl, pci_addr, paddr, vaddr, offset,
+				 size);
+}
+
+static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+
+	/*
+	 * MHI supplies 0 based MSI vector but the API expects the vector to be
+	 * 1 based, so we need to increment the vector by 1.
+	 */
+	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI,
+			  vector + 1);
+}
+
+static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
+				      void *to, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	size_t offset = from % SZ_4K;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, from, &tre_phys, &tre_buf,
+				      offset, size);
+	if (ret) {
+		mutex_unlock(&epf_mhi->lock);
+		return ret;
+	}
+
+	memcpy_fromio(to, tre_buf + offset, size);
+
+	__pci_epf_mhi_unmap_free(mhi_cntrl, from, tre_phys, tre_buf, offset,
+				 size);
+
+	mutex_unlock(&epf_mhi->lock);
+
+	return 0;
+}
+
+static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
+				     void *from, u64 to, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	size_t offset = to % SZ_4K;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, to, &tre_phys, &tre_buf,
+				      offset, size);
+	if (ret) {
+		mutex_unlock(&epf_mhi->lock);
+		return ret;
+	}
+
+	memcpy_toio(tre_buf + offset, from, size);
+
+	__pci_epf_mhi_unmap_free(mhi_cntrl, to, tre_phys, tre_buf, offset,
+				 size);
+
+	mutex_unlock(&epf_mhi->lock);
+
+	return 0;
+}
+
+static int pci_epf_mhi_core_init(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	epf_bar->phys_addr = epf_mhi->mmio_phys;
+	epf_bar->size = epf_mhi->mmio_size;
+	epf_bar->barno = info->bar_num;
+	epf_bar->flags = info->epf_flags;
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+	if (ret) {
+		dev_err(dev, "Failed to set BAR: %d\n", ret);
+		return ret;
+	}
+
+	ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+			      order_base_2(info->msi_count));
+	if (ret) {
+		dev_err(dev, "Failed to set MSI configuration: %d\n", ret);
+		return ret;
+	}
+
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no,
+				   epf->header);
+	if (ret) {
+		dev_err(dev, "Failed to set Configuration header: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_link_up(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	mhi_cntrl->mmio = epf_mhi->mmio;
+	mhi_cntrl->irq = epf_mhi->irq;
+	mhi_cntrl->mru = info->mru;
+
+	/* Assign the struct dev of PCI EP as MHI controller device */
+	mhi_cntrl->cntrl_dev = epc->dev.parent;
+	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
+	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
+	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
+	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
+	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
+
+	/* Register the MHI EP controller */
+	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
+	if (ret) {
+		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_link_down(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+
+	if (mhi_cntrl->mhi_dev) {
+		mhi_ep_power_down(mhi_cntrl);
+		mhi_ep_unregister_controller(mhi_cntrl);
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_bme(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/*
+	 * Power up the MHI EP stack if link is up and stack is in power down
+	 * state.
+	 */
+	if (!mhi_cntrl->enabled && mhi_cntrl->mhi_dev) {
+		ret = mhi_ep_power_up(mhi_cntrl);
+		if (ret) {
+			dev_err(dev, "Failed to power up MHI EP: %d\n", ret);
+			mhi_ep_unregister_controller(mhi_cntrl);
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_bind(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
+	struct platform_device *pdev = to_platform_device(epc->dev.parent);
+	struct device *dev = &epf->dev;
+	struct resource *res;
+	int ret;
+
+	/* Get MMIO base address from Endpoint controller */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmio");
+	epf_mhi->mmio_phys = res->start;
+	epf_mhi->mmio_size = resource_size(res);
+
+	epf_mhi->mmio = ioremap(epf_mhi->mmio_phys, epf_mhi->mmio_size);
+	if (IS_ERR(epf_mhi->mmio))
+		return PTR_ERR(epf_mhi->mmio);
+
+	ret = platform_get_irq_byname(pdev, "doorbell");
+	if (ret < 0) {
+		dev_err(dev, "Failed to get Doorbell IRQ\n");
+		iounmap(epf_mhi->mmio);
+		return ret;
+	}
+
+	epf_mhi->irq = ret;
+
+	return 0;
+}
+
+static void pci_epf_mhi_unbind(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+	struct pci_epc *epc = epf->epc;
+
+	/*
+	 * Forcefully power down the MHI EP stack. Only way to bring the MHI EP
+	 * stack back to working state after successive bind is by getting BME
+	 * from host.
+	 */
+	if (mhi_cntrl->mhi_dev) {
+		mhi_ep_power_down(mhi_cntrl);
+		mhi_ep_unregister_controller(mhi_cntrl);
+	}
+
+	iounmap(epf_mhi->mmio);
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+}
+
+static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
+	.core_init = pci_epf_mhi_core_init,
+	.link_up = pci_epf_mhi_link_up,
+	.link_down = pci_epf_mhi_link_down,
+	.bme = pci_epf_mhi_bme,
+};
+
+static int pci_epf_mhi_probe(struct pci_epf *epf,
+			     const struct pci_epf_device_id *id)
+{
+	struct pci_epf_mhi_ep_info *info =
+			(struct pci_epf_mhi_ep_info *)id->driver_data;
+	struct pci_epf_mhi *epf_mhi;
+	struct device *dev = &epf->dev;
+
+	epf_mhi = devm_kzalloc(dev, sizeof(*epf_mhi), GFP_KERNEL);
+	if (!epf_mhi)
+		return -ENOMEM;
+
+	epf->header = info->epf_header;
+	epf_mhi->info = info;
+	epf_mhi->epf = epf;
+
+	epf->event_ops = &pci_epf_mhi_event_ops;
+
+	mutex_init(&epf_mhi->lock);
+
+	epf_set_drvdata(epf, epf_mhi);
+
+	return 0;
+}
+
+static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
+	{
+		.name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info,
+	},
+	{},
+};
+
+static struct pci_epf_ops pci_epf_mhi_ops = {
+	.unbind	= pci_epf_mhi_unbind,
+	.bind	= pci_epf_mhi_bind,
+};
+
+static struct pci_epf_driver pci_epf_mhi_driver = {
+	.driver.name	= "pci_epf_mhi",
+	.probe		= pci_epf_mhi_probe,
+	.id_table	= pci_epf_mhi_ids,
+	.ops		= &pci_epf_mhi_ops,
+	.owner		= THIS_MODULE,
+};
+
+static int __init pci_epf_mhi_init(void)
+{
+	return pci_epf_register_driver(&pci_epf_mhi_driver);
+}
+module_init(pci_epf_mhi_init);
+
+static void __exit pci_epf_mhi_exit(void)
+{
+	pci_epf_unregister_driver(&pci_epf_mhi_driver);
+}
+module_exit(pci_epf_mhi_exit);
+
+MODULE_DESCRIPTION("PCI EPF driver for MHI Endpoint devices");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

