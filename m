Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088C0725A8A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbjFGJdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjFGJc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 05:32:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3381735;
        Wed,  7 Jun 2023 02:32:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QbhrZ36VkzLqYX;
        Wed,  7 Jun 2023 17:29:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 17:32:52 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v5 3/5] hwtracing: hisi_ptt: Export available filters through sysfs
Date:   Wed, 7 Jun 2023 17:31:21 +0800
Message-ID: <20230607093123.51421-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230607093123.51421-1-yangyicong@huawei.com>
References: <20230607093123.51421-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The PTT can only filter the traced TLP headers by the Root Ports or the
Requester ID of the Endpoint, which are located on the same PCIe core of
the PTT device. The filter value used is derived from the BDF number of
the supported Root Port or the Endpoint. It's not friendly enough for the
users since it requires the user to be familiar enough with the platform
and calculate the filter value manually.

This patch export the available filters through sysfs. Each available
filters is presented as an individual file with the name of the BDF
number of the related PCIe device. The files are created under
$(PTT PMU dir)/available_root_port_filters and
$(PTT PMU dir)/available_requester_filters respectively. The filter
value can be known by reading the related file.

Then the users can easily know the available filters for trace and get
the filter values without calculating.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../ABI/testing/sysfs-devices-hisi_ptt        |  52 +++++
 Documentation/trace/hisi-ptt.rst              |   6 +
 drivers/hwtracing/ptt/hisi_ptt.c              | 207 ++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h              |  14 ++
 4 files changed, 279 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
index 82de6d710266..d7e206b4901c 100644
--- a/Documentation/ABI/testing/sysfs-devices-hisi_ptt
+++ b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
@@ -59,3 +59,55 @@ Description:	(RW) Control the allocated buffer watermark of outbound packets.
 		The available tune data is [0, 1, 2]. Writing a negative value
 		will return an error, and out of range values will be converted
 		to 2. The value indicates a probable level of the event.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	This directory contains the files providing the PCIe Root Port filters
+		information used for PTT trace. Each file is named after the supported
+		Root Port device name <domain>:<bus>:<device>.<function>.
+
+		See the description of the "filter" in Documentation/trace/hisi-ptt.rst
+		for more information.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters/multiselect
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(Read) Indicates if this kind of filter can be selected at the same
+		time as others filters, or must be used on it's own. 1 indicates
+		the former case and 0 indicates the latter.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters/<bdf>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(Read) Indicates the filter value of this Root Port filter, which
+		can be used to control the TLP headers to trace by the PTT trace.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	This directory contains the files providing the PCIe Requester filters
+		information used for PTT trace. Each file is named after the supported
+		Endpoint device name <domain>:<bus>:<device>.<function>.
+
+		See the description of the "filter" in Documentation/trace/hisi-ptt.rst
+		for more information.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters/multiselect
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(Read) Indicates if this kind of filter can be selected at the same
+		time as others filters, or must be used on it's own. 1 indicates
+		the former case and 0 indicates the latter.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters/<bdf>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(Read) Indicates the filter value of this Requester filter, which
+		can be used to control the TLP headers to trace by the PTT trace.
diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
index 69c538153838..989255eb5622 100644
--- a/Documentation/trace/hisi-ptt.rst
+++ b/Documentation/trace/hisi-ptt.rst
@@ -148,6 +148,12 @@ For example, if the desired filter is Endpoint function 0000:01:00.1 the filter
 value will be 0x00101. If the desired filter is Root Port 0000:00:10.0 then
 then filter value is calculated as 0x80001.
 
+The driver also presents every supported Root Port and Requester filter through
+sysfs. Each filter will be an individual file with name of its related PCIe
+device name (domain:bus:device.function). The files of Root Port filters are
+under $(PTT PMU dir)/root_port_filters and files of Requester filters
+are under $(PTT PMU dir)/requester_filters.
+
 Note that multiple Root Ports can be specified at one time, but only one
 Endpoint function can be specified in one trace. Specifying both Root Port
 and function at the same time is not supported. Driver maintains a list of
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 31471488fc91..5c366a757573 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -405,6 +405,144 @@ hisi_ptt_alloc_add_filter(struct hisi_ptt *hisi_ptt, u16 devid, bool is_port)
 	return filter;
 }
 
