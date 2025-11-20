Return-Path: <linux-pci+bounces-41805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296DC7529A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EF25362AD5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BA376BF1;
	Thu, 20 Nov 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gV64s3dw"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CC376BF4;
	Thu, 20 Nov 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653751; cv=none; b=COCt59L1N/x9tlT9yWaFpqK5/gLLemHKWjmllvjPDxl5M9qe7L0b80A51IKfsdwF3YpKPG5d+AyxKpiWNdFf/bPkylMuswpyxGrkMh8arj/dJ6eHcDysWS1VpS/eO+T8Jzc/nKPvDa5VSu3IB5Qbfood4wg0yyoR6kdzb0/CURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653751; c=relaxed/simple;
	bh=OGknm9RlxOFdzEIgb0Da240Rs6WBRlFklz56cuT5Dzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZpj1iNoEv66ZuKa+Tze3Fe7Zv33K9jEvko9WmSzrBcz7fd5BJKbpNhsbIvW8zoLXeSAAlPwN6dOaYNYWufuS2JJukjEO+kehTHIyfENdXMiprEu77J9H6eX6Qv0UoUZJGnPuFm4gUl6yQxdU++/tyKuG1SPxzYmU/LIE5tvLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gV64s3dw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763653746;
	bh=OGknm9RlxOFdzEIgb0Da240Rs6WBRlFklz56cuT5Dzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gV64s3dwXmsMljMFBMmBoJ42qjeQHC9N24uo4ZJBqIEkncBs9YZXB3Nd/kXGyszun
	 cm4zlyod0+P0iSdP1dCBdCUTY42rOJion/yFnsZwmkuHNx+VYW7DBrqo5ZHquHNID6
	 FifqKimupbrrs1I4KNwohZ+bAsUGTl7wB0XvPuyp7oduEP7EZidkBPhcvynK4Jae9R
	 MEiMCGtTaHjUeUUYPVB82jBif+IKIBRcz983UGyNtCXwgqQ8SdswlR7WDMO4fZil6L
	 MHzyDi/jcqAjXOA/1lPwBPBGZEZypMtTkr5UCNkwFamiPZfzU+i7kGIwM6vryl9fYq
	 sEfCDzFUZbGUg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD10C17E0117;
	Thu, 20 Nov 2025 16:49:04 +0100 (CET)
Message-ID: <c23d5d1e-4816-41c7-9886-41d586c84cc6@collabora.com>
Date: Thu, 20 Nov 2025 16:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] arm64: dts: mediatek: Add Openwrt One AP
 functionality
To: Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Sjoerd Simons <sjoerd@collabora.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
 kishon@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org, nbd@nbd.name,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 daniel@makrotopia.org, bryan@bryanhinton.com, conor.dooley@microchip.com
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
 <176360700676.1051457.11874224265724256534.git-patchwork-notify@kernel.org>
 <20251120152829.GH661940@google.com> <20251120073639.3fd7cc7c@kernel.org>
 <20251120154012.GJ661940@google.com> <20251120074457.5aa06d89@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251120074457.5aa06d89@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/11/25 16:44, Jakub Kicinski ha scritto:
> On Thu, 20 Nov 2025 15:40:12 +0000 Lee Jones wrote:
>>>>>    - [v4,02/11] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
>>>>>      (no matching commit)
>>>>>    - [v4,03/11] dt-bindings: phy: mediatek,tphy: Add support for MT7981
>>>>>      (no matching commit)
>>>>>    - [v4,04/11] arm64: dts: mediatek: mt7981b: Add PCIe and USB support
>>>>>      (no matching commit)
>>>>>    - [v4,05/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable PCIe and USB
>>>>>      (no matching commit)
>>>>>    - [v4,06/11] dt-bindings: net: mediatek,net: Correct bindings for MT7981
>>>>>      https://git.kernel.org/netdev/net-next/c/bc41fbbf6faa
>>>>>    - [v4,07/11] arm64: dts: mediatek: mt7981b: Add Ethernet and WiFi offload support
>>>>>      (no matching commit)
>>>>>    - [v4,08/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable Ethernet
>>>>>      (no matching commit)
>>>>>    - [v4,09/11] arm64: dts: mediatek: mt7981b: Disable wifi by default
>>>>>      (no matching commit)
>>>>>    - [v4,10/11] arm64: dts: mediatek: mt7981b: Add wifi memory region
>>>>>      (no matching commit)
>>>>>    - [v4,11/11] arm64: dts: mediatek: mt7981b-openwrt-one: Enable wifi
>>>>>      (no matching commit)
>>
>> This is a very odd way of presenting that one patch from the set was merged.
>>
>> Not sure I've seen this before.  Is it new?
>>
>> It's very confusing.  Is it a core PW thing and / or can it be configured?
> 
> It's k.org infra bot. Konstantin, would it be possible to highlight
> more that a series is partially applied?

I guess that adding "(subset)" like b4 does would improve those messages quite
a lot ;-)

Cheers,
Angelo

