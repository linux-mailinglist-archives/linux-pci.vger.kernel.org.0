Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6808E197CC1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgC3NVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 09:21:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53690 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgC3NVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 09:21:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02UDL2jt031436;
        Mon, 30 Mar 2020 08:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585574462;
        bh=+J7/orsJ+f3n8AP528k2E4lXsemlYiKykv103gMGbNs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kb5zGWqeuttBS/SGS8JvVLGy8S1NWsngXQDtJvDBobj91kZWGAfcLvbYc7jtOgoe/
         5zy62g1cagX2uTZa6Crix35OnZeqdAEKl7fs6zdOc5mTHSj74hdlNqGlFPkBf2U8/v
         7cz1sfQU3rHXwUzgHpbBJ+cIlT/UTUguJXR8Zwe4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02UDL2vV057094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Mar 2020 08:21:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Mar 2020 08:21:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Mar 2020 08:21:01 -0500
Received: from [10.250.133.232] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02UDKx0m009138;
        Mon, 30 Mar 2020 08:21:00 -0500
Subject: Re: PCIe EPF
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
 <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com>
 <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
 <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com>
Date:   Mon, 30 Mar 2020 18:50:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prabhakar,

On 3/30/2020 6:39 PM, Lad, Prabhakar wrote:
> Hi Kishon,
> 
> On Mon, Mar 30, 2020 at 12:59 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Prabhakar,
>>
>> On 3/29/2020 7:34 PM, Lad, Prabhakar wrote:
>>> Hi Kishon,
>>>
>>> On Sat, Mar 28, 2020 at 6:44 PM Lad, Prabhakar
>>> <prabhakar.csengg@gmail.com> wrote:
>>>>
>>>> Hi Kishon,
>>>>
>>>> On Tue, Mar 24, 2020 at 2:41 PM Lad, Prabhakar
>>>> <prabhakar.csengg@gmail.com> wrote:
>>>>>
>>>>> Hi Kishon,
>>>>>
>>>>> On Tue, Mar 24, 2020 at 1:58 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>
>>>>>> Hi Prabhakar,
>>>>>>
>>>>>> On 3/22/2020 4:19 AM, Lad, Prabhakar wrote:
>>>>>>> Hi Kishon,
>>>>>>>
>>>>>>> On Fri, Mar 20, 2020 at 5:28 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>>>
>>>>>>>> Hi Prabhakar,
>>>>>>>>
>>>>>>>> On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
>>>>>>>>> Hi Kishon,
>>>>>>>>>
>>>>>>>>> I rebased my rcar-endpoint patches on endpoint branch, which has
>>>>>>>>> support for streaming DMA API support, with this  read/write/copy
>>>>>>>>> tests failed, to make sure nothing hasn't changed on my driver I
>>>>>>>>> reverted the streaming DMA API patch
>>>>>>>>> 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
>>>>>>>>> streaming DMA APIs for buffer allocation" and tests began to pass
>>>>>>>>> again.
>>>>>>>>>
>>>>>>>>> If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
>>>>>>>>> for read/write/copy pass as expected.
>>>>>>>>>
>>>>>>>>> Could you please through some light why this could be happening.
>>>>>>>>
>>>>>>>> Do you see any differences in the address returned by dma_map_single() like is
>>>>>>>> it 32-bit address or 64-bit address?
>>>>>>>>
>>>>>>> Both return 32 bit address, debugging further I see that with
>>>>>>> GFP_KERNEL flag for small buffer
>>>>>>> sizes the read/write/copy tests pass(upto 4k), so I am suspecting its
>>>>>>> related to caching probably.
>>>>>>> Also adding wmb()/rmb() just with GFP_KERNEL flag didn't help. Note I
>>>>>>> am using PIO transfers.
>>>>>>> Any thoughts on how we tackle it ?
>>>>>>>
>>>>>>> # With GFP_KERNEL flag
>>>>>>> root@hihope-rzg2m:~# pcitest -r
>>>>>>> [   46.210649] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff0004b4ae0000 dma:7e99d000 align:ffff0004b4ae0000
>>>>>>> READ ( 102400 bytes):           NOT OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r
>>>>>>> [   51.880063] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff0004b4ae0000 dma:7e9c0000 align:ffff0004b4ae0000
>>>>>>> READ ( 102400 bytes):           OKAY
>>>>>>
>>>>>> Here one of the read test is passing and the other is failing.
>>>>>> For the 1st case dma:7e99d000, address is aligned to 4K
>>>>>> For the 2nd case dma:7e9c0000, address is aligned to 256K
>>>>>>
>>>>>> I'm suspecting this could be an alignment issue. Does the outbound ATU of your
>>>>>> EP has any restrictions? (like the address should be aligned to the size?).
>>>>>>
>>>>> There isn't any  restriction for outbound ATU on ep,  Although I tried
>>>>> alignment from
>>>>> SZ_1 - SZ_256K and each failed at several points.
>>>>>
>>>>> With GFP_KERNEL | GFP_DMA, as in my previous dump here the address too
>>>>> is not aligned to 256 but still read passes.
>>>>> root@hihope-rzg2m:~# pcitest -r -s 16384
>>>>>  [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
>>>>> READ (  16384 bytes):           OKAY
>>>>>
>>>>> And I have verified with GFP_KERNEL | GFP_DMA on my platform
>>>>> everything works as expected,
>>>>>
>>>>> So how about a patch for pci_endpoint_test.c, where flags are passed
>>>>> as  part of driver_data and it defaults to just GFP_KERNEL ?
>>>>>
>>>> Any thoughts on the above ? I intended to get the endpoint driver for v5.7.
>>>>
>>> Correct me if I am wrong here, streaming DMA API should be used with
>>> dma (-d) option so that root device
>>> makes sure the data is synced when data is transferred whereas
>>> previously with dma_alloc_coherent()
>>> we didn't have to care about cache issues. Also for a non-dma (-d)
>>> option we don't have a handle to dma
>>> in rootpport device so that we can call a sync operation. I say this
>>> because on my platform  with streaming
>>> DMA api it works for small size buffers but it doesn't work with large
>>> size buffers.
>>
>> Streaming DMA API and DMA support in endpoint can be treated independently.
>> dma_alloc_coherent() will give you coherent memory, so you don't have to flush
>> or invalidate. This memory is usually limited in a platform.
>> The other option was to use streaming DMA APIs which doesn't give coherent
>> memory but SW has to take care of flush and invalidate.
>>
> Agreed. But we don't flush in SW when -d option is not specified I am
> assuming  when we us
> -d dma engine takes care of flushing it.

The -d option switch doesn't change anything on the SW that runs on the host
side (misc/pci-endpoint-test.c). That only tells the EP to use DMA.

When you use streaming APIs, dma_map_single(), dmap_unmap_single() takes care
of flushing or invalidating memory based on the platform. (Platforms which have
coherent memory will have dma-coherent property,
dma_map_single()/dmap_unmap_single() will not do flush or invalidate.

Did you try to probe the failure further by comparing the hexdumps? Where does
the mismatch happen?

> 
>>>
>>> Could you please confirm with streaming DMA api without DMA (-d)
>>> option for large buffers read/write/copy
>>> still passes for you.
>>
>> root@j7-evm:~# ./pcitest -r
>> READ ( 102400 bytes):           OKAY
>> root@j7-evm:~# ./pcitest -r -s 1024000
>> READ (1024000 bytes):           OKAY
>> root@j7-evm:~# ./pcitest -w -s 1024000
>> WRITE (1024000 bytes):          OKAY
>> root@j7-evm:~# ./pcitest -c -s 1024000
>> COPY (1024000 bytes):           OKAY
>> root@j7-evm:~# ./pcitest -c -s 10240000
>> COPY (10240000 bytes):          OKAY
>> root@j7-evm:~# ./pcitest -r -s 10240000
>> READ (10240000 bytes):          OKAY
>> root@j7-evm:~# ./pcitest -w -s 10240000
>> WRITE (10240000 bytes):         OKAY
> 
> Thank you for testing is this on Jacinto ?
> 
>>>
>>> Although I am not sure why adding GFP_KERNEL | GFP_DMA flag for
>>> kzalloc  on my platform fixes everything.
>>
>> Which host do you use? If this is only a host side limitation, you could try
>> using a different host.
>>
> I am trying this on  Renesas RZ/G2N as host and RZ/G2E as an endpoint.
> ATM I can only test this on
> Renesas platforms only and all of them have same PCIe controller :(

Does the host controller work well with other standard PCIe cards (NVMe, USB
etc.,)?
> 
> How about adding flags as part of driver data and defaulting it GFP_KERNEL ?

Nope. Not before we clearly understand the reason for the failure.

Thanks
Kishon

> 
> Cheers,
> --Prabhakar
> 
>> Thanks
>> Kishon
>>
>>>
>>> Cheers,
>>> --Prabhakar
>>>
>>>
>>>> Cheers,
>>>> --Prabhakar
>>>>
>>>>> Cheers,
>>>>> --Prabhakar
>>>>>
>>>>>> Thanks
>>>>>> Kishon
>>>>>>
>>>>>>> root@hihope-rzg2m:~# pcitest -r
>>>>>>> [   53.354830] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff0004b4ae0000 dma:7e9e2000 align:ffff0004b4ae0000
>>>>>>> READ ( 102400 bytes):           NOT OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r
>>>>>>> [   55.307236] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff0004b4ae0000 dma:7ea04000 align:ffff0004b4ae0000
>>>>>>> READ ( 102400 bytes):           NOT OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r
>>>>>>> [   57.098626] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff0004b4ae0000 dma:7ea23000 align:ffff0004b4ae0000
>>>>>>> READ ( 102400 bytes):           NOT OKAY
>>>>>>>
>>>>>>> # GFP_KERNEL | GFP_DMA
>>>>>>>
>>>>>>> root@hihope-rzg2m:~# pcitest -r -s 1024001
>>>>>>> [  174.562071] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff00003b900000 dma:7b900000 align:ffff00003b900000
>>>>>>> READ (1024001 bytes):           OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r -s 16384
>>>>>>> [  186.629347] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff00003b848000 dma:7b848000 align:ffff00003b848000
>>>>>>> READ (  16384 bytes):           OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r -s 8192
>>>>>>> [  190.578335] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff00003b840000 dma:7b840000 align:ffff00003b840000
>>>>>>> READ (   8192 bytes):           OKAY
>>>>>>> root@hihope-rzg2m:~# pcitest -r -s 128
>>>>>>> [  199.428021] pci-endpoint-test 0000:01:00.0: pci_endpoint_test_read
>>>>>>> kzalloc:ffff00003b800000 dma:7b800000 align:ffff00003b800000
>>>>>>> READ (    128 bytes):           OKAY
>>>>>>> root@hihope-rzg2m:~#
>>>>>>>
>>>>>>> Cheers,
>>>>>>> --Prabhakar
>>>>>>>
>>>>>>>> Thanks
>>>>>>>> Kishon
