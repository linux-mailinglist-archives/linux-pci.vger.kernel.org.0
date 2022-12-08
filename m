Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E64646887
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 06:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLHFWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 00:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLHFVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 00:21:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5ED9AE3A;
        Wed,  7 Dec 2022 21:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670476894; x=1702012894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVG9I9NhI+ceFL1LJHw2sRb+ant6x1xdoQ/mv+tQZBY=;
  b=FJNquIrBfWNQPnlQGcBuyGETfAJWa/0MUk9zUM2MaQEdQG9KCTUvkI1Y
   iw0eJH6Ot47bkMgP/nXWvwbefJr4X3ypLIWFZx8lNUH0OC8VlrGLJMZlh
   yU28rQf2KrtTupdhp2IrzpNubZetZFQ05dQANLjMr0O9+g/ML8a6eTBT5
   Lb3LY1KDQPMFnI9C783xrCutlEZJLTklGtIGoEg4rWG49TJp+u6CGPsEz
   KhdBYTb+HAfVWj1OspMZag1IbFjMp4R+5XnP5npfo7JnOp8tmZSM3gJ+r
   zPPZaLwy0ZnkF0/wuBxaXyrQYN2LB4NRLmcK5qQ+gALmGdfoB0ZNdx4rY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381367283"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381367283"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710324499"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="710324499"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.25.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:31 -0800
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
Subject: [PATCH V3 8/8] cxl/test: Simulate event log overflow
Date:   Wed,  7 Dec 2022 21:21:14 -0800
Message-Id: <20221208052115.800170-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208052115.800170-1-ira.weiny@intel.com>
References: <20221208052115.800170-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Rebased on pending cxl-security

Changes from RFC
	Adjust for new struct changes
---
 tools/testing/cxl/test/events.c | 48 ++++++++++++++++++++++++++++++++-
 tools/testing/cxl/test/events.h |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index 5214826d264f..f389e1ba2ab7 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -23,6 +23,7 @@ void reset_event_log(struct mock_event_log *log)
 {
 	log->cur_idx = 0;
 	log->clear_idx = 0;
+	log->nr_overflow = log->overflow_reset;
 }
 
 /* Handle can never be 0 use 1 based indexing for handle */
@@ -54,8 +55,12 @@ static void event_store_add_event(struct mock_event_store *mes,
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
@@ -65,6 +70,7 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
+	u16 nr_overflow;
 	u8 log_type;
 	int i;
 
@@ -96,6 +102,19 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	if (!log_empty(log))
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
 EXPORT_SYMBOL_GPL(mock_get_event);
@@ -136,6 +155,9 @@ int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 		}
 	}
 
+	if (log->nr_overflow)
+		log->nr_overflow = 0;
+
 	/* Clear events */
 	log->clear_idx += pl->nr_recs;
 	return 0;
@@ -260,6 +282,30 @@ void cxl_mock_add_event_logs(struct mock_event_store *mes)
 			      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&gen_media);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&mem_module);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram);
+	/* Overflow this log */
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
+
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
 			      (struct cxl_event_record_raw *)&dram);
diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
index 626cd79f1871..80a74568f455 100644
--- a/tools/testing/cxl/test/events.h
+++ b/tools/testing/cxl/test/events.h
@@ -14,6 +14,8 @@ struct mock_event_log {
 	u16 clear_idx;
 	u16 cur_idx;
 	u16 nr_events;
+	u16 nr_overflow;
+	u16 overflow_reset;
 	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
 };
 
-- 
2.37.2

