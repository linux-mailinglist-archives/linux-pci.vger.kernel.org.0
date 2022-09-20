Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118605BDAA0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 05:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiITDFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiITDEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 23:04:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B758B69;
        Mon, 19 Sep 2022 20:04:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MWmYF3g0PzHnxw;
        Tue, 20 Sep 2022 11:02:09 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 11:04:17 +0800
CC:     <yangyicong@hisilicon.com>, <acme@kernel.org>,
        <peterz@infradead.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <mike.leach@linaro.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <liuqi6124@gmail.com>
Subject: Re: [PATCH v13 3/3] perf tool: Add support for parsing HiSilicon PCIe
 Trace packet
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220919173238.GA1014074@bhelgaas>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <da9e41a5-5e0b-adda-5648-f779e8e71fc7@huawei.com>
Date:   Tue, 20 Sep 2022 11:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220919173238.GA1014074@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/20 1:32, Bjorn Helgaas wrote:
> On Mon, Sep 19, 2022 at 05:00:45PM +0800, Yicong Yang wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> Add support for using 'perf report --dump-raw-trace' to parse PTT packet.
>>
>> Example usage:
>>
>> Output will contain raw PTT data and its textual representation, such
>> as:
>>
>> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
>> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
>> .
>> . ... HISI PTT data: size 4194304 bytes
>> .  00000000: 00 00 00 00                                 Prefix
>> .  00000004: 08 20 00 60                                 Header DW0
>> .  00000008: ff 02 00 01                                 Header DW1
>> .  0000000c: 20 08 00 00                                 Header DW2
>> .  00000010: 10 e7 44 ab                                 Header DW3
>> .  00000014: 2a a8 1e 01                                 Time
>> .  00000020: 00 00 00 00                                 Prefix
>> .  00000024: 01 00 00 60                                 Header DW0
>> .  00000028: 0f 1e 00 01                                 Header DW1
>> .  0000002c: 04 00 00 00                                 Header DW2
>> .  00000030: 40 00 81 02                                 Header DW3
>> .  00000034: ee 02 00 00                                 Time
> 
> This is great!  Is there a way to actually decode the TLP headers?
> E.g., something along the lines of what this does?
> https://github.com/NetTLP/wireshark-nettlp/blob/master/plugins/nettlp.lua

Thanks for the link, we'd like to implement something similar. This patch brings
fundamental support for the decoding in perf, which means decoding according to
the hardware packets format definition of each fields. 8DW will like above and
4DW will look like (more detailed):

. ... HISI PTT data: size 4194304 bytes
.  00000000: ff 0f 20 40                                 Format 3 Type 1f T9 1 T8 1 TH 1 SO 1 Length 1 Time 201
.  00000004: 0f 10 80 00                                 Header DW1
.  00000008: 00 04 00 00                                 Header DW2
.  0000000c: 48 01 01 00                                 Header DW3

In the next step we intend to do further decoding in the perf report, with granule
to each fields defined in the PCIe spec according to the different TLP's format
and type.

> If there is, it might be nice if the commit log included a hint about
> how to do more decoding.
> 

Since the definition of each Header DWx is exactly the same with the PCIe spec,
so I think user can certainly get the raw data and use the tools like nettlp.lua
to further decode for now.

Thanks,
Yicong
