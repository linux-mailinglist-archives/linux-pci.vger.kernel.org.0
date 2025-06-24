Return-Path: <linux-pci+bounces-30553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF9AE7166
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D2B17BDD8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED62259CB3;
	Tue, 24 Jun 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KhGnubNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403832580CB
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799543; cv=none; b=tJY9IehVBJNtpW2BvJu9U5wm2OTumNzpVdIasFZcXf7/5tN3hepIkG8BhqmpJDUncS3dJosiTr7Y5dL8TnvaybUK57mfTtOgUzjZ8m5gGnoao3mk3V2PElwJGN31Rl7fAu4IHiQtNYTbfgbCrefl5mFlBOX7vDkbJAtqLABMDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799543; c=relaxed/simple;
	bh=vg1ef1oRFT4Gwpd8ueYyQA6/BOZsNA4oa9AALT0Rbxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iJsqtxuJxlh6d8N6xkhJWG1OFf58bLXUbas1fmsqgCHPpwPP0MNCRZY9D2DERWvEbTTfb/WxkL5hB4zk7+kN2/ytqX3saYoPEnAA6nXlzMSMGKTZrR9hvSzA07LEC3QJAHJGt46D/4DTc+QK7dYJSB/VcHdmQpJCBZAG4yY8c/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KhGnubNm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234d3261631so9630605ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750799541; x=1751404341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkIMyFBlVlgs2Ulo4+3BI7DnkrCtZPojDt3EBpbXk+s=;
        b=KhGnubNmsT7u5pVY+SRS2xFXm4T/sYLMrizOIUh6hmEE9MlBmOdYfembezeB+sKxo9
         d9VdW8vGnjlDaSfw/RfnyTAdK9xdNVr0QmHNH/CgiaZK/DQ7PmnjySR+2knRYMYTQ1gR
         vuxT3dfsXGzE15ACBVV9Q9TVQpQVU6xTLiegw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750799541; x=1751404341;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkIMyFBlVlgs2Ulo4+3BI7DnkrCtZPojDt3EBpbXk+s=;
        b=lCDAoRY2i72ihNB4Q/cAgAiI7jQ1/fj485bYshj8PwkSVGxUy5wmClPKh4W2PKy827
         vW+qRMpNS2PNGxesOxYaUtKPQFi12AxYCHGbhs7CrzolS59kEkzxJ+ip6ZIDZFRGHi59
         7Tfnfou8As3QohhLgSGYnRpNCrAW7Kqz3zgaDm9ckyiDB8SlmzJxjLI+TyZydlUQHzm4
         U24LRlln4seL+nLDmpWXLd250kHP+ouN4QcvGNDZcKCfk58Zff2buJ0ISX0DIAY7eXJS
         a3uR4aJuDwlzVrve4p10I+t+40HECGQ1Nr55W626JAUTyOoKLspVbDqnO/TzF6wxkQXc
         QqEA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwG/XXL/Q5/EPHyN+bXjbCN1lJkbjzXBau2Ywyb9ep/+Y1MomZnqjQF87kK1P98h0BB8XtwK41H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wPUrB63cgyDkiptD6Rd9obqP5LXf7dPGaftbDzbSCwpkdUF8
	bgQBFBqsvKtXrdsWyRQOovPCJswXzynUCLrWrsszzIdPfXQimSQV7muySSLkPk/8bQ==
X-Gm-Gg: ASbGncuBkEvm6n8gh0WYcnW10OuNiCq7Dx/s71d0UggexVANhSWHjTHMPiRDhqcedfP
	s/zfANVXBxnuoMhEVWLzD7qSYBTP9g4X8QiHVfUuZADVQ2EwgL91u6Gx+os+OeaeNWhGC+BWAIW
	d5h68PsAcR+EA12WOEfyFxSh2NTzt89OBdnRG5a2NeJLJgmsFm+b2mzBhp0yArakP80GjRGZLrf
	uiAJgeL91hwe1lmQsbD2Tov0GchKWU4jBauGjOVhkx0BasCqt9wyW+mSuRKnxLLDiC5tIwjKqWy
	boxUFqdVrQXbcLhQVZqxHhLnfF4KVkyvHkCeomhf+5riqUlWhA7iMcYsQBzBxu1vmW4OHgzRO2z
	hvFXA5L1M9qLvBvgBmBD98k6WvAcoLT7gIs9f
X-Google-Smtp-Source: AGHT+IE8AtKCbRL/Ae95ntUOEV0G/Hz0ZyjAAOPX2JCe7DpKTe3ncgHoFdCvDL7h49ynbDxxbTuKNg==
X-Received: by 2002:a17:902:d60e:b0:234:f6ba:e681 with SMTP id d9443c01a7336-2382409dfc9mr13529245ad.5.1750799541406;
        Tue, 24 Jun 2025 14:12:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53d94b1sm23610a91.33.2025.06.24.14.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 14:12:20 -0700 (PDT)
Message-ID: <78106b8c-3f4e-44d0-9828-9b46952f3fa6@broadcom.com>
Date: Tue, 24 Jun 2025 14:12:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 stblinux/next 2/2] clk: rp1: Implement remaining clock
 tree
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
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
References: <c20066500908db854aa4816b40e956296bab526a.1750714412.git.andrea.porta@suse.com>
 <17e5c6e0c085cfa0bf4b63b639cdc92c6a4c1418.1750714412.git.andrea.porta@suse.com>
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
In-Reply-To: <17e5c6e0c085cfa0bf4b63b639cdc92c6a4c1418.1750714412.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 14:46, Andrea della Porta wrote:
> The RP1 clock generator driver currently defines only the fundamental
> clocks such as the front PLLs for system, audio and video subsystems
> and the ethernet clock.
> 
> Add the remaining clocks to the tree so as to be completed, which means
> that the following RP1 peripherals could now consume their specific clocks
> and be enabled to work (provided that the relevant driver changes for each
> specific peripheral, if any, are committed):
> 
> - ADC
> - Audio IN/OUT
> - DMA controller
> - I2S
> - MIPI DPI/DSI
> - PWM
> - SDIO
> - UART
> - Video Encoder
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Stephen, can I get an Acked-by or Reviewed-by from you so I can take 
those changes in the Broadcom ARM SoC pull request that I will submit in 
the next few days, thanks!
-- 
Florian

