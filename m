Return-Path: <linux-pci+bounces-7740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1A8CBBD3
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 09:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34CE1F2237F
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830077F2D;
	Wed, 22 May 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r0lo/d7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EE2233A;
	Wed, 22 May 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362267; cv=none; b=dSG4KXC1P5JE5q6oT4iz+DcuE8by1RMiAw59bCa3JyRo7WPFJQekflY21u1mK/Wndrnv4YOaW8J+W3rASOpcFF+RorR8hav/1BjG72rySQiwbcm2CY39J5G+MwU+lxcPrNRzGCWXji8QpV4tTi7M7UIBEEDqnao1Pmohs1ZNHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362267; c=relaxed/simple;
	bh=S4+VlRYjbyjOZgdhFha9p34kKt6KjBudlxAU/clKD14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZgLzHmGW/adhZg2Qy3gvtSjsbcoBAmSX30WQu0b52cnqB+UbWdP1N610I2Ew+cvp/byweMNldYQpkAk7NOO9jZCl/dNz6hzUHOjUsFJHHSAYSAwBMi8yzykOorw4BUfnwkpGTgmjVuxBi1GayFRAvwxP/L3Gcp/w2uPZQvWe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r0lo/d7x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716362263;
	bh=S4+VlRYjbyjOZgdhFha9p34kKt6KjBudlxAU/clKD14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0lo/d7x0JyE1O8oKfIQPef1AKCZ3GUtCkMvX9SiMYkyKn3gWAw1kXgN6VLtr5w/f
	 RLmnOZDgjU7Ft4ig9dhZZbkqKoRNB5Y1XWn13lH365hIcAMFuOlmm2nAsoSHJJop+F
	 GJvSO3TISL8WrBO9aUf80A/ncF5LPBsSQxGeHpJo/hbD7xkQCVhue8/rOQGEV0omqF
	 sOGj4Z69669yMBPHi6x9JzWMwMpYr8Mv7myfMEqdTL3QgiD7W+UP2c6uLGGHcceAuv
	 Vxs9DAIX/IVBw4zhXIFOePlkmism1/706nAgHRu3sXDeuf9f0uYkP0ct4yPaUbAe+h
	 F6Sg/wXiaTh8A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E5CE378214D;
	Wed, 22 May 2024 07:17:43 +0000 (UTC)
Message-ID: <e856dbde-c712-473f-a761-cd29d6e8d8b5@collabora.com>
Date: Wed, 22 May 2024 09:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: mediatek,mt7621-pcie: add PCIe host
 topology ascii graph
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 kw@linux.com, lpieralisi@kernel.org, bhelgaas@google.com,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240522044321.3205160-1-sergio.paracuellos@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240522044321.3205160-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/05/24 06:43, Sergio Paracuellos ha scritto:
> MediaTek MT7621 PCIe subsys supports a single Root Complex (RC) with 3 Root
> Ports. Add PCIe host topology ascii graph to the binding for completeness.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Lovely.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../bindings/pci/mediatek,mt7621-pcie.yaml    | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> index 6fba42156db6..c41608863d6c 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> @@ -13,6 +13,35 @@ description: |+
>     MediaTek MT7621 PCIe subsys supports a single Root Complex (RC)
>     with 3 Root Ports. Each Root Port supports a Gen1 1-lane Link
>   
> +                          MT7621 PCIe HOST Topology
> +
> +                                   .-------.
> +                                   |       |
> +                                   |  CPU  |
> +                                   |       |
> +                                   '-------'
> +                                       |
> +                                       |
> +                                       |
> +                                       v
> +                              .------------------.
> +                  .-----------|  HOST/PCI Bridge |------------.
> +                  |           '------------------'            | Type1
> +             BUS0 |                     |                     | Access
> +                  v                     v                     v On Bus0
> +          .-------------.        .-------------.       .-------------.
> +          | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
> +          |    BUS0     |        |    BUS0     |       |    BUS0     |
> +          |    DEV0     |        |    DEV1     |       |    DEV2     |
> +          '-------------'        '-------------'       '-------------'
> +    Type0        |          Type0       |         Type0       |
> +   Access   BUS1 |         Access   BUS2|        Access   BUS3|
> +   On Bus1       v         On Bus2      v        On Bus3      v
> +           .----------.           .----------.          .----------.
> +           | Device 0 |           | Device 0 |          | Device 0 |
> +           |  Func 0  |           |  Func 0  |          |  Func 0  |
> +           '----------'           '----------'          '----------'
> +
>   allOf:
>     - $ref: /schemas/pci/pci-host-bridge.yaml#
>   


