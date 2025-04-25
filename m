Return-Path: <linux-pci+bounces-26734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB5A9C4A5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB345A3B76
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB38238C2A;
	Fri, 25 Apr 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hi9sU/dE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AA23236D
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575668; cv=none; b=gzWi9faRsO31WcIoqvklDVFFuMk5iyn0sPseBjy5rbsJHhp32djC4QOnelZx1HpTh2sBwv2grX6wNlUt3FBb3OCh06BGh7yTsuDfBOnnd9SSQUdvOdHVx5d7oXfGKddWh0nGrqhs3N92lLfj21qXNiyRi7YpHaP3GcCNUSSXnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575668; c=relaxed/simple;
	bh=qV1pZ+3JNp92kKS0xXXAb/pAJaziKcnWjRvO2Z5j/JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O1VlL6F9OhRNOdcp+srdrvr/Qeger6ZpqDC1LPYlSKg4tvG46dy1/tIuCfNb0rmqcAL31X9ZhySD3a1n77p5nlDjUoMzxlFovqq09kah/1WZr0+qGRLCXdaSqH9eM04CH5J1Et+vQgVUtbdNwJUqnK6D+7fMeBQe4wxtPZYWhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hi9sU/dE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c277331eso3060561b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745575666; x=1746180466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5B7y37K/WGDfH6iYqZP3IbPETHIDt3dOJy9LPqxh618=;
        b=hi9sU/dEpFQfBFlaD5a7O2qhVFpneBbrm9Jc4YWpt7nxK7cZtmdKE50fsj+XqWrp1+
         F8Wx4KzDWJBw7F25oW1NleaBjZB90nyK6+CRT7lQP0TbSYv7aRmSSYzKQQiib9HaV+CB
         wX1A5dfcphrBYCEpmV3tY6oaAYsNC9wy1bImo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575666; x=1746180466;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B7y37K/WGDfH6iYqZP3IbPETHIDt3dOJy9LPqxh618=;
        b=cvQSL7zEPOqMnjeB0Lb1G8PDbkTiTLvnCQaETcbPV7XPRJFnC/f3hPAtkJ5m6oiubF
         tFz3jFSirvid4rRfEFKMQR/2t4/j9e2n+3EAz99m6r7dRZjRjCAGBCPT97g4fnUQTixm
         3wEtjhy0/c11bmuIjXnRz/yoPVZ6cmkT9vJaL5J53OQJFTDPgLxaRaVhsUj0fNSIeFvd
         app2XJdIqW8YSVJpAJqVsJh+hVjacwjScU2eumKE22Y93j+UdYUbfu1MAS6H18b2SCKF
         VajviNyJmqz6Z74b+3wdjr0AoH9x7B29qSu6HtEZ4n9tYFB66NthNKjBuNkhboOSpigz
         RgaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+mFHapZlHF9uBEKt0tnd6IbC8RQAmyZKftcvB+I+9606xOGPIqAlODlnFku+gHp7iwXRWZxFOu6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eyLWZVzR5gKSW0TCH4q9U2tRwUQW/v5IgXCOHnoSRxQ7t2i5
	zSrydfVkBECAmneHRz/3tS6K5br4tYVrqStiohdlZuVxk6JST7Ii0m6nxIJaLA==
X-Gm-Gg: ASbGncvQ9KhQDmtrpwWrl+X2C3YYwRPDQW1G6QKrrYb3JyC2wvdL7Qx2Fq8SdVSPKRy
	zhTxTiopqh0+VkJbWhSC+vTWs2SNjjt9iOPtTa5KBLhVinEoUnYj2EOCDWIwC/tyTZipRhenJuk
	Rxad+MTCOEtogYRmEbpFl+Mnh0lD/YRYMkv/GuRpF3qxFOPOZ+cUIarX6tMhFv3Be9IKaiqk5G5
	1oE0WyZ7JMBG75hpWhx5XceTyBb+4aMhBgVx3MxyCIyWAmkS0arYJ0y0C3vrmLQqz7oQclTshZB
	KBPdbCJNo1aSIKBt6vSiChrCewk0xntnfbRvrRHeqtsqpk/Ouq7ptbKcdeUUh92zUKixssJeayw
	yH5DdMqsAjne6krXOYTfHTx2IS5nuR6yg2w==
X-Google-Smtp-Source: AGHT+IH+RPx8vMoFBrGnE2UELbu76oBxdqLLmuOZ9MxvthItxwA6UQaxgwbV1lK1NsLiE9He6IufKQ==
X-Received: by 2002:a05:6a21:6b0b:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-2045b1257f0mr2341262637.0.1745575666250;
        Fri, 25 Apr 2025 03:07:46 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f48b2sm2564155a12.8.2025.04.25.03.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 03:07:45 -0700 (PDT)
Message-ID: <78cdc9c7-47f5-4522-8dea-b0bb3228dd7b@broadcom.com>
Date: Fri, 25 Apr 2025 12:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 -next 11/12] arm64: defconfig: Enable RP1
 misc/clock/gpio drivers
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <928679d1511a43b8dda150009eb023b4eaaff5a2.1745347417.git.andrea.porta@suse.com>
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
In-Reply-To: <928679d1511a43b8dda150009eb023b4eaaff5a2.1745347417.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/2025 8:53 PM, Andrea della Porta wrote:
> Select the RP1 drivers needed to operate the PCI endpoint containing
> several peripherals such as Ethernet and USB Controller. This chip is
> present on RaspberryPi 5.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


