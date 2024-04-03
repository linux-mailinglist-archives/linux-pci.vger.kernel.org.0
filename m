Return-Path: <linux-pci+bounces-5594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D685896751
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E31F24A91
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E15D73D;
	Wed,  3 Apr 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWTzfv1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D687286A6;
	Wed,  3 Apr 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130876; cv=none; b=fBt8gtPXrZdRh8cE5a596YXEtE5eNPwq7Fu1arp4S0VYbmeehAtvz5hnxim+LY2pQpQGV4Dx4Zh19Ob7EgZwM3qU64pB3PUxjZ+8W+xs3LsLinwWVr6T6gROzhDDgmDtFRQCrqVgBTjO/RxD0ogFKzOJUFiCpqXU2U3nlrqnCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130876; c=relaxed/simple;
	bh=ohHul4K7Pgm4EOjX61t9xdDjDL1x620XVzPfPILMOrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofajgHG7+DJrNf4jLlGmn+LeSl1/mUbcKFkkH11AVzWQ6lBTUDSspZsgESLyauAXT8u7OaxHKY0htpnblIWUNQvAiNZ4uWa3UMqwNJG9PtYwconqIm/f6LWHMVhRdDE8qUfjTbdAoGE8TisrfMGbKInP354RFH7PqMsEHWwg4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWTzfv1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E62C433F1;
	Wed,  3 Apr 2024 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712130876;
	bh=ohHul4K7Pgm4EOjX61t9xdDjDL1x620XVzPfPILMOrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qWTzfv1/yq5V8VS0HIJBVsUeGbKPBMh22QdR9lqj8ZG9TEqNxsqOmBG/8g2BFwKV2
	 jzh6U242LWI4ZxItIs/0qnwNhszOwfGeCcgnfaFHPmLVEMPFOnuQFJdtTCzPp+mWZ0
	 Vy0hX8NoGsYMPipG11vJ/3TG/wHjQm08Yj0uDKRGd5WK9Y9L3sKMYqc617T1XV+efV
	 5puQ5S/WfbWBcDyQoYRLMrsPAIWNlkTABKUJzO76n8rVJmFyNw2BvHWWvqZWUb8tCX
	 TEe7MSutEYEaVvtxCWoiHvH/5LIxn7yVTn25CB+79B/3YXQQSbutjPlcKEXjUH7ACK
	 o8YJEzHccVDcg==
Message-ID: <eb580d64-1110-479a-9a0b-c2f1eacd23e7@kernel.org>
Date: Wed, 3 Apr 2024 16:54:32 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] PCI: endpoint: Introduce pci_epc_map_align()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-3-dlemoal@kernel.org>
 <20240403074520.GC25309@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240403074520.GC25309@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 16:45, Manivannan Sadhasivam wrote:
> On Sat, Mar 30, 2024 at 01:19:12PM +0900, Damien Le Moal wrote:
>> Some endpoint controllers have requirements on the alignment of the
>> controller physical memory address that must be used to map a RC PCI
>> address region. For instance, the rockchip endpoint controller uses
>> at most the lower 20 bits of a physical memory address region as the
>> lower bits of an RC PCI address. For mapping a PCI address region of
>> size bytes starting from pci_addr, the exact number of address bits
>> used is the number of address bits changing in the address range
>> [pci_addr..pci_addr + size - 1].
>>
>> For this example, this creates the following constraints:
>> 1) The offset into the controller physical memory allocated for a
>>    mapping depends on the mapping size *and* the starting PCI address
>>    for the mapping.
>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>>    the offset needed into the allocated physical memory, which can end
>>    up being a smaller size than the desired mapping size.
>>
>> Handling these constraints independently of the controller being used in
>> a PCI EP function driver is not possible with the current EPC API as
>> it only provides the ->align field in struct pci_epc_features.
>> Furthermore, this alignment is static and does not depend on a mapping
>> pci address and size.
>>
>> Solve this by introducing the function pci_epc_map_align() and the
>> endpoint controller operation ->map_align to allow endpoint function
>> drivers to obtain the size and the offset into a controller address
>> region that must be used to map an RC PCI address region. The size
>> of the physical address region provided by pci_epc_map_align() can then
>> be used as the size argument for the function pci_epc_mem_alloc_addr().
>> The offset into the allocated controller memory can be used to
>> correctly handle data transfers. Of note is that pci_epc_map_align() may
>> indicate upon return a mapping size that is smaller (but not 0) than the
>> requested PCI address region size. For such case, an endpoint function
>> driver must handle data transfers in fragments.
>>
> 
> Is there any incentive in exposing pci_epc_map_align()? I mean, why can't it be
> hidden inside the new alloc() API itself?

I could drop pci_epc_map_align(), but the idea here was to have an API that is
not restrictive. E.g., a function driver could allocate memory, keep it and
repetedly use map_align and map() function to remap it to different PCI
addresses. With your suggestion, that would not be possible.

> 
> Furthermore, is it possible to avoid the map_align() callback and handle the
> alignment within the EPC driver?

I am not so sure that this is possible because handling the alignment can
potentially result in changing the amount of memory to allocate, based on the
PCI address also. So the allocation API would need to change, a lot.

>> +	/*
>> +	 * Assume a fixed alignment constraint as specified by the controller
>> +	 * features.
>> +	 */
>> +	features = pci_epc_get_features(epc, func_no, vfunc_no);
>> +	if (!features || !features->align) {
>> +		map->map_pci_addr = pci_addr;
>> +		map->map_size = size;
>> +		map->map_ofst = 0;
> 
> These values are overwritten anyway below.

Looks like "return" got dropped. Bug. Will re-add it.


-- 
Damien Le Moal
Western Digital Research