+static ssize_t hisi_ptt_filter_show(struct device *dev, struct device_attribute *attr,
+				    char *buf)
+{
+	struct hisi_ptt_filter_desc *filter;
+	unsigned long filter_val;
+
+	filter = container_of(attr, struct hisi_ptt_filter_desc, attr);
+	filter_val = hisi_ptt_get_filter_val(filter->devid, filter->is_port) |
+		     (filter->is_port ? HISI_PTT_PMU_FILTER_IS_PORT : 0);
+
+	return sysfs_emit(buf, "0x%05lx\n", filter_val);
+}
+
+static int hisi_ptt_create_rp_filter_attr(struct hisi_ptt *hisi_ptt,
+					  struct hisi_ptt_filter_desc *filter)
+{
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
+
+	sysfs_attr_init(&filter->attr.attr);
+	filter->attr.attr.name = filter->name;
+	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
+	filter->attr.show = hisi_ptt_filter_show;
+
+	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
+				       HISI_PTT_RP_FILTERS_GRP_NAME);
+}
+
+static void hisi_ptt_remove_rp_filter_attr(struct hisi_ptt *hisi_ptt,
+					  struct hisi_ptt_filter_desc *filter)
+{
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
+
+	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
+				     HISI_PTT_RP_FILTERS_GRP_NAME);
+}
+
+static int hisi_ptt_create_req_filter_attr(struct hisi_ptt *hisi_ptt,
+					   struct hisi_ptt_filter_desc *filter)
+{
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
+
+	sysfs_attr_init(&filter->attr.attr);
+	filter->attr.attr.name = filter->name;
+	filter->attr.attr.mode = 0400; /* DEVICE_ATTR_ADMIN_RO */
+	filter->attr.show = hisi_ptt_filter_show;
+
+	return sysfs_add_file_to_group(kobj, &filter->attr.attr,
+				       HISI_PTT_REQ_FILTERS_GRP_NAME);
+}
+
+static void hisi_ptt_remove_req_filter_attr(struct hisi_ptt *hisi_ptt,
+					   struct hisi_ptt_filter_desc *filter)
+{
+	struct kobject *kobj = &hisi_ptt->hisi_ptt_pmu.dev->kobj;
+
+	sysfs_remove_file_from_group(kobj, &filter->attr.attr,
+				     HISI_PTT_REQ_FILTERS_GRP_NAME);
+}
+
+static int hisi_ptt_create_filter_attr(struct hisi_ptt *hisi_ptt,
+				       struct hisi_ptt_filter_desc *filter)
+{
+	int ret;
+
+	if (filter->is_port)
+		ret = hisi_ptt_create_rp_filter_attr(hisi_ptt, filter);
+	else
+		ret = hisi_ptt_create_req_filter_attr(hisi_ptt, filter);
+
+	if (ret)
+		pci_err(hisi_ptt->pdev, "failed to create sysfs attribute for filter %s\n",
+			filter->name);
+
+	return ret;
+}
+
+static void hisi_ptt_remove_filter_attr(struct hisi_ptt *hisi_ptt,
+					struct hisi_ptt_filter_desc *filter)
+{
+	if (filter->is_port)
+		hisi_ptt_remove_rp_filter_attr(hisi_ptt, filter);
+	else
+		hisi_ptt_remove_req_filter_attr(hisi_ptt, filter);
+}
+
+static void hisi_ptt_remove_all_filter_attributes(void *data)
+{
+	struct hisi_ptt_filter_desc *filter;
+	struct hisi_ptt *hisi_ptt = data;
+
+	mutex_lock(&hisi_ptt->filter_lock);
+
+	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
+		hisi_ptt_remove_filter_attr(hisi_ptt, filter);
+
+	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
+		hisi_ptt_remove_filter_attr(hisi_ptt, filter);
+
+	hisi_ptt->sysfs_inited = false;
+	mutex_unlock(&hisi_ptt->filter_lock);
+}
+
+static int hisi_ptt_init_filter_attributes(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_filter_desc *filter;
+	int ret;
+
+	mutex_lock(&hisi_ptt->filter_lock);
+
+	/*
+	 * Register the reset callback in the first stage. In reset we traverse
+	 * the filters list to remove the sysfs attributes so the callback can
+	 * be called safely even without below filter attributes creation.
+	 */
+	ret = devm_add_action(&hisi_ptt->pdev->dev,
+			      hisi_ptt_remove_all_filter_attributes,
+			      hisi_ptt);
+	if (ret)
+		goto out;
+
+	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
+		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
+		if (ret)
+			goto out;
+	}
+
+	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
+		ret = hisi_ptt_create_filter_attr(hisi_ptt, filter);
+		if (ret)
+			goto out;
+	}
+
+	hisi_ptt->sysfs_inited = true;
+out:
+	mutex_unlock(&hisi_ptt->filter_lock);
+	return ret;
+}
+
 static void hisi_ptt_update_filters(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
@@ -429,6 +567,18 @@ static void hisi_ptt_update_filters(struct work_struct *work)
 			filter = hisi_ptt_alloc_add_filter(hisi_ptt, info.devid, info.is_port);
 			if (!filter)
 				continue;
+
+			/*
+			 * If filters' sysfs entries hasn't been initialized,
+			 * then we're still at probe stage. Add the filters to
+			 * the list and later hisi_ptt_init_filter_attributes()
+			 * will create sysfs attributes for all the filters.
+			 */
+			if (hisi_ptt->sysfs_inited &&
+			    hisi_ptt_create_filter_attr(hisi_ptt, filter)) {
+				hisi_ptt_del_free_filter(hisi_ptt, filter);
+				continue;
+			}
 		} else {
 			struct hisi_ptt_filter_desc *tmp;
 			struct list_head *target_list;
@@ -438,6 +588,9 @@ static void hisi_ptt_update_filters(struct work_struct *work)
 
 			list_for_each_entry_safe(filter, tmp, target_list, list)
 				if (filter->devid == info.devid) {
+					if (hisi_ptt->sysfs_inited)
+						hisi_ptt_remove_filter_attr(hisi_ptt, filter);
+
 					hisi_ptt_del_free_filter(hisi_ptt, filter);
 					break;
 				}
@@ -663,10 +816,58 @@ static struct attribute_group hisi_ptt_pmu_format_group = {
 	.attrs = hisi_ptt_pmu_format_attrs,
 };
 
+static ssize_t hisi_ptt_filter_multiselect_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct dev_ext_attribute *ext_attr;
+
+	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)ext_attr->var);
+}
+
+static struct dev_ext_attribute root_port_filters_multiselect = {
+	.attr = {
+		.attr = { .name = "multiselect", .mode = 0400 },
+		.show = hisi_ptt_filter_multiselect_show,
+	},
+	.var = "1",
+};
+
+static struct attribute *hisi_ptt_pmu_root_ports_attrs[] = {
+	&root_port_filters_multiselect.attr.attr,
+	NULL
+};
+
+static struct attribute_group hisi_ptt_pmu_root_ports_group = {
+	.name = HISI_PTT_RP_FILTERS_GRP_NAME,
+	.attrs = hisi_ptt_pmu_root_ports_attrs,
+};
+
+static struct dev_ext_attribute requester_filters_multiselect = {
+	.attr = {
+		.attr = { .name = "multiselect", .mode = 0400 },
+		.show = hisi_ptt_filter_multiselect_show,
+	},
+	.var = "0",
+};
+
+static struct attribute *hisi_ptt_pmu_requesters_attrs[] = {
+	&requester_filters_multiselect.attr.attr,
+	NULL
+};
+
+static struct attribute_group hisi_ptt_pmu_requesters_group = {
+	.name = HISI_PTT_REQ_FILTERS_GRP_NAME,
+	.attrs = hisi_ptt_pmu_requesters_attrs,
+};
+
 static const struct attribute_group *hisi_ptt_pmu_groups[] = {
 	&hisi_ptt_cpumask_attr_group,
 	&hisi_ptt_pmu_format_group,
 	&hisi_ptt_tune_group,
+	&hisi_ptt_pmu_root_ports_group,
+	&hisi_ptt_pmu_requesters_group,
 	NULL
 };
 
