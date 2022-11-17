Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2F62D53D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiKQImg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiKQImd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:42:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FA7340C;
        Thu, 17 Nov 2022 00:42:31 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCYGm6b1RzqSLX;
        Thu, 17 Nov 2022 16:38:40 +0800 (CST)
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
Subject: [PATCH v3 3/4] Documentation: perf: Indent filter options list of hisi-pcie-pmu
Date:   Thu, 17 Nov 2022 16:41:35 +0800
Message-ID: <20221117084136.53572-4-yangyicong@huawei.com>
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

From: Bagas Sanjaya <bagasdotme@gmail.com>

The "Filter options" list have a rather ugly indentation. Also, the first
paragraph after list name is rendered without separator (as continuation
from the name).

Align the list by indenting the list items and add a blank line
separator for each list name.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 80 ++++++++++---------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index bbe66480ff85..645f08f65429 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -48,59 +48,65 @@ Filter options
 --------------
 
 1. Target filter
-PMU could only monitor the performance of traffic downstream target Root Ports
-or downstream target Endpoint. PCIe PMU driver support "port" and "bdf"
-interfaces for users, and these two interfaces aren't supported at the same
-time.
 
--port
-"port" filter can be used in all PCIe PMU events, target Root Port can be
-selected by configuring the 16-bits-bitmap "port". Multi ports can be selected
-for AP-layer-events, and only one port can be selected for TL/DL-layer-events.
+   PMU could only monitor the performance of traffic downstream target Root
+   Ports or downstream target Endpoint. PCIe PMU driver support "port" and
+   "bdf" interfaces for users, and these two interfaces aren't supported at the
+   same time.
 
-For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of bitmap
-should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4 lanes),
-bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
+   - port
 
-Example usage of perf::
+     "port" filter can be used in all PCIe PMU events, target Root Port can be
+     selected by configuring the 16-bits-bitmap "port". Multi ports can be
+     selected for AP-layer-events, and only one port can be selected for
+     TL/DL-layer-events.
 
-  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
+     For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of
+     bitmap should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4
+     lanes), bit8 is set, port=0x100; if these two Root Ports are both
+     monitored, port=0x101.
 
--bdf
+     Example usage of perf::
 
-"bdf" filter can only be used in bandwidth events, target Endpoint is selected
-by configuring BDF to "bdf". Counter only counts the bandwidth of message
-requested by target Endpoint.
+       $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
 
-For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
+   - bdf
 
-Example usage of perf::
+     "bdf" filter can only be used in bandwidth events, target Endpoint is
+     selected by configuring BDF to "bdf". Counter only counts the bandwidth of
+     message requested by target Endpoint.
+
+     For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
+
+     Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
+       $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
 
 2. Trigger filter
-Event statistics start when the first time TLP length is greater/smaller
-than trigger condition. You can set the trigger condition by writing "trig_len",
-and set the trigger mode by writing "trig_mode". This filter can only be used
-in bandwidth events.
 
-For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
-means statistics start when TLP length > trigger condition, "trig_mode=1"
-means start when TLP length < condition.
+   Event statistics start when the first time TLP length is greater/smaller
+   than trigger condition. You can set the trigger condition by writing
+   "trig_len", and set the trigger mode by writing "trig_mode". This filter can
+   only be used in bandwidth events.
 
-Example usage of perf::
+   For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
+   means statistics start when TLP length > trigger condition, "trig_mode=1"
+   means start when TLP length < condition.
+
+   Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
 
 3. Threshold filter
-Counter counts when TLP length within the specified range. You can set the
-threshold by writing "thr_len", and set the threshold mode by writing
-"thr_mode". This filter can only be used in bandwidth events.
 
-For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
-counter counts when TLP length >= threshold, and "thr_mode=1" means counts
-when TLP length < threshold.
+   Counter counts when TLP length within the specified range. You can set the
+   threshold by writing "thr_len", and set the threshold mode by writing
+   "thr_mode". This filter can only be used in bandwidth events.
 
-Example usage of perf::
+   For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
+   counter counts when TLP length >= threshold, and "thr_mode=1" means counts
+   when TLP length < threshold.
+
+   Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.24.0

