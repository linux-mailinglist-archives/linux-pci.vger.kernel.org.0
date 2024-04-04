Return-Path: <linux-pci+bounces-5743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD6898EB6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FA01F2845B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC52131E24;
	Thu,  4 Apr 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IMkm0FYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A24130E29;
	Thu,  4 Apr 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257908; cv=none; b=fZbXz9wtwxvAluevkFx1uUmyr8YeQLRYdzDOw5QsPmozNHd9G2VWi5UzxoHwkOFbsEHyhobeKs+g2N6ck0pyCkjeclg+ELy8SmIIxapx1+Mq2eMA1ciab4Qmf1dtRzsLahXrqMvosqZMEH09YiA29NE6acyO7HGFxZ1Brvwyz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257908; c=relaxed/simple;
	bh=FGhMVP9veFuiJdO7Z8K1Q6jjeAFy4VcENSgyp8WFDPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTJQttcrAJA3hapYRg456EIruMbrmZfPvaK09dt5HbYRWomJxDCq5UcVUkZQwDu5vBOpETYZXrDddpwGB6S3Yl1kpzJYAW9S2GLcliI36WIYc/7g1uQBfXRpeIvkHS416YYAOMWHK703f9p3Mv7mC4JLreE2jVpW867IQr8OsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IMkm0FYR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434CJNJR012191;
	Thu, 4 Apr 2024 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zDCDuxXDs9kKNIo7ljG5
	ygOFalux282V1wN8nUjxRFA=; b=IMkm0FYRaR6dSPAS3wPUgH5MO8r06dOtL0LK
	HVzB9VfMABIX36ab2uiTODutQ1KWIKslym/53MiKtpjiRx+mcsOubrO26pmFeGCM
	G7ZEG3bfue7nu4Ad/wMcFywWG0a0i3otAHcywYPx7Q19ttJ1mKxgHr/oICTqHSzs
	0A/VmF5B7j56Sgj69K7ZfLg90czSCZDPvgS0PyYOqNVZUgm4JTA2/TQaH4tzli8p
	Y1Q+lyDZDnHnR7KoyjiInv9Fp0YQJ9YPe3a5q5T2Y5ysLi/fH2fD6QU4JlTrQabj
	4ePOsNUSalc+fLOn6fxw7SpD3tQPRTG4DSaM3lNZYMCGhiyA+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en5tcaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:11:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434JBc80010236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:11:38 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:11:38 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
Date: Thu, 4 Apr 2024 12:11:24 -0700
Message-ID: <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nt6qfygtK3Z1pw2gkYag6lWWTOIiyxec
X-Proofpoint-GUID: nt6qfygtK3Z1pw2gkYag6lWWTOIiyxec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=909
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040136

On some of Qualcomm platform, firmware configures PCIe controller into
ECAM mode allowing static memory allocation for configuration space of
supported bus range. Firmware also takes care of bringing up PCIe PHY
and performing required operation to bring PCIe link into D0. Firmware
also manages system resources (e.g. clocks/regulators/resets/ bus voting).
Hence add Qualcomm PCIe ECAM root complex driver which enumerates PCIe
root complex and connected PCIe devices. Firmware won't be enumerating
or powering up PCIe root complex until this driver invokes power domain
based notification to bring PCIe link into D0/D3cold mode.

This driver also support MSI functionality using PCIe controller based
MSI controller as GIC ITS based MSI functionality is not available on
some of platform.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/Kconfig          |  12 +
 drivers/pci/controller/Makefile         |   1 +
 drivers/pci/controller/pcie-qcom-ecam.c | 575 ++++++++++++++++++++++++++++++++
 3 files changed, 588 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-qcom-ecam.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e534c02..abbd9f2 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -353,6 +353,18 @@ config PCIE_XILINX_CPM
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
 
