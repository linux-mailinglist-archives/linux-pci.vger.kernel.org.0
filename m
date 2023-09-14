Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD87A0283
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjINLZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 07:25:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610C1FCA;
        Thu, 14 Sep 2023 04:25:33 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RmZgY48Rzz1N83N;
        Thu, 14 Sep 2023 19:23:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 19:25:03 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH v2 5/5] hwtracing: hisi_ptt: Add dummy callback pmu::read()
Date:   Thu, 14 Sep 2023 19:22:23 +0800
Message-ID: <20230914112223.27165-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230914112223.27165-1-yangyicong@huawei.com>
References: <20230914112223.27165-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 62a444f5228e..c1b5fd2b8974 100644
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

