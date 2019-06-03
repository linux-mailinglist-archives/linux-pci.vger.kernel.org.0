Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11A9327CC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 06:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFCEnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 00:43:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfFCEnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 00:43:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x534gx0F005516;
        Sun, 2 Jun 2019 23:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559536979;
        bh=E6ITgZk0gwJFpfDrJUzPTP4EDvNlXXfx7GbfX+azVjw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q5IjgtTZHJ9+BFGFPUp/lGEvpViC6Do8mMW+H48V7eZRMSWupqb4grUfi50StiZ2q
         Pq86FLnhSP2MAskU9bWaige72r9Ms9C25mZq0v6oM5e6y79n6ug1c0SMhYvIFHYsvm
         6C6N8/tDLSOxBetxl0/Y+bDR6IsDE+UbjkWrEJk4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x534gxZZ089193
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Jun 2019 23:42:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 2 Jun
 2019 23:42:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 2 Jun 2019 23:42:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x534gqMU050684;
        Sun, 2 Jun 2019 23:42:53 -0500
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
 <75d578c2-a98c-d1ef-1633-6dc5dc3b0913@ti.com>
 <CABEDWGxBxmiKjoPUSUaUBXUhKkUTXVX0U9ooRou8tcWJojb52g@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6e692ff6-e64f-e651-c8ae-34d0034ad7b9@ti.com>
Date:   Mon, 3 Jun 2019 10:11:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABEDWGxBxmiKjoPUSUaUBXUhKkUTXVX0U9ooRou8tcWJojb52g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 31/05/19 11:46 PM, Alan Mikhak wrote:
> On Thu, May 30, 2019 at 10:08 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi Alan,
>>>
>>> Hi Kishon,
>>>
>>> I have some improvements in mind for a v2 patch in response to
>>> feedback from Gustavo Pimentel that the current implementation is HW
>>> specific. I hesitate from submitting a v2 patch because it seems best
>>> to seek comment on possible directions this may be taking.
>>>
>>> One alternative is to wait for or modify test functions in
>>> pci-epf-test.c to call DMAengine client APIs, if possible. I imagine
>>> pci-epf-test.c test functions would still allocate the necessary local
>>> buffer on the endpoint side for the same canned tests for everyone to
>>> use. They would prepare the buffer in the existing manner by filling
>>> it with random bytes and calculate CRC in the case of a write test.
>>> However, they would then initiate DMA operations by using DMAengine
>>> client APIs in a generic way instead of calling memcpy_toio() and
>>> memcpy_fromio(). They would post-process the buffer in the existing
>>
>> No, you can't remove memcpy_toio/memcpy_fromio APIs. There could be platforms
>> without system DMA or they could have system DMA but without MEMCOPY channels
>> or without DMA in their PCI controller.
> 
> I agree. I wouldn't remove memcpy_toio/fromio. That is the reason this
> patch introduces the '-d' flag for pcitest to communicate that user
> intent across the PCIe bus to pci-epf-test so the endpoint can
> initiate the transfer using either memcpy_toio/fromio or DMA.
> 
>>> manner such as the checking for CRC in the case of a read test.
>>> Finally, they would release the resources and report results back to
>>> the user of pcitest across the PCIe bus through the existing methods.
>>>
>>> Another alternative I have in mind for v2 is to change the struct
>>> pci_epc_dma that this patch added to pci-epc.h from the following:
>>>
>>> struct pci_epc_dma {
>>>         u32     control;
>>>         u32     size;
>>>         u64     sar;
>>>         u64     dar;
>>> };
>>>
>>> to something similar to the following:
>>>
>>> struct pci_epc_dma {
>>>         size_t  size;
>>>         void *buffer;
>>>         int flags;
>>> };
>>>
>>> The 'flags' field can be a bit field or separate boolean values to
>>> specify such things as linked-list mode vs single-block, etc.
>>> Associated #defines would be removed from pci-epc.h to be replaced if
>>> needed with something generic. The 'size' field specifies the size of
>>> DMA transfer that can fit in the buffer.
>>
>> I still have to look closer into your DMA patch but linked-list mode or single
>> block mode shouldn't be an user select-able option but should be determined by
>> the size of transfer.
> 
> Please consider the following when taking a closer look at this patch.

After seeing comments from Vinod and Arnd, it looks like the better way of
adding DMA support would be to register DMA within PCI endpoint controller to
DMA subsystem (as dmaengine) and use only dmaengine APIs in pci_epf_test.
> 
> In my specific use case, I need to verify that any valid block size,
> including a one byte transfer, can be transferred across the PCIe bus
> by memcpy_toio/fromio() or by DMA either as a single block or as
> linked-list. That is why, instead of deciding based on transfer size,
> this patch introduces the '-L' flag for pcitest to communicate the
> user intent across the PCIe bus to pci-epf-test so the endpoint can
> initiate the DMA transfer using a single block or in linked-list mode.
The -L option seems to select an internal DMA configuration which might be
specific to one implementation. As Gustavo already pointed, we should have only
generic options in pcitest. This would no longer be applicable when we move to
dmaengine.

Thanks
Kishon
