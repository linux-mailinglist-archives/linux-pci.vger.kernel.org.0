Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CFE1E9B27
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFABQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 May 2020 21:16:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35798 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFABQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 May 2020 21:16:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0511GFBE077304;
        Sun, 31 May 2020 20:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590974175;
        bh=nmBVOGZ6DigGZrEHfDNyY0pzJCmoX4ALlVYIJmH8ruU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=DhBv92SeT8NUFq0TfpZHoKtzpDOrYomFTV02VZQhPeTmUfo43amF0iyCBmyIZRURA
         W2J+kffABIadckRvm8g4OasEa+ttkI5E11foTqm9V9+6pNqYHHgXVBtHZLZvDHbGst
         0QD/BMj29EFcADgh6J7ZLNS4m3+XWbyiUSc3vmBU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0511GFQN088753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 31 May 2020 20:16:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 31
 May 2020 20:16:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 31 May 2020 20:16:14 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0511GBQt059820;
        Sun, 31 May 2020 20:16:12 -0500
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200522033631.32574-1-kishon@ti.com>
 <20200522033631.32574-4-kishon@ti.com>
 <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
 <df29309d-8401-4040-eb1e-90bb3af93a82@ti.com>
 <CAL_JsqLy9T8O81stSW8RHpsUXFFjon80VG9-Jgync1eVR4iTew@mail.gmail.com>
 <b3663862-44df-867f-0824-28802909f224@ti.com>
 <CAL_JsqJMZxOFw-kn5_9bNTPzJuwHybJAi6iQyBq=6BrKSvfTqA@mail.gmail.com>
 <457db3ae-e68a-d2fc-ba5f-5393ad464413@ti.com>
Message-ID: <e31f1479-ba0e-d599-4cdc-dd1395d02e6c@ti.com>
Date:   Mon, 1 Jun 2020 06:46:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <457db3ae-e68a-d2fc-ba5f-5393ad464413@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/28/2020 3:36 AM, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 5/27/2020 10:07 PM, Rob Herring wrote:
>> On Wed, May 27, 2020 at 4:49 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Hi Rob,
>>>
>>> On 5/26/2020 8:42 PM, Rob Herring wrote:
>>>> On Sun, May 24, 2020 at 9:30 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>
>>>>> Hi Rob,
>>>>>
>>>>> On 5/22/2020 9:24 PM, Rob Herring wrote:
>>>>>> On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>>
>>>>>>> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
>>>>>>> 32-bit accesses for reading or writing to Cadence registers. Convert all
>>>>>>> read and write accesses to 32-bit in Cadence PCIe driver in preparation
>>>>>>> for adding PCIe support in TI's J721E SoC.
>>>>>>
>>>>>> Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
>>>>>> with this and never can be given the PCI_COMMAND and PCI_STATUS
>>>>>> registers are in the same word (IIRC, that's the main reason 32-bit
>>>>>> config space accesses are broken). So this isn't going to work at
>>>>>
>>>>> right, PCI_STATUS has write '1' to clear bits and there's a chance that it
>>>>> could be reset while raising legacy interrupt. While this cannot be avoided for
>>>>> TI's J721E, other platforms doesn't have to have this limitation.
>>>>>> least for EP accesses. And maybe you need a custom .raise_irq() hook
>>>>>> to minimize any problems (such as making the RMW atomic at least from
>>>>>> the endpoint's perspective).
>>>>>
>>>>> This is to make sure EP doesn't update in-consistent state when RC is updating
>>>>> the PCI_STATUS register? Since this involves two different systems, how do we
>>>>> make this atomic?
>>>>
>>>> You can't make it atomic WRT both systems, but is there locking around
>>>> each RMW? Specifically, are preemption and interrupts disabled to
>>>> ensure time between a read and write are minimized? You wouldn't want
>>>> interrupts disabled during the delay too though (i.e. around
>>>> .raise_irq()).
>>>
>>> Okay, I'll add spin spin_lock_irqsave() in cdns_pcie_write_sz(). As you also
>>> pointed below that delay for legacy interrupt is wrong and it has to be fixed
>>> (with a later series).
>>
>> But you don't need a lock everywhere. You need locks in the callers
>> (and only sometimes).
> 
> Okay, the locks should be added only for registers where HOST can also write to
> the same register? Maybe only raise_irq then..
> 
>>
>>> How do you want to handle cdns_pcie_ep_fn_writew() now? Because now we are
>>> changing the default implementation to perform only 32-bit access (used for
>>> legacy interrupt, msi-x interrupt and while writing standard headers) and it's
>>> not okay only for legacy interrupts for platforms other than TI.
>>
>> Now I'm wondering how set_msi is not racy in the current code with the
>> host setting/clearing PCI_MSI_FLAGS_ENABLE? Maybe that bit is RO from
>> the EP side?
> 
> set_msi/set_msix is a one time configuration that is invoked before the host
> establishes the link with the endpoint. I don't think we have to consider this
> as racy.

Can we try to close on this discussion please?

Thanks
Kishon

> 
> Thanks
> Kishon
> 
>>
>> Ultimately I think you're going to have to provide your own endpoint
>> functions or you need accessors for specific registers like
>> PCI_MSI_FLAGS. Then for example, you just rely on the 2 bytes before
>> PCI_MSI_FLAGS being reserved and do a 32-bit access without a RMW.
>> Trying to abstract this at the register read/write level is going to
>> be fragile
>>
>> Rob
>>
