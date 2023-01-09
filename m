Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261596630AE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjAITnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbjAITmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:42:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245C78E84;
        Mon,  9 Jan 2023 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673293363; x=1704829363;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tHTjIAWtPe+3WtNy4KbQ4Od4tOeLhSHI1LcaGgi50ak=;
  b=UEJRaV6HP27Di75OzRBlxruSBfe7R3X2d24tZiQ2lr74lAIgsd1urWcR
   KKBGl3bNkPGeNdO6p/vRUE5+hJo/Nf80NWdG4LR4BqgcDEAQiM/DG69We
   QGDDqwpzXdom156Dbe3G2r7uhJoe2JN9oV03fiZ2E52cUbLtMAPtKf8fJ
   kc+uoMPGPk+cE+Knc5K25rgDk8NVC9m4xdiKKqroLUkaUsPK8b5IFtSPf
   MODXRcrle0Tw4bwNF0YSPw7EoQg+7UQQ+8zpW6Mw8a7ooL2vZ3SW+8yOv
   MwMmqTjTZXJt5XaNvcItCtPWT9cbzqOXK/G88fi2wma6NR9bdwQyHFBox
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385269913"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385269913"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656783517"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656783517"
Received: from cwchen-mobl.amr.corp.intel.com (HELO localhost) ([10.212.45.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:40 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 09 Jan 2023 11:42:26 -0800
Subject: [PATCH v6 7/8] cxl/test: Add specific events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v6-7-346583105b30@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673293350; l=3691;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=tHTjIAWtPe+3WtNy4KbQ4Od4tOeLhSHI1LcaGgi50ak=;
 b=JOj+wki1eckvvzD2k48jcZa7DDfwXPOUwqAezsbMVJIDd+PvlIuFN8FM1V4NVHspQCbFZMcV7uT9
 SHB4l8FbAu4/WpC4Qfd7tl4L8Wue2edqsedLUUXj1Scn0drq3yhO
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

Each type of event has different trace point outputs.

Add mock General Media Event, DRAM event, and Memory Module Event
records to the mock list of events returned.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	Pick up tag
---
 tools/testing/cxl/test/mem.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 036f27f9c18e..73db722a8879 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -277,12 +277,85 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
+struct cxl_event_gen_media gen_media = {
+	.hdr = {
+		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+		.length = sizeof(struct cxl_event_gen_media),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x2000),
+	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+	/* .validity_flags = <set below> */
+	.channel = 1,
+	.rank = 30
+};
+
+struct cxl_event_dram dram = {
+	.hdr = {
+		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+		.length = sizeof(struct cxl_event_dram),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x8000),
+	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+	/* .validity_flags = <set below> */
+	.channel = 1,
+	.bank_group = 5,
+	.bank = 2,
+	.column = {0xDE, 0xAD},
+};
+
+struct cxl_event_mem_module mem_module = {
+	.hdr = {
+		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+		.length = sizeof(struct cxl_event_mem_module),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.event_type = CXL_MMER_TEMP_CHANGE,
+	.info = {
+		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
+		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
+			      (CXL_DHI_AS_WARNING << 4) |
+			      (CXL_DHI_AS_WARNING << 5),
+		.device_temp = { 0xDE, 0xAD},
+		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+	}
+};
+
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
+	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
+			   &gen_media.validity_flags);
+
+	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
+			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
+			   &dram.validity_flags);
+
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+		      (struct cxl_event_record_raw *)&gen_media);
+	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
+		      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
 	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
+		      (struct cxl_event_record_raw *)&dram);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
 }
 

-- 
2.39.0
