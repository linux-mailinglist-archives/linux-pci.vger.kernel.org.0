Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE9BF4AF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfIZOJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 10:09:15 -0400
Received: from ns.iliad.fr ([212.27.33.1]:50522 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfIZOJP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 10:09:15 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id CE80420554;
        Thu, 26 Sep 2019 16:09:13 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 2F6002040A;
        Thu, 26 Sep 2019 16:09:13 +0200 (CEST)
Subject: Re: [PATCH 00/11] PCI dma-ranges parsing consolidation
To:     Andrew Murray <andrew.murray@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mans Rullgard <mans@mansr.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190926084859.GB9720@e119886-lin.cambridge.arm.com>
 <036f298c-c65c-7da2-92dc-fc80892672c1@free.fr>
 <CAL_JsqLtYYXCgGN6_t8SuPqPmQwhhRJXaf8+kxnKxLHbRQRaDQ@mail.gmail.com>
 <20190926133849.GF9720@e119886-lin.cambridge.arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <407c0073-3694-6cce-0619-1f0ae3a55ed6@free.fr>
Date:   Thu, 26 Sep 2019 16:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926133849.GF9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Sep 26 16:09:13 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/2019 15:38, Andrew Murray wrote:

> On Thu, Sep 26, 2019 at 08:11:16AM -0500, Rob Herring wrote:
>
>> On Thu, Sep 26, 2019 at 6:20 AM Marc Gonzalez wrote:
>>>
>>> On 26/09/2019 10:49, Andrew Murray wrote:
>>>
>>>> On Tue, Sep 24, 2019 at 04:46:19PM -0500, Rob Herring wrote:
>>>>
>>>>> pci-rcar-gen2 is the only remaining driver doing its own dma-ranges
>>>>> handling as it is still using the old ARM PCI functions. Looks like it
>>>>> is the last one (in drivers/pci/).
>>>>
>>>> It also seems that pcie-tango is using of_pci_dma_range_parser_init
>>>> and so parsing dma-ranges. Though it's using the dma_ranges for a
>>>> slightly different purpose.
>>
>> Seems I missed that as I only grep'ed for for_each_of_pci_range...
>>
>>> The rationale for that code can be found here:
>>>
>>>         https://patchwork.kernel.org/patch/9915469/
>>>
>>> NB: 1) The PCIE_TANGO_SMP8759 Kconfig symbol is marked "depends on BROKEN",
>>> and 2) The driver adds TAINT_CRAP,
>>> and 3) The maker of the tango platform is dead.
> 
> Thanks for the context Marc, much appreciated.
> 
> Is there a path to make this driver not BROKEN? Or is this likely to bit rot?

It is not the device driver that is BROKEN, it is the device being driven ;-)

I don't know how many smp8759 boards exist in the wild. Mans might have one.
I didn't keep mine.

Regards.
