Return-Path: <linux-pci+bounces-28885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E009ACCBE0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777FF1897C9E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013D1CCEE0;
	Tue,  3 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZHakJ+Ud"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FA1C84D0
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971051; cv=none; b=iFFubNL08Tf+mVft+s9RIbWcy2LEGwWhsg5mzdi4C7JS8ZWJbEAbV4FtHEN80YiOTZ+por+8aWrs+MgMcmneDj2X5bBsQPA6pW2HH6zoEsf7oDKyiq2/rQ4EIFAYDa7hAiIdcg2MCtJzgDLO54Z+Wa5HpD0r4lVmg8h0Jb4Ud1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971051; c=relaxed/simple;
	bh=XoH8NdFI6O7ol9UjBGasC7bU6m1a0clU79ZLMUCBgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5cFgtUGiyJy2DXh7pnE1SsPWLBidqIpbn2DaNiUPrrRI/iY7vYs6iesi9FeZgoXcr5ZWssE8WkY0mOWJhmSFcsuyaDY1GUUTAscTAjEjqvK4n+XP0z2ZIUT39hQNs4VVNkQIt6Yn0CrIUo+nUj6BvNbnlljTadRd9BAGtc8xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZHakJ+Ud; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742af848148so3918021b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748971049; x=1749575849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ5YX5z3KBN085PsYk9M8htYCNBDm2d0pRk6SE3Tnco=;
        b=ZHakJ+UdFiIdzBmTWC5IcPiDppTuvNizObnHD4oMXMudkOR8CYKwwyn0NIeNBMi5Bi
         Mg8qwuIWSS0NHqdf1vZUvhhebq6ML0A3vzXkN3rpodWgPI/dlDIDeQy+frTvOZS3cQFb
         8iAkM0fAaaCFaWt5KknlCzQKF+/GnH6MRUkaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748971049; x=1749575849;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ5YX5z3KBN085PsYk9M8htYCNBDm2d0pRk6SE3Tnco=;
        b=ToQ31gI0NcPFrD6o/FRhbmdfAQ7fFSLNHn0UPfQA9CROnunizDiCBJ1dWELMjwqaH7
         7dp/YyLiL9j9VQ2DpJoAGyDcfru7bX5j+V3fXgNCCHhmG2f3ZkAfYcIFwuBmmPy813du
         z3k4ENUZ6LS4rzczhMyvLkiEUp3xczLmntjh+T1J4jfJ4gFUaQ3/bZiBD34ZEOBF/qHR
         RgSHzBXe1ySRyLWb3BIaA8PStD/twhQQpZRIyEatPiaLq8+yGDjF+ffL7Nr+zJZSUDox
         SphImtXTA/kAN7C2ei+/yk2CovT3ZzhDpT1mxq8ec1urINnMIXSEU0mnwql8JucksLVx
         whuA==
X-Gm-Message-State: AOJu0YxaJwyBUvAj0uzTogznFwRtd7mx1Wd2II9h6D3aJjCyMoEKwga9
	eb8BIrS9PbLs4mXL7yIHXhU5zHOB1S0AvyY2IEjGj/rULg4O9btaBTLHbWsK2n3tzPGiSBpeMRt
	Nm4Udvbwp
X-Gm-Gg: ASbGncvCv8Qt95fhC6mRmJGVR/5L3nA7ktQdh/L6D6gmePaFcjBWTVHdA9+wy5Qn17i
	5/gJGEzTgGeoU/kj9M8nFu8q4QJrdctgsaHD41gE8EwU5+ggkaDeKg7TYLILdE/rW5b2DUsoel2
	pJ/IBEg7tOyQupfSxwqKAhcexjf4GM79ahjxOobMgbqL9+umgMT5Youzg15qb9B8WOZf7fNGEwM
	yhOS8lUOsfaaZmAqrGoX50BUTfyGXAkkpRaYvYp8POX28xnYd2xnr+zVRVznErPYH2A8pOhHYcU
	kplp5lLtBYr9JvnyzXpe5CLH9+Ag44Hjru/MmGghhr96pIlTNcpMziD7U6m3PS+Wz7YL0FRNtCZ
	Uinp9U34/mTggbZvhnt4q0ELlZSiqe/OEe4qLsR4DPQ4c4Rk=
X-Google-Smtp-Source: AGHT+IH5GulsAjqe5CcgYA7XklQijHBuhHK02IVeHV6VG0dpYUeRl+hBb/uGE/suyrCQ+bYpoUsRKw==
X-Received: by 2002:a05:6a00:2da0:b0:732:2923:b70f with SMTP id d2e1a72fcca58-747d18a68e5mr17089629b3a.11.1748971049157;
        Tue, 03 Jun 2025 10:17:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe9670bsm9639276b3a.30.2025.06.03.10.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:17:28 -0700 (PDT)
Message-ID: <3037cd65-89e8-4029-9ee2-4695db5987ad@broadcom.com>
Date: Tue, 3 Jun 2025 10:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
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
In-Reply-To: <CA+-6iNz48EFUGUOiHCSaqgsU_tKGV1=Xvw4fjoUS_AMhUHAi6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 10:16, Jim Quinlan wrote:
> On Tue, Jun 3, 2025 at 12:24 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 5/30/25 16:32, Florian Fainelli wrote:
>>> On 5/30/25 15:40, Jim Quinlan wrote:
>>>> Add optional num-lanes property Broadcom STB PCIe host controllers.
>>>>
>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>
>>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> Sorry I take that back, I think this should be:
>>
>> num-lanes:
>>     enum: [ 1, 2, 4 ]
>>
>> We are basically documenting the allowed values, not specifying that we
>> can repeat the num-lames property between 1 and 4 times.
> 
> num-lanes is already defined as
> 
>      enum: [ 1, 2, 4, 8, 16, 32 ]

Right, but then we need to re-define it with our own specific 
constraints, still, don't we?
-- 
Florian

