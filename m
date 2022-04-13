Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F64FF61D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiDML4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 07:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDML4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 07:56:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089D1240A4
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 04:54:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F051596;
        Wed, 13 Apr 2022 04:54:18 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A3F3F73B;
        Wed, 13 Apr 2022 04:54:15 -0700 (PDT)
Message-ID: <c4dba770-1449-322e-ea7b-387cfbeaceb6@arm.com>
Date:   Wed, 13 Apr 2022 12:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>,
        Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
References: <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
 <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
 <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p1>
 <20220411094744epcms2p152a3a161ce35835464b7e745dd86050a@epcms2p1>
 <YlQk/9hFnb+/TpHo@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YlQk/9hFnb+/TpHo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-04-11 13:54, Christoph Hellwig wrote:
> On Mon, Apr 11, 2022 at 06:47:44PM +0900, Wangseok Lee wrote:
>>>> ï¿½Therefore,ï¿½theï¿½dma_set_mask(32)(inï¿½dw_pcie_host_init())
>>>> ï¿½wasï¿½modifiedï¿½toï¿½beï¿½performedï¿½onlyï¿½when
>>>> ï¿½theï¿½dev-dma_maskï¿½isï¿½notï¿½setï¿½largerï¿½thanï¿½32ï¿½bits.
>>>
>>> Soï¿½whatï¿½setsï¿½dev->dma_maskï¿½toï¿½aï¿½largerï¿½thanï¿½32-bitï¿½valueï¿½here?
>>> Weï¿½needï¿½toï¿½findï¿½andï¿½fixï¿½that.
>>
>> At the code of of_dma_configure_id() of driver/of/device.c..
>> In the 64bit system, if the dma start addr is used as 0x1'0000'0000
>> and the size is used as 0xf'0000'0000, "u64 end" is 0xf'ffff'ffff.
>> And the dma_mask value is changed from 0xffff'ffff'ffff'ffff to
>> 0xf'ffff'ffffff due to the code below.
> 
> That does look rather wrong to me, as any limitation should only
> be in the bus mask.  Unless I'm missing something (and Robin should
> know the code much better than I do) we should do something like
> the patch below:

Yeah, there's some smelly history here... Originally, of_dma_configure() 
pre-set the masks as an attempt to impose any restriction represented by 
DT "dma-ranges" - the platform it was implemented in aid of happened to 
have a 31-bit DMA range, which may well have coloured some implicit 
assumptions. IIRC, when I first implemented the separate bus_dma_mask to 
properly solve the general constraint problem, I left the other 
mask-setting in place since even though it shouldn't have served any 
purpose any more, I figured it wasn't actively harmful, and by that 
point it had been around long enough that I was a little wary of opening 
a can of worms if anything *had* erroneously started relying on it.

I'm not against making the change now though - I'm about to get to the 
point of turning all the dma_configure stuff inside-out in the course of 
my IOMMU rework anyway, so I fully expect to be breaking things and 
picking up the pieces. Getting this in first so it's easily bisectable 
and leaves me less code to further break seems most sensible :)

If you're happy to write up the patch, please also do the equivalent for 
acpi_arch_dma_setup() too.

This is all orthogonal to why the original patch in this thread is 
wrong, though. If the pcie-designware driver could somehow guarantee 
that all endpoint functions present, or able to appear later, can handle 
MSI addresses of some width >32, then it could set its DMA mask for the 
fake DMA mapping accordingly, but that has nothing at all to do with how 
many address bits might happen to be wired up on the external AXI interface.

Robin.

> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 874f031442dc7..b197861fcde08 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -113,8 +113,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   {
>   	const struct iommu_ops *iommu;
>   	const struct bus_dma_region *map = NULL;
> -	u64 dma_start = 0;
> -	u64 mask, end, size = 0;
> +	u64 dma_start = 0, size = 0;
>   	bool coherent;
>   	int ret;
>   
> @@ -156,6 +155,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   			kfree(map);
>   			return -EINVAL;
>   		}
> +
> +		dev->bus_dma_limit = dma_start + size - 1;
> +		dev->dma_range_map = map;
>   	}
>   
>   	/*
> @@ -169,25 +171,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   		dev->dma_mask = &dev->coherent_dma_mask;
>   	}
>   
> -	if (!size && dev->coherent_dma_mask)
> -		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> -	else if (!size)
> -		size = 1ULL << 32;
> -
> -	/*
> -	 * Limit coherent and dma mask based on size and default mask
> -	 * set by the driver.
> -	 */
> -	end = dma_start + size - 1;
> -	mask = DMA_BIT_MASK(ilog2(end) + 1);
> -	dev->coherent_dma_mask &= mask;
> -	*dev->dma_mask &= mask;
> -	/* ...but only set bus limit and range map if we found valid dma-ranges earlier */
> -	if (!ret) {
> -		dev->bus_dma_limit = end;
> -		dev->dma_range_map = map;
> -	}
> -
>   	coherent = of_dma_is_coherent(np);
>   	dev_dbg(dev, "device is%sdma coherent\n",
>   		coherent ? " " : " not ");