+config PCIE_QCOM_ECAM
+	tristate "QCOM PCIe ECAM host controller"
+	depends on ARCH_QCOM && PCI
+	depends on OF
+	select PCI_MSI
+	select PCI_HOST_COMMON
+	select IRQ_DOMAIN
+	help
+	 Say 'Y' here if you want to use ECAM shift mode compatible Qualcomm
+	 PCIe root host controller. The controller is programmed using firmware
+	 to support ECAM compatible memory address space.
+
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index f2b19e6..2f1ee1e 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
+obj-$(CONFIG_PCIE_QCOM_ECAM) += pcie-qcom-ecam.o
 
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
diff --git a/drivers/pci/controller/pcie-qcom-ecam.c b/drivers/pci/controller/pcie-qcom-ecam.c
new file mode 100644
index 00000000..5b4c68b
--- /dev/null
+++ b/drivers/pci/controller/pcie-qcom-ecam.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm PCIe ECAM root host controller driver
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define PCIE_MSI_CTRL_BASE			(0x820)
+#define PCIE_MSI_CTRL_SIZE			(0x68)
+#define PCIE_MSI_CTRL_ADDR_OFFS			(0x0)
+#define PCIE_MSI_CTRL_UPPER_ADDR_OFFS		(0x4)
+#define PCIE_MSI_CTRL_INT_N_EN_OFFS(n)		(0x8 + 0xc * (n))
+#define PCIE_MSI_CTRL_INT_N_MASK_OFFS(n)	(0xc + 0xc * (n))
+#define PCIE_MSI_CTRL_INT_N_STATUS_OFFS(n)	(0x10 + 0xc * (n))
+
+#define	MSI_DB_ADDR	0xa0000000
+#define MSI_IRQ_PER_GRP (32)
+
+/**
+ * struct qcom_msi_irq - MSI IRQ information
+ * @client:	pointer to MSI client struct
+ * @grp:	group the irq belongs to
+ * @grp_index:	index in group
+ * @hwirq:	hwirq number
+ * @virq:	virq number
+ * @pos:	position in MSI bitmap
+ */
+struct qcom_msi_irq {
+	struct qcom_msi_client *client;
+	struct qcom_msi_grp *grp;
+	unsigned int grp_index;
+	unsigned int hwirq;
+	unsigned int virq;
+	u32 pos;
+};
+
+/**
+ * struct qcom_msi_grp - MSI group information
+ * @int_en_reg:		memory-mapped interrupt enable register address
+ * @int_mask_reg:	memory-mapped interrupt mask register address
+ * @int_status_reg:	memory-mapped interrupt status register address
+ * @mask:		tracks masked/unmasked MSI
+ * @irqs:		structure to MSI IRQ information
+ */
+struct qcom_msi_grp {
+	void __iomem *int_en_reg;
+	void __iomem *int_mask_reg;
+	void __iomem *int_status_reg;
+	u32 mask;
+	struct qcom_msi_irq irqs[MSI_IRQ_PER_GRP];
+};
+
+/**
+ * struct qcom_msi - PCIe controller based MSI controller information
+ * @clients:		list for tracking clients
+ * @dev:		platform device node
+ * @nr_hwirqs:		total number of hardware IRQs
+ * @nr_virqs:		total number of virqs
+ * @nr_grps:		total number of groups
+ * @grps:		pointer to all groups information
+ * @bitmap:		tracks used/unused MSI
+ * @mutex:		for modifying MSI client list and bitmap
+ * @inner_domain:	parent domain; gen irq related
+ * @msi_domain:		child domain; pcie related
+ * @msi_db_addr:	MSI doorbell address
+ * @cfg_lock:		lock for configuring MSI controller registers
+ * @pcie_msi_cfg:	memory-mapped MSI controller register space
+ */
+struct qcom_msi {
+	struct list_head clients;
+	struct device *dev;
+	int nr_hwirqs;
+	int nr_virqs;
+	int nr_grps;
+	struct qcom_msi_grp *grps;
+	unsigned long *bitmap;
+	struct mutex mutex;
+	struct irq_domain *inner_domain;
+	struct irq_domain *msi_domain;
+	phys_addr_t msi_db_addr;
+	spinlock_t cfg_lock;
+	void __iomem *pcie_msi_cfg;
+};
+
+/**
+ * struct qcom_msi_client - structure for each client of MSI controller
+ * @node:		list to track number of MSI clients
+ * @msi:		client specific MSI controller based resource pointer
+ * @dev:		client's dev of pci_dev
+ * @nr_irqs:		number of irqs allocated for client
+ * @msi_addr:		MSI doorbell address
+ */
+struct qcom_msi_client {
+	struct list_head node;
+	struct qcom_msi *msi;
+	struct device *dev;
+	unsigned int nr_irqs;
+	phys_addr_t msi_addr;
+};
+
+static void qcom_msi_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct qcom_msi_grp *msi_grp;
+	u32 status;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	msi_grp = irq_desc_get_handler_data(desc);
+	status = readl_relaxed(msi_grp->int_status_reg);
+	status ^= (msi_grp->mask & status);
+	writel(status, msi_grp->int_status_reg);
+
+	for (i = 0; status; i++, status >>= 1)
+		if (status & 0x1)
+			generic_handle_irq(msi_grp->irqs[i].virq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void qcom_msi_mask_irq(struct irq_data *data)
+{
+	struct irq_data *parent_data;
+	struct qcom_msi_irq *msi_irq;
+	struct qcom_msi_grp *msi_grp;
+	struct qcom_msi *msi;
+	unsigned long flags;
+
+	parent_data = data->parent_data;
+	if (!parent_data)
+		return;
+
+	msi_irq = irq_data_get_irq_chip_data(parent_data);
+	msi = msi_irq->client->msi;
+	msi_grp = msi_irq->grp;
+
+	spin_lock_irqsave(&msi->cfg_lock, flags);
+	pci_msi_mask_irq(data);
+	msi_grp->mask |= BIT(msi_irq->grp_index);
+	writel(msi_grp->mask, msi_grp->int_mask_reg);
+	spin_unlock_irqrestore(&msi->cfg_lock, flags);
+}
+
+static void qcom_msi_unmask_irq(struct irq_data *data)
+{
+	struct irq_data *parent_data;
+	struct qcom_msi_irq *msi_irq;
+	struct qcom_msi_grp *msi_grp;
+	struct qcom_msi *msi;
+	unsigned long flags;
+
+	parent_data = data->parent_data;
+	if (!parent_data)
+		return;
+
+	msi_irq = irq_data_get_irq_chip_data(parent_data);
+	msi = msi_irq->client->msi;
+	msi_grp = msi_irq->grp;
+
+	spin_lock_irqsave(&msi->cfg_lock, flags);
+	msi_grp->mask &= ~BIT(msi_irq->grp_index);
+	writel(msi_grp->mask, msi_grp->int_mask_reg);
+	pci_msi_unmask_irq(data);
+	spin_unlock_irqrestore(&msi->cfg_lock, flags);
+}
+
+static struct irq_chip qcom_msi_irq_chip = {
+	.name		= "qcom_pci_msi",
+	.irq_enable	= qcom_msi_unmask_irq,
+	.irq_disable	= qcom_msi_mask_irq,
+	.irq_mask	= qcom_msi_mask_irq,
+	.irq_unmask	= qcom_msi_unmask_irq,
+};
+
+static int qcom_msi_domain_prepare(struct irq_domain *domain, struct device *dev,
+				int nvec, msi_alloc_info_t *arg)
+{
+	struct qcom_msi *msi = domain->parent->host_data;
+	struct qcom_msi_client *client;
+
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->msi = msi;
+	client->dev = dev;
+	client->msi_addr = msi->msi_db_addr;
+	mutex_lock(&msi->mutex);
+	list_add_tail(&client->node, &msi->clients);
+	mutex_unlock(&msi->mutex);
+
+	/* zero out struct for pcie msi framework */
+	memset(arg, 0, sizeof(*arg));
+	return 0;
+}
+
+static struct msi_domain_ops qcom_msi_domain_ops = {
+	.msi_prepare	= qcom_msi_domain_prepare,
+};
+
+static struct msi_domain_info qcom_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+	.ops	= &qcom_msi_domain_ops,
+	.chip	= &qcom_msi_irq_chip,
+};
+
+static int qcom_msi_irq_set_affinity(struct irq_data *data,
+				const struct cpumask *mask, bool force)
+{
+	struct irq_data *parent_data = irq_get_irq_data(irqd_to_hwirq(data));
+	int ret = 0;
+
+	if (!parent_data)
+		return -ENODEV;
+
+	/* set affinity for MSI HW IRQ */
+	if (parent_data->chip->irq_set_affinity)
+		ret = parent_data->chip->irq_set_affinity(parent_data, mask, force);
+
+	return ret;
+}
+
+static void qcom_msi_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct irq_data *parent_data = irq_get_irq_data(irqd_to_hwirq(data));
+	struct qcom_msi_irq *msi_irq = irq_data_get_irq_chip_data(data);
+	struct qcom_msi_client *client = msi_irq->client;
+
+	if (!parent_data)
+		return;
+
+	msg->address_lo = lower_32_bits(client->msi_addr);
+	msg->address_hi = upper_32_bits(client->msi_addr);
+	msg->data = msi_irq->pos;
+}
+
+static struct irq_chip qcom_msi_bottom_irq_chip = {
+	.name			= "qcom_msi",
+	.irq_set_affinity	= qcom_msi_irq_set_affinity,
+	.irq_compose_msi_msg	= qcom_msi_irq_compose_msi_msg,
+};
+
+static int qcom_msi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *args)
+{
+	struct device *dev = ((msi_alloc_info_t *)args)->desc->dev;
+	struct qcom_msi_client *tmp, *client = NULL;
+	struct qcom_msi *msi = domain->host_data;
+	int i, ret = 0;
+	int pos;
+
+	mutex_lock(&msi->mutex);
+	list_for_each_entry(tmp, &msi->clients, node) {
+		if (tmp->dev == dev) {
+			client = tmp;
+			break;
+		}
+	}
+
+	if (!client) {
+		dev_err(msi->dev, "failed to find MSI client dev\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	pos = bitmap_find_next_zero_area(msi->bitmap, msi->nr_virqs, 0,
+					nr_irqs, nr_irqs - 1);
+	if (pos > msi->nr_virqs) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	bitmap_set(msi->bitmap, pos, nr_irqs);
+	for (i = 0; i < nr_irqs; i++) {
+		u32 grp = pos / MSI_IRQ_PER_GRP;
+		u32 index = pos % MSI_IRQ_PER_GRP;
+		struct qcom_msi_irq *msi_irq = &msi->grps[grp].irqs[index];
+
+		msi_irq->virq = virq + i;
+		msi_irq->client = client;
+		irq_domain_set_info(domain, msi_irq->virq,
+				msi_irq->hwirq,
+				&qcom_msi_bottom_irq_chip, msi_irq,
+				handle_simple_irq, NULL, NULL);
+		client->nr_irqs++;
+		pos++;
+	}
+out:
+	mutex_unlock(&msi->mutex);
+	return ret;
+}
+
+static void qcom_msi_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct qcom_msi_client *client;
+	struct qcom_msi_irq *msi_irq;
+	struct qcom_msi *msi;
+
+	if (!data)
+		return;
+
+	msi_irq = irq_data_get_irq_chip_data(data);
+	client  = msi_irq->client;
+	msi = client->msi;
+
+	mutex_lock(&msi->mutex);
+	bitmap_clear(msi->bitmap, msi_irq->pos, nr_irqs);
+
+	client->nr_irqs -= nr_irqs;
+	if (!client->nr_irqs) {
+		list_del(&client->node);
+		kfree(client);
+	}
+	mutex_unlock(&msi->mutex);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= qcom_msi_irq_domain_alloc,
+	.free	= qcom_msi_irq_domain_free,
+};
+
+static int qcom_msi_alloc_domains(struct qcom_msi *msi)
+{
+	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr_virqs,
+						&msi_domain_ops, msi);
+	if (!msi->inner_domain) {
+		dev_err(msi->dev, "failed to create IRQ inner domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->dev->of_node),
+					&qcom_msi_domain_info, msi->inner_domain);
+	if (!msi->msi_domain) {
+		dev_err(msi->dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->inner_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int qcom_msi_irq_setup(struct qcom_msi *msi)
+{
+	struct qcom_msi_grp *msi_grp;
+	struct qcom_msi_irq *msi_irq;
+	int i, index, ret;
+	unsigned int irq;
+
+	/* setup each MSI group. nr_hwirqs == nr_grps */
+	for (i = 0; i < msi->nr_hwirqs; i++) {
+		irq = irq_of_parse_and_map(msi->dev->of_node, i);
+		if (!irq) {
+			dev_err(msi->dev,
+				"MSI: failed to parse/map interrupt\n");
+			ret = -ENODEV;
+			goto free_irqs;
+		}
+
+		msi_grp = &msi->grps[i];
+		msi_grp->int_en_reg = msi->pcie_msi_cfg +
+				PCIE_MSI_CTRL_INT_N_EN_OFFS(i);
+		msi_grp->int_mask_reg = msi->pcie_msi_cfg +
+				PCIE_MSI_CTRL_INT_N_MASK_OFFS(i);
+		msi_grp->int_status_reg = msi->pcie_msi_cfg +
+				PCIE_MSI_CTRL_INT_N_STATUS_OFFS(i);
+
+		for (index = 0; index < MSI_IRQ_PER_GRP; index++) {
+			msi_irq = &msi_grp->irqs[index];
+
+			msi_irq->grp = msi_grp;
+			msi_irq->grp_index = index;
+			msi_irq->pos = (i * MSI_IRQ_PER_GRP) + index;
+			msi_irq->hwirq = irq;
+		}
+
+		irq_set_chained_handler_and_data(irq, qcom_msi_handler, msi_grp);
+	}
+
+	return 0;
+
+free_irqs:
+	for (--i; i >= 0; i--) {
+		irq = msi->grps[i].irqs[0].hwirq;
+
+		irq_set_chained_handler_and_data(irq, NULL, NULL);
+		irq_dispose_mapping(irq);
+	}
+
+	return ret;
+}
+
+static void qcom_msi_config(struct irq_domain *domain)
+{
+	struct qcom_msi *msi;
+	int i;
+
+	msi = domain->parent->host_data;
+
+	/* program termination address */
+	writel(msi->msi_db_addr, msi->pcie_msi_cfg + PCIE_MSI_CTRL_ADDR_OFFS);
+	writel(0, msi->pcie_msi_cfg + PCIE_MSI_CTRL_UPPER_ADDR_OFFS);
+
+	/* restore mask and enable all interrupts for each group */
+	for (i = 0; i < msi->nr_grps; i++) {
+		struct qcom_msi_grp *msi_grp = &msi->grps[i];
+
+		writel(msi_grp->mask, msi_grp->int_mask_reg);
+		writel(~0, msi_grp->int_en_reg);
+	}
+}
+
+static void qcom_msi_deinit(struct qcom_msi *msi)
+{
+	irq_domain_remove(msi->msi_domain);
+	irq_domain_remove(msi->inner_domain);
+}
+
+static struct qcom_msi *qcom_msi_init(struct device *dev)
+{
+	struct qcom_msi *msi;
+	u64 addr;
+	int ret;
+
+	msi = devm_kzalloc(dev, sizeof(*msi), GFP_KERNEL);
+	if (!msi)
+		return ERR_PTR(-ENOMEM);
+
+	msi->dev = dev;
+	mutex_init(&msi->mutex);
+	spin_lock_init(&msi->cfg_lock);
+	INIT_LIST_HEAD(&msi->clients);
+
+	msi->msi_db_addr = MSI_DB_ADDR;
+	msi->nr_hwirqs = of_irq_count(dev->of_node);
+	if (!msi->nr_hwirqs) {
+		dev_err(msi->dev, "no hwirqs found\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {
+		dev_err(msi->dev, "failed to get reg address\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	dev_dbg(msi->dev, "hwirq:%d pcie_msi_cfg:%llx\n", msi->nr_hwirqs, addr);
+	msi->pcie_msi_cfg = devm_ioremap(dev, addr + PCIE_MSI_CTRL_BASE, PCIE_MSI_CTRL_SIZE);
+	if (!msi->pcie_msi_cfg)
+		return ERR_PTR(-ENOMEM);
+
+	msi->nr_virqs = msi->nr_hwirqs * MSI_IRQ_PER_GRP;
+	msi->nr_grps = msi->nr_hwirqs;
+	msi->grps = devm_kcalloc(dev, msi->nr_grps, sizeof(*msi->grps), GFP_KERNEL);
+	if (!msi->grps)
+		return ERR_PTR(-ENOMEM);
+
+	msi->bitmap = devm_kcalloc(dev, BITS_TO_LONGS(msi->nr_virqs),
+				sizeof(*msi->bitmap), GFP_KERNEL);
+	if (!msi->bitmap)
+		return ERR_PTR(-ENOMEM);
+
+	ret = qcom_msi_alloc_domains(msi);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = qcom_msi_irq_setup(msi);
+	if (ret) {
+		qcom_msi_deinit(msi);
+		return ERR_PTR(ret);
+	}
+
+	qcom_msi_config(msi->msi_domain);
+	return msi;
+}
+
+static int qcom_pcie_ecam_suspend_noirq(struct device *dev)
+{
+	return pm_runtime_put_sync(dev);
+}
+
+static int qcom_pcie_ecam_resume_noirq(struct device *dev)
+{
+	return pm_runtime_get_sync(dev);
+}
+
+static int qcom_pcie_ecam_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_msi *msi;
+	int ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "fail to enable pcie controller: %d\n", ret);
+		return ret;
+	}
+
+	msi = qcom_msi_init(dev);
+	if (IS_ERR(msi)) {
+		pm_runtime_put_sync(dev);
+		return PTR_ERR(msi);
+	}
+
+	ret = pci_host_common_probe(pdev);
+	if (ret) {
+		dev_err(dev, "pci_host_common_probe() failed:%d\n", ret);
+		qcom_msi_deinit(msi);
+		pm_runtime_put_sync(dev);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops qcom_pcie_ecam_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_ecam_suspend_noirq,
+				qcom_pcie_ecam_resume_noirq)
+};
+
+static const struct pci_ecam_ops qcom_pcie_ecam_ops = {
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+
+static const struct of_device_id qcom_pcie_ecam_of_match[] = {
+	{
+		.compatible	= "qcom,pcie-ecam-rc",
+		.data		= &qcom_pcie_ecam_ops,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_pcie_ecam_of_match);
+
+static struct platform_driver qcom_pcie_ecam_driver = {
+	.probe	= qcom_pcie_ecam_probe,
+	.driver	= {
+		.name			= "qcom-pcie-ecam-rc",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= qcom_pcie_ecam_of_match,
+		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
+		.pm			= &qcom_pcie_ecam_pm_ops,
+	},
+};
+module_platform_driver(qcom_pcie_ecam_driver);
+
+MODULE_DESCRIPTION("Qualcomm PCIe ECAM root complex driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4


