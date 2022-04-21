Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6202509FEE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385524AbiDUMtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbiDUMtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 08:49:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA51326D6;
        Thu, 21 Apr 2022 05:46:42 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kkcfw3M6BzFq0j;
        Thu, 21 Apr 2022 20:44:08 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:46:40 +0800
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: Make sure the bus bridge powered on when scanning
 bus
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220414123736.34150-1-yangyicong@hisilicon.com>
 <20220420163249.GA1305194@bhelgaas>
 <CAJZ5v0jarkeaPsq6qPLotYVqfw9rZ_OdawxBN1-1=YhvVQAz9Q@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <1a9ab733-2377-4fd2-6a3b-eade26cdf9d3@huawei.com>
Date:   Thu, 21 Apr 2022 20:46:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jarkeaPsq6qPLotYVqfw9rZ_OdawxBN1-1=YhvVQAz9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/4/21 0:42, Rafael J. Wysocki wrote:
> On Wed, Apr 20, 2022 at 6:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Rafael, linux-pm, since I'd really like his ack/review]
>>
>> On Thu, Apr 14, 2022 at 08:37:36PM +0800, Yicong Yang wrote:
>>> When the bus bridge is runtime suspended, we'll fail to rescan
>>> the devices through sysfs as we cannot access the configuration
>>> space correctly when the bridge is in D3hot.
>>> It can be reproduced like:
>>>
>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>>>
>>> 0000:80:00.0 is root port and is runtime suspended and we cannot
>>> get 0000:81:00.1 after rescan.
>>>
>>> Make bridge powered on when scanning the child bus, by adding
>>> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
>>>
>>> A similar issue is met and solved by
>>> d963f6512e15 ("PCI: Power on bridges before scanning new devices")
>>> which rescan the devices through /sys/bus/pci/devices/0000:80:00.0/rescan.
>>> The callstack is like:
>>>
>>> dev_rescan_restore()
>>>   pci_rescan_bus()
>>>     pci_scan_bridge_extend()
>>>       pci_scan_child_bus_extend() /* will wake up the bridge with this patch */
>>>
>>> With this patch the issue is also resolved, so let's remove the calls of
>>> pm_runtime_*() in pci_scan_bridge_extend().
>>>
>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>> Change since v2:
>>> - just rebase it on v5.18-rc2
>>> Link: https://lore.kernel.org/linux-pci/1601029386-4928-1-git-send-email-yangyicong@hisilicon.com/
>>>
>>> Change since v1:
>>> - use an intermediate variable *bridge as suggested
>>> - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
>>> Link: https://lore.kernel.org/linux-pci/1596022223-4765-1-git-send-email-yangyicong@hisilicon.com/
>>>
>>>  drivers/pci/probe.c | 21 ++++++++++++---------
>>>  1 file changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 17a969942d37..2ca6b4b708e3 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1257,12 +1257,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>>       u8 fixed_sec, fixed_sub;
>>>       int next_busnr;
>>>
>>> -     /*
>>> -      * Make sure the bridge is powered on to be able to access config
>>> -      * space of devices below it.
>>> -      */
>>> -     pm_runtime_get_sync(&dev->dev);
> 
> I understand why this is added below, but I'm not sure why it is safe
> to remove it from here.
> 
> Say the bridge is initially in D3cold and we are accessing its config
> space below.  Why is it not necessary to power it up in that case?
> 

For the bridge in runtime D3cold we still need to power it up. I considered and tested this on the platform
supported D3hot only. Under D3hot state the configuration space is still accessible and the brigde will be
powered up when scanning children, but under D3cold we'll fail to read the bus number here. Will fix it.

>>> -
>>>       pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>>>       primary = buses & 0xFF;
>>>       secondary = (buses >> 8) & 0xFF;
>>> @@ -1464,8 +1458,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>>  out:
>>>       pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>>>
>>> -     pm_runtime_put(&dev->dev);
>>> -
>>>       return max;
>>>  }
>>>
>>> @@ -2859,11 +2851,19 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>       unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>>>       unsigned int start = bus->busn_res.start;
>>>       unsigned int devfn, fn, cmax, max = start;
>>> -     struct pci_dev *dev;
>>> +     struct pci_dev *dev, *bridge = bus->self;
> 
> I would initialize the new variable in a separate line.
> 

will separate them.

Thanks.

>>>       int nr_devs;
>>>
>>>       dev_dbg(&bus->dev, "scanning bus\n");
>>>
>>> +     /*
>>> +      * Make sure the bus bridge is powered on, otherwise we may not be
>>> +      * able to scan the devices as we may fail to access the configuration
>>> +      * space of subordinates.
>>> +      */
>>> +     if (bridge)
>>> +             pm_runtime_get_sync(&bridge->dev);
>>> +
>>>       /* Go find them, Rover! */
>>>       for (devfn = 0; devfn < 256; devfn += 8) {
>>>               nr_devs = pci_scan_slot(bus, devfn);
>>> @@ -2976,6 +2976,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>               }
>>>       }
>>>
>>> +     if (bridge)
>>> +             pm_runtime_put(&bridge->dev);
>>> +
>>>       /*
>>>        * We've scanned the bus and so we know all about what's on
>>>        * the other side of any bridges that may be on this bus plus
>>> --
> .
> 
