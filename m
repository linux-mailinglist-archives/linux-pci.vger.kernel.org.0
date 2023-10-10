Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BC7BF66A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjJJIu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjJJIuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 04:50:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B1A4;
        Tue, 10 Oct 2023 01:50:22 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Ty03029ztT9c;
        Tue, 10 Oct 2023 16:45:44 +0800 (CST)
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
Subject: [PATCH v3 0/5] Several updates for PTT driver
Date:   Tue, 10 Oct 2023 16:47:26 +0800
Message-ID: <20231010084731.30450-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
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

This series contains several updates for PTT driver:
- Disable interrupt when trace stops, reverse to what we do in trace start
- Always handle the interrupt in hardirq context
- Optimize the AUX buffer handling to make consumer have more time to process
  the data
- Since we're a uncore PMU so block any task attach operation
- Add a dummy pmu::read() callback since the perf core may use

Change since v2:
- Add fix tag for Patch 5/5
- refine the commit in Patch 3/5, trying to make it more clear
Link: https://lore.kernel.org/all/20230914112223.27165-1-yangyicong@huawei.com/

Change since v1:
- Add Jonathan's tag, thanks
Link: https://lore.kernel.org/all/20230809081825.11518-1-yangyicong@huawei.com/

Junhao He (1):
  hwtracing: hisi_ptt: Add dummy callback pmu::read()

Yicong Yang (4):
  hwtracing: hisi_ptt: Disable interrupt after trace end
  hwtracing: hisi_ptt: Handle the interrupt in hardirq context
  hwtracing: hisi_ptt: Optimize the trace data committing
  hwtracing: hisi_ptt: Don't try to attach a task

 drivers/hwtracing/ptt/hisi_ptt.c | 33 +++++++++++++++++++++-----------
 drivers/hwtracing/ptt/hisi_ptt.h |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.24.0

