Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04BE53E92E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiFFL52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiFFL5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 07:57:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446DDE;
        Mon,  6 Jun 2022 04:57:09 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGsQH0lTMzjXN0;
        Mon,  6 Jun 2022 19:56:07 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 19:57:02 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v9 6/8] perf tool: Add support for parsing HiSilicon PCIe Trace packet
Date:   Mon, 6 Jun 2022 19:55:53 +0800
Message-ID: <20220606115555.41103-7-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220606115555.41103-1-yangyicong@hisilicon.com>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

Add support for using 'perf report --dump-raw-trace' to parse PTT packet.

Example usage:

Output will contain raw PTT data and its textual representation, such
as:

0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
.
. ... HISI PTT data: size 4194304 bytes
.  00000000: 00 00 00 00                                 Prefix
.  00000004: 08 20 00 60                                 Header DW0
.  00000008: ff 02 00 01                                 Header DW1
.  0000000c: 20 08 00 00                                 Header DW2
.  00000010: 10 e7 44 ab                                 Header DW3
.  00000014: 2a a8 1e 01                                 Time
.  00000020: 00 00 00 00                                 Prefix
.  00000024: 01 00 00 60                                 Header DW0
.  00000028: 0f 1e 00 01                                 Header DW1
.  0000002c: 04 00 00 00                                 Header DW2
.  00000030: 40 00 81 02                                 Header DW3
.  00000034: ee 02 00 00                                 Time
....

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/Build                         |   2 +
 tools/perf/util/auxtrace.c                    |   3 +
 tools/perf/util/hisi-ptt-decoder/Build        |   1 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 164 +++++++++++++++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  31 +++
 tools/perf/util/hisi-ptt.c                    | 192 ++++++++++++++++++
 6 files changed, 393 insertions(+)
 create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
 create mode 100644 tools/perf/util/hisi-ptt.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index a51267d88ca9..e22df9e7fd10 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -116,6 +116,8 @@ perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-$(CONFIG_AUXTRACE) += arm-spe.o
 perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
+perf-$(CONFIG_AUXTRACE) += hisi-ptt.o
+perf-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c5ef322a30b8..3371a0feec68 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -51,6 +51,7 @@
 #include "intel-pt.h"
 #include "intel-bts.h"
 #include "arm-spe.h"
+#include "hisi-ptt.h"
 #include "s390-cpumsf.h"
 #include "util/mmap.h"
 
@@ -1305,6 +1306,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 		err = s390_cpumsf_process_auxtrace_info(event, session);
 		break;
 	case PERF_AUXTRACE_HISI_PTT:
