Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A2649950
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiLLHHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 02:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiLLHGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 02:06:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AE60C7;
        Sun, 11 Dec 2022 23:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670828801; x=1702364801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78l/lqtv3kBiBYEHgS8oobA+GpF3myru5t4uuLelBFw=;
  b=P1ExZbCr0sBRQlz8AqFlOKVg6c/90J6R1a0NnHjxpKjHx9LVzrGcfQq+
   yY6hKVm7zbyHsHLTfHoD5R066d7IOztO5Ba85vWppwYI/vhbX8Dz7r1wW
   iTv9dxrX8Wq/Wg8wfiDkciarmjn16xCPm9GmXh5U5IJIJnTByh7pas/MN
   6ag59/3PeEUhls9H+7ZsG6x56B2FV37f7c7ywL62VsWIH7OmPbOTxSPx1
   jDO5GUiqbZ/AAIHJrCT+Egys3nIcacdkGvI1VRLWqNtDFzt2faTwEWMIl
   JuVgaTqaKWpbNsS7N3g9fhVDLH5HHOyMiFtrhvNLjBUPYaCQBHDVmDT1L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317811874"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317811874"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641643116"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641643116"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.168.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:40 -0800
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
Subject: [PATCH V4 8/9] cxl/test: Add specific events
Date:   Sun, 11 Dec 2022 23:06:26 -0800
Message-Id: <20221212070627.1372402-9-ira.weiny@intel.com>
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

Each type of event has different trace point outputs.

Add mock General Media Event, DRAM event, and Memory Module Event
records to the mock list of events returned.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	Dan
		Move code to mem.c
---
 tools/testing/cxl/test/mem.c | 73 ++++++++++++++++++++++++++++++++++++
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
2.37.2

