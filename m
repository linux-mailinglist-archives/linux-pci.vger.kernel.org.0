Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2402258EC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTHqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 03:46:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTHqm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jul 2020 03:46:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F33E3A047A3BA07D7708;
        Mon, 20 Jul 2020 15:46:35 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 15:46:26 +0800
Subject: Re: [RFC PATCH] hwtracing: Add HiSilicon PCIe Tune and Trace device
 driver
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200716213120.GA648781@bjorn-Precision-5520>
CC:     <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <8ba5a585-bce3-94a6-850d-4bf5a22d6805@hisilicon.com>
Date:   Mon, 20 Jul 2020 15:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200716213120.GA648781@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/7/17 5:31, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2020 at 05:06:19PM +0800, Yicong Yang wrote:
>> On 2020/7/11 7:09, Bjorn Helgaas wrote:
>>> On Sat, Jun 13, 2020 at 05:32:13PM +0800, Yicong Yang wrote:
>>>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>>>> integrated Endpoint(RCiEP) device, providing the capability
>>>> to dynamically monitor and tune the PCIe traffic parameters(tune),
>>>> and trace the TLP headers to the memory(trace).
>>>>
>>>> Add the driver for the device to enable its functions. The driver
>>>> will create debugfs directory for each PTT device, and users can
>>>> operate the device through the files under its directory.
>>>> +Tune
>>>> +====
>>>> +
>>>> +PTT tune is designed for monitoring and adjusting PCIe link parameters(events).
>>>> +Currently we support events 4 classes. The scope of the events
>>>> +covers the PCIe core with which the PTT device belongs to.
>>> All of these look like things that have the potential to break the
>>> PCIe protocol and cause errors like timeouts, receiver overflows, etc.
>>> That's OK for a debug/analysis situation, but it should taint the
>>> kernel somehow because I don't want to debug problems like that if
>>> they're caused by users tweaking things.
>>>
>>> That might even be a reason *not* to merge the tune side of this.  I
>>> can see how it might be useful for you internally, but it's not
>>> obvious to me how it will benefit other users.  Maybe that part should
>>> be an out-of-tree module?
>> All the tuning values are not accurate, but abstracted to several
>> _levels_ of each events. The levels are delicately designed to
>> guarantee by the hardware that they are always valid and will not
>> break the PCIe link.  The possible level values exposed to the users
>> is tested and safe and other values will not be accepted.
>>
>> The final tuning events is not settled and we'll not exposed the
>> events which will may lead to the link broken. Furthermore, maybe we
>> could default disable the tune events' level adjustment and make
>> them readonly. The user can enable the full tune function by a
>> module parameters or in the BIOS, and a warning message will be
>> displayed.
>>
>> The tune part is beneficial for the users and not only for our
>> internal use.  We intends to provide a way to tune the link
>> depending on the downstream components and link configuration. For
>> example, users can tune the data path QoS level to get better
>> performance according to the link width is x8 or x16, or according
>> to the endpoints' class is a network card or a nvme disk.  It will
>> make our controller adapt to different condition with high
>> performance, so we hope this feature to be merged.
> OK.  This driver itself is outside my area, so I guess merging it is
> up to Alexander.
>
> Do you have any measurements of performance improvements?  I think it
> would be good to have real numbers showing that this is useful.
>
> You mentioned a warning message, so I assume you'll add some kind of
> dmesg logging when tuning happens?
>
> Is this protected so it's only usable by root or other appropriate
> privileged user?

We haven't got measurement statistic currently as the device is still in
progress. We can measure the improvements when it's finalized.

I suppose to add some info/warning messages in dmesg log when tune happens.

The whole PTT functions are accessible only by root.


>
>>>> +		 * The PTT can designate function for trace.
>>>> +		 * Add the root port's subordinates in the list as we
>>>> +		 * can specify certain function.
>>>> +		 */
>>>> +		child_bus = tpdev->subordinate;
>>>> +		list_for_each_entry(tpdev, &child_bus->devices, bus_list) {
>>> *This* looks like a potential problem with hotplug.  How do you deal
>>> with devices being added/removed after this loop?
>> Yes. I have considered the add/remove situation but not intend to address it
>> in this RFC and assume the topology is static after probing.
>> I will manage the situation in next version.
> What happens if a device is added or removed after boot?  If the only
> limitation is that you can't tune or trace a hot-added device, that's
> fine.  (I mean, it's really *not* fine because it's a poor user
> experience, but at least it's just a usability issue, not a crash.)
>
> But if hot-adding or hot-removing a device can cause an oops or a
> crash or something, *that* is definitely a problem.

The hot-adding or hot-removing will not cause a crash or an oops. If we
trace a function which is removed after boot, we'll get no data as there
is no TLPs on the link. If we trace a function added after boot,
we can get valid datas.

These situations should be considered by the driver. If user input a
removed BDF, an -EINVAL should return. If user input a BDF added after
boot, driver should address it properly(in this RFC, as the BDF is not
in list so an -EINVAL will return).

The available function/root port list of PTT in this RFC is static, it
should be dynamic considering the hot-added/hot-removed situations. Or
with other ways instead of maintaining a list.

Regards,
Yicong


>
> Bjorn
> .
>

