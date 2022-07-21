Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019A57CB32
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiGUNDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGUNDJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 09:03:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5574E3F;
        Thu, 21 Jul 2022 06:02:57 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LpXjq2npgzkXCn;
        Thu, 21 Jul 2022 21:00:31 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 21:02:55 +0800
From:   <yangyicong@huawei.com>
To:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <corbet@lwn.net>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <suzuki.poulose@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <bagasdotme@gmail.com>
Subject: [PATCH v11 3/8] hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace device
Date:   Thu, 21 Jul 2022 21:01:11 +0800
Message-ID: <20220721130116.43366-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220721130116.43366-1-yangyicong@huawei.com>
References: <20220721130116.43366-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Add tune function for the HiSilicon Tune and Trace device. The interface
of tune is exposed through sysfs attributes of PTT PMU device.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 131 +++++++++++++++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h |  23 ++++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index c64642097f8b..9133c86ac6af 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -25,6 +25,135 @@
 /* Dynamic CPU hotplug state used by PTT */
 static enum cpuhp_state hisi_ptt_pmu_online;
 
+static bool hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return !readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
+				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
+				  HISI_PTT_WAIT_POLL_INTERVAL_US,
+				  HISI_PTT_WAIT_TUNE_TIMEOUT_US);
+}
+
+static ssize_t hisi_ptt_tune_attr_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	struct dev_ext_attribute *ext_attr;
+	struct hisi_ptt_tune_desc *desc;
+	u32 reg;
+	u16 val;
+
+	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
+	desc = ext_attr->var;
+
+	mutex_lock(&hisi_ptt->tune_lock);
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  desc->event_code);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+
+	/* Write all 1 to indicates it's the read process */
+	writel(~0U, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (!hisi_ptt_wait_tuning_finish(hisi_ptt)) {
+		mutex_unlock(&hisi_ptt->tune_lock);
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
+	val = FIELD_GET(HISI_PTT_TUNING_DATA_VAL_MASK, reg);
+
+	mutex_unlock(&hisi_ptt->tune_lock);
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t hisi_ptt_tune_attr_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	struct dev_ext_attribute *ext_attr;
+	struct hisi_ptt_tune_desc *desc;
+	u32 reg;
+	u16 val;
+
+	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
+	desc = ext_attr->var;
+
+	if (kstrtou16(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&hisi_ptt->tune_lock);
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  desc->event_code);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	writel(FIELD_PREP(HISI_PTT_TUNING_DATA_VAL_MASK, val),
+	       hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (!hisi_ptt_wait_tuning_finish(hisi_ptt)) {
+		mutex_unlock(&hisi_ptt->tune_lock);
+		return -ETIMEDOUT;
+	}
+
+	mutex_unlock(&hisi_ptt->tune_lock);
+	return count;
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
+ * The value of the tuning event are composed of two parts: main event code
+ * in BIT[0,15] and subevent code in BIT[16,23]. For example, qox_tx_cpl is
+ * a subevent of 'Tx path QoS control'  * which for tuning the weight of Tx
+ * completion TLPs. See hisi_ptt.rst documentation for more information.
+ */
+#define HISI_PTT_TUNE_QOS_TX_CPL		(0x4 | (3 << 16))
+#define HISI_PTT_TUNE_QOS_TX_NP			(0x4 | (4 << 16))
+#define HISI_PTT_TUNE_QOS_TX_P			(0x4 | (5 << 16))
+#define HISI_PTT_TUNE_RX_ALLOC_BUF_LEVEL	(0x5 | (6 << 16))
+#define HISI_PTT_TUNE_TX_ALLOC_BUF_LEVEL	(0x5 | (7 << 16))
+
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_cpl, HISI_PTT_TUNE_QOS_TX_CPL);
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_np, HISI_PTT_TUNE_QOS_TX_NP);
+HISI_PTT_TUNE_ATTR_COMMON(qos_tx_p, HISI_PTT_TUNE_QOS_TX_P);
+HISI_PTT_TUNE_ATTR_COMMON(rx_alloc_buf_level, HISI_PTT_TUNE_RX_ALLOC_BUF_LEVEL);
+HISI_PTT_TUNE_ATTR_COMMON(tx_alloc_buf_level, HISI_PTT_TUNE_TX_ALLOC_BUF_LEVEL);
+
+static struct attribute *hisi_ptt_tune_attrs[] = {
+	&hisi_ptt_qos_tx_cpl_attr.attr.attr,
+	&hisi_ptt_qos_tx_np_attr.attr.attr,
+	&hisi_ptt_qos_tx_p_attr.attr.attr,
+	&hisi_ptt_rx_alloc_buf_level_attr.attr.attr,
+	&hisi_ptt_tx_alloc_buf_level_attr.attr.attr,
+	NULL,
+};
+
+static struct attribute_group hisi_ptt_tune_group = {
+	.name	= "tune",
+	.attrs	= hisi_ptt_tune_attrs,
+};
+
 static u16 hisi_ptt_get_filter_val(u16 devid, bool is_port)
 {
 	if (is_port)
@@ -393,6 +522,7 @@ static struct attribute_group hisi_ptt_pmu_format_group = {
 static const struct attribute_group *hisi_ptt_pmu_groups[] = {
 	&hisi_ptt_cpumask_attr_group,
 	&hisi_ptt_pmu_format_group,
+	&hisi_ptt_tune_group,
 	NULL
 };
 
@@ -719,6 +849,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
 	if (ret)
 		return ret;
 
+	mutex_init(&hisi_ptt->tune_lock);
 	spin_lock_init(&hisi_ptt->pmu_lock);
 
 	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 10446dce8a86..5beb1648c93a 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/cpumask.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/perf_event.h>
 #include <linux/spinlock.h>
@@ -22,6 +23,11 @@
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
@@ -37,6 +43,8 @@
 #define HISI_PTT_TRACE_INT_STAT		0x0890
 #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
 #define HISI_PTT_TRACE_INT_MASK		0x0894
+#define HISI_PTT_TUNING_INT_STAT	0x0898
+#define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
 #define HISI_PTT_TRACE_WR_STS		0x08a0
 #define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
 #define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
@@ -59,6 +67,7 @@
 #define HISI_PTT_RESET_TIMEOUT_US	10UL
 #define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
 /* Poll timeout and interval for waiting hardware work to finish */
+#define HISI_PTT_WAIT_TUNE_TIMEOUT_US	1000000UL
 #define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
 #define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
 
@@ -71,6 +80,18 @@
 #define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
 #define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
 
+/**
+ * struct hisi_ptt_tune_desc - Describe tune event for PTT tune
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
  * struct hisi_ptt_dma_buffer - Describe a single trace buffer of PTT trace.
  *                              The detail of the data format is described
@@ -143,6 +164,7 @@ struct hisi_ptt_pmu_buf {
  * @hisi_ptt_pmu: the pum device of trace
  * @iobase:       base IO address of the device
  * @pdev:         pci_dev of this PTT device
+ * @tune_lock:    lock to serialize the tune process
  * @pmu_lock:     lock to serialize the perf process
  * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
  * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
@@ -156,6 +178,7 @@ struct hisi_ptt {
 	struct pmu hisi_ptt_pmu;
 	void __iomem *iobase;
 	struct pci_dev *pdev;
+	struct mutex tune_lock;
 	spinlock_t pmu_lock;
 	u32 upper_bdf;
 	u32 lower_bdf;
-- 
2.24.0

