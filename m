Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5001532769
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 06:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfFCE0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 00:26:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56612 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfFCE0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 00:26:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x534PnwV015194;
        Sun, 2 Jun 2019 23:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559535949;
        bh=U1QCwRlEhwv7rziVzxtrUAAJTnyoVC6b1KNsx66xn1Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KTGfi1N7r6pXKFh2PyV35FKGuy1ELmDFQbE9OxChaUXF0gOFrw25+IvegRkoT0En/
         ojrcoK+2b91d0fsTQTS6bs2NK3R+PDyF9/nntq0F3b6qNv455atkXMYBCQRF9c0sFB
         Lw+XaXm/7Z1/8QWpft8bpS72Tw+FIk38xlIR/B1Y=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x534PnVQ074967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Jun 2019 23:25:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 2 Jun
 2019 23:25:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 2 Jun 2019 23:25:48 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x534PfNv118820;
        Sun, 2 Jun 2019 23:25:43 -0500
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Vinod Koul <vkoul@kernel.org>
CC:     Alan Mikhak <alan.mikhak@sifive.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
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
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
References: <1558650258-15050-1-git-send-email-alan.mikhak@sifive.com>
 <305100E33629484CBB767107E4246BBB0A6FAFFD@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxsQ9NXrN7W_8HVrXQBb9HiBd+d1dNfv+cXmoBpXQnLwA@mail.gmail.com>
 <305100E33629484CBB767107E4246BBB0A6FC308@DE02WEMBXB.internal.synopsys.com>
 <CABEDWGxL-WYz1BY7yXJ6eKULgVtKeo67XhgHZjvtm5Ka5foKiA@mail.gmail.com>
 <192e3a19-8b69-dfaf-aa5c-45c7087548cc@ti.com>
 <20190531050727.GO15118@vkoul-mobl>
 <d2d8a904-d796-f9f2-8f4a-61e857355a4f@ti.com>
 <20190531063247.GP15118@vkoul-mobl>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <400a7c28-39b1-f242-7810-a1d38aa51446@ti.com>
Date:   Mon, 3 Jun 2019 09:54:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531063247.GP15118@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vinod,

On 31/05/19 12:02 PM, Vinod Koul wrote:
> On 31-05-19, 10:50, Kishon Vijay Abraham I wrote:
>> Hi Vinod,
>>
>> On 31/05/19 10:37 AM, Vinod Koul wrote:
>>> Hi Kishon,
>>>
>>> On 30-05-19, 11:16, Kishon Vijay Abraham I wrote:
>>>> +Vinod Koul
>>>>
>>>> Hi,
>>>>
>>>> On 30/05/19 4:07 AM, Alan Mikhak wrote:
>>>>> On Mon, May 27, 2019 at 2:09 AM Gustavo Pimentel
>>>>> <Gustavo.Pimentel@synopsys.com> wrote:
>>>>>>
>>>>>> On Fri, May 24, 2019 at 20:42:43, Alan Mikhak <alan.mikhak@sifive.com>
>>>>>> wrote:
>>>>>>
>>>>>> Hi Alan,
>>>>>>
>>>>>>> On Fri, May 24, 2019 at 1:59 AM Gustavo Pimentel
>>>>>>> <Gustavo.Pimentel@synopsys.com> wrote:
>>>>>>>>
>>>>>>>> Hi Alan,
>>>>>>>>
>>>>>>>> This patch implementation is very HW implementation dependent and
>>>>>>>> requires the DMA to exposed through PCIe BARs, which aren't always the
>>>>>>>> case. Besides, you are defining some control bits on
>>>>>>>> include/linux/pci-epc.h that may not have any meaning to other types of
>>>>>>>> DMA.
>>>>>>>>
>>>>>>>> I don't think this was what Kishon had in mind when he developed the
>>>>>>>> pcitest, but let see what Kishon was to say about it.
>>>>>>>>
>>>>>>>> I've developed a DMA driver for DWC PCI using Linux Kernel DMAengine API
>>>>>>>> and which I submitted some days ago.
>>>>>>>> By having a DMA driver which implemented using DMAengine API, means the
>>>>>>>> pcitest can use the DMAengine client API, which will be completely
>>>>>>>> generic to any other DMA implementation.
>>>>
>>>> right, my initial thought process was to use only dmaengine APIs in
>>>> pci-epf-test so that the system DMA or DMA within the PCIe controller can be
>>>> used transparently. But can we register DMA within the PCIe controller to the
>>>> DMA subsystem? AFAIK only system DMA should register with the DMA subsystem.
>>>> (ADMA in SDHCI doesn't use dmaengine). Vinod Koul can confirm.
>>>
>>> So would this DMA be dedicated for PCI and all PCI devices on the bus?
>>
>> Yes, this DMA will be used only by PCI ($patch is w.r.t PCIe device mode. So
>> all endpoint functions both physical and virtual functions will use the DMA in
>> the controller).
>>> If so I do not see a reason why this cannot be using dmaengine. The use
>>
>> Thanks for clarifying. I was under the impression any DMA within a peripheral
>> controller shouldn't use DMAengine.
> 
> That is indeed a correct assumption. The dmaengine helps in cases where
> we have a dma controller with multiple users, for a single user case it
> might be overhead to setup dma driver and then use it thru framework.
> 
> Someone needs to see the benefit and cost of using the framework and
> decide.

The DMA within the endpoint controller can indeed be used by multiple users for
e.g in the case of multi function EP devices or SR-IOV devices, all the
function drivers can use the DMA in the endpoint controller.

I think it makes sense to use dmaengine for DMA within the endpoint controller.
> 
>>> case would be memcpy for DMA right or mem to device (vice versa) transfers?
>>
>> The device is memory mapped so it would be only memcopy.
>>>
>>> Btw many driver in sdhci do use dmaengine APIs and yes we are missing
>>> support in framework than individual drivers
>>
>> I think dmaengine APIs is used only when the platform uses system DMA and not
>> ADMA within the SDHCI controller. IOW there is no dma_async_device_register()
>> to register ADMA in SDHCI with DMA subsystem.
> 
> We are looking it from the different point of view. You are looking for
> dmaengine drivers in that (which would be in drivers/dma/) and I am
> pointing to users of dmaengine in that.
> 
> So the users in mmc would be ones using dmaengine APIs:
> $git grep -l dmaengine_prep_* drivers/mmc/
> 
> which tells me 17 drivers!

right. For the endpoint case, drivers/pci/controller should register with the
dmaengine i.e if the controller has aN embedded DMA (I think it should be okay
to keep that in drivers/pci/controller itself instead of drivers/dma) and
drivers/pci/endpoint/functions/ should use dmaengine API's (Depending on the
platform, this will either use system DMA or DMA within the PCI controller).

Thanks
Kishon
