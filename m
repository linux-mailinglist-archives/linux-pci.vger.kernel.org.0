Return-Path: <linux-pci+bounces-29610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D8AD7C6E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73477AA246
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF620B806;
	Thu, 12 Jun 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/0IBsnE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35D170A26
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760420; cv=none; b=lvjvn88sfM4s/Q4t8/rpntIuUMklTW3lFtdRfADz8vy+XJUjnkBxTgP393MUHxoZzrP+YNJavw+upDgCXj0bAxf7Ks2q01CFb6bqdnuk7FAdJW2DOA/eBp8+sgKSYExhcVL2leGVrHlY83sj1mWdAopsGxTSDZ1hRRnoAsenecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760420; c=relaxed/simple;
	bh=2M25hDcowO9r/dKivoIyxFyLQS6kg61uVhGlx2ia3Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQnee/z3AkeNfWN+chKos9XiG2P1o+WFWT1hKb1BVE3ez/LOLhwfxLjC6d9jWb0NmDalgqfbxkO0d9sspuJAFv/QBM+GMm74ufLpDWU04J6YKQl8zAxIL/FJ2JnYD5Pc8iTtaDTkpfPO9KjzZDV7fu3pGSHSEmlojAZPSeWUs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/0IBsnE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2426123b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760419; x=1750365219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mOgI8wkRh/TcHLzM6q6KrFLM1z1tv99KRwudvZ99sGo=;
        b=H/0IBsnE7PzmfsUr1yE+v63Nq3h4C60uCoY2QcME7fa8fVz/eTWP/0rPrnmG3rjI54
         rSK+1dUE3EYojI/xJFXn9ZbXA+5XXRVyrzH2678wb6jLQV04kl0hIy7WaaDDDIwowEaU
         0ZnW/RNwaupKYLpg7wWbcVCPHNv3gE1Sryc98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760419; x=1750365219;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOgI8wkRh/TcHLzM6q6KrFLM1z1tv99KRwudvZ99sGo=;
        b=U2HC3aS/H7n7aspnufbbytEDzUBCnoKRinSiSNGQlBWT4fsQn6JdZZ7KkECIb9NVPr
         M6K2n7TivKsglmPN+BC8XFOY/IA6j3ltJFqbjrhrzzeceaEiNv5LPbXYdHHSHE9MYUJH
         h0BGCeDwfhD6/ShgKBTrSxzIwuqJqHgVHRLGKzqA7RtagR2n5f3goghTafVlwdz5JuVL
         TLu+bRoOQ8kivHyyeN9LWiD5qjBMiAqYH09NNAJjiTDGTvs4KNxoMapcHrjtil6EGMie
         d5Qw9tbRXBjj+4iC8QI67ChEn3/1iF6ovyEyeZG4MxGsatqUdVDSfvV9iAHrjPP3RS2M
         ka8A==
X-Forwarded-Encrypted: i=1; AJvYcCUHEdYDIL1vq0X5JFiAFcWMhAHBuNFXw/FoXuCSpCd5z6sK6vM8lTODM+9lf69QRhkQYUA64Q6SQI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4TV9jc13TUPFuyOT0XaGaYHQtbbEPf/F9Cvi0qk9hKl9vLeL
	2/j+qizbSXD2mCTqnNXTIdi+i2BMGPf4qnNfU5+7wgHZYSvFjd6oSFMDV95y67AcDA==
X-Gm-Gg: ASbGncvK3hA7c3F85ois3IJc9MTZAJK6HYUpTPpYVEFWEtQgRd1/1C88909p42VHXou
	5gCqbftPiUTZpkFCHfh08waBwMYEK9kirI1ZsLHV+rnxPaow/7UsZzHuKmhEOyvtMnfkNNHCTHT
	avHJ00dF8d4bOR+UW559l+Njh/dSS8DQMRucQp7eaD+y+XwFFQdzieQMqJkfCiS8g1e+WA1XxWk
	0sk1mp7AZslNGVAdLyVIFmROAkRRIsZ7EUchAQCf9tgXmokTuD+oHVVKEv/nCpyEOfx5amWJ3tW
	VqSSZ4aFFbRo1KmKfyhCq7uO1JAJmpl/lxAM2aL9JTFA7Jwi1AU+P95zGqMTsZSBQdR30yYxzKG
	PafPuyGa36l//qdK8qaKvL7q5WQ==
X-Google-Smtp-Source: AGHT+IGxWTQ3G8N7AIkSjljWYpk+4BK9api3JAi+StL69DOF4TENkbk77s1blE3dNgT6Hnjl5aDBjw==
X-Received: by 2002:a05:6a21:9005:b0:201:8a06:6e3b with SMTP id adf61e73a8af0-21fac38085amr604842637.9.1749760419027;
        Thu, 12 Jun 2025 13:33:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ce7adsm155996b3a.149.2025.06.12.13.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:33:38 -0700 (PDT)
Message-ID: <39805e5d-fecc-401b-a11c-871e215f08b3@broadcom.com>
Date: Thu, 12 Jun 2025 13:33:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: brcmstb: Refactor indication of SSC status
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
 <20250609221710.10315-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20250609221710.10315-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 15:17, Jim Quinlan wrote:
> Instead of using a bool to track the Spread Spectrum Clocking (SSC), just
> use a string constant since that will be the end result anyway.  The
> motivation for this change is underscored by a subsequent commit that adds
> Cable Modem SoCs to the driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

