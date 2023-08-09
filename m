Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AB7754FD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHIIUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHIIUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:20:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212FE7D;
        Wed,  9 Aug 2023 01:20:43 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLNJJ29p6zmXZQ;
        Wed,  9 Aug 2023 16:19:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:20:39 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <jonathan.cameron@huawei.com>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 5/5] hwtracing: hisi_ptt: Add dummy callback pmu::read()
Date:   Wed, 9 Aug 2023 16:18:25 +0800
Message-ID: <20230809081825.11518-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230809081825.11518-1-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Junhao He <hejunhao3@huawei.com>

When start trace with perf option "-C $cpu" and immediately stop it
with SIGTERM or others, the perf core will invoke pmu::read() while
the driver doesn't implement it. Add a dummy pmu::read() to avoid
any issues.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 916686c6a9c8..7392e039b8c1 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -1184,6 +1184,10 @@ static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
 	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
 }
 
+static void hisi_ptt_pmu_read(struct perf_event *event)
+{
+}
+
 static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
 {
 	cpuhp_state_remove_instance_nocalls(hisi_ptt_pmu_online, hotplug_node);
@@ -1227,6 +1231,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
 		.stop		= hisi_ptt_pmu_stop,
 		.add		= hisi_ptt_pmu_add,
 		.del		= hisi_ptt_pmu_del,
+		.read		= hisi_ptt_pmu_read,
 	};
 
 	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
-- 
2.24.0

