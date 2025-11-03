Return-Path: <linux-pci+bounces-40088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B6C2AA1E
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 09:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDC188F8AE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF32E0925;
	Mon,  3 Nov 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kB+jhMCM"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF202DC348;
	Mon,  3 Nov 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159786; cv=none; b=jeg6FReZOqw+f0s0X6QmTWTjyqJR+jmHfm/Low5PYOrS+GiPs3SNrYBkOTt8xu4GoXJYDuoN4LjyybIbFiDg8Xe6rbKdB4Q/Vji7TCQFyPrm9FfKBik6LlbzMEvvYMPSoWHZnVhiWxC2W1Nz12gPOjd4Hbmo5/1CeGjXneCo5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159786; c=relaxed/simple;
	bh=8tuJsROwI2VzZ5xr0xXLp3Zh781ZfsXiSloTIPD4CrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4v9DBaJpz65OGLPHNxJZIRqDUddv+aNw8YGIi5/hKpt9TTsP0g29jD27E7xKJWul2kV+uTxoRwcZmAFtBZGEkrqReJFPKBSPeBSUxqVsQZwhKp8R6JMPfbKdnN/TiS9stahbh/z5CwcoCHYgXdMoM11Lp70IbjqqLmZUCBNY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kB+jhMCM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762159427;
	bh=8tuJsROwI2VzZ5xr0xXLp3Zh781ZfsXiSloTIPD4CrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kB+jhMCM1GHi+MeyUo5A2D2Nl2Zaj4w0rJ0MtcoWUiZRrLwlQXY18GUWmUIdC6Qtz
	 Hm/2tah1AkhRImWrzcwBH9eWu8zkbl6eoxm70yGutoNNZlNjJCGFifITnFUw3mT2Nc
	 wvb59Iqh937c9S4bPXnwsRXxFoFpIxLcxdkjc7b7uCuWLmtQQ69tzgsoc9IPU5ye2s
	 XppA6l5hCm/mMApe2zwkPeLlLikVgqeG3BBy5A5U6I3IUXSSaq8es3RhhKEeGctTIM
	 XTtMgYmMybm2OXIsUt3yIYx9aU3EgPTJ0RcA5cEgcIIKJ96gyL1PExd9QVNV+8UQzQ
	 1z2HMVD+If0Ng==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ECECB17E090D;
	Mon,  3 Nov 2025 09:43:45 +0100 (CET)
Message-ID: <75a89547-6f21-4f89-8091-375e7013c26d@collabora.com>
Date: Mon, 3 Nov 2025 09:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
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
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
 <20251101-openwrt-one-network-v2-8-2a162b9eea91@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251101-openwrt-one-network-v2-8-2a162b9eea91@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/11/25 14:32, Sjoerd Simons ha scritto:
> Different SoCs have different numbers of Wireless Ethernet
> Dispatch (WED) units:
> - MT7981: Has 1 WED unit
> - MT7986: Has 2 WED units
> - MT7988: Has 2 WED units
> 
> Update the binding to reflect these hardware differences. The MT7981
> also uses infracfg for PHY switching, so allow that property.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



