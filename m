Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E733364251
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDSNEu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 09:04:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17361 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbhDSND5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 09:03:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FP6Pq1J0Sz7vwK;
        Mon, 19 Apr 2021 21:01:03 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 21:03:18 +0800
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>
CC:     <helgaas@kernel.org>, <gregkh@linuxfoundation.org>,
        <lorenzo.pieralisi@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, <john.garry@huawei.com>,
        <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <8735vpf20c.fsf@ashishki-desk.ger.corp.intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <628f2f4a-03ce-a646-bf27-d6836baca425@hisilicon.com>
Date:   Mon, 19 Apr 2021 21:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <8735vpf20c.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/17 21:56, Alexander Shishkin wrote:
> Yicong Yang <yangyicong@hisilicon.com> writes:
> 
>> The reason for not using perf is because there is no current support
>> for uncore tracing in the perf facilities.
> 
> Not unless you count
> 
> $ perf list|grep -ic uncore
> 77
> 

these are uncore events probably do not support sampling.

I tried on x86:

# ./perf record -e uncore_imc_0/cas_count_read/
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc_0/cas_count_read/).
/bin/dmesg | grep -i perf may provide additional information.

For HiSilicon uncore PMUs, we don't support uncore sampling:

'The current driver does not support sampling. So "perf record" is unsupported. ' [1]

and also in another PMU:

'PMU doesn't support process specific events and cannot be used in sampling mode.' [2]

[1] Documentation/admin-guide/perf/hisi-pmu.rst
[2] Documentation/admin-guide/perf/arm_dsu_pmu.rst

>> We have our own format
>> of data and don't need perf doing the parsing.
> 
> Perf has AUX buffers, which are used for all kinds of own formats.
> 

ok. we thought perf will break the data format but AUX buffers seems won't.
do we need to add full support for tracing as well as parsing or it's ok for
not parsing it through perf?

>> A similar approach for implementing this function is ETM, which use
>> sysfs for configuring and a character device for dumping data.
> 
> And also perf. One reason ETM has a sysfs interface is because the
> driver predates perf's AUX buffers. Can't say if it's the only
> reason. I'm assuming you're talking about Coresight ETM.
> 

got it. thanks.

>> Greg has some comments on our implementation and doesn't advocate
>> to build driver on debugfs [1]. So I resend this series to
>> collect more feedbacks on the implementation of this driver.
>>
>> Hi perf and ETM related experts, is it suggested to adapt this driver
>> to perf? Or is the debugfs approach acceptable? Otherwise use
> 
> Aside from the above, I don't think the use of debugfs for kernel ABIs
> is ever encouraged.
> 

ok. thanks for the suggestions.

Regards,
Yicong

> Regards,
> --
> Ale
> 
> .
> 

