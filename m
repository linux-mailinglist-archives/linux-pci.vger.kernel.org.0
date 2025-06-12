Return-Path: <linux-pci+bounces-29609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B200AD7C68
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5EB7A2D28
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293C2BE7C6;
	Thu, 12 Jun 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qxlfl7P7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886B1D95B3
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760400; cv=none; b=dKQ01T3EjKVbUfP2+pqN3fzLxzxfzsN9yvlPgty2qltXlfP32jKvnz0QHBpsdM75AypiKJDP9fsvCaKelLKMtV7OU+NWVDVf8kipv0AjR7YLTcc8nbVcLamvwnvoazCw7AMxN/9yU8foMNKnn5Nhu4NyXmGuH4s0orsTuUngFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760400; c=relaxed/simple;
	bh=fGBDmziyIRuXQZJnl6uQGrXC23dRZIVMVbpxEXsAiKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2foApyMGEuiYKE89N/P5msG20lq6dOMF4mvqcgyG4vlIC/TNe2FJLkfeh6pTc12xNIrdZYme7BT12mQpOeRzYp7R5py7mAZ0WPLkbyaqd5ro8HbyZWjWkHup4Q8aujkWGdVckGVMp/TVDWzFlZ3SJb9YabtJKN2bJFOLOFHJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qxlfl7P7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1255694b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760399; x=1750365199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qwZraCb/toXwxJFa7U6Iu6ktQLnnjzZR5/ifzAHb2qM=;
        b=Qxlfl7P7uFObmjIuD3P7kAV0IzBSKzRjicpmiuilJRgmxEAUbrJRWBl5rH4fKKVtSG
         i1zcrduwEZaVEiP/Ofo8BTF49Ckk6APtHbE3t7irI3p7GEwCLYE0VbuK974c1G+BFaqH
         tixUbSiiZe8hiZNkuhp69U9pP8426jUceUEds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760399; x=1750365199;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwZraCb/toXwxJFa7U6Iu6ktQLnnjzZR5/ifzAHb2qM=;
        b=HPuNjqCCwrh7sDKXZeNjQ9zHQ3vc3nlKNKzjX71me4ntUM/eHGN3EtS06K2tNSk+JF
         o3jHoVCEfzQrn3yloM+F+OUriUZKl+6AbTrtpMi2SVyY0V+Qr3bsTtErCl94cldcF+Bs
         RBqFzI/1BGmEX4xxidlqknQGf5r3Hnzi/Ngn9Pr4Qp6ID2zzo3j60tlcRwOO3nW11P/j
         oEglufu03bRhp0nr2wGfwphYvLG0un8hdHII5mXmuDyQNSeo5m96s8p1yKQQ33GFNFQU
         EE86jU2AbZO3nLIZfagHlKM6tbhLg3doVf17w/XeXcBJpkThGTkBjrjjk6O4Hwdeo2wZ
         UBxw==
X-Forwarded-Encrypted: i=1; AJvYcCXt+wdJewjBan6KeauS6rTj8GAPbKkwn19p8pa1PbblCIB8AZu9rcan0553+KGWHYH1YUYHiyPU3FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYy63YIiGd/CaCTR7Y5/OR35spwXRcCAR1tE/mMOcCHdIHNr2
	9cbDsaAvjcNc1G8I8nc1cqOdiuTbPZzBIsy8MpZ0h6toUwk7Fgc7RtgRBjagnt3qdQ==
X-Gm-Gg: ASbGncum6s/tplCc4jVFrEUpj48pSFkvXgblWKB/sJV/bL+u5cdax+6rIBZPUxZ3Q94
	aiwpPVjqNF8Aai4Nr+bx5zikW8q4HJkHqkfuincwk+u6qvmURdS+UQqjyX1KwIgVMysQHbddbeI
	PNAYl44aFypETiaIArS9FqYNmELQVWKJn9eK4TrO8lu9uPmNsk2cPRFL/cuVRO/nyCFHQ00cSzK
	YFCLGq8nbOmOYFfqI6GhfW7pNYcqy84eoVnpCDwwagfI4U5RlhQcSvsvk25K/uzqKP9VGWC842K
	U2fOeVUeeZyFq098uNyB62v81rtwg1F1XYJgo83THdkJDuHQL82idppN2uvqsfk2CGXc7A83QF4
	b6o8XtDVqDys83RXKT8p5KyscQQ==
X-Google-Smtp-Source: AGHT+IGmDN5dx5IZAbkRjssr+2utVCHnvk8DVR8P7vF8WVwd5EOmE77VMLC93zSUoOrUzZXL5NP8+g==
X-Received: by 2002:a05:6a00:2e90:b0:740:596e:1489 with SMTP id d2e1a72fcca58-7488f73f776mr864997b3a.23.1749760398965;
        Thu, 12 Jun 2025 13:33:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9d1sm161700b3a.30.2025.06.12.13.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:33:18 -0700 (PDT)
Message-ID: <b24a0359-50e2-482d-9241-7889af85c365@broadcom.com>
Date: Thu, 12 Jun 2025 13:33:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt bindings: PCI: brcmstb: Include cable-modem SoCs
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
 <20250609221710.10315-2-james.quinlan@broadcom.com>
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
In-Reply-To: <20250609221710.10315-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 15:17, Jim Quinlan wrote:
> Add four Broadcom Cable Modem SoCs to the compatibility list.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

