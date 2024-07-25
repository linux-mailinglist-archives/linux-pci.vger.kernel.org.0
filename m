Return-Path: <linux-pci+bounces-10778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD093BDD8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EB81F21568
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323C167D8C;
	Thu, 25 Jul 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNB1meIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D11CD11;
	Thu, 25 Jul 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895603; cv=none; b=PBfq0AcHuldGaZgyLbPzwwq0VwsBXmLsbvfpdRDoFKpSxVvJkpucgtoc6pMvfO4qOa6gzclu1GzvbrURVhU0Wbgkn8dygLqD6WtHLQiazVP4IQMHRmOzPuD9fPDc0KD/gGjUNEFj1WOgy3R88yPk9M+ZbjheIsU2Ngy4u33YA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895603; c=relaxed/simple;
	bh=d3PTHMtxj6MV7zGofEm7wAsMBTJGxFfpiR1Uwd+ay0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKT6+nQSJCi/8KVebyzbokSrTi4SLhNk0CDJnYNkdMHV9P8xKxgvruoJRq73tHLo3zXTtwCT0EV1Ah5vkgHBWhflQHnF+tJ2vhlyMzXAc1ZVLsC3At4rfbzLuYTKoXmTcE0eS5NDpdWonc46DxsCN/s12HqAUMZpUFgo7qjLULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNB1meIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9742FC116B1;
	Thu, 25 Jul 2024 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721895603;
	bh=d3PTHMtxj6MV7zGofEm7wAsMBTJGxFfpiR1Uwd+ay0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNB1meIt97IzzHXbWk8omMFCyioOmmWbp2I+W0Pb3tMmG3MSz1Y2pnaxCzFqRAZrn
	 tpnuJ4SgFsa73AlWacob32FEJDwOlOszXZmMTB0Fe84Z+F7Zpa1ewr+STgdZG/CBaZ
	 I+G7QBGG7TTdedBPOhH87gvmVMsPRYMJ0e/vJU6Gzhz4kcashXfSEgRBkKrfSk7GR8
	 YaLxy/9pzfyAqZ5jSV2hUG5dt3C9uCxAbeZyzZft9Ix4sgqLjU3J7YJBrydFhu9wCL
	 ljLEJkHlVg7gHaQBMwdSbgCHLr1n+/FOXBcXgm9rGXL4mPSzTeuegdHgXD7Kv2KSbg
	 iP5OZCunTHz2w==
Message-ID: <04b1ceb2-538e-4b1b-be5c-5a81d7a457ad@kernel.org>
Date: Thu, 25 Jul 2024 17:20:00 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, rick.wertenbroek@heig-vd.ch,
 alberto.dassatti@heig-vd.ch, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/24 17:06, Rick Wertenbroek wrote:
> On Thu, Jul 25, 2024 at 7:33 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
>>> Hello Rick,
>>>
>>> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
>>>>>
>>>>> But like you suggested in the other mail, the right thing is to merge
>>>>> alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
>>>>> currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
>>>>> instead.)
>>>>>
>>>>
>>>> Yes, if we merge both, the code will need to be in the EPC code
>>>> (because of the set_bar), and then the pci_epf_alloc_space (if needed)
>>>> would be called internally in the EPC code and not in the endpoint
>>>> function code.
>>>>
>>>> The only downside, as I said in my other mail, is the very niche case
>>>> where the contents of a BAR should be moved and remain unchanged when
>>>> rebinding a given endpoint function from one controller to another.
>>>> But this is not expected in any endpoint function currently, and with
>>>> the new changes, the endpoint could simply copy the BAR contents to a
>>>> local buffer and then set the contents in the BAR of the new
>>>> controller.
>>>> Anyways, probably no one is moving live functions between controllers,
>>>> and if needed it still can be done, so no problem here...
>>>
>>> I think we need to wait for Mani's opinion, but I've never heard of anyone
>>> doing so, and I agree with your suggested feature to copy the BAR contents
>>> in case anyone actually changes the backing EPC controller to an EPF.
>>> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
>>>
>>
>> Hi Rick/Niklas,
>>
>> TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
>> we do not need to worry until the actual requirement comes.
>>
>> But I really like combining alloc() and set_bar() APIs. Something I wanted to do
>> for so long but never got around to it. We can use the API name something like
>> pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
>> have it to align with existing APIs.
>>
>> And regarding the implementation, the use of fixed address for BAR is not new.
>> If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
>> location that is derived from the controller DT node (MMIO region).
>>
>> But I was thinking of moving this region to EPF node once we add DT support for
>> EPF driver. Because, there can be many EPFs in a single endpoint and each can
>> have upto 6 BARs. We cannot really describe each resource in the controller DT
>> node.
>>
>> Given that you really have a usecase now for multiple BARs, I think it is best
>> if we can add DT support for the EPF drivers and describe the BAR resources in
>> each EPF node. With that, we can hide all the resource allocation within the EPC
>> core without exposing any flag to the EPF drivers.
>>
>> So if the EPF node has a fixed location for BAR and defined in DT, then the new
>> API pci_epf_alloc_set_bar() API will use that address and configure it
>> accordingly. If not, it will just call pci_epf_alloc_space() internally to
>> allocate the memory from coherent region and use it.
>>
>> Wdyt?
>>
>> - Mani
>>
>> --
>> மணிவண்ணன் சதாசிவம்
> 
> Hello Mani, thank you for your feedback.
> 
> I don't know if the EPF node in the DT is the right place for the
> following reasons. First, it describes the requirements of the EPF and
> not the restrictions imposed by the EPC (so for example one function
> requires the BAR to use a given physical address and this is described
> in the DT EPF node, but the controller could use any address, it just
> configures the controller to use the address the EPF wants, but in the
> other case (e.g., on FPGA), the EPC can only handle a BAR at a given
> physical address and no other address so this should be in the EPC
> node). Second, it is very static, so the EPC relation EPF would be
> bound in the DT, I prefer being able to bind-unbind from configfs so
> that I can make changes without reboot (e.g., alternate between two or
> more endpoint functions, which may have different BAR requirements and
> configurations).
> 
> For the EPFs I really think it is good to keep the BAR requirements in
> the code for the moment, this makes it easier to swap endpoint
> functions and makes development easier as well (e.g., binding several
> different EPFs without reboot of the SoC they run on. In my typical
> tests I bind one function, turn-on the host, do tests, turn-off the
> host, make changes to an EPF, scp the new .ko on the SoC, rebind,
> turn-on the host, etc.). For example, I alternate between pci-epf-test
> (6 bars) and pci-epf-nvme (1 bar) of different sizes.
> 
> However, I can see a world where both binding and configuring EPF from
> DT and the way it is currently done (alloc/set bar in code) and bind
> in configfs could exist together as each have their use cases. But
> forcing the use of DT seems impractical.

I do not think using DT for configuring an EPF *ever* make sense. An init script
on the EP platform can take care of whatever needs to be configured. DT is for
and should be restricted to describing the HW, not things that can be configured
at runtime using the HW information.

Doing it this way also makes the EPF code independent on the platform. E.g. if
we ever add an EPF node in the DT, that same EPF would not work on an endpoint
capable platform using UEFI. That is not acceptable for HW generic EPFs (e.g.
nvme, virtio, etc).

-- 
Damien Le Moal
Western Digital Research


