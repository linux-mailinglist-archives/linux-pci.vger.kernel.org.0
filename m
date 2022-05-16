Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79745284AF
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiEPMxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiEPMxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 08:53:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62326393F5;
        Mon, 16 May 2022 05:53:16 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L1zfz55DzzhZT8;
        Mon, 16 May 2022 20:52:27 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 20:53:14 +0800
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
Subject: [PATCH v8 5/8] perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
Date:   Mon, 16 May 2022 20:52:20 +0800
Message-ID: <20220516125223.32012-6-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220516125223.32012-1-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
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

HiSilicon PCIe tune and trace device (PTT) could dynamically tune
the PCIe link's events, and trace the TLP headers).

This patch add support for PTT device in perf tool, so users could
use 'perf record' to get TLP headers trace data.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/arch/arm/util/auxtrace.c   |  63 +++++++++
 tools/perf/arch/arm/util/pmu.c        |   3 +
 tools/perf/arch/arm64/util/Build      |   2 +-
 tools/perf/arch/arm64/util/hisi-ptt.c | 187 ++++++++++++++++++++++++++
 tools/perf/util/auxtrace.c            |   1 +
 tools/perf/util/auxtrace.h            |   1 +
 tools/perf/util/hisi-ptt.h            |  19 +++
 7 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
 create mode 100644 tools/perf/util/hisi-ptt.h

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 384c7cfda0fd..297fffedf45e 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -4,9 +4,11 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <dirent.h>
 #include <stdbool.h>
 #include <linux/coresight-pmu.h>
 #include <linux/zalloc.h>
+#include <api/fs/fs.h>
 
 #include "../../../util/auxtrace.h"
 #include "../../../util/debug.h"
@@ -14,6 +16,7 @@
 #include "../../../util/pmu.h"
 #include "cs-etm.h"
 #include "arm-spe.h"
+#include "hisi-ptt.h"
 
 static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 {
@@ -50,6 +53,52 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 	return arm_spe_pmus;
 }
 
+static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
+{
+	const char *sysfs = sysfs__mountpoint();
+	struct perf_pmu **hisi_ptt_pmus = NULL;
+	struct dirent *dent;
+	char path[PATH_MAX];
+	DIR *dir = NULL;
+	int idx = 0;
+
+	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
+	dir = opendir(path);
+	if (!dir) {
+		pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
+		*err = -EINVAL;
+		goto out;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, HISI_PTT_PMU_NAME))
+			(*nr_ptts)++;
+	}
+
+	if (!(*nr_ptts))
+		goto out;
+
+	hisi_ptt_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_ptts));
+	if (!hisi_ptt_pmus) {
+		pr_err("hisi_ptt alloc failed\n");
+		*err = -ENOMEM;
+		goto out;
+	}
+
+	rewinddir(dir);
+	while ((dent = readdir(dir))) {
+		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < (*nr_ptts)) {
+			hisi_ptt_pmus[idx] = perf_pmu__find(dent->d_name);
+			if (hisi_ptt_pmus[idx])
+				idx++;
+		}
+	}
+
+out:
+	closedir(dir);
+	return hisi_ptt_pmus;
+}
+
 static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
 					   int pmu_nr, struct evsel *evsel)
 {
@@ -71,17 +120,21 @@ struct auxtrace_record
 {
 	struct perf_pmu	*cs_etm_pmu = NULL;
 	struct perf_pmu **arm_spe_pmus = NULL;
+	struct perf_pmu **hisi_ptt_pmus = NULL;
 	struct evsel *evsel;
 	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
+	struct perf_pmu *found_ptt = NULL;
 	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
+	int nr_ptts = 0;
 
 	if (!evlist)
 		return NULL;
 
 	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
 	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
+	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cs_etm_pmu && !found_etm)
@@ -89,9 +142,13 @@ struct auxtrace_record
 
 		if (arm_spe_pmus && !found_spe)
 			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
+
+		if (arm_spe_pmus && !found_spe)
+			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
 	}
 
 	free(arm_spe_pmus);
+	free(hisi_ptt_pmus);
 
 	if (found_etm)
 		auxtrace_event_cnt++;
@@ -99,6 +156,9 @@ struct auxtrace_record
 	if (found_spe)
 		auxtrace_event_cnt++;
 
