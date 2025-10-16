Return-Path: <linux-pci+bounces-38336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BDDBE30F8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A26C587228
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA531BC96;
	Thu, 16 Oct 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fche2fNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E47317702;
	Thu, 16 Oct 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614138; cv=none; b=UtVq1CYVpecPLlLBurpI3rjRvmmvr0nGbv+9KRe7DlsvV+ni+QoVYl8Ii9FtwgiZnoVahobewJsPuZw7HmzRIlFRCar8iHFrKMT9JZCIongx+bUp8zANApEWzGLjWurMn1iQA32ph2nqzqqmQI7ukx9Ok6cFoT9L+GWcieacrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614138; c=relaxed/simple;
	bh=uvKbe11B8kQ6Ee0GKNfpxCLAco7lfj+y6SoI+zoc8AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpAqyCmQz7p9WLLr+72VxITlFQI+gS6wOhXt80uRj8TAGWagVfImZvO95N2LshiRizNybhuth76HphhYGTBJa8KeMDZLzdF3iL0iVlRY4tWYsd+CMMTsmQtdSLAk4nhQUP5ZSgIRtaMp0HCuaZQSyj0H3XdhM2oXP3uJ1W8OWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fche2fNu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760614134;
	bh=uvKbe11B8kQ6Ee0GKNfpxCLAco7lfj+y6SoI+zoc8AA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fche2fNudBfF4EiJNAIhzgxus/W7G1rXmy0ZISAzBlNqLXlkez8nEUVF4mFeLQq2B
	 0+qex3PNagHzhTv9mTl7nlmWg8DWOwDFaw/zkw9GhvuyK0uGN4yNBDaRdVZ+Q3HcRY
	 U+AihgPGf4FElZeklIWhqjk++yzvkfkX0GH8Uqf+JRB1PY45Y32XLw2XvZWINO0QsR
	 9Vzztu206IXhgfsfFIcREu55tzxE/FcUZT8IvzPImZxhicuaCstPcuM/gcD90GvPPz
	 KJP4ob0WqIdZeV4KST2Tb1b/XoXVf0d3Xiatko8wRWCM/EKpUcr5V4p75aqu+Lmoap
	 hO1GHvT6+h9aA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CCDB17E1060;
	Thu, 16 Oct 2025 13:28:53 +0200 (CEST)
Message-ID: <9bf32a56-b67f-488a-8719-3f97d85533d3@collabora.com>
Date: Thu, 16 Oct 2025 13:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] arm64: dts: mediatek: mt7981b: Add wifi memory
 region
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
 <20251016-openwrt-one-network-v1-13-de259719b6f2@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-openwrt-one-network-v1-13-de259719b6f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> Add required memory region for the builtin wifi block. Disable the block
> by default as it won't function properly without at least pin muxing.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

You should split this commit in two:
  - Add wifi memory region
  - Disable wifi by default

Regarding the second commit, you have to re-enable the wifi node in all of
the currently supported MT7981b devices, including:
  - Xiaomi AX3000T
  - Cudy WR3000 V1

While I agree that without pin muxing the wifi may not properly work, it is
unclear whether the aforementioned devices are pre-setting the pinmux in the
bootloader before booting Linux.

In case those do, you'd be "breaking" WiFi on two routers here.

Cheers,
Angelo