+		err = hisi_ptt_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/hisi-ptt-decoder/Build b/tools/perf/util/hisi-ptt-decoder/Build
new file mode 100644
index 000000000000..db3db8b75033
--- /dev/null
+++ b/tools/perf/util/hisi-ptt-decoder/Build
@@ -0,0 +1 @@
+perf-$(CONFIG_AUXTRACE) += hisi-ptt-pkt-decoder.o
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
new file mode 100644
index 000000000000..dc8f19914628
--- /dev/null
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+#include <linux/bitops.h>
+#include <stdarg.h>
+
+#include "../color.h"
+#include "hisi-ptt-pkt-decoder.h"
+
+/*
+ * For 8DW format, the bit[31:11] of DW0 is always 0x1fffff, which can be
+ * used to distinguish the data format.
+ * 8DW format is like:
+ *   bits [                 31:11                 ][       10:0       ]
+ *        |---------------------------------------|-------------------|
+ *    DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
+ *    DW1 [                       Prefix                              ]
+ *    DW2 [                     Header DW0                            ]
+ *    DW3 [                     Header DW1                            ]
+ *    DW4 [                     Header DW2                            ]
+ *    DW5 [                     Header DW3                            ]
+ *    DW6 [                   Reserved (0x0)                          ]
+ *    DW7 [                        Time                               ]
+ *
+ * 4DW format is like:
+ *   bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
+ *        |-----|---------|---|---|---|---|-------------|-------------|
+ *    DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
+ *    DW1 [                     Header DW1                            ]
+ *    DW2 [                     Header DW2                            ]
+ *    DW3 [                     Header DW3                            ]
+ */
+
+enum hisi_ptt_8dw_pkt_field_type {
+	HISI_PTT_8DW_RSV0,
+	HISI_PTT_8DW_PREFIX,
+	HISI_PTT_8DW_HEAD0,
+	HISI_PTT_8DW_HEAD1,
+	HISI_PTT_8DW_HEAD2,
+	HISI_PTT_8DW_HEAD3,
+	HISI_PTT_8DW_RSV1,
+	HISI_PTT_8DW_TIME,
+	HISI_PTT_8DW_TYPE_MAX
+};
+
+enum hisi_ptt_4dw_pkt_field_type {
+	HISI_PTT_4DW_HEAD1,
+	HISI_PTT_4DW_HEAD2,
+	HISI_PTT_4DW_HEAD3,
+	HISI_PTT_4DW_TYPE_MAX
+};
+
+static const char * const hisi_ptt_8dw_pkt_field_name[] = {
+	[HISI_PTT_8DW_PREFIX]	= "Prefix",
+	[HISI_PTT_8DW_HEAD0]	= "Header DW0",
+	[HISI_PTT_8DW_HEAD1]	= "Header DW1",
+	[HISI_PTT_8DW_HEAD2]	= "Header DW2",
+	[HISI_PTT_8DW_HEAD3]	= "Header DW3",
+	[HISI_PTT_8DW_TIME]	= "Time"
+};
+
+static const char * const hisi_ptt_4dw_pkt_field_name[] = {
+	[HISI_PTT_4DW_HEAD1]	= "Header DW1",
+	[HISI_PTT_4DW_HEAD2]	= "Header DW2",
+	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
+};
+
+union hisi_ptt_4dw {
+	struct {
+		uint32_t format : 2;
+		uint32_t type : 5;
+		uint32_t t9 : 1;
+		uint32_t t8 : 1;
+		uint32_t th : 1;
+		uint32_t so : 1;
+		uint32_t len : 10;
+		uint32_t time : 11;
+	};
+	uint32_t value;
+};
+
+static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *desc)
+{
+	const char *color = PERF_COLOR_BLUE;
+	int i;
+
+	printf(".");
+	color_fprintf(stdout, color, "  %08x: ", pos);
+	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++)
+		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
+	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
+		color_fprintf(stdout, color, "   ");
+	color_fprintf(stdout, color, "  %s\n", desc);
+}
+
+static int hisi_ptt_8dw_kpt_desc(const unsigned char *buf, int pos)
+{
+	int i;
+
+	for (i = 0; i < HISI_PTT_8DW_TYPE_MAX; i++) {
+		/* Do not show reserved filed */
+		if (i == HISI_PTT_8DW_RSV0 || i == HISI_PTT_8DW_RSV1) {
+			pos += HISI_PTT_FIELD_LENTH;
+			continue;
+		}
+
+		hisi_ptt_print_pkt(buf, pos, hisi_ptt_8dw_pkt_field_name[i]);
+		pos += HISI_PTT_FIELD_LENTH;
+	}
+
+	return hisi_ptt_pkt_size[HISI_PTT_8DW_PKT];
+}
+
+static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
+{
+	const char *color = PERF_COLOR_BLUE;
+	union hisi_ptt_4dw dw0;
+	int i;
+
+	dw0.value = *(uint32_t *)(buf + pos);
+	printf(".");
+	color_fprintf(stdout, color, "  %08x: ", pos);
+	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++)
+		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
+	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
+		color_fprintf(stdout, color, "   ");
+
+	color_fprintf(stdout, color,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Format", dw0.format, "Type", dw0.type, "T9", dw0.t9,
+		      "T8", dw0.t8, "TH", dw0.th, "SO", dw0.so, "Length",
+		      dw0.len, "Time", dw0.time);
+}
+
+static int hisi_ptt_4dw_kpt_desc(const unsigned char *buf, int pos)
+{
+	int i;
+
+	hisi_ptt_4dw_print_dw0(buf, pos);
+	pos += HISI_PTT_FIELD_LENTH;
+
+	for (i = 0; i < HISI_PTT_4DW_TYPE_MAX; i++) {
+		hisi_ptt_print_pkt(buf, pos, hisi_ptt_4dw_pkt_field_name[i]);
+		pos += HISI_PTT_FIELD_LENTH;
+	}
+
+	return hisi_ptt_pkt_size[HISI_PTT_4DW_PKT];
+}
+
+int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type)
+{
+	if (type == HISI_PTT_8DW_PKT)
+		return hisi_ptt_8dw_kpt_desc(buf, pos);
+
+	return hisi_ptt_4dw_kpt_desc(buf, pos);
+}
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
new file mode 100644
index 000000000000..e78f1b5bc836
--- /dev/null
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#ifndef INCLUDE__HISI_PTT_PKT_DECODER_H__
+#define INCLUDE__HISI_PTT_PKT_DECODER_H__
+
+#include <stddef.h>
+#include <stdint.h>
+
+#define HISI_PTT_8DW_CHECK_MASK		GENMASK(31, 11)
+#define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
+#define HISI_PTT_MAX_SPACE_LEN		10
+#define HISI_PTT_FIELD_LENTH		4
+
+enum hisi_ptt_pkt_type {
+	HISI_PTT_4DW_PKT,
+	HISI_PTT_8DW_PKT,
+	HISI_PTT_PKT_MAX
+};
+
+static int hisi_ptt_pkt_size[] = {
+	[HISI_PTT_4DW_PKT]	= 16,
+	[HISI_PTT_8DW_PKT]	= 32,
+};
+
+int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type);
+
+#endif
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
new file mode 100644
index 000000000000..9798e297e7ab
--- /dev/null
+++ b/tools/perf/util/hisi-ptt.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <byteswap.h>
+#include <endian.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "auxtrace.h"
+#include "color.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "hisi-ptt.h"
+#include "hisi-ptt-decoder/hisi-ptt-pkt-decoder.h"
+#include "machine.h"
+#include "session.h"
+#include "symbol.h"
+#include "tool.h"
+#include "util/synthetic-events.h"
+#include <internal/lib.h>
+
+struct hisi_ptt {
+	struct auxtrace auxtrace;
+	u32 auxtrace_type;
+	struct perf_session *session;
+	struct machine *machine;
+	u32 pmu_type;
+};
+
+struct hisi_ptt_queue {
+	struct hisi_ptt *ptt;
+	struct auxtrace_buffer *buffer;
+};
+
+static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
+{
+	uint32_t head = *(uint32_t *)buf;
+
+	if ((HISI_PTT_8DW_CHECK_MASK & head) == HISI_PTT_IS_8DW_PKT)
+		return HISI_PTT_8DW_PKT;
+
+	return HISI_PTT_4DW_PKT;
+}
+
+static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
+			  unsigned char *buf, size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+	enum hisi_ptt_pkt_type type;
+	size_t pos = 0;
+	int pkt_len;
+
+	type = hisi_ptt_check_packet_type(buf);
+	len = round_down(len, hisi_ptt_pkt_size[type]);
+	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
+		      len);
+
+	while (len > 0) {
+		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
+		if (!pkt_len)
+			color_fprintf(stdout, color, " Bad packet!\n");
+
+		pos += pkt_len;
+		len -= pkt_len;
+	}
+}
+
+static void hisi_ptt_dump_event(struct hisi_ptt *ptt, unsigned char *buf,
+				size_t len)
+{
+	printf(".\n");
+
+	hisi_ptt_dump(ptt, buf, len);
+}
+
+static int hisi_ptt_process_event(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused,
+				  struct perf_sample *sample __maybe_unused,
+				  struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
+					   union perf_event *event,
+					   struct perf_tool *tool __maybe_unused)
+{
+	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
+					    auxtrace);
+	int fd = perf_data__fd(session->data);
+	int size = event->auxtrace.size;
+	void *data = malloc(size);
+	off_t data_offset;
+	int err;
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	err = readn(fd, data, size);
+	if (err != (ssize_t)size) {
+		free(data);
+		return -errno;
+	}
+
+	if (dump_trace)
+		hisi_ptt_dump_event(ptt, data, size);
+
+	return 0;
+}
+
+static int hisi_ptt_flush(struct perf_session *session __maybe_unused,
+			  struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void hisi_ptt_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static void hisi_ptt_free(struct perf_session *session)
+{
+	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
+					    auxtrace);
+
+	session->auxtrace = NULL;
+	free(ptt);
+}
+
+static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
+				       struct evsel *evsel)
+{
+	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);
+
+	return evsel->core.attr.type == ptt->pmu_type;
+}
+
+static void hisi_ptt_print_info(__u64 type)
+{
+	if (!dump_trace)
+		return;
+
+	fprintf(stdout, "  PMU Type           %" PRId64 "\n", (s64) type);
+}
+
+int hisi_ptt_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct hisi_ptt *ptt;
+
+	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE +
+				sizeof(struct perf_record_auxtrace_info))
+		return -EINVAL;
+
+	ptt = zalloc(sizeof(*ptt));
+	if (!ptt)
+		return -ENOMEM;
+
+	ptt->session = session;
+	ptt->machine = &session->machines.host; /* No kvm support */
+	ptt->auxtrace_type = auxtrace_info->type;
+	ptt->pmu_type = auxtrace_info->priv[0];
+
+	ptt->auxtrace.process_event = hisi_ptt_process_event;
+	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
+	ptt->auxtrace.flush_events = hisi_ptt_flush;
+	ptt->auxtrace.free_events = hisi_ptt_free_events;
+	ptt->auxtrace.free = hisi_ptt_free;
+	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
+	session->auxtrace = &ptt->auxtrace;
+
+	hisi_ptt_print_info(auxtrace_info->priv[0]);
+
+	return 0;
+}
-- 
2.24.0

