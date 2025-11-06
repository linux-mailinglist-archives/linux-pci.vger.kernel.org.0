Return-Path: <linux-pci+bounces-40472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0DC39B2C
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108C618C6B94
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83626E709;
	Thu,  6 Nov 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QPXnUDcL"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D4239E9E;
	Thu,  6 Nov 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419620; cv=none; b=Gv+uryxlLlT7MC5IDIxMFpDpP30Jh38PXXv7FjNnUbOj55LkM2Xj6IO0Y4IYAAsr3CE1UfcIbDT+6cbrbBcuEV3BYVHPCCBKc/pkPyvR4y3hOW4DZwKhGWqhZimR5Qd8Z0WL1TK/e8VhuIVtFdpynwid8iVvUKsapFdVJ8ZC3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419620; c=relaxed/simple;
	bh=dDyHvtX05p1WbayGiNH5360z2meP1cpRfl9zSAmCDQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nraQBUdRW6hbjk0gDZhKhqjCfMBoz+UZ5uPKjmpB6qruwIrqHLBBjv9DFTBM1hvsfOuKNZvV7VSLqaOsbZvV99WKwWhbJkzRNdQyfc4m2ZehD5PBDHK40JfMq1gTa57FLyV57rY8hM11xs1XOm9ncVlAannpGc9GmZykdhBdwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QPXnUDcL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762419616;
	bh=dDyHvtX05p1WbayGiNH5360z2meP1cpRfl9zSAmCDQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QPXnUDcLPa0qRTSblPIwFChQTByXlh5eKkZ1xMoI7Wf/kfRrGSl3Joeb0HDUlK6Iw
	 bDvhN6ZIwnWJODJ+lJHjPf3F13eRtDHwYOgOe1uylSardsA5m/qHoSnhRcoFyYNfGZ
	 0u4xYuDrjXC4XfciO/UYuis3ZxhCedroAqK4HBdjEWacA9EHn2/T92VMKtfbRNlIYU
	 7fcHagvJTpwyVeYxJlffF5owE3Vq93nwQCoCkPv0ch6CM29VlsEIkrBp3MTN/4etjZ
	 6nb2EKpFnGsgtMmqDIOA+kbKNl67LSVxIQhJ2dHjAUIZKNOE6stebJTGWHo0HVkFcR
	 mZ1OoXE6qqE8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE6A317E1345;
	Thu,  6 Nov 2025 10:00:15 +0100 (CET)
Message-ID: <c760da37-1d13-4440-9457-afef83649db8@collabora.com>
Date: Thu, 6 Nov 2025 10:00:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251105062815.966716-1-wenst@chromium.org>
 <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
 <CAGXv+5EwiL_-ozRARH2UBm5znHi1egBoCjmELN=17hvFF_oeoQ@mail.gmail.com>
 <3e1ffe72-b6a4-45cc-a053-190077818f19@collabora.com>
 <CAGXv+5GAyt6U710En_k=fq-CPrq_H6rmc=kpBNw4yXjj8qL2cw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5GAyt6U710En_k=fq-CPrq_H6rmc=kpBNw4yXjj8qL2cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/11/25 06:52, Chen-Yu Tsai ha scritto:
> On Wed, Nov 5, 2025 at 7:32 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 05/11/25 10:21, Chen-Yu Tsai ha scritto:
>>> On Wed, Nov 5, 2025 at 4:45 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 05/11/25 07:28, Chen-Yu Tsai ha scritto:
>>>>> As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
>>>>> common code") come up later" in the code, it is possible for link up to
>>>>> occur later:
>>>>>
>>>>>      Let's standardize this to succeed as there are usecases where devices
>>>>>      (and the link) appear later even without hotplug. For example, a
>>>>>      reconfigured FPGA device.
>>>>>
>>>>> Another case for this is the new PCIe power control stuff. The power
>>>>> control mechanism only gets triggered in the PCI core after the driver
>>>>> calls into pci_host_probe(). The power control framework then triggers
>>>>> a bus rescan. In most driver implementations, this sequence happens
>>>>> after link training. If the driver errors out when link training times
>>>>> out, it will never get to the point where the device gets turned on.
>>>>>
>>>>> Ignore the link up timeout, and lower the error message down to a
>>>>> warning.
>>>>>
>>>>> This makes PCIe devices that have not-always-on power rails work.
>>>>> However there may be some reversal of PCIe power sequencing, since now
>>>>> the PERST# and clocks are enabled in the driver, while the power is
>>>>> applied afterwards.
>>>>>
>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>
>>>> Ok, that's sensible.
>>>>
>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>
>>>>> ---
>>>>> The change works to get my PCIe WiFi device working, but I wonder if
>>>>> the driver should expose more fine grained controls for the link clock
>>>>> and PERST# (when it is owned by the controller and not just a GPIO) to
>>>>> the power control framework. This applies not just to this driver.
>>>>>
>>>>> The PCI standard says that PERST# should hold the device in reset until
>>>>> the power rails are valid or stable, i.e. at their designated voltages.
>>>>
>>>> I completely agree with all of the above - and I can imagine multiple PCI-Express
>>>> controller drivers doing the same as what's being done in MTK Gen3.
>>>>
>>>> This means that the boot process may get slowed down by the port startup sequence
>>>> on multiple PCI-Express controllers (again not just MediaTek) and it's something
>>>> that must be resolved in some way... with the fastest course of action imo being
>>>> giving controller drivers knowledge of whether there's any device that is expected
>>>> to be powered off at that time (in order to at least avoid all those waits that
>>>> are expected to fail).
>>>
>>> That also requires some refactoring, since all the drivers _wait_ for link
>>> up before going into the PCI core, which does the actual child node parsing.
>>>
>>> I would like some input from Bartosz, who introduced the PCI power control
>>> framework, and Manivannan, who added slot power control.
>>>
>>>> P.S.: Chen-Yu, did you check if the same applies to the MTK previous gen driver?
>>>>          Could you please check and eventually send a commit to do the same there?
>>>
>>> My quick survey last week indicated that all the drivers except for the
>>> dwc family error out if link up timed out.
>>>
>>> I don't have any hardware for the older generation though. And it looks
>>> like for the previous gen, the driver performs even worse, since it can
>>> support multiple slots, and each slot is brought up sequentially. A slot
>>> is discarded if link up times out. And the whole driver errors out if no
>>> slots are working.
>>>
>>
>> Hey, that's bold.
>>
>> If only one driver (DWC) is working okay, there's something wrong that must be
>> fixed before that behavior change goes upstream (which it already did, ugh).
> 
> To be fair one only runs into it if they convert over to the PCI slot power
> description in the device tree, and their hardware isn't DWC based. This
> is pretty new.
> 

That changes a lot of things then - I thought it was a regression, but it's not.

>> This needs attention from both Bartosz and Mani really-right-now.
>>
>> I'm not sure about possible good solutions, and unfortunately I don't really have
>> any time to explore, so I'm not spitting any words on that - leaving this to both
>> Bartosz and Mani as that's also the right thing to do anyway.
> 
> Mani mentioned [1] that work towards moving the pwrctrl stuff into drivers
> is almost complete. So I think we're covered.
> 

We're covered. Yes.

Cheers,
Angelo

> ChenYu
> 
> [1] https://lore.kernel.org/all/rz6ajnl7l25hfl2u7lloywtw7sq7smhb63hg76wjslyuwyjb7a@fhuafuino5kv/



