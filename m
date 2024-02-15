Return-Path: <linux-pci+bounces-3490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33D856209
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DCD288286
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550312BEB9;
	Thu, 15 Feb 2024 11:47:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0312AAF0;
	Thu, 15 Feb 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997636; cv=none; b=noxaQzdVJmGify0zbUVzI6bh5YrouvR7wq34DbGHGhK+d9l8cOMaU4nlcr6vcTpOLaBvQjl05cdIblHSA2cmV4PgvAmdUh5xaHvE1w8L3ndtSMw5y+b3G/S9J50/KJgNSFRXfzcGfX/gkM6uub9SbES8IhVdnAc9l2dUdeIeiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997636; c=relaxed/simple;
	bh=lP9mG+q31w+0eBk1IgbWBdBggPCn8pZT5QzEIkttmUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8kagY51HZyzMk5ecxoLM8DV0aXdxI6zxgCc8Bg33ZfZxyVy4xpgMPJcshpO8MA1sT7uqb2uo1FlaPG/Cbf42SrpEimCELyZL1G9vlNOl6IknD7UtrTN7oDcblHNqjnux/H3sC9p3e89RgMkpI42UeAB5nrad/R11kFpurdAYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCrF2pKJz67Lqc;
	Thu, 15 Feb 2024 19:43:41 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id F22231400D3;
	Thu, 15 Feb 2024 19:47:08 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:47:08 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <mchehab@kernel.org>
CC: <qingshun.wang@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 1/2] rasdaemon: Add handling of new fields in aer_event for advisory non-fatal and other errors
Date: Thu, 15 Feb 2024 19:46:58 +0800
Message-ID: <20240215114659.1513-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215114659.1513-1-shiju.jose@huawei.com>
References: <20240215114659.1513-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add handling of following new fields in trace aer_event
for advisory non-fatal and other errors.

  - cor_status		(Correctable Error Status)
  - cor_mask		(Correctable Error Mask)
  - uncor_status	(Uncorrectable Error Status)
  - uncor_severity	(Uncorrectable Error Severity)
  - uncor_mask		(Uncorrectable Error Mask)
  - aer_cap_ctrl	(AER Capabilities and Control)
  - link_status		(Link Status)
  - device_status	(Device Status)
  - device_control_2	(Device Control 2)

https://lore.kernel.org/lkml/20240125062802.50819-5-qingshun.wang@linux.intel.com/

