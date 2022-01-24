Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F7498091
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiAXNMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 08:12:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31122 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbiAXNMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 08:12:39 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jj9KS5GTLz1FCqm;
        Mon, 24 Jan 2022 21:08:44 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 21:12:36 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 4/8] hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace device
Date:   Mon, 24 Jan 2022 21:11:14 +0800
Message-ID: <20220124131118.17887-5-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220124131118.17887-1-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add tune function for the HiSilicon Tune and Trace device. The interface
of tune is exposed through sysfs attributes of PTT PMU device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 154 +++++++++++++++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h |  19 ++++
 2 files changed, 173 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 2994354e690b..b11e702eb506 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -21,6 +21,159 @@
 
 #include "hisi_ptt.h"
 
+static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
+				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
+				  HISI_PTT_WAIT_POLL_INTERVAL_US,
+				  HISI_PTT_WAIT_TIMEOUT_US);
+}
+
+static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
+				  u32 event, u16 *data)
+{
+	u32 reg;
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  event);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+
+	/* Write all 1 to indicates it's the read process */
+	writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
+		return -ETIMEDOUT;
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
+	*data = (u16)reg;
+
+	return 0;
+}
+
+static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
+				  u32 event, u16 data)
+{
+	u32 reg;
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  event);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+
+	reg = data;
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static ssize_t hisi_ptt_tune_attr_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	struct dev_ext_attribute *ext_attr;
+	struct hisi_ptt_tune_desc *desc;
+	int ret;
+	u16 val;
+
+	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
+	desc = ext_attr->var;
+
+	if (!mutex_trylock(&hisi_ptt->mutex))
+		return -EBUSY;
+
+	ret = hisi_ptt_tune_data_get(hisi_ptt, desc->event_code, &val);
+
+	mutex_unlock(&hisi_ptt->mutex);
+	return ret ? ret : sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t hisi_ptt_tune_attr_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	struct dev_ext_attribute *ext_attr;
+	struct hisi_ptt_tune_desc *desc;
+	int ret;
+	u16 val;
+
+	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
+	desc = ext_attr->var;
+
+	if (kstrtou16(buf, 10, &val))
+		return -EINVAL;
+
+	if (!mutex_trylock(&hisi_ptt->mutex))
+		return -EBUSY;
+
+	ret = hisi_ptt_tune_data_set(hisi_ptt, desc->event_code, val);
+
+	mutex_unlock(&hisi_ptt->mutex);
+	return ret ? ret : count;
+}
+
+#define HISI_PTT_TUNE_ATTR(_name, _val, _show, _store)			\
+	static struct hisi_ptt_tune_desc _name##_desc = {		\
+		.name = #_name,						\
+		.event_code = _val,					\
+	};								\
+	static struct dev_ext_attribute hisi_ptt_##_name##_attr = {	\
+		.attr	= __ATTR(_name, 0600, _show, _store),		\
+		.var	= &_name##_desc,				\
+	}
+
+#define HISI_PTT_TUNE_ATTR_COMMON(_name, _val)		\
+	HISI_PTT_TUNE_ATTR(_name, _val,			\
+			   hisi_ptt_tune_attr_show,	\
+			   hisi_ptt_tune_attr_store)
+
+/*
+ * The value of the tuning event are composed of two parts: main event code in bit[0,15] and
+ * subevent code in bit[16,23]. For example, qox_tx_cpl is a subevent of 'Tx path QoS control'
+ * which for tuning the weight of Tx completion TLPs. See hisi_ptt.rst documentation for
+ * more information.
+ */
+#define HISI_PTT_TUNE_QOS_TX_CPL				(0x4 | (3 << 16))
+#define HISI_PTT_TUNE_QOS_TX_NP					(0x4 | (4 << 16))
+#define HISI_PTT_TUNE_QOS_TX_P					(0x4 | (5 << 16))
+#define HISI_PTT_TUNE_TX_PATH_IOB_RX_REQ_ALLOC_BUF_LEVEL	(0x5 | (6 << 16))
+#define HISI_PTT_TUNE_TX_PATH_TX_REQ_ALLOC_BUF_LEVEL		(0x5 | (7 << 16))
+
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_cpl,
+			  HISI_PTT_TUNE_QOS_TX_CPL);
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_np,
+			  HISI_PTT_TUNE_QOS_TX_NP);
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_p,
+			  HISI_PTT_TUNE_QOS_TX_P);
+HISI_PTT_TUNE_ATTR_COMMON(tx_path_iob_rx_req_alloc_buf_level,
+			  HISI_PTT_TUNE_TX_PATH_IOB_RX_REQ_ALLOC_BUF_LEVEL);
+HISI_PTT_TUNE_ATTR_COMMON(tx_path_tx_req_alloc_buf_level,
+			  HISI_PTT_TUNE_TX_PATH_TX_REQ_ALLOC_BUF_LEVEL);
+
+static struct attribute *hisi_ptt_tune_attrs[] = {
+	&hisi_ptt_qos_tx_cpl_attr.attr.attr,
+	&hisi_ptt_qos_tx_np_attr.attr.attr,
+	&hisi_ptt_qos_tx_p_attr.attr.attr,
+	&hisi_ptt_tx_path_iob_rx_req_alloc_buf_level_attr.attr.attr,
+	&hisi_ptt_tx_path_tx_req_alloc_buf_level_attr.attr.attr,
+	NULL,
+};
+
+static struct attribute_group hisi_ptt_tune_group = {
+	.attrs	= hisi_ptt_tune_attrs,
+	.name	= "tune",
+};
+
 static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
 {
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
@@ -516,6 +669,7 @@ static struct attribute_group hisi_ptt_pmu_filter_group = {
 static const struct attribute_group *hisi_ptt_pmu_groups[] = {
 	&hisi_ptt_pmu_format_group,
 	&hisi_ptt_pmu_filter_group,
+	&hisi_ptt_tune_group,
 	NULL
 };
 
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 151e9e544653..c350f6d91c69 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -23,6 +23,11 @@
 /*
  * The definition of the device registers and register fields.
  */
+#define HISI_PTT_TUNING_CTRL		0x0000
+#define   HISI_PTT_TUNING_CTRL_CODE	GENMASK(15, 0)
+#define   HISI_PTT_TUNING_CTRL_SUB	GENMASK(23, 16)
+#define HISI_PTT_TUNING_DATA		0x0004
+#define   HISI_PTT_TUNING_DATA_VAL_MASK	GENMASK(15, 0)
 #define HISI_PTT_TRACE_ADDR_SIZE	0x0800
 #define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
 #define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
@@ -38,6 +43,8 @@
 #define HISI_PTT_TRACE_INT_STAT		0x0890
 #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
 #define HISI_PTT_TRACE_INT_MASK		0x0894
+#define HISI_PTT_TUNING_INT_STAT	0x0898
+#define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
 #define HISI_PTT_TRACE_WR_STS		0x08a0
 #define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
 #define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
@@ -71,6 +78,18 @@ enum hisi_ptt_trace_status {
 	HISI_PTT_TRACE_STATUS_ON,
 };
 
+/**
+ * struct hisi_ptt_tune_desc - describe tune event for PTT tune
+ * @hisi_ptt:   PTT device this tune event belongs to
+ * @name:       name of this event
+ * @event_code: code of the event
+ */
+struct hisi_ptt_tune_desc {
+	struct hisi_ptt *hisi_ptt;
+	const char *name;
+	u32 event_code;
+};
+
 /**
  * struct hisi_ptt_dma_buffer - describe a single trace buffer of PTT trace.
  *                              The detail of the data format is described
-- 
2.24.0

