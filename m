Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F67754FE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjHIIUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHIIUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:20:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BB10FF;
        Wed,  9 Aug 2023 01:20:41 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLNJH6G7NzmXZF;
        Wed,  9 Aug 2023 16:19:27 +0800 (CST)
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
Subject: [PATCH 3/5] hwtracing: hisi_ptt: Optimize the trace data committing
Date:   Wed, 9 Aug 2023 16:18:23 +0800
Message-ID: <20230809081825.11518-4-yangyicong@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

Currently during the PTT trace, we'll only commit the data
to the perf core when its full, which means after 4 interrupts
and totally 16MiB data while the AUX buffer is 16MiB length.
Then the userspace gets notified and handle the data. The driver
cannot apply a new AUX buffer immediately until the committed data
are handled and there's enough room in the buffer again.

This patch tries to optimize this by commit the data in every
interrupts in a 4MiB granularity. Then the userspace can have
enough time to consume the data and there's always enough room
in the AUX buffer.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 89638ed96cf9..3aba7bb6e548 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -274,15 +274,14 @@ static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
 	buf->pos += size;
 
 	/*
-	 * Just commit the traced data if we're going to stop. Otherwise if the
-	 * resident AUX buffer cannot contain the data of next trace buffer,
-	 * apply a new one.
+	 * Always commit the data to the AUX buffer in time to make sure
+	 * userspace got enough time to consume the data.
+	 *
+	 * If we're not going to stop, apply a new one and check whether
+	 * there's enough room for the next trace.
 	 */
-	if (stop) {
-		perf_aux_output_end(handle, buf->pos);
-	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
-		perf_aux_output_end(handle, buf->pos);
-
+	perf_aux_output_end(handle, size);
+	if (!stop) {
 		buf = perf_aux_output_begin(handle, event);
 		if (!buf)
 			return -EINVAL;
-- 
2.24.0

