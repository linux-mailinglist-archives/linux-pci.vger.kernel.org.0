Return-Path: <linux-pci+bounces-38335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DBBE30E6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB9B586D3A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0831961B;
	Thu, 16 Oct 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ciTFAcdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC33164AA;
	Thu, 16 Oct 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614136; cv=none; b=fEwyjXhhkW+1Oem++YdM16MPGDP4IxtOa4jP1kQDZbNHMEvy8B2TS5p6Yt/yZZU5gvY6biL9dpmXTJeMHVKS9CjA7gqRadaMj3iyKlESAJ/oBMCZzNmxRcTRfetLO/qPr09t74H/s2iG9w1Q30rJNfSuSZb640sYXeY5erIfbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614136; c=relaxed/simple;
	bh=Ly+GqD50EQby60wKFpjz5BdLWtcrRKYoyDEb5wk9upA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gkwisodvl0iyOne+bZU0JyBD57xjyt0kOmesjSBP2sdDbILQ7EObmV9zw/Y36isK3p08+SuE4pI/3ZMz6u04GappI7vnGD3ZAPY3Kcx4rZgAADbITDfov4ue1DgjwbLU7/ArbunccwG3/4NBqAn51ztQEOxRCyyPfMUoCTGce/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ciTFAcdw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614132;
	bh=Ly+GqD50EQby60wKFpjz5BdLWtcrRKYoyDEb5wk9upA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ciTFAcdwTMcoM9IMD3uzqeIM16hWrwQqKAh6NVXx2gLsw/y0wpQOWmMYdaYNrH4LE
	 35rJDXHyl/VaV/NdwjPuhwCfVEyGTwbrlSZn8Kmj0xQ3IOamihQKxL4cXhUN45/EHt
	 9X21t6yJJzrhfViqYjmOY4o4870+X4q9Ys0Bnkssv/UUNyu5HROI/OcjSLdkvMdla9
	 Y9YxsJoYFkxGRq++7paJ9zgPqvlVyl7WPz+vedtxF59ZJXbefaY2A52fh75LBZDHuc
	 7Raso927eozklnf0Uk6bNieeCreoDZBrOVElVNqHGYj+LRTfWmGmy/LfhEhRhUfhiJ
	 HA47jH7KwcI6Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB9D817E0FC2;
	Thu, 16 Oct 2025 13:28:51 +0200 (CEST)
Message-ID: <1e600905-894f-4428-adfd-1337cb6d4794@collabora.com>
Date: Thu, 16 Oct 2025 13:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 wifi
To: Sjoerd Simons <sjoerd@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-14-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-14-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Enable Dual-band WiFI 6 functionality on the Openwrt One
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



