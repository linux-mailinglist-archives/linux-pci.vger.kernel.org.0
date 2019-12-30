Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0E12CD7C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 09:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfL3IMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 03:12:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfL3IMG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 03:12:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 692DD9AA0CF7A4652F84;
        Mon, 30 Dec 2019 16:12:02 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 16:11:51 +0800
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bjorn@helgaas.com>, <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
References: <20191218142831.GA101587@google.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <dfd3ad93-7c17-abb2-b620-99df5c984fd4@huawei.com>
Date:   Mon, 30 Dec 2019 16:11:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20191218142831.GA101587@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2019/12/18 22:28, Bjorn Helgaas wrote:
> On Wed, Dec 18, 2019 at 05:16:03PM +0800, Xiongfeng Wang wrote:
>> On 2019/12/11 12:10, Bjorn Helgaas wrote:
>>> On Tue, Dec 10, 2019 at 9:28 PM Xiongfeng Wang
>>> <wangxiongfeng2@huawei.com> wrote:
>>>> On 2019/12/7 2:10, Bjorn Helgaas wrote:
>>>>> On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
>>>>>> HiSilicon PCI Network Processor 5896 devices misreport the
>>>>>> class type as 'NOT_DEFINED', but it is actually a network
>>>>>> device. Also the size of BAR3 is reported as 265T, but this BAR
>>>>>> is actually unused.  This patch modify the class type to
>>>>>> 'CLASS_NETWORK' and disable the unused BAR3.
> 
>>>>> The question is not whether the BAR is used by the driver; the
>>>>> question is whether the device responds to accesses to the
>>>>> region described by the BAR when PCI_COMMAND_MEMORY is turned
>>>>> on.
>>>>
>>>> I asked the hardware engineer. He said I can not write an address
>>>> into that BAR.
>>>
>>> If the BAR is not writable, I think sizing should fail, so I
>>> suspect some of the bits are actually writable.
>>
>> Sorry for the delayed response. It's not so convenient for me to get
>> to the hardware guys.  BAR0 BAR1 BAR2 are 32-bit and can be used to
>> access the registers and memory within 5896 devices. These three
>> BARs can meet the need for most scenario.  BAR3 is 64-bit and can be
>> used to access all the registers and memory within 5896 devices.
>> (BAR3 is writable. Sorry for the non-confirmed information before.)
>> But BAR3 is not used by the driver and the size is very
>> large（larger than 100G, still didn't get the precise size）.  So I
>> think maybe we can disable this BAR for now, otherwise the
>> unassigned resource will cause 'pci_enable_device()' returning
>> failure.
> 
> Here's the problem: the proposed patch (below) clears the struct
> resource corresponding to BAR 3, but that doesn't actually disable the
> BAR.  It hides the BAR from Linux, so Linux will pretend it doesn't
> exist, but it's still there in the hardware.
> 
> The hardware BAR 3 still contains some value (possibly zero), and if
> PCI_COMMAND_MEMORY is set (which you need to do if you want to use
> *any* memory BARs on the device), the device will respond to any
> transactions in the BAR 3 range.  Depending on the topology and all
> the other BAR and window assignments, this may cause address
> conflicts.

I have checked with the hardware engineer. He said the transactions have some
bits to indicate whether the address is 32-bit or 64-bit. The device will respond
only when the 64-bit address transactions is in the BAR3 range.

So I think, if I clear the resource corresponding to BAR3, the 64-bit window of the
downport is empty. There will be no 64-bit address transaction sent to the device.

Thanks,
Xiongfeng

> 
> + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
> + * when assigning the resources. But this BAR is actually unused by the driver,
> + * so let's disable it.
> + */
> +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
> +{
> +       struct resource *r = &pdev->resource[3];
> +
> +       r->start = 0;
> +       r->end = 0;
> +       r->flags = 0;
> +
> +       pci_info(pdev, "Disabling invalid BAR 3\n");
> 
> .
> 

