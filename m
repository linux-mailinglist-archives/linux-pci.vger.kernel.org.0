Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1304FB786
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiDKJcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiDKJcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 05:32:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70929DF3B;
        Mon, 11 Apr 2022 02:30:37 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcNqZ4gJZz1HBN2;
        Mon, 11 Apr 2022 17:30:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 17:30:35 +0800
CC:     <yangyicong@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/ACPI: Decouple the negotiation of ASPM and other PCIe
 services
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20220407131602.14727-1-yangyicong@hisilicon.com>
 <20220407154257.GA235990@bhelgaas>
 <CAJZ5v0gWzDsh8VWY+EzO6WxyO6Fe1GcRzVfABVOaO0ywJegLwA@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <21430f77-3a68-150a-5b66-9ceb00945c8b@huawei.com>
Date:   Mon, 11 Apr 2022 17:30:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gWzDsh8VWY+EzO6WxyO6Fe1GcRzVfABVOaO0ywJegLwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Rafael,

On 2022/4/8 0:41, Rafael J. Wysocki wrote:
> On Thu, Apr 7, 2022 at 5:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Rafael]
>>
>> On Thu, Apr 07, 2022 at 09:16:02PM +0800, Yicong Yang wrote:
>>> Currently we regard ASPM as a necessary PCIe service and if it's disabled
>>> by pcie_aspm=off we cannot enable other services like AER and hotplug.
>>> However the ASPM is just one of the PCIe services and other services
>>> mentioned no dependency on this. So this patch decouples the negotiation
>>> of ASPM and other PCIe services, then we can make use of other services
>>> in the absence of ASPM.
>>
>> Why do you want to boot with "pcie_aspm=off"?  If we have to use a
>> PCI-related parameter to boot, something is already wrong, so if
>> there's a problem that requires ASPM to be disabled, we should fix
>> that first.
>>

We found this when testing the functions of AER and hotplug. The pcie_aspm=off
is added by the tester who found it affect the function and it makes us think
that it maybe not reasonable to couple these 3 services together.

>> If there's a known hardware or firmware issue with ASPM, we should
>> quirk it so users don't have to discover this parameter.
>>
>>> Aaron Sierra tried to fix this originally:
>>> https://lore.kernel.org/linux-pci/20190702201318.GC128603@google.com/
>>
>> Yes.  My question from that review is still open:
>>
>>   But Rafael added ACPI_PCIE_REQ_SUPPORT with 415e12b23792 ("PCI/ACPI:
>>   Request _OSC control once for each root bridge (v3)") [1], apparently
>>   related to a bug [2].  I assume there was some reason for requiring
>>   all those things together, so I'd really like his comments.
> 
> Well, it was quite a few years ago.
> 
>>   [1] https://git.kernel.org/linus/415e12b23792
>>   [2] https://bugzilla.kernel.org/show_bug.cgi?id=20232
>>
>> Rafael clearly said in [1] that we need to:
>>
>>   ... check if all of the requisite _OSC support bits are set before
>>   calling acpi_pci_osc_control_set() for a given root complex.
> 
> IIRC, the idea was to avoid requesting native control of anything PCIe
> if those bits were not set in the mask, because otherwise we wouldn't
> be able to get PME and native hotplug control which were not
> configurable at that time.  [PME is still not configurable and
> potentially related to hotplug, because they may use the same MSI IRQ
> in principle, but the native hotplug is configurable now anyway.]
> 

I'm a bit confused about the 'configurable' here, is it only about PME
and hotplug share the same interrupt? Currently the PME and hotplug
interrupt is allocated by the pcie port driver and PME can get the irq
if the interrupt is allocated successfully.

>> We would still need to explain why Rafael thought all these _OSC
>> support bits were required, but now they're not.
>>
>> _OSC does not negotiate directly for control of ASPM (though of course
>> it *does* negotiate for control of the PCIe Capability, which contains
>> the ASPM control bits), but the PCI Firmware spec, r3.3, sec 4.5.3, has
>> this comment in a sample _OSC implementation:
>>
>>   // Only allow native hot plug control if the OS supports:
>>   // * ASPM
>>   // * Clock PM
>>   // * MSI/MSI-X
>>
>> which matches the current ACPI_PCIE_REQ_SUPPORT.
>>

thanks for the reference. So it indicates that native hotplug depends
on ASPM? But maybe not AER or PME, as commented following above sample
in the spec:

// Always allow native PME, AER (no dependencies)

So the AER should work on pcie_aspm=off, does it make sense?

>> So I think I would approach this by reworking the _OSC negotiation so
>> we always advertise "OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT"
>> if CONFIG_PCIEASPM=y.
> 
> That'd be reasonable IMO.
> 
>> Advertising support for ASPM doesn't mean Linux has to actually
>> *enable* it, so we could make a different mechanism to prevent use of
>> ASPM if we have a device or platform quirk or we're booting with
>> "pcie_aspm=off".
> 

I agree on this and I think this approach can resolve the condition here.
If os got the ASPM control but user sepcified pcie_aspm=off, I think we
can stop the ASPM link configuring to avoid enable the ASPM function.

> Right.
> 
> Note that if we don't request the native control of a PCIe feature,
> this basically gives the BIOS a licence to scribble on the related
> device registers and some of the features are not independent, so we
> may need to advertise support for two features in order to get control
> of just one of them.
> .
> 

ok. thanks for the note.

Regards,
Yicong
