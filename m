Return-Path: <linux-pci+bounces-40342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E4C355E8
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42911A2044D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10A302CC1;
	Wed,  5 Nov 2025 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XPy5obg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567232DC334;
	Wed,  5 Nov 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342329; cv=none; b=YjIXK9pj/TDiQ4HThdM0ZDxofL91TH8L05cH30pB+0OuuvY4/6/NyzBg6luqRDNRJ7zIwoYIZl8iJ/KuZJURQYai8rh1ZTqZa/yNbySEnX7l8XfyKrDuJmPKwJLK4kkCH/td4oYxwWDkfXkv4U1I5zkhH8eviCG5G2rtmXWbgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342329; c=relaxed/simple;
	bh=qo7Q5+N4DDgqiZo8JDVIJ2IijBxpBe/S1c2lwaOZkJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii2mPU1xEndBvMCX1OpBdgohCaq1g36S6TrjYJPGmI8bE6isQn3pksn8fXhl8TpFWsFOK9Hf+vttanen7oF0OBtqSlnFhh0PmPhx5SQ08S0ub0cXiNtnjvfi6kWe8IUHVUrKCriyFVmpbpCtqlfzUQ44IBoq/wRCq9bLAIE7xCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XPy5obg5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762342325;
	bh=qo7Q5+N4DDgqiZo8JDVIJ2IijBxpBe/S1c2lwaOZkJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XPy5obg5QNFSpQkeUn4jpYq0MZfgWvlHwvYbUuDpQu7gGnm8a6RfJqrqhAHNSZvsy
	 Iyw9cjdtDntX58SK4J+P+S0PYTC7tdKEw13MtE5I48vTa+B7Iqx3POlBjv8Wx7v7GP
	 UEQX3oKAFdPkpFqdyuIyKrP6vDEfPjJdj+TwnnEHC969Msqx0lkJsXHTBvuG+ZsAlU
	 lLcLCHvBujZB3tfuh3ztWwFknm1vgjesigUI5qxnVaXkwS3yhZ83gGssirZo6WN9dy
	 gYWT5dlE7iuapua5SgF2IQ7lPMnBs+pRcC4+wJurjfYbPebdvpx4BSU6WZ0d5fIyc9
	 HJEWiaTaoP0bw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0389217E12AA;
	Wed,  5 Nov 2025 12:32:04 +0100 (CET)
Message-ID: <3e1ffe72-b6a4-45cc-a053-190077818f19@collabora.com>
Date: Wed, 5 Nov 2025 12:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251105062815.966716-1-wenst@chromium.org>
 <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
 <CAGXv+5EwiL_-ozRARH2UBm5znHi1egBoCjmELN=17hvFF_oeoQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5EwiL_-ozRARH2UBm5znHi1egBoCjmELN=17hvFF_oeoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/11/25 10:21, Chen-Yu Tsai ha scritto:
> On Wed, Nov 5, 2025 at 4:45 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 05/11/25 07:28, Chen-Yu Tsai ha scritto:
>>> As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
>>> common code") come up later" in the code, it is possible for link up to
>>> occur later:
>>>
>>>     Let's standardize this to succeed as there are usecases where devices
>>>     (and the link) appear later even without hotplug. For example, a
>>>     reconfigured FPGA device.
>>>
>>> Another case for this is the new PCIe power control stuff. The power
>>> control mechanism only gets triggered in the PCI core after the driver
>>> calls into pci_host_probe(). The power control framework then triggers
>>> a bus rescan. In most driver implementations, this sequence happens
>>> after link training. If the driver errors out when link training times
>>> out, it will never get to the point where the device gets turned on.
>>>
>>> Ignore the link up timeout, and lower the error message down to a
>>> warning.
>>>
>>> This makes PCIe devices that have not-always-on power rails work.
>>> However there may be some reversal of PCIe power sequencing, since now
>>> the PERST# and clocks are enabled in the driver, while the power is
>>> applied afterwards.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> Ok, that's sensible.
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>> ---
>>> The change works to get my PCIe WiFi device working, but I wonder if
>>> the driver should expose more fine grained controls for the link clock
>>> and PERST# (when it is owned by the controller and not just a GPIO) to
>>> the power control framework. This applies not just to this driver.
>>>
>>> The PCI standard says that PERST# should hold the device in reset until
>>> the power rails are valid or stable, i.e. at their designated voltages.
>>
>> I completely agree with all of the above - and I can imagine multiple PCI-Express
>> controller drivers doing the same as what's being done in MTK Gen3.
>>
>> This means that the boot process may get slowed down by the port startup sequence
>> on multiple PCI-Express controllers (again not just MediaTek) and it's something
>> that must be resolved in some way... with the fastest course of action imo being
>> giving controller drivers knowledge of whether there's any device that is expected
>> to be powered off at that time (in order to at least avoid all those waits that
>> are expected to fail).
> 
> That also requires some refactoring, since all the drivers _wait_ for link
> up before going into the PCI core, which does the actual child node parsing.
> 
> I would like some input from Bartosz, who introduced the PCI power control
> framework, and Manivannan, who added slot power control.
> 
>> P.S.: Chen-Yu, did you check if the same applies to the MTK previous gen driver?
>>         Could you please check and eventually send a commit to do the same there?
> 
> My quick survey last week indicated that all the drivers except for the
> dwc family error out if link up timed out.
> 
> I don't have any hardware for the older generation though. And it looks
> like for the previous gen, the driver performs even worse, since it can
> support multiple slots, and each slot is brought up sequentially. A slot
> is discarded if link up times out. And the whole driver errors out if no
> slots are working.
> 

Hey, that's bold.

If only one driver (DWC) is working okay, there's something wrong that must be
fixed before that behavior change goes upstream (which it already did, ugh).

This needs attention from both Bartosz and Mani really-right-now.

I'm not sure about possible good solutions, and unfortunately I don't really have
any time to explore, so I'm not spitting any words on that - leaving this to both
Bartosz and Mani as that's also the right thing to do anyway.

Angelo

> 
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> ---
>>>    drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++++++++----
>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>>> index 75ddb8bee168..5bdb312c9f9b 100644
>>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>>> @@ -504,10 +504,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>>>                ltssm_index = PCIE_LTSSM_STATE(val);
>>>                ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
>>>                              "Unknown state" : ltssm_str[ltssm_index];
>>> -             dev_err(pcie->dev,
>>> -                     "PCIe link down, current LTSSM state: %s (%#x)\n",
>>> -                     ltssm_state, val);
>>> -             return err;
>>> +             dev_warn(pcie->dev,
>>> +                      "PCIe link down, current LTSSM state: %s (%#x)\n",
>>> +                      ltssm_state, val);
>>> +
>>> +             /*
>>> +              * Ignore the timeout, as the link may come up later,
>>> +              * such as when the PCI power control enables power to the
>>> +              * device, at which point it triggers a rescan.
>>> +              */
>>>        }
>>>
>>>        mtk_pcie_enable_msi(pcie);
>>
>>


