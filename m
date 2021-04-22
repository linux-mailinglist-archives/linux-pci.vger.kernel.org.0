Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16893680E5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDVMzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 08:55:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16615 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVMzb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 08:55:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FQy4b3TXCz16Lgg;
        Thu, 22 Apr 2021 20:52:31 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Apr 2021
 20:54:47 +0800
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace
 device
To:     Leo Yan <leo.yan@linaro.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <helgaas@kernel.org>, <gregkh@linuxfoundation.org>,
        <lorenzo.pieralisi@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <8735vpf20c.fsf@ashishki-desk.ger.corp.intel.com>
 <628f2f4a-03ce-a646-bf27-d6836baca425@hisilicon.com>
 <20210422034929.GA13004@leoy-ThinkPad-X240s>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <955f89c6-a330-fd64-f530-43435f5cafcb@hisilicon.com>
Date:   Thu, 22 Apr 2021 20:54:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210422034929.GA13004@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/22 11:49, Leo Yan wrote:
> On Mon, Apr 19, 2021 at 09:03:18PM +0800, Yicong Yang wrote:
>> On 2021/4/17 21:56, Alexander Shishkin wrote:
>>> Yicong Yang <yangyicong@hisilicon.com> writes:
>>>
>>>> The reason for not using perf is because there is no current support
>>>> for uncore tracing in the perf facilities.
>>>
>>> Not unless you count
>>>
>>> $ perf list|grep -ic uncore
>>> 77
>>>
>>
>> these are uncore events probably do not support sampling.
>>
>> I tried on x86:
>>
>> # ./perf record -e uncore_imc_0/cas_count_read/
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc_0/cas_count_read/).
>> /bin/dmesg | grep -i perf may provide additional information.
>>
>> For HiSilicon uncore PMUs, we don't support uncore sampling:
>>
>> 'The current driver does not support sampling. So "perf record" is unsupported. ' [1]
>>
>> and also in another PMU:
>>
>> 'PMU doesn't support process specific events and cannot be used in sampling mode.' [2]
>>
>> [1] Documentation/admin-guide/perf/hisi-pmu.rst
>> [2] Documentation/admin-guide/perf/arm_dsu_pmu.rst
> 
> I did some debugging for this, and yes, it's related with the event
> doesn't support sampling for these x86 uncore events.
> 
> So I can use below commands for the uncore event
> 'uncore_imc/data_reads/' in my experiment:
> 
>   # perf record -e 'uncore_imc/data_reads/' --no-samples -- ls
>   # perf stat -e 'uncore_imc/data_reads/' -- ls
> 
> For your case, I think you need to write the callback
> pmu::event_init(), it should not forbid any tracing even if set
> sampling, just like other perf event drive for support AUX tracing.
> 

thanks for the hint! I didn't know much about perf so I only do
the basic test. will further investigate on this.

>>>> We have our own format
>>>> of data and don't need perf doing the parsing.
>>>
>>> Perf has AUX buffers, which are used for all kinds of own formats.
>>>
>>
>> ok. we thought perf will break the data format but AUX buffers seems won't.
>> do we need to add full support for tracing as well as parsing or it's ok for
>> not parsing it through perf?
> 
> IMHO, this could divide into two parts.  The first part is to enable
> perf drive with support AUX tracing, and perf tool can capture the trace
> data.  The second part is to add the decoder in the perf tool so that
> the developers can *consume* the trace data; for the decoder, you
> could refer the codes:
> 
>   tools/perf/util/intel-pt-decoder/
>   tools/perf/util/cs-etm-decoder/
> 
> Or Arm SPE case:
> 
>   tools/perf/util/arm-spe-decoder/
> 

will refer to these implementation to see how to add the decoder for our
traced data. very detailed guidance!

>>>> A similar approach for implementing this function is ETM, which use
>>>> sysfs for configuring and a character device for dumping data.
>>>
>>> And also perf. One reason ETM has a sysfs interface is because the
>>> driver predates perf's AUX buffers. Can't say if it's the only
>>> reason. I'm assuming you're talking about Coresight ETM.
> 
> I am not the best person to give background for this.  Mathieu or Mike
> could give more info for this.  From my undersanding, Sysfs nodes can
> be used as knobs for configuration, but it's difficult for profiling.
> 

as explained by the maintainers that there are some historical reasons for
having sysfs interfaces for ETM as there is no perf AUX buffers at
beginning. I thought sysfs interface as an option but perf AUX buffer
is better as suggested.

> Let's think about for the profiling, if one developer uses the Sysfs
> for the setting and read out the trace data, these informations are
> discrete.  If another developer wants to review the profiling result,
> then all these info need to be shared together.
> 

ok. make sense to me.

> So we can benefit much from the perf tool for the usage, since all the
> profiling context will be gathered (DSOs, hardware configuration which
> can be saved into metadata), so the final profiling file can be easily
> shared and more friendly for reviewing.
> 

ok. it will be beneficial if we use perf for both tracing and decoding,
as we'll also get addition information attached to the trace data.

Considering we have two functions: tracing and tuning. For tracing we
can make use of perf AUX buffer but for tuning, I still cannot see how to
make use of perf. So probably we can make tuning go through sysfs?
And Daniel suggested so.

Appreciate for the suggestion and guidance!

Regards,
Yicong

> Thanks,
> Leo
> 
> .
> 

