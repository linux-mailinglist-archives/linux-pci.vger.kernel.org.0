Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D7649954
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 08:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLLHHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 02:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiLLHGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 02:06:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6CC62DC;
        Sun, 11 Dec 2022 23:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670828802; x=1702364802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e20KYSDx0gudrTcPlQTPfjNIP2TmZc7a7eiy51TELvE=;
  b=eBIvPH42RSKzHBiSZGEXVX47JgcPKIMF5D1CRjYb1Y9uK5bonzaVR4j2
   Whtp4w3Xw1ZKul83l2ysayU7rdKuXO3CLaleySGaCf5GYvJh96A6g3hqv
   OI5P0nL1QjwcZhXn/CT6+ouv9YSD8yc5x4mX6VdVer6zNBo6BfHTvVSlB
   5JsC1LyRpJQZ6WZFkQJ8+tBTFFJ4EGU9rt2ogFMcQJwHwvtmtqBWHWTxs
   FNa5DJN0OD6n5ziVoA5jRiVbUTXKVFtV+pXVPBs4JKmcRexGfqHq9TVLF
   KQQQGjc29eKJatF1dI1I5qd+dYjxHNHNK5/9TB6N2jfNaxvWGvTAZoWkw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317811880"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317811880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641643120"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641643120"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.168.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:41 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V4 9/9] cxl/test: Simulate event log overflow
Date:   Sun, 11 Dec 2022 23:06:27 -0800
Message-Id: <20221212070627.1372402-10-ira.weiny@intel.com>
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

Log overflow is marked by a separate trace message.

Simulate a log with lots of messages and flag overflow until space is
cleared.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	Dan
		Move code to mem.c
---
 tools/testing/cxl/test/mem.c | 50 +++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 73db722a8879..b2327a8de4a6 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -78,6 +78,8 @@ struct mock_event_log {
 	u16 clear_idx;
 	u16 cur_idx;
 	u16 nr_events;
+	u16 nr_overflow;
+	u16 overflow_reset;
 	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
 };
 
@@ -116,6 +118,7 @@ static void event_reset_log(struct mock_event_log *log)
 {
 	log->cur_idx = 0;
 	log->clear_idx = 0;
+	log->nr_overflow = log->overflow_reset;
 }
 
 /* Handle can never be 0 use 1 based indexing for handle */
@@ -147,8 +150,12 @@ static void mes_add_event(struct mock_event_store *mes,
 		return;
 
 	log = &mes->mock_logs[log_type];
-	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
+
+	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
+		log->nr_overflow++;
+		log->overflow_reset = log->nr_overflow;
 		return;
+	}
 
 	log->events[log->nr_events] = event;
 	log->nr_events++;
@@ -159,6 +166,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
+	u16 nr_overflow;
 	u8 log_type;
 	int i;
 
@@ -191,6 +199,19 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
 	if (!event_log_empty(log))
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
+	if (log->nr_overflow) {
+		u64 ns;
+
+		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
+		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		ns = ktime_get_real_ns();
+		ns -= 5000000000; /* 5s ago */
+		pl->first_overflow_timestamp = cpu_to_le64(ns);
+		ns = ktime_get_real_ns();
+		ns -= 1000000000; /* 1s ago */
+		pl->last_overflow_timestamp = cpu_to_le64(ns);
+	}
+
 	return 0;
 }
 
@@ -231,6 +252,9 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
 		}
 	}
 
+	if (log->nr_overflow)
+		log->nr_overflow = 0;
+
 	/* Clear events */
 	log->clear_idx += pl->nr_recs;
 	return 0;
@@ -353,6 +377,30 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 		      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&dram);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&gen_media);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&mem_module);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
+		      (struct cxl_event_record_raw *)&dram);
+	/* Overflow this log */
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
+
 	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
 		      (struct cxl_event_record_raw *)&dram);
-- 
2.37.2

