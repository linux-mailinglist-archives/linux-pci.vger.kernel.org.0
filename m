Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63C65F7BD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 00:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjAEXiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 18:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbjAEXiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 18:38:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E04F108;
        Thu,  5 Jan 2023 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672961888; x=1704497888;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QvhtlK4SYmJQvhKAlXbD4WLjYDIsGYSH3KPw5DihPkE=;
  b=nVLw8tMz2wmSm2dqCjRJR/1Og0yeZncMGMdnBxtZcEM+Pv1s20knjrPn
   UORhq6BS5YEN+kvtOApT7teFFuJLi7qr9eg9Ao9AfNpLozwnzLpr32l+J
   R0+XkZ7Fh2as/4V6fmVX+OkyaMdv7qPYdViF/bXELG2hdHVNOwb30lG3V
   J7ABgVGbxBzLqQTwlAB6Httstm7yy/MfbysBK4a/I13lc3LDfyVQF3i9L
   uICmxpV7Vj4/Dvet73xjhB+F8PMzZ7c2zau2/lPbn6PrrhgIpm5u1FW34
   J9Nvsfy+hGl0XCyghrd1+P+Wyqeu5CZ9D9mZc+V70QSaWMQ32XNV2dAHb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305872027"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305872027"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:38:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="798093088"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="798093088"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.87.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:38:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 05 Jan 2023 15:37:58 -0800
Subject: [PATCH v5 8/8] cxl/test: Simulate event log overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v5-8-180c618ed5d1@intel.com>
References: <20221216-cxl-ev-log-v5-0-180c618ed5d1@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v5-0-180c618ed5d1@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672961882; l=4119;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=QvhtlK4SYmJQvhKAlXbD4WLjYDIsGYSH3KPw5DihPkE=;
 b=KuAJ5anv2nw8kxqSaDoiuiqUXVBaVm6no2luHReVvIml1W9p9VjwjYybW2WdZJEsxaOvR8LWqT7r
 2TAZ0PQGBKAAMZCKjadCBfJy5qGqe/Aap/tLhgdXeL5WkkUUGDao
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
