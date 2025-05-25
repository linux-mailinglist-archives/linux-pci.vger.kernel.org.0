Return-Path: <linux-pci+bounces-28390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CDAC34F1
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBF3B7BB6
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603A1EEA5D;
	Sun, 25 May 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WvmTCjqS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D0Achqh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BB4A1D;
	Sun, 25 May 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748179997; cv=none; b=Kv1nm5uECmTD12bvzxF4mLuZO2PQJ3tmSN+22iaYESNtyiDtpqWG7ekWmOUZEnNqQeLrZR1ScQDYiEAj5Z7cFFIFSbyVqJBBEZNnBkAW63gi3m6yx84EVqweD8gikvniuO4JtPBOSCjZ1Q7mwNTFQ6PmpDiX8NNKKe7erqE4zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748179997; c=relaxed/simple;
	bh=Locvvt1Uu092XcCY9zxBP9Rih7vf1H7dJHmPx6hakKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r811PhnvedCsgKeMfplWLj9970xowNkYxZrBGh7zpknWBA22van04vr13M5I25fySIPYn/eiX5ps7Ceoe6mLOxLtXvGERb9t5Z4gllIyoiW+MuxsvMUneqbSMaJgkVuPF2M6IveDrESfbqv4bIoxxPESFuRikErzCeBCUo5zKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WvmTCjqS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D0Achqh8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b50G127Rkz9sX2;
	Sun, 25 May 2025 15:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748179993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaBe/qc+2pXExuQttHiqmVdIlwW/IMB18Yyn98zdkjY=;
	b=WvmTCjqShVbX7JrLS/FXF6KbBbigWBeZGBKazdmn4NQK4CkL1ptA5YNgySTl/lA0pSg5/w
	QygXSca6z+l22SB8KD1QuTVtOQXIC+wPFHCisYCeO0PZi1jfAby75/4uVNKv0wsSkFG8Y2
	1eTA1YmIPUnZjSqtiUI8o1wrjRWYjFF4nCcLjxfhD4FvPz6PXzE4fBZShIpDt+SoyWgTaY
	gTvIX15B/TcDUn98ZtzvMV1eWyxD6lGiMhUgscoYNfRlABPBd5i8uEuYwXC2ykokgCYnYg
	L4KZ6ERAizdr7FjmrFliBo5MtkdKSwh28mNRG0ccxno57oRpdHSFOA9rjiX+iA==
Message-ID: <395343ba-93cc-495c-b5eb-7ee425996465@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748179991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaBe/qc+2pXExuQttHiqmVdIlwW/IMB18Yyn98zdkjY=;
	b=D0Achqh8/WvHVdwyXE9o848j56o/juRstx9hORCoSrgA/Fn/HCpZGhVu4/hhga2/zbptuB
	Dobf0+K909nOZlzOh7y+j9hRFVyq9X5ppmZEkvP2TLfk7Y5pt23y8GpbJjY7zJW9OAAt55
	SMlWRjUBbCJBkpg1NXf+MUFqmO8mrp9zzpWzXh0s4UNFwRZQ0cmn9XtA80kSE6hFQh8Zj6
	F0ysGSEoa68rDaZecgqkwRSxyqrQtXfnjiOcmQV9QSif8nsTy1hNny7OvpJZfC6EdiJhkf
	UEfQt70cWDx90X/dghI98D7RfbMRkqGL95vzgEE/t8GAJanxT0tvp9FIZB37eA==
Date: Sun, 25 May 2025 15:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
 Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>
 <20250410204845.GA1027003-robh@kernel.org>
 <40c400ab-8770-4595-9a4c-004e6157c348@mailbox.org>
 <CAMuHMdU0U8RjJwgMs1gqaKUXj+aP=gMZRgO6Ni5gPHr3yFa_Hg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdU0U8RjJwgMs1gqaKUXj+aP=gMZRgO6Ni5gPHr3yFa_Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 30e54f29d21d2aff1b6
X-MBO-RS-META: 3hum87jao36mwgujkt91b8to163zmxcp

On 4/23/25 11:38 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Sun, 13 Apr 2025 at 11:29, Marek Vasut <marek.vasut@mailbox.org> wrote:
>> On 4/10/25 10:48 PM, Rob Herring wrote:
>>> On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
>>>> Document 'aux' clock which are used to supply the PCIe bus. This
>>>> is useful in case of a hardware setup, where the PCIe controller
>>>> input clock and the PCIe bus clock are supplied from the same
>>>> clock synthesiser, but from different differential clock outputs:
>>>>
>>>>    ____________                    _____________
>>>> | R-Car PCIe |                  | PCIe device |
>>>> |            |                  |             |
>>>> |    PCIe RX<|==================|>PCIe TX     |
>>>> |    PCIe TX<|==================|>PCIe RX     |
>>>> |            |                  |             |
>>>> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
>>>> '------------'      ||  ||      '-------------'
>>>>                       ||  ||
>>>>    ____________       ||  ||
>>>> |  9FGV0441  |      ||  ||
>>>> |            |      ||  ||
>>>> |   CLK DIF0<|======''  ||
>>>> |   CLK DIF1<|==========''
>>>> |   CLK DIF2<|
>>>> |   CLK DIF3<|
>>>> '------------'
>>>>
>>>> The clock are named 'aux' because those are one of the clock listed in
>>>> Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml which
>>>> fit closest to the PCIe bus clock. According to that binding document,
>>>> the 'aux' clock describe clock which supply the PMC domain, which is
>>>> likely PCIe Mezzanine Card domain.
>>>
>>> Pretty sure that PMC is "power management controller" given it talks
>>> about low power states.
>>>
>>>
>>>>
>>>> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> NOTE: Shall we patch Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>>>>         instead and add 'bus' clock outright ?
>>>
>>> Based on the diagram, this has nothing to do with the specific
>>> controller. It should also probably a root port property, not host
>>> bridge.
>> How would you suggest I describe the clock which supply the PCIe bus
>> clock lane (CLK DIF1 in the diagram) , which have to be enabled together
>> with clock which supply the PCIe controller input clock lane (CLK DIF0) ?
> 
> I think Rob wants you to add clocks/clock-names for this to
> dtschema/schemas/pci/pci-bus-common.yaml.  Then you can have pcie@M,N
> subnode(s) with num-lanes, clock, and clock-names describing the PCIe
> endpoint(s)?
> 
> git grep "pcie*@[0-9],[0-9]" -- $(git grep -l num-lanes -- Documentation/ )
> 
> Does that make sense?

No, not really. There can be any arbitrary PCIe card plugged into the 
M.2 slot, so how can I predict what exactly will be plugged into the 
slot and describe it in DT up front this way ?

-- 
Best regards,
Marek Vasut

