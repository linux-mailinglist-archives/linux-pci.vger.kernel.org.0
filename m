Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61634B1D1E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfIMMMB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 08:12:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39636 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMMMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 08:12:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8DCBfTF029680;
        Fri, 13 Sep 2019 07:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568376701;
        bh=LDh14wMax5cYelccR2YxVkVYtjeK9DovOmYdwRMAozw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fwgcbN9uRCohF/rMgheWo77AJ3u9XGF+rvdQmL76F7++oOQMUlee1dOKrty6ZNwaw
         yYNEseEyEs/VwrIebopIDauIfbDPDkj2xrwYn8zh3OCKXi+ebecCB7c9Y6YXTkas5P
         p1e58JpAombycTdLvkwsEcnwPGnCJ0OVAj8PZBKo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8DCBfXB036693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Sep 2019 07:11:41 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 13
 Sep 2019 07:11:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 13 Sep 2019 07:11:41 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8DCBZAo123690;
        Fri, 13 Sep 2019 07:11:36 -0500
Subject: Re: [PATCH] PCI: endpoint: Add DMA to Linux PCI EP Framework
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        Haotian Wang <haotian.wang@sifive.com>, <haotian.wang@duke.edu>
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
 <6e692ff6-e64f-e651-c8ae-34d0034ad7b9@ti.com>
 <CABEDWGx2N66L=27JY6Ywbfny78UaxENkxBTqxU37PfuQO-ZMZw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <40fafe93-d2dd-b1f5-bc16-cd84ff07bd13@ti.com>
Date:   Fri, 13 Sep 2019 17:41:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABEDWGx2N66L=27JY6Ywbfny78UaxENkxBTqxU37PfuQO-ZMZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Haotian Wang

On 03/06/19 11:12 PM, Alan Mikhak wrote:
> On Sun, Jun 2, 2019 at 9:43 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi Alan,
>> On 31/05/19 11:46 PM, Alan Mikhak wrote:
>>> On Thu, May 30, 2019 at 10:08 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>> Hi Alan,
>>>>> Hi Kishon,
>>>>
>>>> I still have to look closer into your DMA patch but linked-list mode or single
>>>> block mode shouldn't be an user select-able option but should be determined by
>>>> the size of transfer.
>>>
>>> Please consider the following when taking a closer look at this patch.
>>
>> After seeing comments from Vinod and Arnd, it looks like the better way of
>> adding DMA support would be to register DMA within PCI endpoint controller to
>> DMA subsystem (as dmaengine) and use only dmaengine APIs in pci_epf_test.
> 
> Thanks Kishon. That makes it clear where these pieces should go.
> 
>>> In my specific use case, I need to verify that any valid block size,
>>> including a one byte transfer, can be transferred across the PCIe bus
>>> by memcpy_toio/fromio() or by DMA either as a single block or as
>>> linked-list. That is why, instead of deciding based on transfer size,
>>> this patch introduces the '-L' flag for pcitest to communicate the
>>> user intent across the PCIe bus to pci-epf-test so the endpoint can
>>> initiate the DMA transfer using a single block or in linked-list mode.
>> The -L option seems to select an internal DMA configuration which might be
>> specific to one implementation. As Gustavo already pointed, we should have only
>> generic options in pcitest. This would no longer be applicable when we move to
>> dmaengine.
> 
> Single-block DMA seemed as generic as linked-list DMA and
> memcpy_toio/fromio. It remains unclear how else to communicate that
> intent to pci_epf_test each time I invoke pcitest.
> 
> Regards,
> Alan
> 
