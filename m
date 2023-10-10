Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5C7BF675
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJJIub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjJJIu2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 04:50:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA3A7;
        Tue, 10 Oct 2023 01:50:22 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4TzJ5w91zVlDB;
        Tue, 10 Oct 2023 16:46:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 16:50:20 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH v3 3/5] hwtracing: hisi_ptt: Optimize the trace data committing
Date:   Tue, 10 Oct 2023 16:47:29 +0800
Message-ID: <20231010084731.30450-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231010084731.30450-1-yangyicong@huawei.com>
References: <20231010084731.30450-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

In the current implementation, there're 4*4MiB trace buffer and hardware
will fill the buffer one by one. The driver will get notified if one
buffer is full and then copy data to the AUX buffer. If there's no
enough room for the next trace buffer, we'll commit the AUX buffer to
the perf core and try to apply a new one. In a typical configuration
the AUX buffer will be 16MiB, so we'll commit the data after the whole
AUX buffer is occupied. Then the driver cannot apply a new AUX buffer
immediately until the committed data is consumed by userspace and then
there's room in the AUX buffer again.

This patch tries to optimize this by commit the data after one single
trace buffer is filled. Since there's still room in the AUX buffer,
driver can apply a new one without failure and don't need to wait for
the userspace to consume the data.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 3041238a6e54..4f355df8da23 100644
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