Question: Does "aer_event" table in SQLite DB  to be rename,
for example "aer_event_v2" because new fields are added?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-aer-handler.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 ras-record.c      | 20 ++++++++++++++++
 ras-record.h      | 10 ++++++++
 ras-report.c      | 24 +++++++++++++++++--
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/ras-aer-handler.c b/ras-aer-handler.c
index bb1a6f6..9a732e7 100644
--- a/ras-aer-handler.c
+++ b/ras-aer-handler.c
@@ -54,6 +54,30 @@ static const char *aer_uncor_errors[32] = {
 
 #define BUF_LEN	1024
 
+struct aer_header_log_regs {
+	uint32_t dw0;
+	uint32_t dw1;
+	uint32_t dw2;
+	uint32_t dw3;
+};
+
+struct aer_capability_regs {
+	uint32_t header;
+	uint32_t uncor_status;
+	uint32_t uncor_mask;
+	uint32_t uncor_severity;
+	uint32_t cor_status;
+	uint32_t cor_mask;
+	uint32_t cap_control;
+	struct aer_header_log_regs header_log;
+	uint32_t root_command;
+	uint32_t root_status;
+	uint16_t cor_err_source;
+	uint16_t uncor_err_source;
+};
+
+#define  PCI_ERR_CAP_FEP(x)     ((x) & 0x1f)    /* First Error Pointer */
+
 int ras_aer_event_handler(struct trace_seq *s,
 			  struct tep_record *record,
 			  struct tep_event *event, void *context)
@@ -70,6 +94,7 @@ int ras_aer_event_handler(struct trace_seq *s,
 	char ipmi_add_sel[105];
 	uint8_t sel_data[5];
 	int seg, bus, dev, fn;
+	struct aer_capability_regs *aer_caps = NULL;
 
 	/*
 	 * Newer kernels (3.10-rc1 or upper) provide an uptime clock.
@@ -148,6 +173,41 @@ int ras_aer_event_handler(struct trace_seq *s,
 	}
 	trace_seq_puts(s, ev.error_type);
 
+	aer_caps = tep_get_field_raw(s, event, "aer_caps",
+				     record, &len, 1);
+	if (aer_caps) {
+		ev.cor_status = aer_caps->cor_status;
+		ev.cor_mask = aer_caps->cor_mask;
+		ev.uncor_status = aer_caps->uncor_status;
+		ev.uncor_mask = aer_caps->uncor_mask;
+		ev.uncor_severity = aer_caps->uncor_severity;
+		ev.cap_control = aer_caps->cap_control;
+		ev.first_err_ptr = PCI_ERR_CAP_FEP(aer_caps->cap_control);
+
+		trace_seq_printf(s, " cor_status: 0x%08x", ev.cor_status);
+		trace_seq_printf(s, " cor_mask: 0x%08x", ev.cor_mask);
+		trace_seq_printf(s, " uncor_status: 0x%08x", ev.uncor_status);
+		trace_seq_printf(s, " uncor_mask: 0x%08x", ev.uncor_mask);
+		trace_seq_printf(s, " uncor_severity: 0x%08x", ev.uncor_severity);
+		trace_seq_printf(s, " cap_control: 0x%08x", ev.cap_control);
+		trace_seq_printf(s, " first_error_pointer: 0x%x",
+				 ev.first_err_ptr);
+	}
+	if (tep_get_field_val(s,  event, "link_status", record, &val, 1) >= 0) {
+		ev.link_status = val;
+		trace_seq_printf(s, " link_status: 0x%04x ", ev.link_status);
+	}
+
+	if (tep_get_field_val(s,  event, "device_status", record, &val, 1) >= 0) {
+		ev.device_status = val;
+		trace_seq_printf(s, " device_status: 0x%04x ", ev.device_status);
+	}
+
+	if (tep_get_field_val(s,  event, "device_control_2", record, &val, 1) >= 0) {
+		ev.device_control_2 = val;
+		trace_seq_printf(s, " device_control_2: 0x%04x ", ev.device_control_2);
+	}
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_aer_event(ras, &ev);
diff --git a/ras-record.c b/ras-record.c
index f3ffafb..889e96f 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -111,6 +111,16 @@ static const struct db_fields aer_event_fields[] = {
 		{ .name = "dev_name",		.type = "TEXT" },
 		{ .name = "err_type",		.type = "TEXT" },
 		{ .name = "err_msg",		.type = "TEXT" },
+		{ .name = "cor_status",		.type = "INTEGER" },
+		{ .name = "cor_mask",		.type = "INTEGER" },
+		{ .name = "uncor_status",	.type = "INTEGER" },
+		{ .name = "uncor_mask",		.type = "INTEGER" },
+		{ .name = "uncor_severity",	.type = "INTEGER" },
+		{ .name = "cap_control",	.type = "INTEGER" },
+		{ .name = "first_err_pointer",  .type = "INTEGER" },
+		{ .name = "link_status",	.type = "INTEGER" },
+		{ .name = "device_status",	.type = "INTEGER" },
+		{ .name = "device_control_2",	.type = "INTEGER" },
 };
 
 static const struct db_table_descriptor aer_event_tab = {
@@ -132,6 +142,16 @@ int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev)
 	sqlite3_bind_text(priv->stmt_aer_event,  2, ev->dev_name, -1, NULL);
 	sqlite3_bind_text(priv->stmt_aer_event,  3, ev->error_type, -1, NULL);
 	sqlite3_bind_text(priv->stmt_aer_event,  4, ev->msg, -1, NULL);
+	sqlite3_bind_int(priv->stmt_aer_event,  5, ev->cor_status);
+	sqlite3_bind_int(priv->stmt_aer_event,  6, ev->cor_mask);
+	sqlite3_bind_int(priv->stmt_aer_event,  7, ev->uncor_status);
+	sqlite3_bind_int(priv->stmt_aer_event,  8, ev->uncor_mask);
+	sqlite3_bind_int(priv->stmt_aer_event,  9, ev->uncor_severity);
+	sqlite3_bind_int(priv->stmt_aer_event,  10, ev->cap_control);
+	sqlite3_bind_int(priv->stmt_aer_event,  11, ev->first_err_ptr);
+	sqlite3_bind_int(priv->stmt_aer_event,  12, ev->link_status);
+	sqlite3_bind_int(priv->stmt_aer_event,  13, ev->device_status);
+	sqlite3_bind_int(priv->stmt_aer_event,  14, ev->device_control_2);
 
 	rc = sqlite3_step(priv->stmt_aer_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index 2b2231c..ecab219 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -59,6 +59,16 @@ struct ras_aer_event {
 	uint8_t tlp_header_valid;
 	uint32_t *tlp_header;
 	const char *msg;
+	uint32_t cor_status;
+	uint32_t cor_mask;
+	uint32_t uncor_status;
+	uint32_t uncor_mask;
+	uint32_t uncor_severity;
+	uint32_t cap_control;
+	uint32_t first_err_ptr;
+	uint16_t link_status;
+	uint16_t device_status;
+	uint16_t device_control_2;
 };
 
 struct ras_extlog_event {
diff --git a/ras-report.c b/ras-report.c
index 5cc55b6..5e659ce 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -205,11 +205,31 @@ static int set_aer_event_backtrace(char *buf, struct ras_aer_event *ev)
 						"timestamp=%s\n"	\
 						"error_type=%s\n"	\
 						"dev_name=%s\n"	\
-						"msg=%s\n",	\
+						"msg=%s\n"	\
+						"cor_status=0x%08x\n"	\
+						"cor_mask=0x%08x\n"	\
+						"uncor_status=0x%08x\n"	\
+						"uncor_mask=0x%08x\n"	\
+						"uncor_severity=0x%08x\n"	\
+						"cap_control=0x%08x\n"	\
+						"first_error_pointer=0x%x\n"	\
+						"link_status=0x%04x\n"	\
+						"device_status=0x%04x\n"	\
+						"device_control_2=0x%04x\n",	\
 						ev->timestamp,	\
 						ev->error_type,	\
 						ev->dev_name,	\
-						ev->msg);
+						ev->msg,	\
+						ev->cor_status,	\
+						ev->cor_mask,	\
+						ev->uncor_status,	\
+						ev->uncor_mask,	\
+						ev->uncor_severity,	\
+						ev->cap_control,	\
+						ev->first_err_ptr,	\
+						ev->link_status,	\
+						ev->device_status,	\
+						ev->device_control_2);
 
 	strcat(buf, bt_buf);
 
-- 
2.34.1