@@ -1147,6 +1348,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
+	ret = hisi_ptt_init_filter_attributes(hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to init sysfs filter attributes, ret = %d", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index d598411e9cb8..164012dba4ec 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -11,6 +11,7 @@
 
 #include <linux/bits.h>
 #include <linux/cpumask.h>
+#include <linux/device.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -139,14 +140,25 @@ struct hisi_ptt_trace_ctrl {
 	u32 type:4;
 };
 
+/*
+ * sysfs attribute group name for root port filters and requester filters:
+ * /sys/devices/hisi_ptt<sicl_id>_<core_id>/root_port_filters
+ * and
+ * /sys/devices/hisi_ptt<sicl_id>_<core_id>/requester_filters
+ */
+#define HISI_PTT_RP_FILTERS_GRP_NAME	"root_port_filters"
+#define HISI_PTT_REQ_FILTERS_GRP_NAME	"requester_filters"
+
 /**
  * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
+ * @attr:    sysfs attribute of this filter
  * @list:    entry of this descriptor in the filter list
  * @is_port: the PCI device of the filter is a Root Port or not
  * @name:    name of this filter, same as the name of the related PCI device
  * @devid:   the PCI device's devid of the filter
  */
 struct hisi_ptt_filter_desc {
+	struct device_attribute attr;
 	struct list_head list;
 	bool is_port;
 	char *name;
@@ -194,6 +206,7 @@ struct hisi_ptt_pmu_buf {
  * @port_filters: the filter list of root ports
  * @req_filters:  the filter list of requester ID
  * @filter_lock:  lock to protect the filters
+ * @sysfs_inited: whether the filters' sysfs entries has been initialized
  * @port_mask:    port mask of the managed root ports
  * @work:         delayed work for filter updating
  * @filter_update_lock: spinlock to protect the filter update fifo
@@ -221,6 +234,7 @@ struct hisi_ptt {
 	struct list_head port_filters;
 	struct list_head req_filters;
 	struct mutex filter_lock;
+	bool sysfs_inited;
 	u16 port_mask;
 
 	/*
-- 
2.24.0

