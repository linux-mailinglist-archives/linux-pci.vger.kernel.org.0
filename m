Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95110449CC2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 20:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhKHUA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 15:00:26 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:59917 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbhKHUA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 15:00:26 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id kAlwmHF3cOvR0kAlwmre4l; Mon, 08 Nov 2021 20:57:40 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 08 Nov 2021 20:57:40 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] PCI: xgene-msi: Use bitmap_zalloc() when applicable
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
 <YYb1RXjnXSV8xF/0@rocinante>
 <bd57f9db-e1a5-c2a6-3523-b3c0ad086759@wanadoo.fr>
 <YYh1vrNCavFKuskW@rocinante>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <2ee153cc-961e-abaf-2c02-a15b4c0b7986@wanadoo.fr>
Date:   Mon, 8 Nov 2021 20:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYh1vrNCavFKuskW@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 08/11/2021 à 01:56, Krzysztof Wilczyński a écrit :
> Hi Christophe!
> 
> [...]
>>> I believe, after having a brief look, that we might have a few other
>>> candidates that we could also update:
>>>
>>>     drivers/pci/controller/dwc/pcie-designware-ep.c
>>>     717:	ep->ib_window_map = devm_kcalloc(dev,
>>>     724:	ep->ob_window_map = devm_kcalloc(dev,
>>>     drivers/pci/controller/pcie-iproc-msi.c
>>>     592:	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
>>>     drivers/pci/controller/pcie-xilinx-nwl.c
>>>     470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
>>>     567:	msi->bitmap = kzalloc(size, GFP_KERNEL);
>>>     637:	msi->bitmap = NULL;
>>>     drivers/pci/controller/pcie-iproc-msi.c
>>>     262:	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
>>>     290:	bitmap_release_region(msi->bitmap, hwirq,
>>>     drivers/pci/controller/pcie-xilinx-nwl.c
>>>     470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
>>>     494:	bitmap_release_region(msi->bitmap, data->hwirq,
>>>     drivers/pci/controller/pcie-brcmstb.c
>>>     537:	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
>>>     546:	bitmap_release_region(&msi->used, hwirq, 0);
>>>     drivers/pci/controller/pcie-xilinx.c
>>>     240:	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
>>>     263:	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));
>>>
>>> Some of the above could also potentially benefit from being converted to
>>> use the DECLARE_BITMAP() macro to create the bitmap that is then being
>>> embedded into some struct used to capture details and state, rather than
>>> store a pointer to later allocate memory dynamically.  Some controller
>>> drivers already do this, so we could convert rest where appropriate.
>>>
>>> What do you think?
>>
>> Hi,
>>
>> my first goal was to simplify code that was not already spotted by a cocci
>> script proposed by Joe Perches (see [1]).
> 
> Ahh, OK.  I didn't know that Joe worked on adding new Coccinelle script to
> deal with the bitmap allocations and such.  I assumed you did some code
> review and found some issues.
> 
> I had a quick look at what the Coccinelle script found, and it seems I have
> missed when I did some search on my own:
> 
>    drivers/pci/controller/pcie-rcar-ep.c
> 
>> I'll give a closer look at the opportunities spotted by Joe if they have not
>> already been fixed in the meantime.
> 
> As per the thread you linked to, I can see that neither the new Coccinelle
> script nor the changes from Joe were accepted yet, or I couldn't see
> anything yet (at least not in the PCI tree).

No patch has been proposed yet, only the script and its output has been 
sent on @kernel-janitor.

There was also a discussion about the need to update the corresponding 
kfree() into bitmap_free() to keep consistency.
Doing it with coccinelle could be challenging.

devm_ function are not impacted, but for the others, it can be more 
tricky and would likely need manual update.

CJ

> 
>> Concerning the use of DECLARE_BITMAP instead of alloc/free memory, it can be
>> more tricky to spot it. Will try to give a look at it.
> 
> A lot more code to read, indeed.  However, the benefits are quite nice:
> simpler code, easier error handling and reducing probability of leaking
> memory.
> 
> I think, a lot of the drivers we have in our tree could (and a lot already
> do) leverage the DECLARE_BITMAP() macro reserving space during build time
> over dealing with memory allocations and such.
> 
>>> We also have this nudge from Coverity that we could fix, as per:
>>>
>>>     532 static int brcm_msi_alloc(struct brcm_msi *msi)
>>>     533 {
>>>     534         int hwirq;
>>>     535
>>>     536         mutex_lock(&msi->lock);
>>>         1. address_of: Taking address with &msi->used yields a singleton pointer.
>>>         CID 1468487 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_find_free_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
>>>     537         hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
>>>     538         mutex_unlock(&msi->lock);
>>>     539
>>>     540         return hwirq;
>>>     541 }
>>>     543 static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
>>>     544 {
>>>     545         mutex_lock(&msi->lock);
>>>         1. address_of: Taking address with &msi->used yields a singleton pointer.
>>>         CID 1468424 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_release_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
>>>     546         bitmap_release_region(&msi->used, hwirq, 0);
>>>     547         mutex_unlock(&msi->lock);
>>>     548 }
>>>
>>> We could look at addressing this too at the same time.
>>
>> I'll give it a look.
> 
> Thank you!
> 
> 	Krzysztof
> 

