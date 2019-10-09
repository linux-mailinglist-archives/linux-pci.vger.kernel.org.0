Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55CDD0A80
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJIJEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 05:04:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIJEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 05:04:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9993t0W028585;
        Wed, 9 Oct 2019 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570611835;
        bh=jEegimTNJbOHR+TosMTLwdjur6SlXV6/KlNYDlpB+PY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=msHx5Po+NS1W0yV7jb93vkkntFsEo2/fRtzCPbZeUcmzvjub+48Ad0mNAkFa5RZ4L
         VWQXJg+kABGl4W/oR9lOFqJBJwSenFn3Rlv/QmLVAK4W6AyoGgM5obdtHTKF0y6csv
         7AJQXBMkbQsJ2Fuuz+l15U7ci/Hv9386Xp1Hswdk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9993tSJ093996;
        Wed, 9 Oct 2019 04:03:55 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 04:03:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 04:03:52 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9993oSZ076819;
        Wed, 9 Oct 2019 04:03:52 -0500
Subject: Re: [PATCH] PCI: endpoint: cast the page number to phys_addr_t
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <1570240177-8934-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGx5MzsdcKzNzCtt3DxXAEWK69Bm-QBK0248rGAvWaU22w@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <69ec3cdf-a7e8-d926-ccba-a1edbb92348d@ti.com>
Date:   Wed, 9 Oct 2019 14:33:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABEDWGx5MzsdcKzNzCtt3DxXAEWK69Bm-QBK0248rGAvWaU22w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

On 07/10/19 11:14 PM, Alan Mikhak wrote:
> On Fri, Oct 4, 2019 at 6:49 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>>
>> From: Alan Mikhak <alan.mikhak@sifive.com>
>>
>> Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
>> from type 'int' to 'phys_addr_t' before shifting left. This
>> cast is needed to avoid treating bit 31 of 'pageno' as the
>> sign bit which would otherwise get sign-extended to produce
>> a negative value. When added to the base address of PCI memory
>> space, the negative value would produce an invalid physical
>> address which falls before the start of the PCI memory space.
>>
>> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

Thanks for the patch.

The change-log title should start with "capitalized verb"

linux-pci follows certain guidelines listed here

https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Once that gets fixed
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

>> ---
>>  drivers/pci/endpoint/pci-epc-mem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
>> index 2bf8bd1f0563..d2b174ce15de 100644
>> --- a/drivers/pci/endpoint/pci-epc-mem.c
>> +++ b/drivers/pci/endpoint/pci-epc-mem.c
>> @@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>>         if (pageno < 0)
>>                 return NULL;
>>
>> -       *phys_addr = mem->phys_base + (pageno << page_shift);
>> +       *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
>>         virt_addr = ioremap(*phys_addr, size);
>>         if (!virt_addr)
>>                 bitmap_release_region(mem->bitmap, pageno, order);
>> --
>> 2.7.4
>>
> 
> Hi Kishon,
> 
> This issue was observed when requesting pci_epc_mem_alloc_addr()
> to allocate a region of size 0x40010000ULL (1GB + 64KB) from a
> 128GB PCI address space with page sizes being 64KB. This resulted
> in 'pageno' value of '0x8000' as the first available page in a
> contiguous region for the requested size due to other smaller
> regions having been allocated earlier. With 64KB page sizes,
> the variable 'page_shift' holds a value of 0x10. Shifting 'pageno'
> 16 bits to the left results in an 'int' value whose bit 31 is set.
> 
> [   10.565256] __pci_epc_mem_init: mem size 0x2000000000 page_size 0x10000
> [   10.571613] __pci_epc_mem_init: mem pages 0x200000 bitmap_size
> 0x40000 page_shift 0x10
> 
> PCI memory base 0x2000000000
> PCI memory size 128M 0x2000000000
> page_size 64K 0x10000
> page_shift  16 0x10
> pages 2M 0x200000
> bitmap_size 256K 0x40000
> 
> [  702.050299] pci_epc_mem_alloc_addr: size 0x10000 order 0x0 pageno
> 0x4 virt_add 0xffffffd0047b0000 phys_addr 0x2000040000
> [  702.061424] pci_epc_mem_alloc_addr: size 0x10000 order 0x0 pageno
> 0x5 virt_add 0xffffffd0047d0000 phys_addr 0x2000050000
> [  702.203933] pci_epc_mem_alloc_addr: size 0x40010000 order 0xf
> pageno 0x8000 virt_add 0xffffffd004800000 phys_addr 0x1f80000000
> [  702.216547] Oops - store (or AMO) access fault [#1]
> :::
> [  702.310198] sstatus: 0000000200000120 sbadaddr: ffffffd004804000
> scause: 0000000000000007

Thank you Alan for testing this and sending a patch to fix it.

Cheers
Kishon
