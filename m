Return-Path: <linux-pci+bounces-10765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694A93BC8A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A971BB220FE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91A41A80;
	Thu, 25 Jul 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5qlaLHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FA1CD24;
	Thu, 25 Jul 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889060; cv=none; b=N74w9g70krq+Wqcb5u+ubWiqHYQoei17BcCoPc9jpt8HGdgHeSw4hjcxDjW4IDZyFrVlmeqH+xuUz1DTIcCJvGvufSmuGeuLlZrzE268N5mstFS58+0/dPDaC2F1TIDntlTN+2gynvMrw7O6gQVvWRIfQ2/Za6zcL5Gq3vpMbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889060; c=relaxed/simple;
	bh=c+5vHyrEq33fJEL+MBexg9YzD+yqqTLHP8EpABhR9qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAntLMBR6+fWDflxPX2nHgY8Ret7G0gH/sCFvVP6LZo4Tfnr7+a71H4kiZn0GsYUtLUHoCR721X6l935fWOGRZiB+wQKBQ9k8WLJfZJrreZ7m5Zo/lgBPxgLRviTfQe88J/6itzUTnPJW9dSgz7msApohcNGVY5U0TJVR9iGsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5qlaLHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E370C116B1;
	Thu, 25 Jul 2024 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721889060;
	bh=c+5vHyrEq33fJEL+MBexg9YzD+yqqTLHP8EpABhR9qM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I5qlaLHI2BIAWBXXrX6nnM/vhd3JtieaQxgGsqixQyC5MTCaD2JT9k48j5v7Ha2dc
	 F9s6GMIRBVSPcr7jwP4mVpIq90+Ca/Vp/ntKXjocgvw2pSHF38Sk34FtDpLKkxmLHp
	 StNwvpyufHu1UXovEkjBv3hJDjx/i4NgNvbuW9q6L5x5tpj1Zz6IxwPHIwe2vyPTJj
	 sRl8umaQEpd9T5SSE+n4ALjVb0oW0JUUrkz7eQDV1R9s0DjjDyq7tUf0pd0CpdIRSP
	 8hEPGQBLq3lSfocXAEbd7lKMqReCU7eZ5rddlwXLCu/ed9Nhcx5b9JTqHBHD8QXwsd
	 5fXLtVq0VOWOQ==
Message-ID: <b2dab6f8-8d95-4055-8960-d2dabb5cf98d@kernel.org>
Date: Thu, 25 Jul 2024 15:30:57 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240725053348.GN2317@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 14:33, Manivannan Sadhasivam wrote:
> On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
>> Hello Rick,
>>
>> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
>>>>
>>>> But like you suggested in the other mail, the right thing is to merge
>>>> alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
>>>> currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
>>>> instead.)
>>>>
>>>
>>> Yes, if we merge both, the code will need to be in the EPC code
>>> (because of the set_bar), and then the pci_epf_alloc_space (if needed)
>>> would be called internally in the EPC code and not in the endpoint
>>> function code.
>>>
>>> The only downside, as I said in my other mail, is the very niche case
>>> where the contents of a BAR should be moved and remain unchanged when
>>> rebinding a given endpoint function from one controller to another.
>>> But this is not expected in any endpoint function currently, and with
>>> the new changes, the endpoint could simply copy the BAR contents to a
>>> local buffer and then set the contents in the BAR of the new
>>> controller.
>>> Anyways, probably no one is moving live functions between controllers,
>>> and if needed it still can be done, so no problem here...
>>
>> I think we need to wait for Mani's opinion, but I've never heard of anyone
>> doing so, and I agree with your suggested feature to copy the BAR contents
>> in case anyone actually changes the backing EPC controller to an EPF.
>> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
>>
> 
> Hi Rick/Niklas,
> 
> TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
> we do not need to worry until the actual requirement comes.
> 
> But I really like combining alloc() and set_bar() APIs. Something I wanted to do
> for so long but never got around to it. We can use the API name something like
> pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
> have it to align with existing APIs.
> 
> And regarding the implementation, the use of fixed address for BAR is not new.
> If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
> location that is derived from the controller DT node (MMIO region).
> 
> But I was thinking of moving this region to EPF node once we add DT support for
> EPF driver. Because, there can be many EPFs in a single endpoint and each can
> have upto 6 BARs. We cannot really describe each resource in the controller DT
> node.
> 
> Given that you really have a usecase now for multiple BARs, I think it is best
> if we can add DT support for the EPF drivers and describe the BAR resources in
> each EPF node. With that, we can hide all the resource allocation within the EPC
> core without exposing any flag to the EPF drivers.
> 
> So if the EPF node has a fixed location for BAR and defined in DT, then the new
> API pci_epf_alloc_set_bar() API will use that address and configure it
> accordingly. If not, it will just call pci_epf_alloc_space() internally to
> allocate the memory from coherent region and use it.

EPF node ? Did you perhaps mean EPC node ?
Using DT for endpoint functions is nonsense in my opinion: if something needs to
be configured, an epf has the configfs interface to get the information it may
need. And forcing EPF to have DT node is not scalable anyway.

So assuming you meant EPC, I am not sure if defining a fixed bar address in the
DT works for all cases. E.g. said address may depend on other hardware on the
platform (ex: memory nodes). So the ->get_bar() EPC operation that Rick is
proposing makes a lot more sense to me and will can be scaled to many many
configurations. Given that the EPF will (indirectly) call that operation, some
epf dependent parameters could even be passed.

And I agree (I think we all do) that combing alloc bar and get bar under a
single API is a lot cleaner. Though I am not a big fan of the name
pci_epc_alloc_set_bar() as it implies an allocation, which may not be the case
for fixed bars. So a simpler and more generic name like pci_epf_set_bar(),
pci_epf_init_bar(), pci_epf_config_bar()... would be way better in my opinion.


-- 
Damien Le Moal
Western Digital Research


