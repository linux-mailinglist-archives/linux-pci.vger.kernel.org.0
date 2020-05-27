Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC21E3F5F
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgE0Ktv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 06:49:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54206 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgE0Ktv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 06:49:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04RAnZnC113309;
        Wed, 27 May 2020 05:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590576575;
        bh=PD+boL1tjck4sdCDgLl/S8WZdUjIHY0I5B2iMdPDagU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QWadH3xOFV3pgUzj6qG4hBxcxtI/8N/9aKAye8xOuN2atXdd1fS2UpjsWwMsVoL+V
         xFmgJHBBGy11xtVTT7TaGZUKtvV0oXI7CctJ+U/7+S8RWjiTIBMKHpzaAa1aV3Srh/
         dbKabKVR9yggVeExJmbzECP8fdGOUjsBZ6+wvMIk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RAnZKX073235;
        Wed, 27 May 2020 05:49:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 05:49:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 05:49:35 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RAnV0o056154;
        Wed, 27 May 2020 05:49:32 -0500
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b3663862-44df-867f-0824-28802909f224@ti.com>
Date:   Wed, 27 May 2020 16:19:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLy9T8O81stSW8RHpsUXFFjon80VG9-Jgync1eVR4iTew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/26/2020 8:42 PM, Rob Herring wrote:
> On Sun, May 24, 2020 at 9:30 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 5/22/2020 9:24 PM, Rob Herring wrote:
>>> On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>
>>>> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
>>>> 32-bit accesses for reading or writing to Cadence registers. Convert all
>>>> read and write accesses to 32-bit in Cadence PCIe driver in preparation
>>>> for adding PCIe support in TI's J721E SoC.
>>>
>>> Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
>>> with this and never can be given the PCI_COMMAND and PCI_STATUS
>>> registers are in the same word (IIRC, that's the main reason 32-bit
>>> config space accesses are broken). So this isn't going to work at
>>
>> right, PCI_STATUS has write '1' to clear bits and there's a chance that it
>> could be reset while raising legacy interrupt. While this cannot be avoided for
>> TI's J721E, other platforms doesn't have to have this limitation.
>>> least for EP accesses. And maybe you need a custom .raise_irq() hook
>>> to minimize any problems (such as making the RMW atomic at least from
>>> the endpoint's perspective).
>>
>> This is to make sure EP doesn't update in-consistent state when RC is updating
>> the PCI_STATUS register? Since this involves two different systems, how do we
>> make this atomic?
> 
> You can't make it atomic WRT both systems, but is there locking around
> each RMW? Specifically, are preemption and interrupts disabled to
> ensure time between a read and write are minimized? You wouldn't want
> interrupts disabled during the delay too though (i.e. around
> .raise_irq()).

Okay, I'll add spin spin_lock_irqsave() in cdns_pcie_write_sz(). As you also
pointed below that delay for legacy interrupt is wrong and it has to be fixed
(with a later series).

How do you want to handle cdns_pcie_ep_fn_writew() now? Because now we are
changing the default implementation to perform only 32-bit access (used for
legacy interrupt, msi-x interrupt and while writing standard headers) and it's
not okay only for legacy interrupts for platforms other than TI.

So just for legacy interrupt, you want me to add a different accessor which
does not perform 32-bit writes (while we add a different .raise_irq for TI
platform?
> 
> BTW, I've asked this question before, but aren't PCI legacy interrupts
> level triggered? If so, isn't generating a pulse wrong?

You are right. This is wrong and it has to be fixed. I'll work on this later.

Thanks
Kishon
