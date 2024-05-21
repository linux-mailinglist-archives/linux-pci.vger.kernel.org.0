Return-Path: <linux-pci+bounces-7719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12C8CB039
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01D11C20859
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D2128376;
	Tue, 21 May 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O18sUH7C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8F128372;
	Tue, 21 May 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301165; cv=none; b=tRxi6171C92ZL46jCydstaeQzeDwwtJwbzSeep6v0xQa9jCfg7RioobhnfdOfuV1zy9hyK9uKeVmBk+YpQ3lWBLXesqiMebXtqGZDPn3J7tAoGIU4QABSB+Cb/AJipAhGbxj5DkgcEsNaJUxSqUVaofuokjf81JAv+mkVFzJGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301165; c=relaxed/simple;
	bh=a99dFJz0zAqNSJJLTt4AqoroUPKj1Nnsd1gHD1g7ONQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNxqUG2hNVHxpgQv8wx5Pe3aUH0FlsQahvCx+BPBcGpw2s6zFBziv/XQQBlVmoRaMCPk0AcAtQKDWp5M1ZiJ7eJQ4a8prPi1uXP2mfskVL8UHwDROpSU0mA0Ub5lyX1wMBiVeLDHAuttialcediqRp1LApiYxkCGY1WikiT4hOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O18sUH7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453EAC2BD11;
	Tue, 21 May 2024 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301164;
	bh=a99dFJz0zAqNSJJLTt4AqoroUPKj1Nnsd1gHD1g7ONQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O18sUH7Ckp21o3/gg6nsbYDJcDNcGXZ+dOkLFZMa3RWgLIQVBg9hCgInaXzcFhWEb
	 sUpC45PIsSObf3/X66uYM7cgJp0yXcI2hjZlIZBHz3IOZ+0FDfTEnaDGluDYZlDRC7
	 4cKsDeMtDvjTLvJHFE4IW2yfVUanD9F6UBKPnE/EkqekymhsYO7+lgPMYorDlo0F96
	 Tx7wc+dyZJJCURZnGeex4AUF40ppkw4nj/uckVCshlyGF97IUHbQYiMVRiLdIqBUs0
	 to2KrjEnbgDK6xB2rGh66YWUGerADUn5uXUnw5+owVvkftGc+u8zwhkjV1zkLaDjl+
	 MzMKXnO8yyULQ==
Message-ID: <b7a5e9c2-d2b3-4c99-8628-f48581f5d1ad@kernel.org>
Date: Tue, 21 May 2024 16:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 bhelgaas@google.com, mani@kernel.org, Frank Li <Frank.Li@nxp.com>,
 imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, robh@kernel.org
References: <20240521141431.GA25673@bhelgaas>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240521141431.GA25673@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/21 16:14, Bjorn Helgaas wrote:
> On Tue, May 21, 2024 at 12:16:55PM +0200, Niklas Cassel wrote:
>> On Sat, May 18, 2024 at 02:06:50AM +0900, Krzysztof Wilczyński wrote:
>>> Hello,
>>>
>>>> When PERST# assert and deassert happens on the PERST# supported platforms,
>>>> the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
>>>> to the area that was previously allocated (iATU0) for BAR0, instead of the
>>>> new area (iATU6) for BAR0.
>>>>
>>>> Right now, we dodge the bullet because both iATU0 and iATU6 should
>>>> currently translate inbound accesses to BAR0 to the same allocated memory
>>>> area. However, having two separate inbound mappings for the same BAR is a
>>>> disaster waiting to happen.
>>>>
>>>> The mapping between PCI BAR and iATU inbound window are maintained in the
>>>> dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
>>>> a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
>>>> of the existing mapping in the array and if it is not found (i.e., value in
>>>> the array indexed by the BAR is found to be 0), then it will allocate a new
>>>> map value using find_first_zero_bit().
>>>>
>>>> The issue here is, the existing logic failed to consider the fact that the
>>>> map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
>>>> will return '0' as the map value for BAR0 (note that it returns the first
>>>> zero bit position).
>>>>
>>>> Due to this, when PERST# assert + deassert happens on the PERST# supported
>>>> platforms, the inbound window allocation restarts from BAR0 and the
>>>> existing logic to find the BAR mapping will return '6' for BAR0 instead of
>>>> '0' due to the fact that it considers '0' as an invalid map value.
>>>>
>>>> So fix this issue by always incrementing the map value before assigning to
>>>> bar_to_atu[] array and then decrementing it while fetching. This will make
>>>> sure that the map value '0' always represents the invalid mapping."
>>>
>>> Applied to controller/dwc, thank you!
>>>
>>> [1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
>>>       https://git.kernel.org/pci/pci/c/cd3c2f0fff46
>>>
>>> 	Krzysztof
>>
>> Hello PCI maintainers,
>>
>> There was a message sent out that this patch was applied, yet the patch does
>> not appear to be part of the pull request that was sent out yesterday:
>> https://lore.kernel.org/linux-pci/20240520222943.GA7973@bhelgaas/T/#u
>>
>> In fact, there seems to be many PCI patches that have been reviewed and ready
>> to be included (some of them for months) that is not part of the pull request.
>>
>> Looking at pci/next, these patches do not appear there either, so I assume
>> that these patches will also not be included in a follow-up pull request.
>>
>> Some of these patches are actual fixes, like the patch in $subject, and do not
>> appear to depend on any other patches, so what is the reason for not including
>> them in the PCI pull request?
> 
> The problem was that we didn't get these applied soon enough for them
> to get any time in linux-next before the merge window opened.  I don't
> like to add non-trivial things during the merge window, so I deferred
> most of these.  I plan to get them in linux-next as soon as v6.10-rc1
> is tagged.

We understand that, and we agree with this. However, the point was more about
WHY these patches were not applied earlier as many of them were fully reviewed
for several weeks. We have more patches to send out that depend on all these
deferred patches, and this deferring is delaying us as well. It would be great
if going forward, a more timely processing & applying of reviewed patches
happened. Thank you.

> 
> If we can make a case for post-merge window fixes, e.g., to fix a
> regression in the pull request or other serious issue, that's always a
> possibility.
> 
> Bjorn

-- 
Damien Le Moal
Western Digital Research


