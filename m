Return-Path: <linux-pci+bounces-36841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960AB98EC2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 10:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FC5188DA7E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DDB280CD5;
	Wed, 24 Sep 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dIkiCsN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D22773D1;
	Wed, 24 Sep 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702990; cv=none; b=BXFodpkj0vKra6L+PWOWkn3oh+TOBgRVEYoszx2IlxNzvh/O5hdqjYj4+LTyjfAshMROyHYoWxUnEjzHJKNvFUtMI7C7gxi+ALrR6sDssPh24RhKHHv+ihS3+IcUhzAO/coDUGSxMu5JO1Sf8TUpkGMswDYvnuSISMr2wOSbHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702990; c=relaxed/simple;
	bh=y2emJ3dCkKOLxXAImQ9Iunq9nqId75ZvptZuFpfKlP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dUBWx3qLLfI/WGu56uFi5tEAr1jCRt9WYATDRsxEneFM7uNXH+u8Yt0GTD+1hZgXlxuxkgIpXeomM//P99sSNwIgehjNJmkHEcw2DiWP9DI7y+tJNWFhuPiwuomzJejzXXAvDR5m2D0S9JbZhR6Y3M2yyuzmKDhPZ4mCdvprqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dIkiCsN6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758702985;
	bh=y2emJ3dCkKOLxXAImQ9Iunq9nqId75ZvptZuFpfKlP8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dIkiCsN69Gm3Y/Um2he7IcoInbgW3QKztEMubZde4HWmm7utmioP5m/xdywfOcUGh
	 5iAdf8YHvgMw79jfB31uUbH4Nq7qSd8+xLLvaZro1Df1l/FA+zdlUbFz/WoEzstHKq
	 QZKTQkJy+FWNR0A1AlWET2e7JuOy+KxpH0nmR+vougchQ9tthRqSqwurhmpCpb2W6T
	 iNXp01B9k0cZ+g/DlxScCYqYSPUzDMc3kZO5kpmCbM87BFLZO7ofrIqYehWe5oHVyv
	 r9tINJhRLh7J8hGhh3Mm+tKy3phxIWnQqsZ2rcDXWz1/qTmUDts19e0cNIunvgb107
	 p8lHC524+Od8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E85017E0C21;
	Wed, 24 Sep 2025 10:36:25 +0200 (CEST)
Message-ID: <5613a7f0-c624-46ca-9c65-1b48b4e3e3bd@collabora.com>
Date: Wed, 24 Sep 2025 10:36:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
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
References: <20250923190711.23304-1-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250923190711.23304-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/25 21:06, Christian Marangi ha scritto:
> Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
> binding.
> 
> This differ from the Airoha EN7581 SoC by the fact that only one Gen3
> PCIe controller is present on the SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Fix alphabetical order
> 
>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0278845701ce..1ca9594a9739 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -58,6 +58,7 @@ properties:
>             - const: mediatek,mt8196-pcie
>         - const: mediatek,mt8192-pcie
>         - const: mediatek,mt8196-pcie
> +      - const: airoha,an7583-pcie-gen3

In the previous review, I also asked you to change the compatible string to be
consistent with the others.

airoha,an7583-pcie

Regards,
Angelo

>         - const: airoha,en7581-pcie
>   

