Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422B5284B5
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbiEPMxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 08:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242885AbiEPMxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 08:53:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD09393F4;
        Mon, 16 May 2022 05:53:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L1zZF0rX9zCsqK;
        Mon, 16 May 2022 20:48:21 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 20:53:13 +0800
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
Subject: [PATCH v8 4/8] perf arm: Refactor event list iteration in auxtrace_record__init()
Date:   Mon, 16 May 2022 20:52:19 +0800
Message-ID: <20220516125223.32012-5-yangyicong@hisilicon.com>
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

Use find_pmu_for_event() to simplify logic in auxtrace_record__init().

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 5fc6a2a3dbc5..384c7cfda0fd 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 	return arm_spe_pmus;
 }
 
+static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
+					   int pmu_nr, struct evsel *evsel)
+{
+	int i;
+
+	if (!pmus)
+		return NULL;
+
+	for (i = 0; i < pmu_nr; i++) {
+		if (evsel->core.attr.type == pmus[i]->type)
+			return pmus[i];
+	}
+
+	return NULL;
+}
+
 struct auxtrace_record
 *auxtrace_record__init(struct evlist *evlist, int *err)
 {
-	struct perf_pmu	*cs_etm_pmu;
+	struct perf_pmu	*cs_etm_pmu = NULL;
+	struct perf_pmu **arm_spe_pmus = NULL;
 	struct evsel *evsel;
-	bool found_etm = false;
+	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
-	struct perf_pmu **arm_spe_pmus = NULL;
+	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
-	int i = 0;
 
 	if (!evlist)
 		return NULL;
@@ -68,24 +84,23 @@ struct auxtrace_record
 	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (cs_etm_pmu &&
-		    evsel->core.attr.type == cs_etm_pmu->type)
-			found_etm = true;
-
-		if (!nr_spes || found_spe)
-			continue;
-
-		for (i = 0; i < nr_spes; i++) {
-			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
-				found_spe = arm_spe_pmus[i];
-				break;
-			}
-		}
+		if (cs_etm_pmu && !found_etm)
+			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
+
+		if (arm_spe_pmus && !found_spe)
+			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
 	}
+
 	free(arm_spe_pmus);
 
-	if (found_etm && found_spe) {
-		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
+	if (found_etm)
+		auxtrace_event_cnt++;
+
+	if (found_spe)
+		auxtrace_event_cnt++;
+
+	if (auxtrace_event_cnt > 1) {
+		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
 		return NULL;
 	}
-- 
2.24.0

