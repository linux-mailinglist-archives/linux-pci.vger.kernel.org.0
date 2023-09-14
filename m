Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA97A03B2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjINMZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjINL0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 07:26:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDAE1FF9;
        Thu, 14 Sep 2023 04:26:07 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RmZd250LLztSXd;
        Thu, 14 Sep 2023 19:20:54 +0800 (CST)
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
Subject: [PATCH v2 0/5] Several updates for PTT driver
Date:   Thu, 14 Sep 2023 19:22:18 +0800
Message-ID: <20230914112223.27165-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
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

This series contains several updates for PTT driver:
- Disable interrupt when trace stops, reverse to what we do in trace start
- Always handle the interrupt in hardirq context
- Optimize the AUX buffer handling to make consumer have more time to process
  the data
- Since we're a uncore PMU so block any task attach operation
- Add a dummy pmu::read() callback since the perf core may use

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

