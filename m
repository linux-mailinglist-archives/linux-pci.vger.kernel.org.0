Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4B516AB9
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 08:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382689AbiEBGKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 02:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383486AbiEBGKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 02:10:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6228051313
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 23:06:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id i62so10982044pgd.6
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qL3Xk4i7o3UQDTmWTBFhAVM3P0U5Z5danFVnlmhWQU8=;
        b=CtDYa+9rPrahTWxdPX13retvUVvs4Vrobf4PgFMToLII8bMacFJj+QQrgX4vZYBfdy
         nlJIuJYDDq7BnkZeI8YvZbnNrAl8w50yyKALZQpOmzzCSv6qbcXiC0fpXWl5dkWM/kaf
         Cf/aKhdFLkEtyWCj2qDSzdqupsB5KiWZf7tTUUQKj0/X+Zx46xSDnyivPzGxuQRBB0oD
         vPiCE8BMrPLV+4aysNAAeMgg3p+GJ8egDF3UmXe4XLTWB+N/4/LQF1GymPpYfA28Jewn
         eTgb9jj/nTKB/9HnLl6SYwCOoX3Rkl9LsGQff8ZdN0tXosL74xU4qjUIv+D9w1Omr+Ug
         IJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qL3Xk4i7o3UQDTmWTBFhAVM3P0U5Z5danFVnlmhWQU8=;
        b=WZfs6lurkIgbgJfjIkM6CoyzPtRX+X+kHQDUWTg6L2J926yzK6Lz8yCi0VcRd+x51Q
         EuD04Fg9G24iPqdoLD3JIUajUI28iJ1cUyHa1Y3DDPZiqBBmarhOlGZlOJptHqdZKqI4
         t2VYq0tdgifaHJBLFMeME6USWkuDDsn5QrQLt4Qi4Tg4Ovp77C2Vk6ZztDjoOgwItAeL
         fRAhotDCsxL9VT4JF/sUyjLrikeIFH+t+LgdlJJUF6Z2iORDTplPJiTcnHRoWYQarjK/
         xXBWVdI7rMZnPcGhxQm3vGTaF1lpECaQFYzozxNxaLenivnoY9E+iFYBVg3bnlARett+
         bBLw==
X-Gm-Message-State: AOAM532/93hooo9M7QrsaHGJW4C7At4kOol3Ef++CS1JZwUMQxD8UCIb
        CHVdi7yXurApxmEFEES9rHzG
X-Google-Smtp-Source: ABdhPJxskezcORxtvqy4ATQjhlEIvBxEON3WMDr/MmKeG4ZkcnLMaygsynDRGW7NqqhQ371q9Pyu5Q==
X-Received: by 2002:a62:33c2:0:b0:50d:a588:daab with SMTP id z185-20020a6233c2000000b0050da588daabmr9610562pfz.31.1651471609629;
        Sun, 01 May 2022 23:06:49 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 8/8] PCI: endpoint: Add PCI Endpoint function driver for MHI bus
