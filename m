Return-Path: <linux-pci+bounces-12683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62F96A5A6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B319285A49
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7018F2CB;
	Tue,  3 Sep 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gx84vVng"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EC18E74C
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385532; cv=none; b=pceyhjlLp3UfwSj9iwMTB7K+12mbwQaINEfU5I7ElEXsyU/lDi8CnCMUpMhL6cv73AwV3jWJ85GLO6akcf4xPUOcQORptZaBeclShaqRQitL4KhOMbmJmNu7XhaY4IquUic5jV5Jqu1QDvqiPYf0i0wnO70mksfjRKw67IteiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385532; c=relaxed/simple;
	bh=rYPFCPoP6TAvaL3Ro+0czbeQ09HcZBwhjsTsLYAV4s0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fpB46Q8y7xf75x70/Hi/C0MC1eGS0SH7MNUyPdWua559KVeWcZ+7WSvo9/oKVcJb58GVOMahw2bMIRvErhaEUR9lMF2BVngNGlrC+73CYk5ff9FYcyXayCs9HSCjHBnyzpbJdlIO7pJicyf2Zpu8GWWsQwAFKh/WedkJbod4R9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gx84vVng; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2057917c493so18112955ad.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725385530; x=1725990330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P6f0+kkAoDMMNIRygtqDJeti1CcNmvIahIPj65DnoCo=;
        b=gx84vVngGRZbBYyH/txZZkXWGM8azF/XHNSsZx+E3k/H74+TtYH2laRdNkIUk3HLGx
         aJC/UJiNNuK8JoXfu4hhvBNj2akVGethz1PXaCHhjS5i/wNv2IJviFDh5o1vuCxoufPW
         Unpu2i8u/i/aL6rc7ds21Xdxa0OZd0XoiSM0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385530; x=1725990330;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6f0+kkAoDMMNIRygtqDJeti1CcNmvIahIPj65DnoCo=;
        b=Pk8yKPBpIEicvvM839ZTI9fLSexl5N+Xh4FX3nniVPXn9GBLkbPjuA/76Df9tMxQys
         GC5VoWoRjKaXvZCdkmgv66KtqBSnMHiEyVkS+E86tJNg3g8ZDDOYZopwfU2eVqtN19xF
         Ct8rag08VMbLCQn9cXyUFYoJVTVqFFFHnhRtM2g+f4/48Ayy1/TEGPJuqtLkjw/dsApf
         oniV3oCe0xoyKa0N+Zi3eydKrtk1Yr1khtrjSOIfF6WYvyTgOQLpDts0eC6+C5W8PaVM
         PFuteZv+by/FVlN4IecQ3rxhTm3FzI77q+AicBh7t6EahKowIbaizj9vhMMG5cLODFmQ
         WUhA==
X-Forwarded-Encrypted: i=1; AJvYcCWmq5A9Q7G+qplMgPUhv0OChemRyh2IOJYFL+ptVeV9ApGN9a661xsggZ9Vywz4JL23BWn1mJK+tsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV+pj3Su1vQg29eFNQIcfYw8P78UEwpZzl43WZaRDx+S1haSK
	GQ/GgnAyAAE8F0YptMGv+60gthzTg/f5gTfoqx+6x/rVkUe5WWQqQIoAhXGtqQ==
X-Google-Smtp-Source: AGHT+IF4a+RzkWGPJDt3e7oGqe+xveFDIyLkVpMgSpCetnaEKOW1ehZUjPnPiS59EGj0zcA0/2Nomw==
X-Received: by 2002:a17:903:234b:b0:205:866d:177d with SMTP id d9443c01a7336-205866d1ac4mr110496075ad.21.1725385530463;
        Tue, 03 Sep 2024 10:45:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67a68sm1101985ad.280.2024.09.03.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:45:29 -0700 (PDT)
Message-ID: <8160bbe9-3b36-4232-8d34-4a5ecaa6815e@broadcom.com>
Date: Tue, 3 Sep 2024 10:45:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: florian.fainelli@broadcom.com
Subject: Re: [PATCH] PCI: brcmstb: Sort enums, pcie_offsets[], pcie_cfg_data,
 .compatible strings
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 jim2101024@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240902205456.227409-1-helgaas@kernel.org>
Content-Language: en-US
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
In-Reply-To: <20240902205456.227409-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 13:54, 'Bjorn Helgaas' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Sort enum pcie_soc_base values.
> 
> Rename pcie_offsets_bmips_7425[] to pcie_offsets_bcm7425[] to match BCM7425
> pcie_soc_base enum, bcm7425_cfg, and "brcm,bcm7425-pcie" .compatible
> string.
> 
> Rename pcie_offset_bcm7278[] to pcie_offsets_bcm7278[] to match other
> "pcie_offsets" names.
> 
> Rename pcie_offset_bcm7712[] to pcie_offsets_bcm7712[] to match other
> "pcie_offsets" names.
> 
> Sort pcie_offsets_*[] by SoC name, move them all together, indent values
> for easy reading.
> 
> Sort pcie_cfg_data structs by SoC name.
> 
> Sort .compatible strings by SoC name.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

There was some appeal in preserving the enumeration in the order in 
which the chips have been produced, like 7425, 7435 etc.. but I see we 
probably got some parts of the timeline wrong at some point anyway.

Should we push a bit further an accept a little bit of duplication and 
simply embed the array of register offsets directly into the 
pcie_cfg_data structure, rather than a pointer to to an array?
-- 
Florian

