Return-Path: <linux-pci+bounces-14395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4499B4B2
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CC280E5F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA961155759;
	Sat, 12 Oct 2024 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZyBpFzK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226C15C0;
	Sat, 12 Oct 2024 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734566; cv=none; b=dueTORSQGqOcjdeqY47vS781Iz/KhbNnHsPPY8FmSLdQ8xVI6MhVCrHZSadAhfHG0UenmXGBw+1cyNErEOa7ZuvL/jMAfC3cgWiDh2y+Vk90J56tcFS+pc3z9Dj8GkP4NJL6qPnvd9sj5KqPR5mfjka1nRVMrnUjPci/XSSfXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734566; c=relaxed/simple;
	bh=iBsRVLDpMR+KZSbI3gtf3MamOPTT2NshBNeVSlN779g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5f7jOB9gsm18Lacn23pngoL7BVLkxlGToSitE1GrtUClqVggi3a48JwjtrNiB2BK/ecaQand9+SHgJRbjYsDyjH+74Nfqw3sjFFFJUkLYrDqm6X6M5LbZKeyH+hKzdHiE5k6fHLrvfAHmxUokKyM3L/uLQNBgPqRoxxON2kHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZyBpFzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62978C4CEC7;
	Sat, 12 Oct 2024 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734566;
	bh=iBsRVLDpMR+KZSbI3gtf3MamOPTT2NshBNeVSlN779g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZyBpFzKfn5sRonlKanpV+X0uSE3V5lDsixB73OrsC9TmAXpMQChTwWD7+WOHuWxX
	 Vbb3fVoecg8bAT1CcSO3RZaMxW9wvZfpQ6hzpqLW7GBc8KvCxxs3XuyQM0VfLJXTSj
	 INdp/kbgKHAaGFzFJtIqS3n4ceJd0NrxH7W0SrNpQdHpQTY6hGpaUF/a9+3mi4RQO4
	 YkEVg6aaGi/xUp6CtDdNBgD0LkPYkkgxRZouFjmibYQhr2fGxSHKaoFy79hOc3xXh5
	 TE5+rZVr+IRDTNnYhUzMAcssxWE8lS6j0w3NvuyM9mi1yWmzxWNklpWRBX+g1byZJS
	 jPigtRZcEKGpA==
Message-ID: <b70c7850-1fd2-4267-aa18-5e944a0bf81d@kernel.org>
Date: Sat, 12 Oct 2024 21:02:43 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] PCI: rockchip-ep: Improve
 rockchip_pcie_ep_map_addr()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-5-dlemoal@kernel.org>
 <20241010071357.c3kck3rxdhvy6m67@thinkpad>
 <20241012093101.aj5hyeo3r7g6qlnn@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241012093101.aj5hyeo3r7g6qlnn@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/24 18:31, Manivannan Sadhasivam wrote:
> On Thu, Oct 10, 2024 at 12:43:57PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Oct 07, 2024 at 01:12:10PM +0900, Damien Le Moal wrote:
>>> Add a check to verify that the outbound region to be used for mapping an
>>> address is not already in use.
>>>
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
> 
> I'm trying to understand the ob window mapping here. So if rockchip_ob_region()
> returns same index for different *CPU* addresses, then you cannot map both of
> them? Is this a hardware ATU limitation?

The CPU addresses mapped are (under normal use) addresses from one of the 32 1MB
memory windows that pci_epc_alloc_addr() will give us. To map a memory window
address, we use the ATU entry at the index given by:

static inline u32 rockchip_ob_region(phys_addr_t addr)
{
        return (addr >> ilog2(SZ_1M)) & 0x1f;
}

So each memory window always use the same ATU entry and addresses from different
windows cannot use the same entry, ever.

But if there is a bug in the endpoint driver and map() or unmap() are called
with an invalid address (e.g. one that is not from a memory window), we will
still get a valid ATU entry number for that address. Hence the check that the
address passed to unmap is the one that is actually mapped, and also why we
check that the entry for an address to map is not being used.

> Also rockchip_pcie_prog_ep_ob_atu() is not taking into account of the cpu_addr.
> So I'm not sure how the mapping happens either.

Each ATU entry is for the corresponding memory window at the same index in the
controller memory. So the cpu address is not needed when programming the ATU as
it is implied from the entry we are programming.

So we could remove the cpu_addr argument of this function.

I also suspect that we potentially could play games with the .align_addr() to
assume a fixed 1MB alignment constraint for a PCI address mapping and always
pass 20 to the num_bits field of the ADDR0 register. However, I have not tried that.

-- 
Damien Le Moal
Western Digital Research

