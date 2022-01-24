Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED18949808F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiAXNMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 08:12:39 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16736 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbiAXNMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 08:12:38 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj9KS1KmbzZfLJ;
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
Subject: [PATCH v3 3/8] hisi_ptt: Add support for dynamically updating the filter list
Date:   Mon, 24 Jan 2022 21:11:13 +0800
Message-ID: <20220124131118.17887-4-yangyicong@hisilicon.com>
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

The PCIe devices supported by the PTT trace can be removed/rescanned
by hotplug or through sysfs.  Add support for dynamically updating
the available filter list by registering a PCI bus notifier block.
Then user can always get latest information about available tracing
filters and driver can block the invalid filters of which related
devices no longer exist in the system.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 141 ++++++++++++++++++++++++++++---
 drivers/hwtracing/ptt/hisi_ptt.h |  39 +++++++++
 2 files changed, 167 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index eeb8afc65a56..2994354e690b 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -271,26 +271,120 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 	return 0;
 }
 
-static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
+static void hisi_ptt_update_filters(struct work_struct *work)
 {
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct hisi_ptt_filter_update_info info;
 	struct hisi_ptt_filter_desc *filter;
-	struct hisi_ptt *hisi_ptt = data;
 	struct list_head *target_list;
+	struct hisi_ptt *hisi_ptt;
 
-	target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
-		      &hisi_ptt->port_filters : &hisi_ptt->req_filters;
+	hisi_ptt = container_of(delayed_work, struct hisi_ptt, work);
 
-	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	if (!filter)
-		return -ENOMEM;
+	if (!mutex_trylock(&hisi_ptt->mutex)) {
+		schedule_delayed_work(&hisi_ptt->work, HISI_PTT_WORK_DELAY_MS);
+		return;
+	}
 
-	filter->pdev = pdev;
-	filter->val = hisi_ptt_get_filter_val(pdev);
-	list_add_tail(&filter->list, target_list);
+	while (kfifo_get(&hisi_ptt->filter_update_kfifo, &info)) {
+		target_list = info.is_port ? &hisi_ptt->port_filters :
+			      &hisi_ptt->req_filters;
+
+		if (info.is_add) {
+			filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+			if (!filter)
+				continue;
+
+			filter->pdev = info.pdev;
+			filter->val = info.val;
+
+			list_add_tail(&filter->list, target_list);
+		} else {
+			list_for_each_entry(filter, target_list, list)
+				if (filter->val == info.val) {
+					list_del(&filter->list);
+					kfree(filter);
+					break;
+				}
+		}
 
-	/* Update the available port mask */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
-		hisi_ptt->port_mask |= filter->val;
+		/* Update the available port mask */
+		if (!info.is_port)
+			continue;
+
+		if (info.is_add)
+			hisi_ptt->port_mask |= info.val;
+		else
+			hisi_ptt->port_mask &= ~info.val;
+	}
+
+	mutex_unlock(&hisi_ptt->mutex);
+}
+
+static void hisi_ptt_update_fifo_in(struct hisi_ptt *hisi_ptt,
+				    struct hisi_ptt_filter_update_info *info)
+{
+	struct pci_dev *root_port = pcie_find_root_port(info->pdev);
+
+	if (!root_port)
+		return;
+
+	info->port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
+	if (info->port_devid < hisi_ptt->lower ||
+	    info->port_devid > hisi_ptt->upper)
+		return;
+
+	info->is_port = pci_pcie_type(info->pdev) == PCI_EXP_TYPE_ROOT_PORT;
+	info->val = hisi_ptt_get_filter_val(info->pdev);
+
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
+static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
+{
+	struct hisi_ptt_filter_update_info info = {
+		.pdev = pdev,
+		.is_add = true,
+	};
+	struct hisi_ptt *hisi_ptt = data;
+
+	hisi_ptt_update_fifo_in(hisi_ptt, &info);
 
 	return 0;
 }
@@ -316,6 +410,9 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	struct pci_bus *bus;
 	u32 reg;
 
+	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
+	spin_lock_init(&hisi_ptt->filter_update_lock);
+	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
 	INIT_LIST_HEAD(&hisi_ptt->port_filters);
 	INIT_LIST_HEAD(&hisi_ptt->req_filters);
 
@@ -336,6 +433,13 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	hisi_ptt->core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
 	hisi_ptt->sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
 
+	/*
+	 * No need to fail if the bus is NULL here as the device
+	 * maybe hotplugged after the PTT driver probe, in which
+	 * case we can detect the event and update the list as
+	 * we register a bus notifier for dynamically updating
+	 * the filter list.
+	 */
 	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
 	if (bus)
 		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
@@ -822,6 +926,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
+	/* Register the bus notifier for dynamically updating the filter list */
+	hisi_ptt->hisi_ptt_nb.notifier_call = hisi_ptt_notifier_call;
+	ret = bus_register_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
+	if (ret)
+		pci_warn(pdev, "failed to register filter update notifier, ret = %d", ret);
+
 	return 0;
 }
 
