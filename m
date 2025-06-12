Return-Path: <linux-pci+bounces-29612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB887AD7C91
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5288B3A39BE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AF2D3A85;
	Thu, 12 Jun 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pf03wBG/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24820B806
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760672; cv=none; b=F4lVUBeK+qKzJ//G2eEGjG6/IiCAqoV2gC5O52XS6k8wj8ZJvTrZuwpSsriTkXIY4g3V4FaHITgVkom5xZyTzy3y14iD9T7JbYBrZmzhMoI1FIyceUlzAaWRc7KHsZupxd4VqKwlnYkg9YGNgQVi7ysMG/uioJ6v9fPZ6V3SxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760672; c=relaxed/simple;
	bh=xSZdo/Zzd05ugnakn4C7C0dQqii/sRlp+AQ6zI0Eg90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwACLdyrG5wKvxx1RJzcjj613oUgG+whpJRx2PataYe4/m9WHfgcz8y8VEFptqeGRUeuZj63JVsW5x9OhbjLGkDXl1onq/qVsbR99sj3WVB+vRRQYZDdFLVWqNGIm5S9h0M41nOtJ12/DYkmBZ2EoL3JkqWTnouU/YVhUnU4dYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pf03wBG/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso1758685b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760670; x=1750365470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7HWklvJfKy7JIO8DgRBbmTBlL/1LchC6bmvGtj26N2M=;
        b=Pf03wBG/7mkWmktQbbFEDFEOp/p1KHdsqJNXzZ2sKVdznjU8lI83Krd1G53rs6QPjR
         axz8A19z6kM6ljOEO03w0BVtwElFZXMI1MUZvOtC9ETPvfNru5V2lJGV1k8Sa5K6NofO
         Y4aFDXSUjXJosbheuha7CDR6tVciqs743BXkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760670; x=1750365470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HWklvJfKy7JIO8DgRBbmTBlL/1LchC6bmvGtj26N2M=;
        b=V2+/aPiaffdV9fJrWw0c+ZdL2WO6kEtfU+f/Fq/nzyzmpf5LjOZdYskGavrcdQvSMA
         Dsl555WDH7JMb8tmg+4iLmjexr15fe1BscJ9q/CgEO9+Vpp8pzeO7ic+eZy9vMLPm4il
         c4PtA4m3Due4Q/5UTFRJAVSDtW4gr9TzEWnT4rW+yaoCLmNS1OtIdrJzy/1Zm3WpQdxB
         BV95+f63H+P75IImz0aLSxo1GV9Ywtfm3EIYV7me3+4fxQjXTy96Riw9OwDq3Q+pbM5W
         jpbH/r5+I4RBXRP2iF3ZC1ACiPAoNLg8RuZ82UVLN3gjy32llLHJh9KDSrvR2egchZ6H
         cikg==
X-Forwarded-Encrypted: i=1; AJvYcCUjap5Y9ZdBuKQ62yslcGsXuXZRA/ok65E37AOH0IXjR1Xi5pfUzzaCEHfvH4e1L0I/xTYmbDoqfYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBj8krrDAxr+D+BLFi4gLWQh6r2pfj2TvjyAOCaZBjTBvyrA6
	0NZRrmVqyeNsoqb90PCmkQETQsn7OgPkm72fpF4r2TdYr30h6IXHltYbxq9qxwge3A==
X-Gm-Gg: ASbGncvYuYrk0YQTQXCUQdQGy7/huFkU34MDyyVvDOD3a2ClDxYY63HC8Pjd3mivAyV
	jr/TdBNT8Zax4gaXEsxTuxPR7YoE0M3mnavDKNj63nYVYu2Udd3P+Neq9TCtURHBQED1bPL87vd
	8JrrAOFvsUDwHqHKwA3C5o/4Czjs/x6oEUGzd8/0KwcybfX/NxuqlLChZYux+cA9EkDohvcIcJV
	i4Q1UnBXQx3dj7sXKkdX7xGIS6zicH7w2nrUebGuYy7l0HPLBcGqyZx+CofYhw6EoXiqcm81F/w
	LyvOLbGkzLfHvEuLHg19i1EbBHhUKqWP0kJZbDo5mKSM3USWVCItzTrWPrxjMb6jRZ8Fo+yTBkn
	upNAoIipbLzKgllSitv+rP98wSw==
X-Google-Smtp-Source: AGHT+IEVcVYG19AKfNaCIbnScw72eqDzUbGwGRCRwGuLcyoKLwoOFWNS0WrxzkDzZbCoZAXbB3hpwQ==
X-Received: by 2002:a05:6a00:2307:b0:742:a91d:b2f5 with SMTP id d2e1a72fcca58-7488f6facebmr786242b3a.13.1749760669874;
        Thu, 12 Jun 2025 13:37:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d252esm154388b3a.163.2025.06.12.13.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:37:49 -0700 (PDT)
Message-ID: <0d957a78-0eb4-4474-a251-50994e1a88cb@broadcom.com>
Date: Thu, 12 Jun 2025 13:37:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: brcmstb: Enable Broadcom Cable Modem SoCs
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
 <20250609221710.10315-4-james.quinlan@broadcom.com>
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
In-Reply-To: <20250609221710.10315-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 15:17, Jim Quinlan wrote:
> Broadcom's Cable Modem (CM) group also uses this PCIe driver
> as it shares the PCIe HW core with the STB group.
> 
> Make the modifications to enable the CM SoCs.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---

[snip]

> @@ -1354,7 +1417,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   
>   	brcm_config_clkreq(pcie);
>   
> -	if (pcie->ssc) {
> +	if (IS_CM_SOC(pcie->cfg->soc_base)) {
> +		/* This driver does configure SSC for CM chips */

Nit: does not configure SSC for CM chips. With that fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

-- 
Florian

