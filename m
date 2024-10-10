Return-Path: <linux-pci+bounces-14168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF69980DF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823842832D5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CAE1BDA8F;
	Thu, 10 Oct 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXfIp7Ai"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103219AD73;
	Thu, 10 Oct 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549722; cv=none; b=Kd1f55qh2wPmS+sPdmiAztVdeIzfYmHuLN297+bzs2XUxIil4wuzgH/olpltSbcpmNk8UYrXUK3XvD5wZAAf6qEvLypAJjUuC+otjgYi2IMDGYlaW9Z0rVx3TVIU+o7mzqMr+0zTb7gZj5W3GpumSUJyhOcGqa8eV/ynQWW5rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549722; c=relaxed/simple;
	bh=yG2U03+rpXfeplBSeoqwKQhKM1LaYdj5AZHW2srLQHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfTSHbKB7dcj4hobB6dQrhr+bG7nqUlOnKUsRtLh5tuDOHDIHCCgMuGvctKFSepOIp5W3YK7OZN0kKotKw9nE/buZ0OqIF3Kj1SB8EkF89y/IK3twXyw5lrqyoZIVRU6TRocLrKoUJbqOwJ2G6JfpHMUAlNA0SPFMm7k73Uywfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXfIp7Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EAFC4CEC5;
	Thu, 10 Oct 2024 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728549722;
	bh=yG2U03+rpXfeplBSeoqwKQhKM1LaYdj5AZHW2srLQHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uXfIp7AiUnqRFFvN/a0zg4U5ytOL+ySRDHYP7LgsJ6kW7eH+qBHIRSeGcoH8bt25n
	 wde4j8WesAOWNo5DO2ElcrQWZyZsBvFdGHWdnoPINlfFv5S8Ha7R30QVEziQ8mIOKI
	 86AwUXBCyFoY873BCKkhVfZQxwzMhj00GvJvxKtVa2v9fs/8omTDCLYiqs7WClk/LM
	 YBqNQ5kiiYgKo7DDnTT43zKHkYFe+Y/TMsKXiummLBRSzb8MzruBPhk9llcp/IoH0D
	 8bkPQQ9DH7I1wJuhgsPpNztz5pHYuRySS6I5HqeqSlg+VHX+vildPMbr3KlY0f6Fal
	 9w2FOwkNrTjwA==
Message-ID: <016bb5a6-5f05-404c-acaf-e0a3ed6fcede@kernel.org>
Date: Thu, 10 Oct 2024 17:41:56 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] PCI: rockchip-ep: Fix address translation unit
 programming
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
 <20241007041218.157516-2-dlemoal@kernel.org>
 <20241010070242.3i2f53kpdpr4fgl6@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241010070242.3i2f53kpdpr4fgl6@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/10/10 16:02, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:07PM +0900, Damien Le Moal wrote:
>> The rockchip PCIe endpoint controller handles PCIe transfers addresses
>> by masking the lower bits of the programmed PCI address and using the
>> same number of lower bits masked from the CPU address space used for the
>> mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
>> the number of bits masked is the number of address bits changing in the
>> address range [pci_addr..pci_addr + size - 1].
>>
>> However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
>> using the size of the mapping, resulting in an incorrect number of mask
>> bits depending on the value of the PCI address to map.
>>
>> Fix this by introducing the helper function
>> rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
>> mask bits to use to program the address translation unit. The number of
>> mask bits iscalculated depending on both the PCI address and size of the
>> mapping, and clamped between 8 and 20 using the macros
>> ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS.
>>
> 
> How did you end up with these clamping values? Are the values (at least MAX
> applicable to all SoCs)?
> 
> Btw, it would be helpful if you referenced the TRM and the section that
> describes the outbound mapping. I'm able to find the reference:
> 
> Rockchip RK3399 TRM V1.3 Part2, Section 17.5.5.1.1

OK. Will add that.

I really appreciate very much all the reviews you are sending, but given that
this patch series depends on the series "[PATCH v4 0/7] Improve PCI memory
mapping API", could we start with that one and get it queued ASAP ?

Thanks !

-- 
Damien Le Moal
Western Digital Research

