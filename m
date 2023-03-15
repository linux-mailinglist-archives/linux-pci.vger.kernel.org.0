Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF716BAC6D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 10:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCOJoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjCOJoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 05:44:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F186230B;
        Wed, 15 Mar 2023 02:43:47 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pc54t1FhgzHwtM;
        Wed, 15 Mar 2023 17:41:34 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:43:45 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH 2/4] hwtracing: hisi_ptt: Add support for dynamically updating the filter list
Date:   Wed, 15 Mar 2023 17:43:14 +0800
Message-ID: <20230315094316.26772-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230315094316.26772-1-yangyicong@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

The PCIe devices supported by the PTT trace can be removed/rescanned by
hotplug or through sysfs.  Add support for dynamically updating the
available filter list by registering a PCI bus notifier block. Then user
can always get latest information about available tracing filters and
driver can block the invalid filters of which related devices no longer
exist in the system.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/trace/hisi-ptt.rst |   6 +-
 drivers/hwtracing/ptt/hisi_ptt.c | 152 ++++++++++++++++++++++++++++++-
 drivers/hwtracing/ptt/hisi_ptt.h |  35 +++++++
 3 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
index 4f87d8e21065..3641aca4287a 100644
--- a/Documentation/trace/hisi-ptt.rst
+++ b/Documentation/trace/hisi-ptt.rst
@@ -153,9 +153,9 @@ Endpoint function can be specified in one trace. Specifying both Root Port
 and function at the same time is not supported. Driver maintains a list of
 available filters and will check the invalid inputs.
 
-Currently the available filters are detected in driver's probe. If the supported
-devices are removed/added after probe, you may need to reload the driver to update
-the filters.
+The available filters will be dynamically updates, which means you will always
+get correct filter information when hotplug events happen, or when you manually
+remove/rescan the devices.
 
 2. Type
 -------
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 0a10c7ec46ad..010cdbc3c172 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -354,6 +354,117 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 	return 0;
 }
 
+static void hisi_ptt_update_filters(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct hisi_ptt_filter_update_info info;
+	struct hisi_ptt_filter_desc *filter;
+	struct list_head *target_list;
+	struct hisi_ptt *hisi_ptt;
+
+	hisi_ptt = container_of(delayed_work, struct hisi_ptt, work);
+
+	if (!mutex_trylock(&hisi_ptt->filter_lock)) {
+		schedule_delayed_work(&hisi_ptt->work, HISI_PTT_WORK_DELAY_MS);
+		return;
+	}
+
+	while (kfifo_get(&hisi_ptt->filter_update_kfifo, &info)) {
+		bool is_port = pci_pcie_type(info.pdev) == PCI_EXP_TYPE_ROOT_PORT;
+		u16 devid = PCI_DEVID(info.pdev->bus->number, info.pdev->devfn);
+		u16 val = hisi_ptt_get_filter_val(devid, is_port);
+
+		target_list = is_port ? &hisi_ptt->port_filters : &hisi_ptt->req_filters;
+
+		if (info.is_add) {
+			filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+			if (!filter) {
+				pci_err(hisi_ptt->pdev, "failed to add filter %s\n",
+					pci_name(info.pdev));
+				continue;
+			}
+
+			filter->devid = devid;
+			filter->is_port = is_port;
+			list_add_tail(&filter->list, target_list);
+
+			if (is_port)
+				hisi_ptt->port_mask |= val;
+		} else {
+			list_for_each_entry(filter, target_list, list)
+				if (filter->devid == devid) {
+					list_del(&filter->list);
+					kfree(filter);
+					break;
+				}
+
+			if (is_port)
+				hisi_ptt->port_mask &= ~val;
+		}
+	}
+
+	mutex_unlock(&hisi_ptt->filter_lock);
+}
+
+static void hisi_ptt_update_fifo_in(struct hisi_ptt *hisi_ptt,
+				    struct hisi_ptt_filter_update_info *info)
+{
+	struct pci_dev *root_port = pcie_find_root_port(info->pdev);
+	u32 port_devid;
+
+	if (!root_port)
+		return;
+
+	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
+	if (port_devid < hisi_ptt->lower_bdf ||
+	    port_devid > hisi_ptt->upper_bdf)
+		return;
+
+	/*
+	 * The FIFO size is 16 which is sufficient for almost all the cases,
+	 * since each PCIe core will have most 8 Root Ports (typically only
+	 * 1~4 Root Ports). On failure log the failed filter and let user
+	 * handle it.
+	 */
+	if (kfifo_in_spinlocked(&hisi_ptt->filter_update_kfifo, info, 1,
+				&hisi_ptt->filter_update_lock))
+		schedule_delayed_work(&hisi_ptt->work, 0);
+	else
+		pci_warn(hisi_ptt->pdev,
+			 "filter update fifo overflow for target %s\n",
+			 pci_name(info->pdev));
+}
+
+/*
+ * A PCI bus notifier is used here for dynamically updating the filter
+ * list.
+ */
+static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long action,
+				  void *data)
+{
+	struct hisi_ptt *hisi_ptt = container_of(nb, struct hisi_ptt, hisi_ptt_nb);
+	struct hisi_ptt_filter_update_info info;
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	info.pdev = pdev;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		info.is_add = true;
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		info.is_add = false;
+		break;
+	default:
+		return 0;
+	}
+
+	hisi_ptt_update_fifo_in(hisi_ptt, &info);
+
+	return 0;
+}
+
 static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 {
 	struct pci_dev *root_port = pcie_find_root_port(pdev);
@@ -451,8 +562,13 @@ static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	int ret;
 	u32 reg;
 
+	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
+	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
+	spin_lock_init(&hisi_ptt->filter_update_lock);
+
 	INIT_LIST_HEAD(&hisi_ptt->port_filters);
 	INIT_LIST_HEAD(&hisi_ptt->req_filters);
+	mutex_init(&hisi_ptt->filter_lock);
 
 	ret = hisi_ptt_config_trace_buf(hisi_ptt);
 	if (ret)
@@ -627,14 +743,19 @@ static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
 	 * For Requester ID filters, walk the available filter list to see
 	 * whether we have one matched.
 	 */
+	mutex_lock(&hisi_ptt->filter_lock);
 	if (!hisi_ptt->trace_ctrl.is_port) {
 		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
-			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
+			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port)) {
+				mutex_unlock(&hisi_ptt->filter_lock);
 				return 0;
+			}
 		}
 	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
