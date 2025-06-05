Return-Path: <linux-pci+bounces-29062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EECACF9CA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A483A313E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8717548;
	Thu,  5 Jun 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZxYHmSnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4C27FB2B
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163350; cv=none; b=lVu+klSWBk5cabt5MvqAQsVjf3yVmniMxv6jx7e/b7ue/i6HCWXAHkkrAckTmH7rOvKcXWd7zzOheqMavjB4TMAMerFRZd1OnrHJs7ky21PaBjSwa6a0eJQHXXG8vPVmvLjmCgfiv/opSiTknSu9O570ZlRxkmWXnKHkb2C+kCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163350; c=relaxed/simple;
	bh=R7dbsBZjJE2Azjg5R1VQDyU3z2Exy8+C3l8TPo4Ywkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izv9fVwhqxotyqP4Wh7EMBVR9qZOEl3UiEFxTnEOSjiHI8hFJo09GJ/lnDpONQrGwBTdN/o1hulnhspe2maqVVjRiSBhiZWOBOgT1pCJtDxFSGLapHKlVfTqeIsIdLemsr4rVeqZUmudg/OzT/gl8tpyZwvM/FMP4R4/HCJpU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZxYHmSnP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22d95f0dda4so20212565ad.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749163347; x=1749768147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5468u4m8pLTcYAildW7Ghv+ZFxFp/ImHQGuCTAzbeI=;
        b=ZxYHmSnPDRHWwvdnWBOjcgmuqLw70PiX2ExgOOF8lWNl7C8FBkvzbtjiX0l8MBc3Zr
         ZiA4eakMctBTSUPxbr+9zGA+91n9L/fC6gzEizEowg2NW4j6V9NkSUgETW7w7YWtfJdJ
         1U+QbIetBY4ttOTRboM6yDSff39gVApD6VShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749163347; x=1749768147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5468u4m8pLTcYAildW7Ghv+ZFxFp/ImHQGuCTAzbeI=;
        b=gNfgcQzXxQR/UikqclrhnFqRaZBmbM/eas+jbtRDdWq5o20rjMYMpOcq8+/+bHZyYU
         qZEBq7Lutu7zdd1T9e9W9kd0M5c0LE9QkmPLFb/tKA81E/XI3xvxd0OOQ5Dt7j0DPJxY
         ogUbSd1dncfeHfVVybHTGziMRAZfW9foJL0UQAM8P/wN60YCzkIEnJ937tSWqLl8MlEA
         bP0Hi1qeNTNXsNzEYLMuTUQwEn2YTj+czuzD8wbkp7KLxd9Z7sVjLWGaynkKUbyqw/2H
         w0gAJB6PRtNBjjrpTXntAtro/Rwob70O13j5JYbZwbfjj1BkUJBURoScELtRgu8SVdFK
         gxWA==
X-Forwarded-Encrypted: i=1; AJvYcCUrij+2+h/qfp4puEstGJS4eThKvkJQSYSfTRDuzs830a3pyrvDVDkgpEmp4VpU85pon2b93WVVZnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO306xawKI+eKVcDANySOp2Yer/VTXqcKsrezWAZamjlb6nyHv
	BjtQjSPj6Lr4N0D285WI31J3/oGskj6Gfp9rVMRi22quERhqglMooQvMsSUjj7UksQ==
X-Gm-Gg: ASbGncvFqeYq6ZsiqDqEFGyN8jy0H3TZBzIP02myJ5BJh/bXZDdyZP5seN+tmA6u6cY
	onixRZgiKgH9NbhA6zIZs2AFGN10v9E+loA3fCR+QZR93f7846R/hFYHl04UgEvNlkEP97cRhaQ
	/NHDpMISOfuvTKKb5eZrpptGpp1+aROOFZphc64fFu7NUF+1Sk+rmEYMVRQHpFAqgSCCn+80r4U
	rd3op0ucFwzGAXrfs8Llpl/5ypgJeC4NXVrUI4YYudW0Sn8lwQV3Pjl2EPnKXHeQPARE7U/Pk8t
	2bGxJkbWKkw+bxOv41dXdlR2ahxZ04F0hoVO20CJJ+RGUe8GN/k8+ug0Ihfjf3vVZYyTso7KAYL
	RQTQNfxCfPYSOptE=
X-Google-Smtp-Source: AGHT+IHHHFpE6BSf2Tcrq2DmOOYCDTLBu5+JqxnkzhVqzpPGSyscTwfKDff0mEiWe3sKIkDAXlZjpg==
X-Received: by 2002:a17:903:1245:b0:234:8e54:2d53 with SMTP id d9443c01a7336-23601da9ad1mr13792835ad.45.1749163346985;
        Thu, 05 Jun 2025 15:42:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030926dcsm1157345ad.65.2025.06.05.15.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 15:42:25 -0700 (PDT)
Message-ID: <91ba9f70-3e8e-46f4-bd77-36abb8fae850@broadcom.com>
Date: Thu, 5 Jun 2025 15:42:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
To: Rob Herring <robh@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-2-james.quinlan@broadcom.com>
 <6c3ec1c3-8f62-4d76-86d3-c1bbe3e1418f@broadcom.com>
 <2f79ae4e-6349-472c-b0cc-ea774b8ac7cf@broadcom.com>
 <CA+-6iNz48EFUGUOiHCSaqgsU_tKGV1=Xvw4fjoUS_AMhUHAi6w@mail.gmail.com>
 <3037cd65-89e8-4029-9ee2-4695db5987ad@broadcom.com>
 <20250605223603.GA3375348-robh@kernel.org>
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
In-Reply-To: <20250605223603.GA3375348-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/25 15:36, Rob Herring wrote:
> On Tue, Jun 03, 2025 at 10:17:26AM -0700, Florian Fainelli wrote:
>> On 6/3/25 10:16, Jim Quinlan wrote:
>>> On Tue, Jun 3, 2025 at 12:24 PM Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> On 5/30/25 16:32, Florian Fainelli wrote:
>>>>> On 5/30/25 15:40, Jim Quinlan wrote:
>>>>>> Add optional num-lanes property Broadcom STB PCIe host controllers.
>>>>>>
>>>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>>>
>>>>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>
>>>> Sorry I take that back, I think this should be:
>>>>
>>>> num-lanes:
>>>>      enum: [ 1, 2, 4 ]
>>>>
>>>> We are basically documenting the allowed values, not specifying that we
>>>> can repeat the num-lames property between 1 and 4 times.
> 
> Are you confused with maxItems?

Yes I am.

> 
>>>
>>> num-lanes is already defined as
>>>
>>>       enum: [ 1, 2, 4, 8, 16, 32 ]
>>
>> Right, but then we need to re-define it with our own specific constraints,
>> still, don't we?
> 
> It is correct as-is.

Thanks!
-- 
Florian

