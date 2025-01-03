Return-Path: <linux-pci+bounces-19213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DEA006E5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFC87A1E10
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22531E0081;
	Fri,  3 Jan 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SD7VUe/B"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28261D47C7;
	Fri,  3 Jan 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896388; cv=none; b=V0KOYxT/q3SSN5Ed3ixVjBr8z2HLdfJbB+XYfY9QoHCmbNfRUc6FXvjeduxYkOv6Zsv0wUKSWx0wOfV9W0aYubqp1Zkty7v/+uSs+Hf3PeNeumYo4TfvuPYVUP/zMeXUkocz5k+A16lqrCQr+8xiLtMQlC28JsLW5HFuxgMNkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896388; c=relaxed/simple;
	bh=tq0BNbwUpTeePu6kJCwpL8zpGNCOv2kH1BZGfG9AtRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYipfEFHU0D9rKg8wG1bDDYRMSmUvVuIdwPfJsY9mg+9N72R9x/NAln4AGsSN4r3KFeMrkCNmrIeZceLJrNc5ONwIwbNNEfb9/+QH89YdTPPokyD53KOpRyN989gDSWB16eIIYAwNR685N43x5Nv877xQVb4zsK2OR/nVSllVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SD7VUe/B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735896383;
	bh=tq0BNbwUpTeePu6kJCwpL8zpGNCOv2kH1BZGfG9AtRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SD7VUe/BqaCP7/jdawDnHvwK3xeH5gwaU4kXML+3nwWJ6Sh6EdlCUO9t0j+L/o2pv
	 tsuknYq5B//KtfX/b4fhaqb9D+LG4sN+UO6ObpmjR+A6dpmdJuYsG45115A4DPg2pQ
	 4BchYpp8X4yZSuCgbeOALEqm4PbcuzONJgezhMKMaWCDYVHrQK8VG+iPPPNeMGV1BZ
	 mOqysn57+PQvlgt6+UA4nt8e/ZM4r2t45CaYzxmjby1v4uUe3DGZxeD9FMQNX8nudq
	 M5S3hp9cYWiW9syrQ5/4A7yqZpvv19ktrSvnXiUn7bMTHlIB0DJ3qn+Vtc1rQtYq+e
	 5U5ciLldwJyyA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 75DC317E153E;
	Fri,  3 Jan 2025 10:26:22 +0100 (CET)
Message-ID: <0555fb64-312d-4490-9b03-89fca580c602@collabora.com>
Date: Fri, 3 Jan 2025 10:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
To: Jianjun Wang <jianjun.wang@mediatek.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Xavier Chang <Xavier.Chang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-2-jianjun.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250103060035.30688-2-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/01/25 07:00, Jianjun Wang ha scritto:
> Add compatible string and clock definition for MT8196. It has 6 clocks like
> the MT8195, but 2 of them are different.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index f05aab2b1add..b4158a666fb6 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -51,6 +51,7 @@ properties:
>                 - mediatek,mt7986-pcie
>                 - mediatek,mt8188-pcie
>                 - mediatek,mt8195-pcie
> +              - mediatek,mt8196-pcie
>             - const: mediatek,mt8192-pcie
>         - const: mediatek,mt8192-pcie
>         - const: airoha,en7581-pcie
> @@ -197,6 +198,34 @@ allOf:
>             minItems: 1
>             maxItems: 2
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8196-pcie
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: peri_26m
> +            - const: peri_mem
> +            - const: ahb_apb

ahb_apb is a bus clock, so you can set it as

- const: bus


> +            - const: low_power

Can you please clarify what the LP clock is for?

Thanks,
Angelo

> +
> +        resets:
> +          minItems: 1
> +          maxItems: 2
> +
> +        reset-names:
> +          minItems: 1
> +          maxItems: 2
> +
>     - if:
>         properties:
>           compatible:



