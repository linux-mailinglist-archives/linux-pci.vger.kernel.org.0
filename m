Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D925EBD00
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiI0IRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI0IRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:17:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63536348;
        Tue, 27 Sep 2022 01:16:30 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McC7K4yrlzpTK4;
        Tue, 27 Sep 2022 16:13:33 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:16:28 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <acme@kernel.org>, <peterz@infradead.org>,
        <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
        <james.clark@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <mike.leach@linaro.org>
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <liuqi6124@gmail.com>
Subject: [PATCH v14 0/3] Add perf support for HiSilicon PCIe Tune and Trace device
Date:   Tue, 27 Sep 2022 16:13:57 +0800
Message-ID: <20220927081400.14364-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

This patchset adds the perf tool support for HiSilicon PCIe Tune and Trace
device [1]. The device driver makes use of perf AUX trace for tracing
TLP (Transaction Layer Packet) headers of PCIe. The trace can be started by
`perf record` and the traced data can be decoded by `perf report` with
this patchset. The detailed usage is documented in [1].

This is split from the v11 series as suggested to send driver part and
perf tool part separately. The changelog before v11 can be found at [2].

Since the driver has been accepted, wish to have perf support along with
the PTT driver to enable the full support.

[1] https://lore.kernel.org/lkml/20220816114414.4092-5-yangyicong@huawei.com/
[2] https://lore.kernel.org/lkml/20220816114414.4092-1-yangyicong@huawei.com/

Change since v13:
- Collect tags from John and do few cleanups. Thanks.
Link: https://lore.kernel.org/lkml/20220919090045.6778-1-yangyicong@huawei.com/

Change since v12:
- Remove unused headers and some minor fixes, Per John. Thanks!
Link: https://lore.kernel.org/lkml/20220914075925.48549-1-yangyicong@huawei.com/

Qi Liu (3):
  perf tool: arm: Refactor event list iteration in
    auxtrace_record__init()
  perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
  perf tool: Add support for parsing HiSilicon PCIe Trace packet

 tools/perf/arch/arm/util/auxtrace.c           | 116 +++++++++--
 tools/perf/arch/arm/util/pmu.c                |   3 +
 tools/perf/arch/arm64/util/Build              |   2 +-
 tools/perf/arch/arm64/util/hisi-ptt.c         | 188 +++++++++++++++++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/auxtrace.c                    |   4 +
 tools/perf/util/auxtrace.h                    |   1 +
 tools/perf/util/hisi-ptt-decoder/Build        |   1 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 164 +++++++++++++++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  31 +++
 tools/perf/util/hisi-ptt.c                    | 192 ++++++++++++++++++
 tools/perf/util/hisi-ptt.h                    |  19 ++
 12 files changed, 703 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
 create mode 100644 tools/perf/util/hisi-ptt.c
 create mode 100644 tools/perf/util/hisi-ptt.h

-- 
2.24.0

