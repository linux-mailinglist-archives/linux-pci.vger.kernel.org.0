Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE967A027B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjINLZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 07:25:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD691A5;
        Thu, 14 Sep 2023 04:25:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RmZgX5RV2z1N7yV;
        Thu, 14 Sep 2023 19:23:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 19:25:02 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH v2 1/5] hwtracing: hisi_ptt: Disable interrupt after trace end
Date:   Thu, 14 Sep 2023 19:22:19 +0800
Message-ID: <20230914112223.27165-2-yangyicong@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

On trace end we disable the hardware but leave the interrupt
unmasked. Mask the interrupt to make the process reverse to
the start. No actual issue since hardware should send no
interrupt after disabled.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 4 ++++
 drivers/hwtracing/ptt/hisi_ptt.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 49ea1b0f7489..428cca54217e 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -183,6 +183,10 @@ static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
 static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
 {
 	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	/* Mask the interrupt on the end */
+	writel(HISI_PTT_TRACE_INT_MASK_ALL, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
+
 	hisi_ptt->trace_ctrl.started = false;
 }
 
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index e17f045d7e72..46030aa88081 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -47,6 +47,7 @@
 #define HISI_PTT_TRACE_INT_STAT		0x0890
 #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
 #define HISI_PTT_TRACE_INT_MASK		0x0894
+#define   HISI_PTT_TRACE_INT_MASK_ALL	GENMASK(3, 0)
 #define HISI_PTT_TUNING_INT_STAT	0x0898
 #define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
 #define HISI_PTT_TRACE_WR_STS		0x08a0
-- 
2.24.0

