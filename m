Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B435A0B5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIOKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 10:10:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16512 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIOKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 10:10:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FH0Lp2L84zPnDc;
        Fri,  9 Apr 2021 22:07:14 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 22:09:56 +0800
Subject: Re: [PATCH 3/4] docs: Add documentation for HiSilicon PTT device
 driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <linux-doc@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20210408165758.GA1935187@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <e94e9a35-a799-216d-c9a4-2f5fddc5e8b6@hisilicon.com>
Date:   Fri, 9 Apr 2021 22:09:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210408165758.GA1935187@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/9 0:57, Bjorn Helgaas wrote:
> On Thu, Apr 08, 2021 at 09:22:52PM +0800, Yicong Yang wrote:
>> On 2021/4/8 2:55, Bjorn Helgaas wrote:
>>> On Tue, Apr 06, 2021 at 08:45:53PM +0800, Yicong Yang wrote:
> 
>>>> +On Kunpeng 930 SoC, the PCIe root complex is composed of several
>>>> +PCIe cores.
>>
>>> Can you connect "Kunpeng 930" to something in the kernel tree?
>>> "git grep -i kunpeng" shows nothing that's obviously relevant.
>>> I assume there's a related driver in drivers/pci/controller/?
>>
>> Kunpeng 930 is the product name of Hip09 platform. The PCIe
>> controller uses the generic PCIe driver based on ACPI.
> 
> I guess I'm just looking for a hint to help users know when to enable
> the Kconfig for this.  Maybe the "HiSilicon" in the Kconfig help is
> enough?  Maybe "Kunpeng 930" is not even necessary?  If "Kunpeng 930"
> *is* necessary, there should be some way to relate it to something
> else.
> 

since it's added in Kunpeng 930. otherwise users maybe confused why they
don't find it on Kunpeng 920 (Hip 08) or older platforms. The Kunpeng is
the product name, users should have known it when they have such a platform.

>>>> +from the file, and the desired value written to the file to tune.
>>>
>>>> +Tuning multiple events at the same time is not permitted, which means
>>>> +you cannot read or write more than one tune file at one time.
>>>
>>> I think this is obvious from the model, so the sentence doesn't really
>>> add anything.  Each event is a separate file, and it's obvious that
>>> there's no way to write to multiple files simultaneously.
>>
>> from the usage we shown below this situation won't happen. I just worry
>> that users may have a program to open multiple files at the same time and
>> read/write simultaneously, so add this line here to mention the restriction.
> 
> How is this possible?  I don't think "writing multiple files
> simultaneously" is even possible in the Linux syscall model.  I don't
> think a user will do anything differently after reading "you cannot
> read or write more than one tune file at one time."
> 
then I'll remove this line. thanks.
>>>> +- tx_path_rx_req_alloc_buf_level: watermark of RX requested
>>>> +- tx_path_tx_req_alloc_buf_level: watermark of TX requested
>>>> +
>>>> +These events influence the watermark of the buffer allocated for each
>>>> +type. RX means the inbound while Tx means outbound. For a busy
>>>> +direction, you should increase the related buffer watermark to enhance
>>>> +the performance.
>>>
>>> Based on what you have written here, I would just write 2 to both
>>> files to enhance the performance in both directions.  But obviously
>>> there must be some tradeoff here, e.g., increasing Rx performance
>>> comes at the cost of Tx performane.
>>
>> the Rx buffer and Tx buffer are separate, so they won't influence
>> each other.
> 
> Why would I write anything other than 2 to these files?  That's the
> question I think this paragraph should answer.
> 

In most cases just keep the normal level.

the data in the buffer will be posted when reaching the watermark
or timed out. for some situation you have an idle traffic but you
want a quick response, then set the watermark in lower level.

>>>> +9. data_format
>>>> +--------------
>>>> +
>>>> +File to indicate the format of the traced TLP headers. User can also
>>>> +specify the desired format of traced TLP headers. Available formats
>>>> +are 4DW, 8DW which indicates the length of each TLP headers traced.
>>>> +::
>>>> +    $ cat data_format
>>>> +    [4DW]    8DW
>>>> +    $ echo 8 > data_format
>>>> +    $ cat data_format
>>>> +    4DW     [8DW]
>>>> +
>>>> +The traced TLP header format is different from the PCIe standard.
>>>
>>> I'm confused.  Below you say the fields of the traced TLP header are
>>> defined by the PCIe spec.  But here you say the format is *different*.
>>> What exactly is different?
>>
>> For the Request Header Format for 64-bit addressing of Memory, defind in
>> PCIe spec 4.0, Figure 2-15, the 1st DW is like:
>>
>> Byte 0 > [Fmt] [Type] [T9] [Tc] [T8] [Attr] [LN] [TH] ... [Length]
>>
>> some are recorded in our traced header like below, which some are not.
>> that's what I mean the format of the header are different. But for a
>> certain field like 'Fmt', the meaning keeps same with what Spec defined.
>> that's what I mean the fields definition of our traced header keep same
>> with the Spec.
> 
> Ah, that helps a lot, thank you.  Maybe you could say something along
> the lines of this:
> 
>   When using the 8DW data format, the entire TLP header is logged.
>   For example, the TLP header for Memory Reads with 64-bit addresses
>   is shown in PCIe r5.0, Figure 2-17; the header for Configuration
>   Requests is shown in Figure 2.20, etc.
> 
>   In addition, 8DW trace buffer entries contain a timestamp and
>   possibly a prefix, e.g., a PASID TLP prefix (see Figure 6-20).  TLPs
>   may include more than one prefix, but only one can be logged in
>   trace buffer entries.
> 

yes. but currently we'll only trace the PASID TLP prefix. This field
will be all 0 for a packet with no PASID TLP prefix. I'll mention
it in the doc.

>   When using the 4DW data format, DW0 of the trace buffer entry
>   contains selected fields of DW0 of the TLP, together with a
>   timestamp.  DW1-DW3 of the trace buffer entry contain DW1-DW3
>   directly from the TLP header.
> 

thanks a lot. it does look more clearer. will update the doc
as suggested.

> This looks like a really cool device.  I wish we had this for more
> platforms.

thanks! glad to hear that!

Regards,
Yicong