+	if (found_ptt)
+		auxtrace_event_cnt++;
+
 	if (auxtrace_event_cnt > 1) {
 		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
@@ -111,6 +171,9 @@ struct auxtrace_record
 #if defined(__aarch64__)
 	if (found_spe)
 		return arm_spe_recording_init(err, found_spe);
+
+	if (found_ptt)
+		return hisi_ptt_recording_init(err, found_ptt);
 #endif
 
 	/*
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index b8b23b9dc598..887c8addc491 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 
 #include "arm-spe.h"
+#include "hisi-ptt.h"
 #include "../../../util/pmu.h"
 
 struct perf_event_attr
@@ -22,6 +23,8 @@ struct perf_event_attr
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
+	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
+		pmu->selectable = true;
 #endif
 	}
 
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 9fcb4e68add9..337aa9bdf905 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -11,4 +11,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
-			      arm-spe.o mem-events.o
+			      arm-spe.o mem-events.o hisi-ptt.o
diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
new file mode 100644
index 000000000000..5340b88b66fa
--- /dev/null
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/zalloc.h>
+#include <time.h>
+
+#include <internal/lib.h> // page_size
+#include "../../../util/auxtrace.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/hisi-ptt.h"
+#include "../../../util/pmu.h"
+#include "../../../util/record.h"
+#include "../../../util/session.h"
+#include "../../../util/tsc.h"
+
+#define KiB(x) ((x) * 1024)
+#define MiB(x) ((x) * 1024 * 1024)
+
+struct hisi_ptt_recording {
+	struct auxtrace_record	itr;
+	struct perf_pmu *hisi_ptt_pmu;
+	struct evlist *evlist;
+};
+
+static size_t
+hisi_ptt_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+			struct evlist *evlist __maybe_unused)
+{
+	return HISI_PTT_AUXTRACE_PRIV_SIZE;
+}
+
+static int hisi_ptt_info_fill(struct auxtrace_record *itr,
+			      struct perf_session *session,
+			      struct perf_record_auxtrace_info *auxtrace_info,
+			      size_t priv_size)
+{
+	struct hisi_ptt_recording *pttr =
+			container_of(itr, struct hisi_ptt_recording, itr);
+	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
+
+	if (priv_size != HISI_PTT_AUXTRACE_PRIV_SIZE)
+		return -EINVAL;
+
+	if (!session->evlist->core.nr_mmaps)
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_HISI_PTT;
+	auxtrace_info->priv[0] = hisi_ptt_pmu->type;
+
+	return 0;
+}
+
+static int hisi_ptt_set_auxtrace_mmap_page(struct record_opts *opts)
+{
+	bool privileged = perf_event_paranoid_check(-1);
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(16) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	}
+
+	/* Validate auxtrace_mmap_pages */
+	if (opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
+		size_t min_sz = KiB(8);
+
+		if (sz < min_sz || !is_power_of_2(sz)) {
+			pr_err("Invalid mmap size for HISI PTT: must be at least %zuKiB and a power of 2\n",
+			       min_sz / 1024);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int hisi_ptt_recording_options(struct auxtrace_record *itr,
+				      struct evlist *evlist,
+				      struct record_opts *opts)
+{
+	struct hisi_ptt_recording *pttr =
+			container_of(itr, struct hisi_ptt_recording, itr);
+	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
+	struct evsel *evsel, *hisi_ptt_evsel = NULL;
+	struct evsel *tracking_evsel;
+	int err;
+
+	pttr->evlist = evlist;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == hisi_ptt_pmu->type) {
+			if (hisi_ptt_evsel) {
+				pr_err("There may be only one " HISI_PTT_PMU_NAME "x event\n");
+				return -EINVAL;
+			}
+			evsel->core.attr.freq = 0;
+			evsel->core.attr.sample_period = 1;
+			hisi_ptt_evsel = evsel;
+			opts->full_auxtrace = true;
+		}
+	}
+
+	err = hisi_ptt_set_auxtrace_mmap_page(opts);
+	if (err)
+		return err;
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evlist, hisi_ptt_evsel);
+	evsel__set_sample_bit(hisi_ptt_evsel, TIME);
+
+	/* Add dummy event to keep tracking */
+	err = parse_events(evlist, "dummy:u", NULL);
+	if (err)
+		return err;
+
+	tracking_evsel = evlist__last(evlist);
+	evlist__set_tracking_event(evlist, tracking_evsel);
+
+	tracking_evsel->core.attr.freq = 0;
+	tracking_evsel->core.attr.sample_period = 1;
+	evsel__set_sample_bit(tracking_evsel, TIME);
+
+	return 0;
+}
+
+static u64 hisi_ptt_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return rdtsc();
+}
+
+static void hisi_ptt_recording_free(struct auxtrace_record *itr)
+{
+	struct hisi_ptt_recording *pttr =
+			container_of(itr, struct hisi_ptt_recording, itr);
+
+	free(pttr);
+}
+
+struct auxtrace_record *hisi_ptt_recording_init(int *err,
+						struct perf_pmu *hisi_ptt_pmu)
+{
+	struct hisi_ptt_recording *pttr;
+
+	if (!hisi_ptt_pmu) {
+		*err = -ENODEV;
+		return NULL;
+	}
+
+	pttr = zalloc(sizeof(*pttr));
+	if (!pttr) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
+	pttr->itr.pmu = hisi_ptt_pmu;
+	pttr->itr.recording_options = hisi_ptt_recording_options;
+	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
+	pttr->itr.info_fill = hisi_ptt_info_fill;
+	pttr->itr.free = hisi_ptt_recording_free;
+	pttr->itr.reference = hisi_ptt_reference;
+	pttr->itr.read_finish = auxtrace_record__read_finish;
+	pttr->itr.alignment = 0;
+
+	*err = 0;
+	return &pttr->itr;
+}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index df1c5bbbaa0d..a24cad3ce24e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1281,6 +1281,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 	case PERF_AUXTRACE_S390_CPUMSF:
 		err = s390_cpumsf_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_HISI_PTT:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index dc38b6f57232..3858c5752ead 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -48,6 +48,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_CS_ETM,
 	PERF_AUXTRACE_ARM_SPE,
 	PERF_AUXTRACE_S390_CPUMSF,
+	PERF_AUXTRACE_HISI_PTT,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
new file mode 100644
index 000000000000..2db9b4056214
--- /dev/null
+++ b/tools/perf/util/hisi-ptt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HiSilicon PCIe Trace and Tuning (PTT) support
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ */
+
+#ifndef INCLUDE__PERF_HISI_PTT_H__
+#define INCLUDE__PERF_HISI_PTT_H__
+
+#define HISI_PTT_PMU_NAME		"hisi_ptt"
+#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
+
+struct auxtrace_record *hisi_ptt_recording_init(int *err,
+						struct perf_pmu *hisi_ptt_pmu);
+
+int hisi_ptt_process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session);
+
+#endif
-- 
2.24.0

