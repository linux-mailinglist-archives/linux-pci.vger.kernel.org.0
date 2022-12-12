Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85125649952
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 08:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiLLHHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 02:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiLLHGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 02:06:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E502658;
        Sun, 11 Dec 2022 23:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670828800; x=1702364800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nEJoOA+qbgtmTZT+Ky+rbzr8fT+zHXTeqnEx4sAFDFM=;
  b=fYGsyUy76Al7i59J7XOdRy7/21eHL7BU2coz5xdas+A1OWOSUr5kpOxn
   8QM8k/iQMa+89q/JHLvI8hnqK/wfChPvvLEvtTqxCxdVEbvQyXQtF7mgm
   EV1hwqWOrs2WWwPuoLru/19l0YyuQNC8FLvE47n3n5VLlbOh47NEk1tlW
   7NaZMP0NYU1fWlwxZxkT6S/zS8snLIJBfWhR7PZozNmG9XZEkHHjyOTkx
   32Tnjtuz7kGZf1kA3dW4dFDoUm7KoDKMTGkADObBcxWBRjDmWet9zw9v3
   LcJDZ23TQJR8eTlp7dWssUyQ79pQ9Sx2TRXed6rrgTy71OZwANM4g6eYc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317811869"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317811869"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641643107"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641643107"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.168.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:39 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V4 7/9] cxl/test: Add generic mock events
Date:   Sun, 11 Dec 2022 23:06:25 -0800
Message-Id: <20221212070627.1372402-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221212070627.1372402-1-ira.weiny@intel.com>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Facilitate testing basic Get/Clear Event functionality by creating
multiple logs and generic events with made up UUID's.

Data is completely made up with data patterns which should be easy to
spot in trace output.

A single sysfs entry resets the event data and triggers collecting the
events for testing.

Test traces are easy to obtain with a small script such as this:

	#!/bin/bash -x

	devices=`find /sys/devices/platform -name cxl_mem*`

	# Turn on tracing
	echo "" > /sys/kernel/tracing/trace
	echo 1 > /sys/kernel/tracing/events/cxl/enable
	echo 1 > /sys/kernel/tracing/tracing_on

	# Generate fake interrupt
	for device in $devices; do
	        echo 1 > $device/event_trigger
	done

	# Turn off tracing and report events
	echo 0 > /sys/kernel/tracing/tracing_on
	cat /sys/kernel/tracing/trace

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v3:
	Dan
		Move code to mem.c and remove event.c and overhead
	Clean up function names
---
 tools/testing/cxl/test/Kbuild |   2 +-
 tools/testing/cxl/test/mem.c  | 231 ++++++++++++++++++++++++++++++++++
 2 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index 4e59e2c911f6..61d5f7bcddf9 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(srctree)/drivers/cxl/
+ccflags-y := -I$(srctree)/drivers/cxl/ -I$(srctree)/drivers/cxl/core
 
 obj-m += cxl_test.o
 obj-m += cxl_mock.o
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 5e4ecd93f1d2..036f27f9c18e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -9,6 +9,8 @@
 #include <linux/bits.h>
 #include <cxlmem.h>
 