Date:   Mon,  2 May 2022 11:36:11 +0530
Message-Id: <20220502060611.58987-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/Kconfig       |  10 +
 drivers/pci/endpoint/functions/Makefile      |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 436 +++++++++++++++++++
 3 files changed, 447 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 5f1242ca2f4e..93497fb70e31 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -25,3 +25,13 @@ config PCI_EPF_NTB
 	  device tree.
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
+
+config PCI_EPF_MHI
+	tristate "PCI Endpoint driver for MHI bus"
+	depends on PCI_ENDPOINT && MHI_BUS_EP
+	help
+	   Enable this configuration option to enable the PCI Endpoint
+	   driver for Modem Host Interface (MHI) bus found in Qualcomm
+	   modems such as SDX55.
+
+	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 96ab932a537a..eee99b2e9103 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
+obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
new file mode 100644
index 000000000000..a8119841a252
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI EPF driver for MHI Endpoint devices
+ *
+ * Copyright (C) 2022 Linaro Ltd.
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
+struct pci_epf_mhi_ep_info {
+	const struct mhi_ep_cntrl_config *config;
+	struct pci_epf_header *epf_header;
+	enum pci_barno bar_num;
+	u32 epf_flags;
+	u32 msi_count;
+	u32 mru;
+};
+
+#define MHI_EP_CHANNEL_CONFIG_UL(ch_num, ch_name)	\
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.dir = DMA_TO_DEVICE,			\
+	}
+
+#define MHI_EP_CHANNEL_CONFIG_DL(ch_num, ch_name)	\
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.dir = DMA_FROM_DEVICE,			\
+	}
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
+	MHI_EP_CHANNEL_CONFIG_UL(36, "IP_SW0"),
+	MHI_EP_CHANNEL_CONFIG_DL(37, "IP_SW0"),
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
+	enum pci_notify_event event;
+	u32 mmio_size;
+	int irq;
+	bool mhi_registered;
+};
+
+static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
+				 phys_addr_t *phys_ptr, void __iomem **virt, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+	void __iomem *virt_addr;
+	phys_addr_t phys_addr;
+	int ret;
+
+	virt_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, size + offset);
+	if (!virt_addr)
+		return -ENOMEM;
+
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr, pci_addr - offset, size + offset);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, phys_addr, virt_addr, size + offset);
+
+		return ret;
+	}
+
+	*phys_ptr = phys_addr + offset;
+	*virt = virt_addr + offset;
+
+	return 0;
+}
+
+static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
+				   phys_addr_t phys_addr, void __iomem *virt_addr, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
+
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr - offset);
+	pci_epc_mem_free_addr(epc, phys_addr - offset, virt_addr - offset, size + offset);
+}
+
+void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+
+	/*
+	 * Vector is incremented by 1 here as the DWC core will decrement it before
+	 * writing to iATU.
+	 */
+	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI, vector + 1);
+}
+
+int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void __iomem *to,
+			       size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	size_t offset = from % 0x1000;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	tre_buf = pci_epc_mem_alloc_addr(epc, &tre_phys, size + offset);
+	if (!tre_buf) {
+		mutex_unlock(&epf_mhi->lock);
+		return -ENOMEM;
+	}
+
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, tre_phys, from - offset,
+			       size + offset);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
+		mutex_unlock(&epf_mhi->lock);
+		return ret;
+	}
+
+	memcpy_fromio(to, tre_buf + offset, size);
+
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, tre_phys);
+	pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
+
+	mutex_unlock(&epf_mhi->lock);
+
+	return 0;
+}
+
+int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl, void __iomem *from, u64 to,
+			      size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(mhi_cntrl, struct pci_epf_mhi, mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf_mhi->epf->epc;
+	void __iomem *tre_buf;
+	phys_addr_t tre_phys;
+	size_t offset = to % 0x1000;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	tre_buf = pci_epc_mem_alloc_addr(epc, &tre_phys, size + offset);
+	if (!tre_buf) {
+		mutex_unlock(&epf_mhi->lock);
+		return -ENOMEM;
+	}
+
+	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, tre_phys, to - offset,
+			       size + offset);
+	if (ret) {
+		pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
+		mutex_unlock(&epf_mhi->lock);
+		return ret;
+	}
+
+	memcpy_toio(tre_buf + offset, from, size);
+
+	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, tre_phys);
+	pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
+
+	mutex_unlock(&epf_mhi->lock);
+
+	return 0;
+}
+
+static int pci_epf_mhi_notifier(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	switch (val) {
+	case CORE_INIT:
+		epf_bar->phys_addr = epf_mhi->mmio_phys;
+		epf_bar->size = epf_mhi->mmio_size;
+		epf_bar->barno = info->bar_num;
+		epf_bar->flags = info->epf_flags;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Failed to set BAR: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      order_base_2(info->msi_count));
+		if (ret) {
+			dev_err(dev, "Failed to set MSI configuration: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, epf->header);
+		if (ret) {
+			dev_err(dev, "Failed to set Configuration header: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		break;
+	case LINK_UP:
+		mhi_cntrl->mmio = epf_mhi->mmio;
+		mhi_cntrl->irq = epf_mhi->irq;
+		mhi_cntrl->mru = info->mru;
+
+		/* Assign the struct dev of PCI EP as MHI controller device */
+		mhi_cntrl->cntrl_dev = epc->dev.parent;
+		mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
+		mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
+		mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
+		mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
+		mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
+
+		/* Register the MHI EP controller */
+		ret = mhi_ep_register_controller(mhi_cntrl, info->config);
+		if (ret) {
+			dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		epf_mhi->mhi_registered = true;
+		break;
+	case LINK_DOWN:
+		if (epf_mhi->mhi_registered) {
+			mhi_ep_power_down(mhi_cntrl);
+			mhi_ep_unregister_controller(mhi_cntrl);
+			epf_mhi->mhi_registered = false;
+		}
+
+		break;
+	case BME:
+		/* Power up the MHI EP stack if link is up and stack is in power down state */
+		if (!mhi_cntrl->enabled && epf_mhi->mhi_registered) {
+			ret = mhi_ep_power_up(mhi_cntrl);
+			if (ret) {
+				dev_err(dev, "Failed to power up MHI EP: %d\n", ret);
+				mhi_ep_unregister_controller(mhi_cntrl);
+				epf_mhi->mhi_registered = false;
+				return NOTIFY_BAD;
+			}
+		}
+
+		break;
+	default:
+		dev_err(&epf->dev, "Invalid MHI EP notifier event: %d\n", epf_mhi->event);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
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
+	if (WARN_ON_ONCE(!epc))
+		return -EINVAL;
+
+	/* Get MMIO base address from Endpoint controller */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmio");
+	epf_mhi->mmio_phys = res->start;
+	epf_mhi->mmio_size = resource_size(res);
+
+	epf_mhi->mmio = ioremap_wc(epf_mhi->mmio_phys, epf_mhi->mmio_size);
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
+	epf->nb.notifier_call = pci_epf_mhi_notifier;
+	pci_epc_register_notifier(epc, &epf->nb);
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
+	pci_epc_unregister_notifier(epc, &epf->nb);
+
+	/*
+	 * Forcefully power down the MHI EP stack. Only way to bring the MHI EP stack
+	 * back to working state after successive bind is by getting BME from host.
+	 */
+	if (epf_mhi->mhi_registered) {
+		mhi_ep_power_down(mhi_cntrl);
+		mhi_ep_unregister_controller(mhi_cntrl);
+		epf_mhi->mhi_registered = false;
+	}
+
+	iounmap(epf_mhi->mmio);
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+}
+
+static int pci_epf_mhi_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
+{
+	struct pci_epf_mhi_ep_info *info = (struct pci_epf_mhi_ep_info *) id->driver_data;
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
+	mutex_init(&epf_mhi->lock);
+
+	epf_set_drvdata(epf, epf_mhi);
+
+	return 0;
+}
+
+static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
+	{
+		.name = "sdx55", .driver_data = (kernel_ulong_t) &sdx55_info,
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
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

