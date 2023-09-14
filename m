Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F77A0281
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjINLZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjINLZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 07:25:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA441A5;
        Thu, 14 Sep 2023 04:25:25 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RmZgX1ZwGzgZgH;
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
Subject: [PATCH v2 2/5] hwtracing: hisi_ptt: Handle the interrupt in hardirq context
Date:   Thu, 14 Sep 2023 19:22:20 +0800
Message-ID: <20230914112223.27165-3-yangyicong@huawei.com>
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

Handle the trace interrupt in the hardirq context, make sure the irq
core won't threaded it by declaring IRQF_NO_THREAD and userspace won't
balance it by declaring IRQF_NOBALANCING. Otherwise we may violate the
synchronization requirements of the perf core, referenced to the
change of arm-ccn PMU commit 0811ef7e2f54 ("bus: arm-ccn: fix PMU interrupt flags").

In the interrupt handler we mainly doing 2 things:
- Copy the data from the local DMA buffer to the AUX buffer
- Commit the data in the AUX buffer

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 428cca54217e..3041238a6e54 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -346,9 +346,9 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 		return ret;
 
 	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
-	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
-					NULL, hisi_ptt_isr, 0,
-					DRV_NAME, hisi_ptt);
+	ret = devm_request_irq(&pdev->dev, hisi_ptt->trace_irq, hisi_ptt_isr,
+				IRQF_NOBALANCING | IRQF_NO_THREAD, DRV_NAME,
+				hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to request irq %d, ret = %d\n",
 			hisi_ptt->trace_irq, ret);
-- 
2.24.0