+#include "trace.h"
+
 #define LSA_SIZE SZ_128K
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
@@ -67,6 +69,24 @@ static struct {
 
 #define PASS_TRY_LIMIT 3
 
+#define CXL_TEST_EVENT_CNT_MAX 15
+
+/* Set a number of events to return at a time for simulation.  */
+#define CXL_TEST_EVENT_CNT 3
+
+struct mock_event_log {
+	u16 clear_idx;
+	u16 cur_idx;
+	u16 nr_events;
+	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
+};
+
+struct mock_event_store {
+	struct cxl_dev_state *cxlds;
+	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
+	u32 ev_status;
+};
+
 struct cxl_mockmem_data {
 	void *lsa;
 	u32 security_state;
@@ -74,9 +94,198 @@ struct cxl_mockmem_data {
 	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
 	int user_limit;
 	int master_limit;
+	struct mock_event_store mes;
+	u8 event_buf[SZ_4K];
+};
+
+static struct mock_event_log *event_find_log(struct device *dev, int log_type)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return NULL;
+	return &mdata->mes.mock_logs[log_type];
+}
+
+static struct cxl_event_record_raw *event_get_current(struct mock_event_log *log)
+{
+	return log->events[log->cur_idx];
+}
+
+static void event_reset_log(struct mock_event_log *log)
+{
+	log->cur_idx = 0;
+	log->clear_idx = 0;
+}
+
+/* Handle can never be 0 use 1 based indexing for handle */
+static u16 event_get_clear_handle(struct mock_event_log *log)
+{
+	return log->clear_idx + 1;
+}
+
+/* Handle can never be 0 use 1 based indexing for handle */
+static __le16 event_get_cur_event_handle(struct mock_event_log *log)
+{
+	u16 cur_handle = log->cur_idx + 1;
+
+	return cpu_to_le16(cur_handle);
+}
+
+static bool event_log_empty(struct mock_event_log *log)
+{
+	return log->cur_idx == log->nr_events;
+}
+
+static void mes_add_event(struct mock_event_store *mes,
+			  enum cxl_event_log_type log_type,
+			  struct cxl_event_record_raw *event)
+{
+	struct mock_event_log *log;
+
+	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
+		return;
+
+	log = &mes->mock_logs[log_type];
+	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
+		return;
+
+	log->events[log->nr_events] = event;
+	log->nr_events++;
+}
+
+static int mock_get_event(struct cxl_dev_state *cxlds,
+			  struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_get_event_payload *pl;
+	struct mock_event_log *log;
+	u8 log_type;
+	int i;
+
+	if (cmd->size_in != sizeof(log_type))
+		return -EINVAL;
+
+	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
+		return -EINVAL;
+
+	log_type = *((u8 *)cmd->payload_in);
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+
+	log = event_find_log(cxlds->dev, log_type);
+	if (!log || event_log_empty(log))
+		return 0;
+
+	pl = cmd->payload_out;
+
+	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
+		memcpy(&pl->records[i], event_get_current(log),
+		       sizeof(pl->records[i]));
+		pl->records[i].hdr.handle = event_get_cur_event_handle(log);
+		log->cur_idx++;
+	}
+
+	pl->record_count = cpu_to_le16(i);
+	if (!event_log_empty(log))
+		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+
+	return 0;
+}
+
+static int mock_clear_event(struct cxl_dev_state *cxlds,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
+	struct mock_event_log *log;
+	u8 log_type = pl->event_log;
+	u16 handle;
+	int nr;
+
+	if (log_type >= CXL_EVENT_TYPE_MAX)
+		return -EINVAL;
+
+	log = event_find_log(cxlds->dev, log_type);
+	if (!log)
+		return 0; /* No mock data in this log */
+
+	/*
+	 * This check is technically not invalid per the specification AFAICS.
+	 * (The host could 'guess' handles and clear them in order).
+	 * However, this is not good behavior for the host so test it.
+	 */
+	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
+		dev_err(cxlds->dev,
+			"Attempting to clear more events than returned!\n");
+		return -EINVAL;
+	}
+
+	/* Check handle order prior to clearing events */
+	for (nr = 0, handle = event_get_clear_handle(log);
+	     nr < pl->nr_recs;
+	     nr++, handle++) {
+		if (handle != le16_to_cpu(pl->handle[nr])) {
+			dev_err(cxlds->dev, "Clearing events out of order\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Clear events */
+	log->clear_idx += pl->nr_recs;
+	return 0;
+}
+
+static void cxl_mock_event_trigger(struct device *dev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct mock_event_store *mes = &mdata->mes;
+	int i;
+
+	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
+		struct mock_event_log *log;
+
+		log = event_find_log(dev, i);
+		if (log)
+			event_reset_log(log);
+	}
+
+	cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
+}
+
+struct cxl_event_record_raw maint_needed = {
+	.hdr = {
+		.id = UUID_INIT(0xBA5EBA11, 0xABCD, 0xEFEB,
+				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.length = sizeof(struct cxl_event_record_raw),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xa5b6),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
 
+struct cxl_event_record_raw hardware_replace = {
+	.hdr = {
+		.id = UUID_INIT(0xABCDEFEB, 0xBA11, 0xBA5E,
+				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+		.length = sizeof(struct cxl_event_record_raw),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0xb6a5),
+	},
+	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
+static void cxl_mock_add_event_logs(struct mock_event_store *mes)
+{
+	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
+
+	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
+}
+
 static int mock_gsl(struct cxl_mbox_cmd *cmd)
 {
 	if (cmd->size_out < sizeof(mock_gsl_payload))
@@ -582,6 +791,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_PARTITION_INFO:
 		rc = mock_partition_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_EVENT_RECORD:
+		rc = mock_get_event(cxlds, cmd);
+		break;
+	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
+		rc = mock_clear_event(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlds, cmd);
 		break;
@@ -628,6 +843,15 @@ static bool is_rcd(struct platform_device *pdev)
 	return !!id->driver_data;
 }
 
+static ssize_t event_trigger_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	cxl_mock_event_trigger(dev);
+	return count;
+}
+static DEVICE_ATTR_WO(event_trigger);
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -655,6 +879,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->serial = pdev->id;
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->payload_size = SZ_4K;
+	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
 		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
@@ -672,10 +897,15 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	mdata->mes.cxlds = cxlds;
+	cxl_mock_add_event_logs(&mdata->mes);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
+
 	return 0;
 }
 
@@ -714,6 +944,7 @@ static DEVICE_ATTR_RW(security_lock);
 
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
+	&dev_attr_event_trigger.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);
-- 
2.37.2

