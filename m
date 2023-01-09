Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486086630A7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjAITnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjAITmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:42:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA703C3BD;
        Mon,  9 Jan 2023 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673293364; x=1704829364;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QvhtlK4SYmJQvhKAlXbD4WLjYDIsGYSH3KPw5DihPkE=;
  b=f+kM8sY70mJ65HHL5FyB1swNBuudRZ3HWXMBMAH+Hn8Drmgz2IHyRn+T
   9MX6uI31DsLlP5ggA54O/FEIuqNGQXv7NFLU5ntBS+t/lKMl6/YJEzWdW
   eMRRtcI1vSO0s6oQ5/8nJ/H5ZRRVrPnSNxkQz2H4X3er6KydYnH61lMv1
   MdChwmz3asouyq6HD8YLUEkp9M5Rjazhym8a4v4gJDKbMpMd3oRW1JpW8
   hyLZtW3nlQqA9tjv2fpR1CrgOG+lzns5MAKRzGQtQ1LrDd7q8MDNu5m2O
   6i+xAhh9eHWQrVJTPtORi46SzN74mlmxVbKHbWyWu7oNdd4wzRJiFfd4h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385269923"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385269923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656783522"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656783522"
Received: from cwchen-mobl.amr.corp.intel.com (HELO localhost) ([10.212.45.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 09 Jan 2023 11:42:27 -0800
Subject: [PATCH v6 8/8] cxl/test: Simulate event log overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v6-8-346583105b30@intel.com>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673293350; l=4119;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=QvhtlK4SYmJQvhKAlXbD4WLjYDIsGYSH3KPw5DihPkE=;
 b=tSsasDMPRKg+cKKuCNbUwOZUnO0oSWvD7bR6bMtF8KG4Knt0G8aQ4PU+s65rJQshScWIlFU3p6L+
 r3sR4fg0DKv3Xn0osU7LuXzQd8D/Thb9MZItcZbWjBOl/L5BVW8D
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Log overflow is marked by a separate trace message.

Simulate a log with lots of messages and flag overflow until space is
cleared.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	Pick up tag
---
 tools/testing/cxl/test/mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
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
2.39.0
