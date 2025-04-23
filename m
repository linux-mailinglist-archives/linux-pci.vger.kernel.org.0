Return-Path: <linux-pci+bounces-26513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D07A9851E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0CE7A27D6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98B1E25F2;
	Wed, 23 Apr 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GN0jK8qD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4433993
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399776; cv=none; b=qqV97UDYrFohRLxTopsp2H/qFoNDd5DqW1K60rYKsLSdAzifWntho2dhjerIbyUyX0ZpXESTwQ+I3plYHWKENwGsMaYLUJ/sLKUD9T8kkQjgC2fGbj9PxnSh6ndkaaiFg1GbGXoUxGwNcGOdKt2kytKBc4xZ9O+F9QqJz2M4gAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399776; c=relaxed/simple;
	bh=nvQGPbm7SWTHXzI6K8imF/ebjIdLx9Wk2BzCjm7fvsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo0STgvnrcbyg2lKDgCXeemmykjrGfJsBnBtDh2e4Qobp6lVXVOGiilr0b6dNCFdUHxLgPAwG2sVyp5DOkJBFl4leaQlh5jGKabDuPH+I34WDIloLVFRJ/sqdMcTU97B29Mc5jPy1aWPKYcCWohHyfN+sqwjXkvKt4U5QklvHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GN0jK8qD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-400fa6b3012so447412b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745399774; x=1746004574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AAILDNKPNEKGe4car8WKpeE8gJXp2VdN72qfqPkhrdI=;
        b=GN0jK8qDEo8pFk0+xkwOQgY1A71o0Qtypw0SYslHvQ9FNnuKU3YgcghMm03+JYJXdS
         W1jJO1Wo0ZBXJUBQfkg5cYfFMqNwdhgdGIR0W0GyGJm0639XkUim+lT9uVSH4yfWguyi
         82MwOm5TWkv3+Cz24nsRoD6c/xwvdlhu0miqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745399774; x=1746004574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAILDNKPNEKGe4car8WKpeE8gJXp2VdN72qfqPkhrdI=;
        b=eE9UrnGP+GaTSv2DM/p0FXLs4ZQQavninGqoS64a7D+RHthPOEwCJZeUzcR+THSdQf
         n3LUGlNvbFY1fGNTVSgplJ+OElDSwo5GlpFIkA9IMYBY2edQGq6Fe2FiInadPjZl3CH8
         j+2+D3jPO4uLCpjSw0W0Q2PQUvgIN3ZJyY7TpGUz71Zyk/ZOUlgDQRG/XkpNMWByMS+T
         eoSyH57bRTiTtCf4PqW1q+3B2Yk4nJXRyAsHtfDur9TQlRFDiiZLQPp6F+PrVtm/FILG
         ZKzJNxt2UlJaktp0yMd47SLADU2N/1r34pzD0A5qXUPOwrUMXzluBxpwUyRfQlMzDOcZ
         cmGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwQOrcFgsYPz1XkPxhQ4yJfnSYBt6qRUZZsQi6MfdK1LTAv/2RjqynzZQgCN/1huy0t+yJVAs9GsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GH3llC9VU884rMV/GgoU2PTzIUp2jVkS1EvtWo//chtMiJ/5
	ejqq0IibTmfHcKMWNIm1PmUxqzrINia4NYW0EASb5d2Bnd4tsiNbJH/nQfTP9g==
X-Gm-Gg: ASbGncvwAMIdLIRfEByV0UAZj6U1FGd+CrQ3kzEnLdxIikN7AxKokGGfF9IXKq8IPbV
	8EtZinnuLJ1zOfoRwCTzNMQefEzh+sc5WuWJk29oM1GxIx88VapKk8FIXxdUKch9JeWn/ZFkf10
	qCPRmK6oNeAkM/AxTC1WeFWjLuEvWnftp+NN3CHD17ADPAVUHLZyyXllygSmjOG9UUijVrqFqhP
	Z0Iu9QgbecCZMe6BT5RgIX2iMWCCQwXkPZFgkw5Tm0ep2GfZ1djdWtUDNgR4UETQl526ZKSh/lf
	KE62fkKD9EaDsG9tUjFiDZ6Wtegbn6W+DhRIqLFZRwNOMad47jkhNIjbSwQiUQ4CAFx7mYKCRKw
	4DzA=
X-Google-Smtp-Source: AGHT+IFXraHU6tyE5Hug/omFPjCYu6OiPQ714dJZZL7AVyIrDSRTncHCvWK1B8ECGGFlXX9pLgWcCg==
X-Received: by 2002:a05:6808:6f93:b0:400:e771:ab80 with SMTP id 5614622812f47-401e3e73e78mr1355466b6e.0.1745399773788;
        Wed, 23 Apr 2025 02:16:13 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeffe05sm2590955b6e.30.2025.04.23.02.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:16:12 -0700 (PDT)
Message-ID: <67298e07-7608-45ef-b8bd-c219419549d9@broadcom.com>
Date: Wed, 23 Apr 2025 11:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 10/11] arm64: dts: broadcom: bcm2712: Add PCIe DT
 nodes
To: Stanimir Varbanov <stanimir.varbanov@suse.com>,
 bcm-kernel-feedback-list@broadcom.com, Stanimir Varbanov
 <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-11-svarbanov@suse.de>
 <20250128215254.1902647-1-florian.fainelli@broadcom.com>
 <24a6236b-3e4f-4174-914a-373ddcc90fb0@suse.com>
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
In-Reply-To: <24a6236b-3e4f-4174-914a-373ddcc90fb0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 11:13 AM, Stanimir Varbanov wrote:
> Hi,
> 
> On 1/28/25 11:52 PM, Florian Fainelli wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> On Mon, 20 Jan 2025 15:01:18 +0200, Stanimir Varbanov <svarbanov@suse.de> wrote:
>>> Add PCIe devicetree nodes, plus needed reset and mip MSI-X
>>> controllers.
>>>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> ---
>>
>> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
> 
> Florian, this somehow missed v6.15?

Yes, I was busy and did not have time to send the pull requests for 
6.15, this will be sent out for 6.16.
-- 
Florian


