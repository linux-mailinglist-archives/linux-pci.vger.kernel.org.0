Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A131DE862A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 11:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfJ2Kyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 06:54:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50988 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbfJ2Kyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 06:54:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TAsap5038469;
        Tue, 29 Oct 2019 05:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572346476;
        bh=g4lVQboCJwTQ1PyfzSiNM83eVppq9ATTAEWGakj5QGQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ciyonj3zJYONZsccdeLFRPpCuesQqtb78ULy76jlyY1/vyAtTTUlj9x+/s5FZ6l2s
         GTY9XvYEcdqzLSdccI9OVovcZvq4H/V/1A1qepRIUjdQNyFlq74Bz+DNDZ1U4YbTIe
         3mlC2H1Wb5qmfkqDI3eKIce8NbdMNz9nBBzXHZd0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TAsaaL087139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 05:54:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 05:54:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 05:54:23 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TAsWrN048203;
        Tue, 29 Oct 2019 05:54:35 -0500
Subject: Re: [Query] : PCIe - Endpoint Function
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     <linux-pci@vger.kernel.org>
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com>
 <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
 <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com>
 <1ccb98e7-837d-059a-1292-f001b4bb66c6@ti.com>
 <CA+V-a8tesARYDpZ8n6=DJ2DMCuykikWfXx2bKe9XPRSq1yfZgg@mail.gmail.com>
 <CA+V-a8ugFfLaapNcQdvzHEYfyT8UajY6psc0G1K7sdAgGzpSOQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <196e020d-e0aa-8a8d-21da-deff05d8aa81@ti.com>
Date:   Tue, 29 Oct 2019 16:23:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8ugFfLaapNcQdvzHEYfyT8UajY6psc0G1K7sdAgGzpSOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 29/10/19 3:54 PM, Lad, Prabhakar wrote:
> Hi Kishon,
> 
> On Tue, Oct 22, 2019 at 7:06 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>>
>> Hi Kishon,
>>
>>
>> On Tue, Oct 15, 2019 at 8:53 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Hi Prabhakar,
>>>
>>> On 11/10/19 7:07 PM, Lad, Prabhakar wrote:
>>>> Hi Kishon
>>>>
>>>> On Fri, Oct 11, 2019 at 8:35 AM Lad, Prabhakar
>>>> <prabhakar.csengg@gmail.com> wrote:
>>>>>
>>>>> Hi Kishon,
>>>>>
>>>>> On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>
>>>>>> Hi Prabhakar,
>>>>>>
>>>>>> On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I am currently working on adding pcie-endpoint support for a
>>>>>>> controller, this controller doesn't support outbound- inbound address
>>>>>>> translations, it has 1-1 mapping between the CPU and PCI addresses,
>>>>>>> the current endpoint framework is based on  outbound-inbound
>>>>>>> translations, what is the best approach to add this support, or is
>>>>>>> there any WIP already for it ?
>>>>>>
>>>>>> How will the endpoint access host buffer without outbound ATU? I assume the PCI
>>>>>> address reserved for endpoint is not the full 32-bit or 64-bit address space?
>>>>>> In that case, the endpoint cannot directly access the host buffer (unless the
>>>>>> host already knows the address space of the endpoint and gives the endpoint an
>>>>>> address in its OB address space).
>>>>>>
>>>> I lied in my previous mail.
>>>>
>>>> a] The controller needs the cpu_address before starting the link, ie
>>>> with the current implementation,the bars physical address in endpoint
>>>> are assigned
>>>> using dma_alloc_coherent(), but I what I actually want here is the
>>>> phys_addr returned by pci_epc_mem_alloc_addr().
>>>>
>>>> b] In the pci_endpoint_test driver, the pci_address sent to the
>>>> endpoint driver is again dma_alloc_coherent(), but the address which I
>>>> actually want to
>>>> send to endpoint is the BAR's assigned regions in the RC.
>>>
>>> The BAR assigned regions are usually used by RC to access EP memory.
>>> dma_alloc_coherent() is used in pci_endpoint_test to allocate buffer in host
>>> memory to be accessed by EP. Can you again check if statement 'b' is accurate?
>>>
>> yes you were correct, I misread the manual I have a rough driver
>> working now, will post as
>> soon as I tidy it up.
>>
> after several runs of pcitest I hit the following issue any pointers
> on would this be the RC/endpoint ?

It's difficult to tell without seeing your EP controller driver. It could be a
ordering issue. Can you add mb() after memcpy_fromio() in pcitest (for the
error below)?

Thanks
Kishon

> 
> [  153.637906] Internal error: synchronous external abort: 96000210
> [#1] PREEMPT SMP
> [  153.664156] Workqueue: kpcitest pci_epf_test_cmd_handler
> [  153.669505] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [  153.674333] pc : __memcpy_fromio+0x40/0x80
> [  153.678456] lr : pci_epf_test_cmd_handler+0x44c/0x670
> [  153.683537] sp : ffff8000123abd10
> [  153.686871] x29: ffff8000123abd10 x28: 0000000000000000
> [  153.692217] x27: ffff000076b20000 x26: ffff8000124a0000
> [  153.697563] x25: ffff000076ecd000 x24: ffff00007c4ac000
> [  153.702909] x23: ffff800011bb9000 x22: ffff00007af7cc80
> [  153.708254] x21: ffff800011bb9000 x20: ffff800010eef000
> [  153.713600] x19: ffff00007af7ccc0 x18: 0000000000000000
> [  153.718946] x17: 0000000000000000 x16: 0000000000000000
> [  153.724291] x15: 0000000000000000 x14: 0000000000000000
> [  153.729637] x13: 0000000000000000 x12: 0000000000000001
> [  153.734984] x11: 0000000000000002 x10: 0000000000000050
> [  153.740330] x9 : ffff00007dbf2d98 x8 : 0000000000000000
> [  153.745676] x7 : 0000000000000001 x6 : 0000000000019000
> [  153.751021] x5 : ffff000076b39000 x4 : e7c67145d9acb067
> [  153.756367] x3 : ffff8000124afa78 x2 : 0000000000019000
> [  153.761714] x1 : ffff8000124a0000 x0 : ffff000076b2fa78
> [  153.767063] Call trace:
> [  153.769527]  __memcpy_fromio+0x40/0x80
> [  153.773307]  process_one_work+0x29c/0x718
> [  153.777343]  worker_thread+0x40/0x460
> [  153.781032]  kthread+0x11c/0x120
> [  153.784285]  ret_from_fork+0x10/0x18
> [  153.787887] Code: aa0103e3 927df0c6 910020c6 8b060005 (f9400064)
> [  153.794024] ---[ end trace d88a2a6a414998d3 ]---
> 
> Cheers,
> --Prabhakar
> 
