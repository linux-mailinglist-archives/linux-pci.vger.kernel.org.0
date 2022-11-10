Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E57623DF2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 09:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiKJIwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 03:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiKJIwB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 03:52:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7882BB19;
        Thu, 10 Nov 2022 00:51:58 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7Fq32zjYzpWFm;
        Thu, 10 Nov 2022 16:48:15 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:51:56 +0800
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
Subject: [PATCH v2 1/4] drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
Date:   Thu, 10 Nov 2022 16:51:06 +0800
Message-ID: <20221110085109.45227-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221110085109.45227-1-yangyicong@huawei.com>
References: <20221110085109.45227-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Some event id of hisi-pcie-pmu is incorrect, fix them.

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 21771708597d..071e63d9a9ac 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -693,10 +693,10 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
 	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
-	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x1005),
-	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x11005),
-	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x2004),
-	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x12004),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x0804),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x10804),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x0405),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x10405),
 	NULL
 };
 
-- 
2.24.0

