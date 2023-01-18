Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36917671370
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 06:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjARF5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 00:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjARFy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 00:54:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99D582B7;
        Tue, 17 Jan 2023 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674021243; x=1705557243;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Mk0oIVnzMhEKY95fMhecSAt7DLXaIz6CJ6fM/4b0G7E=;
  b=Ok6Ya8fEOreXlv9Gs+TyZQ6+7Lzs7/oMlEIuq46pqt6Y24Uk7TUGtVGE
   ekQ593+OlarAiqRR+vN4sEm1VqMpuDeol/ix2txwqg4gKkvYsn/D7tEpS
   ktigr32Hhbh2oe0B14PWMDYK6XG4DZvxi2If9R2eQGH/zC8n/BEDJGWSJ
   yowxLLXW4YpsNKTYojQSxLHv36m1lQ8kXkZtzGCcBnbcUrtRo+VvKAPpN
   ICjJ3RtRSuYSLVz+D2lfiBYMl9ud+OljiT7OxIqjiJ2X8X14wCIPb4Szp
   Q5v94BRosLx2KD1Hfd+TgZLQRCJkvdP/dXTwhMOXFzdNgavv7N4S0R9I5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304586836"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304586836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:54:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="802043330"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="802043330"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.10.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:54:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 17 Jan 2023 21:53:43 -0800
Subject: [PATCH v7 8/8] cxl/test: Simulate event log overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v7-8-2316a5c8f7d8@intel.com>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674021228; l=4124;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Mk0oIVnzMhEKY95fMhecSAt7DLXaIz6CJ6fM/4b0G7E=;
 b=pJZGC0Qn3+f+KJ22HojFTaXyw6arPsHECysq/YYmmBsfuOR2xI4af/7185+TSWJsk9UBgkE75e43
 MJEtcP3oBtKtV85dBb7PVZ7BvK3mlrnC+OKTZ/jOFbGEkMC8g9tJ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v7:
        <no change>
---
 tools/testing/cxl/test/mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 00bf19a68604..9263b04d35f7 100644
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
