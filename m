Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4030800
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 07:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaFI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 01:08:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44860 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 01:08:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4V58A0U012287;
        Fri, 31 May 2019 00:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559279290;
        bh=gYhMecEMX+ee1Qe5Uep//ZaFtqyHp3bCVlIEhSh0Q5Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bfwmmXuqU3bPsQJLn4eNx+JOLtUj+pooy1VGtjiw/IyfHYv3zCkRWFV5NApuw924J
         dTih+VWTZ5r8tlh6taiaOLxdI4AXnzV7CKMN3yfr/B9sDCbyTIfcXtL5Ct7oHcUrrg
         yBdACAm4XwH7WkKeIEoygelHWUf3DYXLeQuECOdI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4V58A2C053824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 May 2019 00:08:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 31
 May 2019 00:08:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 31 May 2019 00:08:10 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4V583e3072190;
        Fri, 31 May 2019 00:08:04 -0500
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Alan Mikhak <alan.mikhak@sifive.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Vinod Koul <vkoul@kernel.org>
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
 <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com>
Date:   Fri, 31 May 2019 10:36:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGxLeD-K8PjkD5hPSTFGJKs2hxEaAVO+nE5eC9Nx2yw=ig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 30/05/19 11:26 PM, Alan Mikhak wrote:
> On Wed, May 29, 2019 at 10:48 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> +Vinod Koul
>>
>> Hi,
>>
>>>>> On Fri, May 24, 2019 at 1:59 AM Gustavo Pimentel
>>>>> <Gustavo.Pimentel@synopsys.com> wrote:
>>>>>>
>>>>>> Hi Alan,
>>>>>>
>>>>>> This patch implementation is very HW implementation dependent and
>>>>>> requires the DMA to exposed through PCIe BARs, which aren't always the
>>>>>> case. Besides, you are defining some control bits on
>>>>>> include/linux/pci-epc.h that may not have any meaning to other types of
>>>>>> DMA.
>>>>>>
>>>>>> I don't think this was what Kishon had in mind when he developed the
>>>>>> pcitest, but let see what Kishon was to say about it.
>>>>>>
>>>>>> I've developed a DMA driver for DWC PCI using Linux Kernel DMAengine API
>>>>>> and which I submitted some days ago.
>>>>>> By having a DMA driver which implemented using DMAengine API, means the
>>>>>> pcitest can use the DMAengine client API, which will be completely
>>>>>> generic to any other DMA implementation.
>>
>> right, my initial thought process was to use only dmaengine APIs in
>> pci-epf-test so that the system DMA or DMA within the PCIe controller can be
>> used transparently. But can we register DMA within the PCIe controller to the
>> DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
>> (ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.
>>
>> If DMA within the PCIe controller cannot be registered in DMA subsystem, we
>> should use something like what Alan has done in this patch with dma_read ops.
>> The dma_read ops implementation in the EP controller can either use dmaengine
>> APIs or use the DMA within the PCIe controller.
>>
>> I'll review the patch separately.
>>
>> Thanks
>> Kishon
> 
> Hi Kishon,
> 
> I have some improvements in mind for a v2 patch in response to
> feedback from Gustavo Pimentel that the current implementation is HW
> specific. I hesitate from submitting a v2 patch because it seems best
> to seek comment on possible directions this may be taking.
> 
> One alternative is to wait for or modify test functions in
> pci-epf-test.c to call DMAengine client APIs, if possible. I imagine
> pci-epf-test.c test functions would still allocate the necessary local
> buffer on the endpoint side for the same canned tests for everyone to
> use. They would prepare the buffer in the existing manner by filling
> it with random bytes and calculate CRC in the case of a write test.
> However, they would then initiate DMA operations by using DMAengine
> client APIs in a generic way instead of calling memcpy_toio() and
> memcpy_fromio(). They would post-process the buffer in the existing

No, you can't remove memcpy_toio/memcpy_fromio APIs. There could be platforms
without system DMA or they could have system DMA but without MEMCOPY channels
or without DMA in their PCI controller.
> manner such as the checking for CRC in the case of a read test.
> Finally, they would release the resources and report results back to
> the user of pcitest across the PCIe bus through the existing methods.
> 
> Another alternative I have in mind for v2 is to change the struct
> pci_epc_dma that this patch added to pci-epc.h from the following:
> 
> struct pci_epc_dma {
>         u32     control;
>         u32     size;
>         u64     sar;
>         u64     dar;
> };
> 
> to something similar to the following:
> 
> struct pci_epc_dma {
>         size_t  size;
>         void *buffer;
>         int flags;
> };
> 
> The 'flags' field can be a bit field or separate boolean values to
> specify such things as linked-list mode vs single-block, etc.
> Associated #defines would be removed from pci-epc.h to be replaced if
> needed with something generic. The 'size' field specifies the size of
> DMA transfer that can fit in the buffer.

I still have to look closer into your DMA patch but linked-list mode or single
block mode shouldn't be an user select-able option but should be determined by
the size of transfer.
> 
> That way the dma test functions in pci-epf-test.c can simply kmalloc
> and prepare a local buffer on the endpoint side for the DMA transfer
> and pass its pointer down the stack using the 'buffer' field to lower
> layers. This would allow different PCIe controller drivers to
> implement DMA or not according to their needs. Each implementer can
> decide to use DMAengine client API, which would be preferable, or
> directly read or write to DMA hardware registers to suit their needs.

yes, that would be my preferred method as well. In fact I had implemented
pci_epf_tx() in [1], as a way for pci-epf-test to pass buffer address to
endpoint controller driver. I had also implemented helpers for platforms using
system DMA (i.e uses DMAengine).

Thanks
Kishon

[1] ->
http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/drivers/pci/endpoint/pci-epf-core.c?h=ti-linux-4.19.y
> 
> I would appreciate feedback and comment on such choices as part of this review.
> 
> Regards,
> Alan Mikhak
> 
