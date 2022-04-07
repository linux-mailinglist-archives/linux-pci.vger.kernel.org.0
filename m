Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C334F7FDB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbiDGNDe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbiDGNCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 09:02:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89B61AF504;
        Thu,  7 Apr 2022 06:00:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ1dw3GwmzgYSS;
        Thu,  7 Apr 2022 20:58:28 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:00:13 +0800
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
        <yangyicong@hisilicon.com>
Subject: [PATCH v7 3/7] hisi_ptt: Add support for dynamically updating the filter list
Date:   Thu, 7 Apr 2022 20:58:37 +0800
Message-ID: <20220407125841.3678-4-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220407125841.3678-1-yangyicong@hisilicon.com>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe devices supported by the PTT trace can be removed/rescanned by
hotplug or through sysfs.  Add support for dynamically updating the
available filter list by registering a PCI bus notifier block. Then user
can always get latest information about available tracing filters and
driver can block the invalid filters of which related devices no longer
exist in the system.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 159 ++++++++++++++++++++++++++++---
 drivers/hwtracing/ptt/hisi_ptt.h |  34 +++++++
 2 files changed, 180 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 242b41870380..b1958ac20372 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -270,27 +270,121 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
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
-	if (!filter) {
-		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
-		return -ENOMEM;
+	if (!mutex_trylock(&hisi_ptt->mutex)) {
+		schedule_delayed_work(&hisi_ptt->work, HISI_PTT_WORK_DELAY_MS);
+		return;
 	}
 
-	filter->pdev = pdev;
-	list_add_tail(&filter->list, target_list);
+	while (kfifo_get(&hisi_ptt->filter_update_kfifo, &info)) {
+		bool is_port = pci_pcie_type(info.pdev) == PCI_EXP_TYPE_ROOT_PORT;
+		u16 val = hisi_ptt_get_filter_val(info.pdev);
 
-	/* Update the available port mask */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
-		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(pdev);
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
+			filter->pdev = info.pdev;
+			list_add_tail(&filter->list, target_list);
+		} else {
+			list_for_each_entry(filter, target_list, list)
+				if (hisi_ptt_get_filter_val(filter->pdev) == val) {
+					list_del(&filter->list);
+					kfree(filter);
+					break;
+				}
+		}
+
+		/* Update the available port mask */
+		if (!is_port)
+			continue;
+
+		if (info.is_add)
+			hisi_ptt->port_mask |= val;
+		else
+			hisi_ptt->port_mask &= ~val;
+	}
+
+	mutex_unlock(&hisi_ptt->mutex);
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
+	if (port_devid < hisi_ptt->lower ||
+	    port_devid > hisi_ptt->upper)
+		return;
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
@@ -318,6 +412,9 @@ static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	int ret;
 	u32 reg;
 
+	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
+	spin_lock_init(&hisi_ptt->filter_update_lock);
+	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
 	INIT_LIST_HEAD(&hisi_ptt->port_filters);
 	INIT_LIST_HEAD(&hisi_ptt->req_filters);
 
@@ -334,6 +431,13 @@ static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
 	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
 
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
@@ -760,6 +864,31 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
 	return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
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
  * The DMA of PTT trace can only use direct mapping, due to some
  * hardware restriction. Check whether there is an IOMMU or the
@@ -832,6 +961,10 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
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
index 29b6d6293d6c..53805f6c9bc2 100644
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
 
 #define DRV_NAME "hisi_ptt"
 
@@ -57,6 +61,12 @@
 /* Wait time for hardware DMA to reset */
 #define HISI_PTT_RESET_TIMEOUT_US	10UL
 #define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
+/* FIFO size for dynamically updating the PTT trace filter list. */
+#define HISI_PTT_FILTER_UPDATE_FIFO_SIZE	16
+/* Delay time for filter updating work */
+#define HISI_PTT_WORK_DELAY_MS		100UL
+/* Wait time for DMA hardware to reset */
+#define HISI_PTT_RESET_WAIT_MS		1000UL
 /* Poll timeout and interval for waiting hardware work to finish */
 #define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
 #define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
@@ -112,6 +122,15 @@ struct hisi_ptt_filter_desc {
 	struct pci_dev *pdev;
 };
 
+/**
+ * struct hisi_ptt_filter_update_info - information for PTT filter updating
+ * @pdev:       the PCI device to update in the filter list
+ * @is_add:     adding to the filter or not
+ */
+struct hisi_ptt_filter_update_info {
+	struct pci_dev *pdev;
+	bool is_add;
+};
 
 /**
  * struct hisi_ptt_pmu_buf - descriptor of the AUX buffer of PTT trace
@@ -139,9 +158,13 @@ struct hisi_ptt_pmu_buf {
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
@@ -159,6 +182,17 @@ struct hisi_ptt {
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

