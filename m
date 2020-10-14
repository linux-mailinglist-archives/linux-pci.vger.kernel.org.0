Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42328E27C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgJNOuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 10:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgJNOuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 10:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED051D6E;
        Wed, 14 Oct 2020 07:50:02 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4960C3F71F;
        Wed, 14 Oct 2020 07:50:01 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
To:     Rob Herring <robh@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20201009155311.22d3caa5@xhacker.debian>
 <20201009155505.5a580ef5@xhacker.debian>
 <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
 <CAL_JsqLi09RTyiVLcyp1K4MNBggTvs3wqVqihpV2QhuePa3u9w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1f033749-6abe-b006-5e7e-276b02246056@arm.com>
Date:   Wed, 14 Oct 2020 15:49:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLi09RTyiVLcyp1K4MNBggTvs3wqVqihpV2QhuePa3u9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-10-14 15:15, Rob Herring wrote:
> On Mon, Oct 12, 2020 at 6:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-10-09 08:55, Jisheng Zhang wrote:
>>> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
>>> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
>>> may lose power during suspend-to-RAM, so when we resume, we want to
>>> redo the latter but not the former. If designware based driver (for
>>> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
>>> msi page will be leaked.
>>>
>>> As pointed out by Rob and Ard, there's no need to allocate a page for
>>> the MSI address, we could use an address in the driver data.
>>>
>>> To avoid map the MSI msg again during resume, we move the map MSI msg
>>> from dw_pcie_msi_init() to dw_pcie_host_init().
>>
>> You should move the unmap there as well. As soon as you know what the
>> relevant address would be if you *were* to do DMA to this location, then
>> the exercise is complete. Leaving it mapped for the lifetime of the
>> device in order to do not-DMA to it seems questionable (and represents
>> technically incorrect API usage without at least a sync_for_cpu call
>> before any other access to the data).
>>
>> Another point of note is that using streaming DMA mappings at all is a
>> bit fragile (regardless of this change). If the host controller itself
>> has a limited DMA mask relative to physical memory (which integrators
>> still seem to keep doing...) then you could end up punching your MSI
>> hole right in the middle of the SWIOTLB bounce buffer, where it's then
>> almost *guaranteed* to interfere with real DMA :(
> 
> Couldn't that happen with the current code too? alloc_page() isn't
> guaranteed to be DMA'able, right?

Indeed that's what I meant by "regardless of this change".

>> If no DWC users have that problem and the current code is working well
>> enough, then I see little reason not to make this partucular change to
>> tidy up the implementation, just bear in mind that there's always the
>> possibility of having to come back and change it yet again in future to
>> make it more robust. I had it in mind that this trick was done with a
>> coherent DMA allocation, which would be safe from addressing problems
>> but would need to be kept around for the lifetime of the device, but
>> maybe that was a different driver :/
> 
> Well, we're wasting 4K or 64K of memory and then leaking it is the
> main reason to change it.
> 
> We just need any address that's not memory which PCI could access. We
> could possibly just take the end of (outbound) PCI memory space. Note
> that the DWC driver never sets up inbound translations, so it's all
> 1:1 mapping (though upstream could have some translation).

Right, this patch is undeniably a better implementation of the existing 
approach, I just felt it worth pointing out that that approach itself 
has fundamental flaws which may or may not be relevant to some current 
and/or future users. I know for a fact that there are platforms which 
cripple their PCIe host bridge to 32-bit physical addressing but support 
having RAM above that; I don't *think* any of the ones I know of are 
using the dw_pcie driver, but hey, how much do I know? ;)

Robin.
