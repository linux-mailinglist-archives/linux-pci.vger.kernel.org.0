Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840335B2EBC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 08:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIIGWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 02:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIIGWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 02:22:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590A1216BD;
        Thu,  8 Sep 2022 23:22:26 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP5Q76xMhzZcmB;
        Fri,  9 Sep 2022 14:17:51 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:22:23 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v12 0/3] Add perf support for HiSilicon PCIe Tune and
 Trace device
To:     <acme@kernel.org>, <peterz@infradead.org>,
        <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
        <james.clark@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <mike.leach@linaro.org>
References: <20220816125757.60302-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <bf7ca4f8-315c-cde4-3f31-24a50a007511@huawei.com>
Date:   Fri, 9 Sep 2022 14:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220816125757.60302-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Perf maintainers,

A gentle ping for this. Since the driver part has been accepted, hope the
corresponding perf part can catch this kernel version as well.

Thanks!

On 2022/8/16 20:57, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This patchset adds the perf tool support for HiSilicon PCIe Tune and Trace
> device [1]. The device driver makes use of perf AUX trace for tracing
> TLP(Transaction Layer Packet) headers of PCIe. The trace can be used by
> `perf record` and the traced data can be decoded by `perf report` with
> this patchset. The detailed usage is documented in [1].
> 
> This is split from the v11 series as suggested to send driver part and
> perf tool part separately. The perf tool part has no change since v11.
> The whole changelog can be found at [2].
> 
> [1] https://lore.kernel.org/lkml/20220816114414.4092-5-yangyicong@huawei.com/
> [2] https://lore.kernel.org/lkml/20220816114414.4092-1-yangyicong@huawei.com/
> 
> Qi Liu (3):
>   perf tool: arm: Refactor event list iteration in
>     auxtrace_record__init()
>   perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
>   perf tool: Add support for parsing HiSilicon PCIe Trace packet
> 
>  tools/perf/arch/arm/util/auxtrace.c           | 116 +++++++++--
>  tools/perf/arch/arm/util/pmu.c                |   3 +
>  tools/perf/arch/arm64/util/Build              |   2 +-
>  tools/perf/arch/arm64/util/hisi-ptt.c         | 188 +++++++++++++++++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/auxtrace.c                    |   4 +
>  tools/perf/util/auxtrace.h                    |   1 +
>  tools/perf/util/hisi-ptt-decoder/Build        |   1 +
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 164 +++++++++++++++
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  31 +++
>  tools/perf/util/hisi-ptt.c                    | 192 ++++++++++++++++++
>  tools/perf/util/hisi-ptt.h                    |  19 ++
>  12 files changed, 703 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>  create mode 100644 tools/perf/util/hisi-ptt.c
>  create mode 100644 tools/perf/util/hisi-ptt.h
> 
