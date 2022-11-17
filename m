Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55262D53B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiKQImf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiKQImd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:42:33 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AF729BF;
        Thu, 17 Nov 2022 00:42:31 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCYHX0K9JzJnmc;
        Thu, 17 Nov 2022 16:39:20 +0800 (CST)
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
Subject: [PATCH v3 2/4] docs: perf: Fix PMU instance name of hisi-pcie-pmu
Date:   Thu, 17 Nov 2022 16:41:34 +0800
Message-ID: <20221117084136.53572-3-yangyicong@huawei.com>
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

The PMU instance will be called hisi_pcie<sicl>_core<core> rather than
hisi_pcie<sicl>_<core>. Fix this in the documentation.

Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index 294ebbdb22af..bbe66480ff85 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -15,10 +15,10 @@ HiSilicon PCIe PMU driver
 The PCIe PMU driver registers a perf PMU with the name of its sicl-id and PCIe
 Core id.::
 
-  /sys/bus/event_source/hisi_pcie<sicl>_<core>
+  /sys/bus/event_source/hisi_pcie<sicl>_core<core>
 
 PMU driver provides description of available events and filter options in sysfs,
-see /sys/bus/event_source/devices/hisi_pcie<sicl>_<core>.
+see /sys/bus/event_source/devices/hisi_pcie<sicl>_core<core>.
 
 The "format" directory describes all formats of the config (events) and config1
 (filter options) fields of the perf_event_attr structure. The "events" directory
@@ -33,13 +33,13 @@ monitored by PMU.
 Example usage of perf::
 
   $# perf list
-  hisi_pcie0_0/rx_mwr_latency/ [kernel PMU event]
-  hisi_pcie0_0/rx_mwr_cnt/ [kernel PMU event]
+  hisi_pcie0_core0/rx_mwr_latency/ [kernel PMU event]
+  hisi_pcie0_core0/rx_mwr_cnt/ [kernel PMU event]
   ------------------------------------------
 
-  $# perf stat -e hisi_pcie0_0/rx_mwr_latency/
-  $# perf stat -e hisi_pcie0_0/rx_mwr_cnt/
-  $# perf stat -g -e hisi_pcie0_0/rx_mwr_latency/ -e hisi_pcie0_0/rx_mwr_cnt/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_cnt/
+  $# perf stat -g -e hisi_pcie0_core0/rx_mwr_latency/ -e hisi_pcie0_core0/rx_mwr_cnt/
 
 The current driver does not support sampling. So "perf record" is unsupported.
 Also attach to a task is unsupported for PCIe PMU.
@@ -64,7 +64,7 @@ bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mwr_latency,port=0x1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
 
 -bdf
 
@@ -76,7 +76,7 @@ For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,bdf=0x3900/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
 
 2. Trigger filter
 Event statistics start when the first time TLP length is greater/smaller
@@ -90,7 +90,7 @@ means start when TLP length < condition.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
 
 3. Threshold filter
 Counter counts when TLP length within the specified range. You can set the
@@ -103,4 +103,4 @@ when TLP length < threshold.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.24.0

