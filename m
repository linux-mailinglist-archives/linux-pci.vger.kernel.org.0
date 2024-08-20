Return-Path: <linux-pci+bounces-11875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6B95852A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F48D1F26EA5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842218DF69;
	Tue, 20 Aug 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ruGjHovj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B8178376;
	Tue, 20 Aug 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151028; cv=none; b=qtpybK4nSX1yVjrHd/YMnFHxk/7wfZE/CiiO69+hsFDkito4vXK757BEdePXhDXyTRt4e5KpTAaUH8h0FBhc7ougaa38LLIuPX/SsPAngR27/s8bLl2jF2MSCg07EJr3uvL0gBc5s+Kvgbz85TeyfYUsebPf8Dr6mbcsnBQgU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151028; c=relaxed/simple;
	bh=BW1vJ2JdPKxvBDkkh/Ej1m8/rVRSPIhmWDHII2qDfoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGTXTXgqUakveRplJD2+/caFHDFKNKr6YjBEnmJqlVb27Cju3ACZaXxHwnZ2FGbJ6IR30KMlP/Vw4eDvUTW/g81shNcWr8VpR6k0bMV2heD5iQmS3OHqSZcrVG7bJtrGuxZSeGAXV6IyonOfo08ny3v9Q05yGHCCg/uisBQm4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ruGjHovj; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gMRNs7LZjwSfLgMRNsuK6W; Tue, 20 Aug 2024 12:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724151023;
	bh=X3DOniTI7c55GuiMpK8pOTIVjxNvcVnLEOswNdsJKGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ruGjHovjwVAFHkPZLxFnKlkVPSR2sH1Tu8Yzl2KCNT+h0UXE/4BbQPCozyF2XbFZ/
	 nwpCjlw+zrln9JtbDFUk46hZna6dmbneDRXpOg01Mqh2+FB/bqt95uevMJ3jixrJ8Z
	 TmWJa0R+gQavq69twWk3XNGOruh6Eq2n3ZCW6/MGUfq2zHrWZCSjaIQwUIlowhHpzZ
	 Fnt8K3hVLPlc6xZYMbYmpijRyRIRLbtYz5iQZ/UWazGyJUHpfitv6UATNyixmJUbQG
	 vMGb1d4pU/44nDXBHLabcwHkENzJjyG4ymuJRiApewfa/DL4KqayoEDn/VuMTmoWWl
	 zWOsqj6Kbw+bQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 20 Aug 2024 12:50:23 +0200
X-ME-IP: 90.11.132.44
Message-ID: <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
Date: Tue, 20 Aug 2024 12:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org, axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
 hao.wu@intel.com, jasowang@redhat.com, joabreu@synopsys.com,
 kuba@kernel.org, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, mdf@kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 trix@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
 yilun.xu@intel.com
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-10-pstanner@redhat.com>
 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
 <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/08/2024 à 10:09, Philipp Stanner a écrit :
>>> @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
>>> snet_config_ops = {
>>>    static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
>>> *psnet)
>>>    {
>>>    	char name[50];
>>> -	int ret, i, mask = 0;
>>> +	int i;
>>> +
>>> +	snprintf(name, sizeof(name), "psnet[%s]-bars",
>>> pci_name(pdev));
>>> +
>>>    	/* We don't know which BAR will be used to communicate..
>>>    	 * We will map every bar with len > 0.
>>>    	 *
>>>    	 * Later, we will discover the BAR and unmap all other
>>> BARs.
>>>    	 */
>>>    	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>> -		if (pci_resource_len(pdev, i))
>>> -			mask |= (1 << i);
>>> -	}
>>> -
>>> -	/* No BAR can be used.. */
>>> -	if (!mask) {
>>> -		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
>>> -		return -ENODEV;
>>> -	}
>>> -
>>> -	snprintf(name, sizeof(name), "psnet[%s]-bars",
>>> pci_name(pdev));
>>> -	ret = pcim_iomap_regions(pdev, mask, name);
>>> -	if (ret) {
>>> -		SNET_ERR(pdev, "Failed to request and map PCI
>>> BARs\n");
>>> -		return ret;
>>> -	}
>>> +		if (pci_resource_len(pdev, i)) {
>>> +			psnet->bars[i] = pcim_iomap_region(pdev,
>>> i, name);
>>
>> Hi,
>>
>> Unrelated to the patch, but is is safe to have 'name' be on the
>> stack?
>>
>> pcim_iomap_region()
>> --> __pcim_request_region()
>> --> __pcim_request_region_range()
>> --> request_region() or __request_mem_region()
>> --> __request_region()
>> --> __request_region_locked()
>> --> res->name = name;
>>
>> So an address on the stack ends in the 'name' field of a "struct
>> resource".
> 
> Oh oh...
> 
>>
>> According to a few grep, it looks really unusual.
>>
>> I don't know if it is used, but it looks strange to me.
> 
> 
> I have seen it used in the kernel ringbuffer log when you try to
> request something that's already owned. I think it's here, right in
> __request_region_locked():
> 
> /*
>   * mm/hmm.c reserves physical addresses which then
>   * become unavailable to other users.  Conflicts are
>   * not expected.  Warn to aid debugging if encountered.
>   */
> if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> 	pr_warn("Unaddressable device %s %pR conflicts with %pR",
> 		conflict->name, conflict, res);
> }
> 
> 
> Assuming I interpret the code correctly:
> The conflicting resource is found when a new caller (e.g. another
> driver) tries to get the same region. So conflict->name on the original
> requester's stack is by now gone and you do get UB.
> 
> Very unlikely UB, since only rarely drivers race for the same resource,
> but still UB.
> 
> But there's also a few other places. Grep for "conflict->name".
> 
>>
>>
>> If it is an issue, it was apparently already there before this patch.
> 
> I think this has to be fixed.
> 
> Question would just be whether one wants to fix it locally in this
> driver, or prevent it from happening globally by making the common
> infrastructure copy the string.
> 
> 
> P.
> 

Not a perfect script, but the below coccinelle script only find this 
place, so I would +1 only fixing things here only.

Agree?

CJ



@@
identifier name;
expression x;
constant N;
@@
	char name[N];
	...
(
*	pcim_iomap_region(..., name, ...);
|
*	pcim_iomap_regions(..., name, ...);
|
*	request_region(..., name, ...);
|
*	x = pcim_iomap_region(..., name, ...);
|
*	x = pcim_iomap_regions(..., name, ...);
|
*	x = request_region(..., name, ...);
)



