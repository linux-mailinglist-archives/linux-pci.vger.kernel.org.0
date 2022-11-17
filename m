Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB862D539
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiKQImf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiKQImd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:42:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55A7340B;
        Thu, 17 Nov 2022 00:42:31 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCYGn1Dd7zqSLn;
        Thu, 17 Nov 2022 16:38:41 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:42:29 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <jonathan.cameron@huawei.com>, <bagasdotme@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@huawei.com>, <shenyang39@huawei.com>
Subject: [PATCH v3 4/4] drivers/perf: hisi: Add TLP filter support
Date:   Thu, 17 Nov 2022 16:41:36 +0800
Message-ID: <20221117084136.53572-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221117084136.53572-1-yangyicong@huawei.com>
References: <20221117084136.53572-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The PMU support to filter the TLP when counting the bandwidth with below
options:

- only count the TLP headers
- only count the TLP payloads
- count both TLP headers and payloads

In the current driver it's default to count the TLP payloads only, which
will have an implicity side effects that on the traffic only have header
only TLPs, we'll get no data.

Make this user configuration through "len_mode" parameter and make it
default to count both TLP headers and payloads when user not specified.
Also update the documentation for it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst         | 18 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_pcie_pmu.c         | 14 +++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index 645f08f65429..7e863662e2d4 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -110,3 +110,21 @@ Filter options
    Example usage of perf::
 
      $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+
+4. TLP Length filter
+
+   When counting bandwidth, the data can be composed of certain parts of TLP
+   packets. You can specify it through "len_mode":
+
+   - 2'b00: Reserved (Do not use this since the behaviour is undefined)
+   - 2'b01: Bandwidth of TLP payloads
+   - 2'b10: Bandwidth of TLP headers
+   - 2'b11: Bandwidth of both TLP payloads and headers
+
+   For example, "len_mode=2" means only counting the bandwidth of TLP headers
+   and "len_mode=3" means the final bandwidth data is composed of both TLP
+   headers and payloads. Default value if not specified is 2'b11.
+
+   Example usage of perf::
+
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 071e63d9a9ac..6fee0b6e163b 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -47,10 +47,14 @@
 #define HISI_PCIE_EVENT_M		GENMASK_ULL(15, 0)
 #define HISI_PCIE_THR_MODE_M		GENMASK_ULL(27, 27)
 #define HISI_PCIE_THR_M			GENMASK_ULL(31, 28)
+#define HISI_PCIE_LEN_M			GENMASK_ULL(35, 34)
 #define HISI_PCIE_TARGET_M		GENMASK_ULL(52, 36)
 #define HISI_PCIE_TRIG_MODE_M		GENMASK_ULL(53, 53)
 #define HISI_PCIE_TRIG_M		GENMASK_ULL(59, 56)
 
+/* Default config of TLP length mode, will count both TLP headers and payloads */
+#define HISI_PCIE_LEN_M_DEFAULT		3ULL
+
 #define HISI_PCIE_MAX_COUNTERS		8
 #define HISI_PCIE_REG_STEP		8
 #define HISI_PCIE_THR_MAX_VAL		10
@@ -91,6 +95,7 @@ HISI_PCIE_PMU_FILTER_ATTR(thr_len, config1, 3, 0);
 HISI_PCIE_PMU_FILTER_ATTR(thr_mode, config1, 4, 4);
 HISI_PCIE_PMU_FILTER_ATTR(trig_len, config1, 8, 5);
 HISI_PCIE_PMU_FILTER_ATTR(trig_mode, config1, 9, 9);
+HISI_PCIE_PMU_FILTER_ATTR(len_mode, config1, 11, 10);
 HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
 HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
 
@@ -215,8 +220,8 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
 {
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	u64 port, trig_len, thr_len, len_mode;
 	u64 reg = HISI_PCIE_INIT_SET;
-	u64 port, trig_len, thr_len;
 
 	/* Config HISI_PCIE_EVENT_CTRL according to event. */
 	reg |= FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_real_event(event));
@@ -245,6 +250,12 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
 		reg |= HISI_PCIE_THR_EN;
 	}
 
+	len_mode = hisi_pcie_get_len_mode(event);
+	if (len_mode)
+		reg |= FIELD_PREP(HISI_PCIE_LEN_M, len_mode);
+	else
+		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
+
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
 }
 
@@ -711,6 +722,7 @@ static struct attribute *hisi_pcie_pmu_format_attr[] = {
 	HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
 	HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
 	HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
+	HISI_PCIE_PMU_FORMAT_ATTR(len_mode, "config1:10-11"),
 	HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
 	HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
 	NULL
-- 
2.24.0

