Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B06C1E7F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfI3JzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 05:55:25 -0400
Received: from foss.arm.com ([217.140.110.172]:50864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3JzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835C31000;
        Mon, 30 Sep 2019 02:55:24 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABDC83F739;
        Mon, 30 Sep 2019 02:55:21 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
To:     Thierry Reding <thierry.reding@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        linux-tegra@vger.kernel.org
References: <20190927002455.13169-1-robh@kernel.org>
 <CAK8P3a0oct0EOMi5t4BmpgdkiBM+LjC+2pTST4hcvNCa3MGLmw@mail.gmail.com>
 <20190930082055.GA21971@infradead.org> <20190930085606.GG1518582@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <89e33aae-bc96-53c3-2a4e-e879e9a3c73e@arm.com>
Date:   Mon, 30 Sep 2019 10:55:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930085606.GG1518582@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-09-30 9:56 am, Thierry Reding wrote:
> On Mon, Sep 30, 2019 at 01:20:55AM -0700, Christoph Hellwig wrote:
>> On Sun, Sep 29, 2019 at 01:16:20PM +0200, Arnd Bergmann wrote:
>>> On a semi-related note, Thierry asked about one aspect of the dma-ranges
>>> property recently, which is the behavior of dma_set_mask() and related
>>> functions when a driver sets a mask that is larger than the memory
>>> area in the bus-ranges but smaller than the available physical RAM.
>>> As I understood Thierry's problem and the current code, the generic
>>> dma_set_mask() will either reject the new mask entirely or override
>>> the mask set by of_dma_configure, but it fails to set a correct mask
>>> within the limitations of the parent bus in this case.
>>
>> There days dma_set_mask will only reject a mask if it is too small
>> to be supported by the hardware.  Larger than required masks are now
>> always accepted.
> 
> Summarizing why this came up: the memory subsystem on Tegra194 has a
> mechanism controlled by bit 39 of physical addresses. This is used to
> support two variants of sector ordering for block linear formats. The
> GPU uses a slightly different ordering than other MSS clients, so the
> drivers have to set this bit depending on who they interoperate with.
> 
> I was running into this as I was adding support for IOMMU support for
> the Ethernet controller on Tegra194. The controller has a HW feature
> register that contains how many address bits it supports. This is 40
> for Tegra194, corresponding to the number of address bits to the MSS.
> Without IOMMU support that's not a problem because there are no systems
> with 40 bits of system memory. However, if we enable IOMMU support, the
> DMA/IOMMU code will allocate from the top of a 48-bit (constrained to
> 40 bits via the DMA mask) input address space. This causes bit 39 to be
> set, which in turn will make the MSS reorder sectors and break network
> communications.
> 
> Since this reordering takes place at the MSS level, this applies to all
> MSS clients. Most of these clients always want bit 39 to be 0, whereas
> the clients that can and want to make use of the reordering always want
> bit 39 to be under their control, so they can control in a fine-grained
> way when to set it.
> 
> This means that effectively all MSS clients can only address 39 bits, so
> instead of hard-coding that for each driver I thought it'd make sense to
> have a central place to configure this, so that all devices by default
> are restricted to 39-bit addressing. However, with the current DMA API
> implementation this causes a problem because the default 39-bit DMA mask
> would get overwritten by the driver (as in the example of the Ethernet
> controller setting a 40-bit DMA mask because that's what the hardware
> supports).
> 
> I realize that this is somewhat exotic. On one hand it is correct for a
> driver to say that the hardware supports 40-bit addressing (i.e. the
> Ethernet controller can address bit 39), but from a system integration
> point of view, using bit 39 is wrong, except in a very restricted set of
> cases.
> 
> If I understand correctly, describing this with a dma-ranges property is
> the right thing to do, but it wouldn't work with the current
> implementation because drivers can still override a lower DMA mask with
> a higher one.

But that sounds like exactly the situation for which we introduced 
bus_dma_mask. If "dma-ranges" is found, then we should initialise that 
to reflect the limitation. Drivers may subsequently set a larger mask 
based on what the device is natively capable of, but the DMA API 
internals should quietly clamp that down to the bus mask wherever it 
matters.

Since that change, the initial value of dma_mask and coherent_dma_mask 
doesn't really matter much, as we expect drivers to reset them anyway 
(and in general they have to be able to enlarge them from a 32-bit 
default value).

As far as I'm aware this has been working fine (albeit in equivalent 
ACPI form) for at least one SoC with 64-bit device masks, a 48-bit 
IOMMU, and a 44-bit interconnect in between - indeed if I avoid 
distraction long enough to set up the big new box under my desk, the 
sending of future emails will depend on it ;)

Robin.
