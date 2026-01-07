Return-Path: <linux-pci+bounces-44177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AFCFD5BC
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 12:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F281130B0F79
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 11:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A130C61B;
	Wed,  7 Jan 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GRFfT5q7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AB2FC876;
	Wed,  7 Jan 2026 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767784379; cv=none; b=TfN0h4OqoaPq+HkCsGdHr+pCWLoFNvYtqeScEEvBY8ylTO+kZvseFkHiXZA/nRniDyyPl5GmV2xmRmry8sipc7qLj/SMog9SdhwxYM9zYv+Be8BjmMJeCm7zEb6efaTLYcNLUlWdy8wMOCCriRHekVw5qJOpZQRqh35FEgMY+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767784379; c=relaxed/simple;
	bh=8FREetWQYfqgzhDiO9WBTIlqJFhiC73BzMP7I3w1vQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMkjWqFNmj7X41QjLidLCk/9JTdYWmS6WqS2oNwerSutAI9bwCmcYvShHdGtP2OMyn095R8A1culxQ0EQw4bJEOTHWmNRxiCj7IboWfz6PrPIra9mkoeWmwpSUt/hQ6XJDuB81YnZiRPSzw0K7OboMRcjWxLnRqXMh0gzgApAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GRFfT5q7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767784376;
	bh=8FREetWQYfqgzhDiO9WBTIlqJFhiC73BzMP7I3w1vQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GRFfT5q7chGTiJfUlB0pDh1C0QfcIXq0VIpGD486V4WCNjYPtUCBK2n4z8cK/+gJg
	 AXu+aPT0e1AI8x39N3DehXiiPKzEBTHGe8vF+QYTuWmi/eMgxLTijgE4Ij1SV61oXJ
	 JQILbpQWZSmIevaa7U71+9xVJzb9AtYMaqdbH5oPE0pI9E4pOyRVYyD5JQhpYU6T5T
	 7CIXHUXlqmBwQZU1FleXw/R/QABRaWCo1gArUqm8NUaGYKOcuLHuZ8UmfdAOLA4/dR
	 jLX6m91ad4A6+MChEJXsrg5CrFM5wi3qyoqO6xOpg/GCeZJT1eAsBi5jKj6qCzd1+0
	 O0N3TRJDRYhZw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E06217E152C;
	Wed,  7 Jan 2026 12:12:55 +0100 (CET)
Message-ID: <98320300-04dc-4575-9e8b-22b85374b663@collabora.com>
Date: Wed, 7 Jan 2026 12:12:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe
 compatible
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pci@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 Bryan Hinton <bryan@bryanhinton.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Sjoerd Simons <sjoerd@collabora.com>
References: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
 <20251223-openwrt-one-network-v5-1-7d1864ea3ad5@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251223-openwrt-one-network-v5-1-7d1864ea3ad5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/12/25 13:37, Sjoerd Simons ha scritto:
> Add compatible string for MediaTek MT7981 PCIe Gen3 controller.
> The MT7981 PCIe controller is compatible with the MT8192 PCIe
> controller.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

I picked all of the DTS patches in this series, because this is ready to merge.

PCI maintainers, please, can you pick this one?

Thanks,
Angelo

> ---
> V1 -> V2: Improve commit subject
> ---
>   Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0278845701ce..4db700fc36ba 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,6 +48,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> +              - mediatek,mt7981-pcie
>                 - mediatek,mt7986-pcie
>                 - mediatek,mt8188-pcie
>                 - mediatek,mt8195-pcie
> 