+		mutex_unlock(&hisi_ptt->filter_lock);
 		return 0;
 	}
+	mutex_unlock(&hisi_ptt->filter_lock);
 
 	return -EINVAL;
 }
@@ -910,6 +1031,31 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
 					&hisi_ptt->hisi_ptt_pmu);
 }
 
+static void hisi_ptt_unregister_filter_update_notifier(void *data)
+{
+	struct hisi_ptt *hisi_ptt = data;
+
+	bus_unregister_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
+
+	/* Cancel any work that has been queued */
+	cancel_delayed_work_sync(&hisi_ptt->work);
+}
+
+/* Register the bus notifier for dynamically updating the filter list */
+static int hisi_ptt_register_filter_update_notifier(struct hisi_ptt *hisi_ptt)
+{
+	int ret;
+
+	hisi_ptt->hisi_ptt_nb.notifier_call = hisi_ptt_notifier_call;
+	ret = bus_register_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
+					hisi_ptt_unregister_filter_update_notifier,
+					hisi_ptt);
+}
+
 /*
  * The DMA of PTT trace can only use direct mappings due to some
  * hardware restriction. Check whether there is no IOMMU or the
@@ -981,6 +1127,10 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
+	ret = hisi_ptt_register_filter_update_notifier(hisi_ptt);
+	if (ret)
+		pci_warn(pdev, "failed to register filter update notifier, ret = %d", ret);
+
 	ret = hisi_ptt_register_pmu(hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to register PMU device, ret = %d", ret);
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 5beb1648c93a..b1ba638fe7ea 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -11,12 +11,15 @@
 
 #include <linux/bits.h>
 #include <linux/cpumask.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/perf_event.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #define DRV_NAME "hisi_ptt"
 
@@ -71,6 +74,11 @@
 #define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
 #define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
 
+/* FIFO size for dynamically updating the PTT trace filter list. */
+#define HISI_PTT_FILTER_UPDATE_FIFO_SIZE	16
+/* Delay time for filter updating work */
+#define HISI_PTT_WORK_DELAY_MS			100UL
+
 #define HISI_PCIE_CORE_PORT_ID(devfn)	((PCI_SLOT(devfn) & 0x7) << 1)
 
 /* Definition of the PMU configs */
@@ -143,6 +151,16 @@ struct hisi_ptt_filter_desc {
 	u16 devid;
 };
 
+/**
+ * struct hisi_ptt_filter_update_info - Information for PTT filter updating
+ * @pdev:       the PCI device to update in the filter list
+ * @is_add:     adding to the filter or not
+ */
+struct hisi_ptt_filter_update_info {
+	struct pci_dev *pdev;
+	bool is_add;
+};
+
 /**
  * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
  * @length:   size of the AUX buffer
@@ -170,10 +188,15 @@ struct hisi_ptt_pmu_buf {
  * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
  * @port_filters: the filter list of root ports
  * @req_filters:  the filter list of requester ID
+ * @filter_lock:  lock to protect the filters
  * @port_mask:    port mask of the managed root ports
+ * @work:         delayed work for filter updating
+ * @filter_update_lock: spinlock to protect the filter update fifo
+ * @filter_update_fifo: fifo of the filters waiting to update the filter list
  */
 struct hisi_ptt {
 	struct hisi_ptt_trace_ctrl trace_ctrl;
+	struct notifier_block hisi_ptt_nb;
 	struct hlist_node hotplug_node;
 	struct pmu hisi_ptt_pmu;
 	void __iomem *iobase;
@@ -192,7 +215,19 @@ struct hisi_ptt {
 	 */
 	struct list_head port_filters;
 	struct list_head req_filters;
+	struct mutex filter_lock;
 	u16 port_mask;
+
+	/*
+	 * We use a delayed work here to avoid indefinitely waiting for
+	 * the hisi_ptt->mutex which protecting the filter list. The
+	 * work will be delayed only if the mutex can not be held,
+	 * otherwise no delay will be applied.
+	 */
+	struct delayed_work work;
+	spinlock_t filter_update_lock;
+	DECLARE_KFIFO(filter_update_kfifo, struct hisi_ptt_filter_update_info,
+		      HISI_PTT_FILTER_UPDATE_FIFO_SIZE);
 };
 
 #define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
-- 
2.24.0

