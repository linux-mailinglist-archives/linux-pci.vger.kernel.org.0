Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3ED7081
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJOHxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 03:53:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47918 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfJOHxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 03:53:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9F7rK9D032031;
        Tue, 15 Oct 2019 02:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571126000;
        bh=REFHJ74DmCEuWW5B49IZH/TSsIlR1cvl6nnEE43a75k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GwAjFWzX8lGppeAkcf/HITaD8oK8pVewyyubpAGlf9RUPHlN3JeTPU6Mh9cUZkaDl
         SPeZ11vi709tGqEDxVRb+FzsBNZDTT/7RoQ9PqE1MgedaVfXrXfE/NeRiUb1yzSl+/
         goznnvHrgBT2+I1EbqWbIM8Qx+0p5KR4vdhrDFyU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9F7rKYJ108023
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Oct 2019 02:53:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 15
 Oct 2019 02:53:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 15 Oct 2019 02:53:19 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9F7rCp9104520;
        Tue, 15 Oct 2019 02:53:19 -0500
Subject: Re: [Query] : PCIe - Endpoint Function
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     <linux-pci@vger.kernel.org>
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com>
 <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
 <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1ccb98e7-837d-059a-1292-f001b4bb66c6@ti.com>
Date:   Tue, 15 Oct 2019 13:22:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 11/10/19 7:07 PM, Lad, Prabhakar wrote:
> Hi Kishon
> 
> On Fri, Oct 11, 2019 at 8:35 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>>
>> Hi Kishon,
>>
>> On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>> Hi Prabhakar,
>>>
>>> On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
>>>> Hello,
>>>>
>>>> I am currently working on adding pcie-endpoint support for a
>>>> controller, this controller doesn't support outbound- inbound address
>>>> translations, it has 1-1 mapping between the CPU and PCI addresses,
>>>> the current endpoint framework is based on  outbound-inbound
>>>> translations, what is the best approach to add this support, or is
>>>> there any WIP already for it ?
>>>
>>> How will the endpoint access host buffer without outbound ATU? I assume the PCI
>>> address reserved for endpoint is not the full 32-bit or 64-bit address space?
>>> In that case, the endpoint cannot directly access the host buffer (unless the
>>> host already knows the address space of the endpoint and gives the endpoint an
>>> address in its OB address space).
>>>
> I lied in my previous mail.
> 
> a] The controller needs the cpu_address before starting the link, ie
> with the current implementation,the bars physical address in endpoint
> are assigned
> using dma_alloc_coherent(), but I what I actually want here is the
> phys_addr returned by pci_epc_mem_alloc_addr().
> 
> b] In the pci_endpoint_test driver, the pci_address sent to the
> endpoint driver is again dma_alloc_coherent(), but the address which I
> actually want to
> send to endpoint is the BAR's assigned regions in the RC.

The BAR assigned regions are usually used by RC to access EP memory.
dma_alloc_coherent() is used in pci_endpoint_test to allocate buffer in host
memory to be accessed by EP. Can you again check if statement 'b' is accurate?

Thanks
Kishon
