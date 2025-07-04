Return-Path: <linux-pci+bounces-31493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA9AF85AA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E6B1C81F79
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C111DDA34;
	Fri,  4 Jul 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VqP0gtuU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EA1A4E9E
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596888; cv=none; b=H7PUGwXL0I6K1dcnJ7wI9hBqwtUTOJz9fuOxJBi2jaknJnH0L0SFJiee2+pK2+l/ykDFfkBkW+InBOpsIb/sV9WdI988g9e82dOAvLLj3uxEKxJ64tFrsQkp6RjY419u+2PlL3tu3ViKhTHYKeejNGw1j73IzUNdZki6La4zOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596888; c=relaxed/simple;
	bh=tvOVHCmrAga8yT5RJa+gc1ayXIRYhm9A23B9jDd++xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXiVbt2Z3E1Ql3lRk3kyQqsrsBvzkIhko9A1WsQNJI6q1DZlkRNVQwJmWdvnPWjOR500gIrYSOgnutcLYwSA1hSx1MKPhyg8cEOp/TTvmYDppPSxMNYFYFvc20LeGax+dilgVJfpLskmrGxwJjYxcNia5aQCdwWiVGikxatuIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VqP0gtuU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fba9f962so460667b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 19:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751596886; x=1752201686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s+Zyx/6f+av6RaItPqWjq5QgqXvSeXSnOyIGM0o0Vks=;
        b=VqP0gtuUrGnaWLaS6FmPAm9z0UWsR9PumDfZwN6FytUm9iaO/sQ4COyr99SIIzQEQM
         nGVO7c6DWn9d0wiPolnrZ6oHDTtTnhwZ9ktdrt+ZGKYZGCc89Lru0vuCgmIJTNO31XNL
         rmx1NTPojra8CY7FjBEoBa+Y92nL5HcSlMFbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751596886; x=1752201686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+Zyx/6f+av6RaItPqWjq5QgqXvSeXSnOyIGM0o0Vks=;
        b=wS4wPTNErDFig/jvr6G5wxpbMPKZDR+DyUnblrrqfs1NU+aGJwX+Hm6ymyWu4g3W7N
         nnCmTY9beKhD6O4bpP6L3Zrmm5uNO+pITGVmgIGixfDOf9sWHq7/vXsdh183rFD7YR+Z
         uNoPklRxqWMJhnuUTyXjqjoLKZOvRi/yQy2uRw3GR4yYYNvSIoaldePOHHPywzKMqBnj
         BNizX7ZGKTuBYQmFrBLolz6Y+wlZiC6Ar7HYu0du95XXsqegZjqnCiIZNOZCgs4aXt6O
         zT/4kM1R7FViHbvwJoVclq/jQi3G+mglgqSbMWJh9yPrnhqyRGAHQb8dezKgPItePxsy
         XD1w==
X-Forwarded-Encrypted: i=1; AJvYcCX8ptW33HirGj5GmhkX4HNS/W3rzjWkcM6cBKQjXT7bl73oqEjyewGzyYvc6mF1Ocxw1Fkp6RVg9Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBJhoBPi+P5m6sdMt83kwz1T0NVyiTovAse6VYsRJVvcdgX0Q
	wiML087CG5oyJS0WpwG3DBKsTx4x8dv4v6odPQhjDAZ3A8J0TtUXbOMvZH7s+SS0Hg==
X-Gm-Gg: ASbGncsO+M3pWn7THNUINKR5mYriFM8/EnMxFCfNFFXzpj0f4quzerMm1Rfpg5rINdz
	wmLTrZKfkrIC3k6Q2/MQ41Mt7nJEH8ZVmff98t+12ESlxOqoDEp0oyTeyx4bRekjlJUTN9WCU7x
	DY/ocxlVfcvK1+LH1Yc90oEQTIYqBAqtnfbg4e1IelF7vBDwMKF85ikKQQhkQk5RwB4hVfOjr2D
	FdRJjY7N9uQYZP3A3QT3aEhJS4Xps1GGxvICZchhA2qwwBccXDsiKO/GwNxEI3Krz2UVAY/VBdx
	TTA9tHLCKaOWHvtQisigyM0wYjglLN9drRGLQi4Sqo6Eu0pZVIlFAzgetXmknG5QHSlm4li6cKo
	So5pgPC5vQtJgHx3/wg==
X-Google-Smtp-Source: AGHT+IGJwgT9LS+NWb/RXEybr1oxVH38tHMmZgho/2z5OGzaAVRcM/LGf9l41KlgP5Y8Fve3tnJckA==
X-Received: by 2002:a05:6a00:10ca:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74ce6027efamr1481354b3a.11.1751596886362;
        Thu, 03 Jul 2025 19:41:26 -0700 (PDT)
Received: from [10.230.3.249] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417dd7esm905211b3a.97.2025.07.03.19.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 19:41:25 -0700 (PDT)
Message-ID: <df093a8f-916c-4afb-ae53-4736f2368ade@broadcom.com>
Date: Thu, 3 Jul 2025 19:41:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: brcmstb: Add 74110a0 SoC configuration details
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250703215314.3971473-1-james.quinlan@broadcom.com>
 <20250703215314.3971473-4-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250703215314.3971473-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2025 2:53 PM, Jim Quinlan wrote:
> Enable PCIe for 74110a0 SoC.  This chip uses a simple mechanism
> to map inbound memory regions.  Both the "ranges" and "dma-ranges"
> are identity-mapped to PCIe space.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

> ---
>   drivers/pci/controller/pcie-brcmstb.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 362ac083e112..bfedab15a162 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -276,6 +276,7 @@ enum pcie_soc_base {
>   	BCM7435,
>   	BCM7712,
>   	BCM33940,
> +	BCM74110,
>   };
>   
>   /*
> @@ -291,7 +292,7 @@ enum pcie_soc_base {
>    * power of two.  Such systems may or may not have an IOMMU between the RC
>    * and memory.
>    */
> -#define IS_NG_PCI_SOC(t) (0)
> +#define IS_NG_PCI_SOC(t) ((t) == BCM74110)
>   
>   struct inbound_win {
>   	u64 size;
> @@ -2046,6 +2047,14 @@ static const int pcie_offsets_bcm7712[] = {
>   	[PCIE_INTR2_CPU_BASE]	= 0x4400,
>   };
>   
> +static const int pcie_offset_bcm74110[] = {
> +	[RGR1_SW_INIT_1] = 0xc010,
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x8000,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
> +};
> +
>   static const int pcie_offset_bcm33940[] = {
>   	[RGR1_SW_INIT_1] = 0x9210,
>   	[EXT_CFG_INDEX] = 0x9000,
> @@ -2162,6 +2171,15 @@ static const struct pcie_cfg_data bcm33940_cfg = {
>   	.num_inbound_wins = 10,
>   };
>   
> +static const struct pcie_cfg_data bcm74110_cfg = {
> +	.offsets	= pcie_offset_bcm74110,
> +	.soc_base	= BCM74110,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.has_phy	= true,
> +	.has_err_report	= true,
> +};
> +
>   static const struct of_device_id brcm_pcie_match[] = {
>   	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>   	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
> @@ -2177,6 +2195,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>   	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>   	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>   	{ .compatible = "brcm,bcm33940-pcie", .data = &bcm33940_cfg },
> +	{ .compatible = "brcm,bcm74110-pcie", .data = &bcm74110_cfg },

Nit: if you need to respin, it might be nice to order numerically here?
-- 
Florian


