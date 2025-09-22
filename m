Return-Path: <linux-pci+bounces-36653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C718B906A0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832D5189F31C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBD3064AC;
	Mon, 22 Sep 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UnQ+7rt7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2F30277E;
	Mon, 22 Sep 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540851; cv=none; b=oGy++abRoMYG+vs2VAEDIGxbzVyqSA6QqRhfCVCT5Y2rMs6885STdZ7Ad/O6rBzR3dTD2xvLCohmLZGSl5zgyJX2bbK5yv/E3epv7KvJDe6WRXp2Q0xVY/WI2/CD5+wQWqZ5ieFljEyCJW8Rz4Kfzo3cV4a6jJJL3ACALPZ5CLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540851; c=relaxed/simple;
	bh=2AUbZaIKOwlzTX82erdBzqXPBetRqjw6oBC7QipEoLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sB+rYyQSvfxumBMuPO0kt6HoUN/h7+nROIfzgCU/pQkT1UVi3GrKQUe6MASp+UwjvjzR7p/bkPnG1TYP/OBQg2q9ncH9uL4w3/A7F0CT27rpdTQxZYJaAbFBpFkB6pTdnak5J+yyXr7KpcrppsLiO7Urkq/QzmE9qX62ryxlVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UnQ+7rt7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758540847;
	bh=2AUbZaIKOwlzTX82erdBzqXPBetRqjw6oBC7QipEoLM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UnQ+7rt7p6bm8fqURMk8uIg+fzkgNXeN9miaVyrdlgG6UWsCPwLnKOL2V1Aa1VAeM
	 Ei2XHl2RCGyLJb4G2H34kD9Ahkf6uYpG2tLCX4nQbpLWYIvJ/2I9KD7hfWSvS2NuA+
	 LGn0WYE36FG8H9si6wJ+ea+a+h6hZmSACC5lUDdgc62XIojfRQs1toxI/fI99gnSUh
	 lihJExOOpaPYCraAgf5JVjvLxU5h44E19Sa709Q9AvQJLSald+Tty6LuyfRaQ6fhmu
	 eSAayBxov7y0c2JTHmHjSbOQy3Rj14/Qot4lv34MgEEQC4oDuKhGxPQMRKqobE+RXE
	 sRsZnLErho1zA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A2CE317E01CC;
	Mon, 22 Sep 2025 13:34:06 +0200 (CEST)
Message-ID: <40efb310-e63b-47ea-b62b-cc3d614c47b4@collabora.com>
Date: Mon, 22 Sep 2025 13:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 Airoha AN7583
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com
References: <20250920092612.21464-1-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250920092612.21464-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/25 11:25, Christian Marangi ha scritto:
> Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
> binding.
> 
> This differ from the Airoha EN7581 SoC by the fact that only one Gen3
> PCIe controller is present on the SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0278845701ce..3f556d1327a6 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -59,6 +59,7 @@ properties:
>         - const: mediatek,mt8192-pcie
>         - const: mediatek,mt8196-pcie

"an" comes before "en", please move it here.

Also, for consistency with all of the other compatibles, this should be just
"airoha,an7583-pcie": please rename it.

>         - const: airoha,en7581-pcie
> +      - const: airoha,an7583-pcie-gen3



>   
>     reg:
>       maxItems: 1
> @@ -298,6 +299,26 @@ allOf:
>               - const: phy-lane1
>               - const: phy-lane2
>   
> +  - if:
> +      properties:
> +        compatible:
> +          const: airoha,an7583-pcie-gen3

same for this if block, please put it before en7583.

Everything else looks good.

Cheers,
Angelo

> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          items:
> +            - const: sys-ck
> +
> +        resets:
> +          minItems: 1
> +
> +        reset-names:
> +          items:
> +            - const: phy-lane0
> +
>   unevaluatedProperties: false
>   
>   examples:




