Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86FF14EBD3
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 12:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgAaLkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 06:40:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgAaLkh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 06:40:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VBeYsk091097;
        Fri, 31 Jan 2020 05:40:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580470834;
        bh=m0Mme7WS8+ZsSm8E9LQe/XImeF5NbuWOZVlu2eiakq8=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=ahziNfN08L07lftrccCG5nL6bik6SLz+2H0jE0A7nTMwtpxuDy3OfZitXcZK6U79V
         R0T8vcgBVEoAJYhNpBu4n0MiCVrJij49pD6F2XVBw+DWhqTd1Bb+iHFFb/Bg66/+bf
         Lg4GxhUfjjY7Lcm68qhYuqj/VGM806sa5TDqjrew=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VBeYdC016972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 05:40:34 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 05:40:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 05:40:33 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VBeWsj128092;
        Fri, 31 Jan 2020 05:40:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com>
 <20200130164235.GA6705@lst.de>
Message-ID: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
Date:   Fri, 31 Jan 2020 17:14:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200130164235.GA6705@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 30/01/20 10:12 pm, Christoph Hellwig wrote:
> On Thu, Jan 30, 2020 at 01:39:58PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Christoph,
>>
>> On 30/01/20 1:28 pm, Christoph Hellwig wrote:
>>> On Fri, Nov 15, 2019 at 04:29:31PM +0530, Kishon Vijay Abraham I wrote:
>>>> Hi Christoph,
>>>>
>>>> I think we are encountering a case where the connected PCIe card (like PCIe USB
>>>> card) supports 64-bit addressing and the ARM core supports 64-bit addressing
>>>> but the PCIe controller in the SoC to which PCIe card is connected supports
>>>> only 32-bits.
>>>>
>>>> Here dma APIs can provide an address above the 32 bit region to the PCIe card.
>>>> However this will fail when the card tries to access the provided address via
>>>> the PCIe controller.
>>>
>>> What kernel version do you test?  The classic arm version of dma_capable
>>> doesn't take the bus dma mask into account.  In Linux 5.5 I switched
>>> ARM to use the generic version in
>>>
>>> 130c1ccbf55 ("dma-direct: unify the dma_capable definitions")
>>>
>>> so with that this case is supposed to work, without that it doesn't
>>> have much of a chance.
>>
>> I got into a new issue in 5.5 kernel with NVMe card wherein I get the
>> below warn dump. This is different from the issue I initially posted
>> seen with USB and SATA cards (I was getting a data mismatch then). With
>> 5.5 kernel I don't see those issues anymore in USB card. I only see the
>> below warn dump with NVMe card.
> 
> Can you throw in a little debug printk if this comes from
> dma_direct_possible or swiotlb_map?

I could see swiotlb_tbl_map_single() returning DMA_MAPPING_ERROR.

Kernel with debug print:
https://github.com/kishon/linux-wip.git nvm_dma_issue

Full log: https://pastebin.ubuntu.com/p/Xf2ngxc3kB/

Thanks
Kishon
