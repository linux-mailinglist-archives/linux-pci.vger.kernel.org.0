Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CBE36432E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhDSNPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 09:15:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16603 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbhDSNNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 09:13:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FP6d05Hd3z1BGKt;
        Mon, 19 Apr 2021 21:10:44 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 21:12:57 +0800
Subject: Re: [PATCH RESEND 3/4] docs: Add HiSilicon PTT device driver
 documentation
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <1618654631-42454-4-git-send-email-yangyicong@hisilicon.com>
 <20210419090750.g6aeyyrki7fiotxl@maple.lan>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <e884000f-3131-490b-eb0c-bc82ed642a85@hisilicon.com>
Date:   Mon, 19 Apr 2021 21:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210419090750.g6aeyyrki7fiotxl@maple.lan>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/19 17:07, Daniel Thompson wrote:
> On Sat, Apr 17, 2021 at 06:17:10PM +0800, Yicong Yang wrote:
>> Document the introduction and usage of HiSilicon PTT device driver.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  Documentation/trace/hisi-ptt.rst | 326 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 326 insertions(+)
>>  create mode 100644 Documentation/trace/hisi-ptt.rst
>>
>> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
>> new file mode 100644
>> index 0000000..f093846
>> --- /dev/null
>> +++ b/Documentation/trace/hisi-ptt.rst
>> @@ -0,0 +1,326 @@
>> [...]
>> +On Kunpeng 930 SoC, the PCIe Root Complex is composed of several
>> +PCIe cores. Each PCIe core includes several Root Ports and a PTT
>> +RCiEP, like below. The PTT device is capable of tuning and
>> +tracing the link of the PCIe core.
>> +::
>> +          +--------------Core 0-------+
>> +          |       |       [   PTT   ] |
>> +          |       |       [Root Port]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +    Root Complex  |------Core 1-------+
>> +          |       |       [   PTT   ] |
>> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +          +---------------------------+
>> +
>> +The PTT device driver cannot be loaded if debugfs is not mounted.
> 
> This can't be right can it? Obviously debugfs must be enabled but why
> mounted?
> 

just mention the limit as I'm not sure it's always be mounted.

> 
>> +Each PTT device will be presented under /sys/kernel/debugfs/hisi_ptt
>> +as its root directory, with name of its BDF number.
>> +::
>> +
>> +    /sys/kernel/debug/hisi_ptt/<domain>:<bus>:<device>.<function>
>> +
>> +Tune
>> +====
>> +
>> +PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
>> +Currently we support events in 4 classes. The scope of the events
>> +covers the PCIe core to which the PTT device belongs.
>> +
>> +Each event is presented as a file under $(PTT root dir)/$(BDF)/tune, and
>> +mostly a simple open/read/write/close cycle will be used to tune
>> +the event.
>> +::
>> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/tune
>> +    $ ls
>> +    qos_tx_cpl    qos_tx_np    qos_tx_p
>> +    tx_path_rx_req_alloc_buf_level
>> +    tx_path_tx_req_alloc_buf_level
>> +    $ cat qos_tx_dp
>> +    1
>> +    $ echo 2 > qos_tx_dp
>> +    $ cat qos_tx_dp
>> +    2
>> +
>> +Current value (numerical value) of the event can be simply read
>> +from the file, and the desired value written to the file to tune.
> 
> I saw that this RFC asks about whether debugfs is an appropriate
> interface for the *tracing* capability of the platform. Have similar
> questions been raised about the tuning interfaces?
> 

yes. as well.

> It looks to me like tuning could be handled entirely using sysfs
> attributes. I think trying to handle these mostly decoupled feature
> in the same place is likely to be a mistake.
> 

Tuning and tracing are two separate functions and it does make sense
to decouple them. Thanks for the advice, we can make tuning using
sysfs attributes as debugfs is not encouraged.

Regards,
Yicong

> 
> Daniel.
> 
> .
> 