@@ -829,6 +939,11 @@ void hisi_ptt_remove(struct pci_dev *pdev)
 {
 	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
 
+	bus_unregister_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
+
+	/* Cancel any work that has been queued */
+	cancel_delayed_work_sync(&hisi_ptt->work);
+
 	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
 		hisi_ptt_trace_end(hisi_ptt);
 
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 002b64dfa42d..151e9e544653 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -10,11 +10,15 @@
 #define _HISI_PTT_H
 
 #include <linux/bits.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/perf_event.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 /*
  * The definition of the device registers and register fields.
@@ -50,6 +54,10 @@
 #define HISI_PTT_TRACE_BUF_SIZE			SZ_4M
 #define HISI_PTT_TRACE_TOTAL_BUF_SIZE		(HISI_PTT_TRACE_BUF_SIZE * \
 						 HISI_PTT_TRACE_BUF_CNT)
+/* FIFO size for dynamically updating the PTT trace filter list. */
+#define HISI_PTT_FILTER_UPDATE_FIFO_SIZE	16
+/* Delay time for filter updating work */
+#define HISI_PTT_WORK_DELAY_MS		100UL
 /* Wait time for DMA hardware to reset */
 #define HISI_PTT_RESET_WAIT_MS		1000UL
 /* Poll timeout and interval for waiting hardware work to finish */
@@ -136,6 +144,22 @@ struct hisi_ptt_pmu_buf {
 	long pos;
 };
 
+/**
+ * struct hisi_ptt_filter_update_info - information for PTT filter updating
+ * @pdev:       the PCI device to update in the filter list
+ * @port_devid: the device ID of the PCI device
+ * @is_port:    whether the PCI device is a root port
+ * @is_add:     adding to the filter or not
+ * @val:        the filter value related to the PCI device
+ */
+struct hisi_ptt_filter_update_info {
+	struct pci_dev *pdev;
+	u32 port_devid;
+	bool is_port;
+	bool is_add;
+	u16 val;
+};
+
 /**
  * struct hisi_ptt - per PTT device data
  * @trace_ctrl:   the control information of PTT trace
@@ -151,9 +175,13 @@ struct hisi_ptt_pmu_buf {
  * @port_filters: the filter list of root ports
  * @req_filters:  the filter list of requester ID
  * @port_mask:    port mask of the managed root ports
+ * @work:         delayed work for filter updating
+ * @filter_update_lock: spinlock to protect the filter update fifo
+ * @filter_update_fifo: fifo of the filters waiting to update the filter list
  */
 struct hisi_ptt {
 	struct hisi_ptt_trace_ctrl trace_ctrl;
+	struct notifier_block hisi_ptt_nb;
 	struct pmu hisi_ptt_pmu;
 	void __iomem *iobase;
 	struct pci_dev *pdev;
@@ -174,6 +202,17 @@ struct hisi_ptt {
 	struct list_head port_filters;
 	struct list_head req_filters;
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

