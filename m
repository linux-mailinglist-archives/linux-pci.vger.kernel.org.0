Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8425B828D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiINIBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINIBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 04:01:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23443E4A;
        Wed, 14 Sep 2022 01:01:46 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSCRL1XLSzHnjB;
        Wed, 14 Sep 2022 15:59:42 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 16:01:43 +0800
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
Subject: [RESEND PATCH v12 0/3] Add perf support for HiSilicon PCIe Tune and Trace device
Date:   Wed, 14 Sep 2022 15:59:22 +0800
Message-ID: <20220914075925.48549-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

This patchset adds the perf tool support for HiSilicon PCIe Tune and Trace
device [1]. The device driver makes use of perf AUX trace for tracing
TLP (Transaction Layer Packet) headers of PCIe. The trace can be used by
`perf record` and the traced data can be decoded by `perf report` with
this patchset. The detailed usage is documented in [1].

This is split from the v11 series as suggested to send driver part and
perf tool part separately. The perf tool part has no change since v11.
The whole changelog can be found at [2].

Wish to have perf support along with the PTT driver to enable the full
support.

[1] https://lore.kernel.org/lkml/20220816114414.4092-5-yangyicong@huawei.com/
[2] https://lore.kernel.org/lkml/20220816114414.4092-1-yangyicong@huawei.com/

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

