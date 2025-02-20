Return-Path: <linux-pci+bounces-21924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC765A3E388
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B187167AE8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A11F892D;
	Thu, 20 Feb 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LA80N+eI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7841FAC30
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075264; cv=none; b=YaKTYyPWpTeEouZO1JpPz3PXWnPDrWYUWCRnAfOQIbsk+4ylGB+Kz27lgAHyX/6KTEppc+q0DWTgcLGpIdztyvyMyXtGYAcShvhp8FbdhztGuPgVltgfkbeXK+URPiXm0rOkre4Au0ONK6JGPQIZHM+iTv06XxuHwWFAg2sR/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075264; c=relaxed/simple;
	bh=9LyArO1V6x/btSOf+YKP3+IhtB3t+HvWTzREOzTKzg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geoXKozCOMgFtRT46L2XDmZ/eQafUN3SFgba2wd6zf/2JQvF09CUZ7ZR7hQSPsvAaurmtTOF0+sWgGpHeXOwKJuZ9m2T2glkOpN5mITxTyeAHQ1MaKqWJeZji6RLvAjXzW0XrTqBP6YwN9i9aY4InVBxq0M4q+U60AXJBvTLWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LA80N+eI; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72716c75f20so367724a34.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740075262; x=1740680062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XFoKwRv8+iHXzA4sW8NR+HMTovNN52QXmnRE1AZkRlg=;
        b=LA80N+eIlKgOT9AIRggsrqrCI2wD8OgsguhE4XSsey3V0NtA1NB28EbAXEpdBp7VqE
         /gNlkYpFmDL2E/RLKQdeNTMAN9jIIuIhSAI6qq+k5r2DNb4jfo7iwq+0+WYX/6JsdLBH
         s9+OVSGuavYM10nhV9MUmJRh71d85UpMrrhAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075262; x=1740680062;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFoKwRv8+iHXzA4sW8NR+HMTovNN52QXmnRE1AZkRlg=;
        b=wHkb8d5FuKH+fPOqdDZim1xqc4iBsi8QbLaGQazWooAiGGsyNkGqOgGr7t7NPJ062T
         HNwY3uijMlcrP7P/G6IHtczcAOPEbVrLIeVjx/Qy01Bo+P6lsHMiVfR9EpGD82K1gYJy
         3hTc4mXfd5VoOTAHCgeXefdNHpEgsZVOIqclEcchTZqV4I9MaI5PKnmWHn9lfqPBSuRt
         CUSquEi7Hd/tDgpHk7H7SRbcou9lzrjHSEv1JRyX0IX0Cije9oY1DRBMGkMU9jzyDH5n
         YNOdmbeCgox4G6SsHBgWCUxYr38urmlVB5ls+xPkkd2dHdiK3wf5M8L1SJ91/YPswjLz
         izig==
X-Forwarded-Encrypted: i=1; AJvYcCWn7QZ9bmHRsUTlkPeLhzZOqjFgtE8FUFHhoNdnMsRUgnwYgDo57xGuyV5kctFj/2Oe+L4AC6S0QlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjkeRc2nLqo+n48UQVpxeydJuw9BDU0g0FamYU++BAnIbkWeI
	6KKDl/Lk05POyHoSwr0W4Wa158SJePcYATPFx6TL3aTe7tUNGq5tjPLD4Qr3/w==
X-Gm-Gg: ASbGncvsKKHoWcqluS1UaqgPEE4DDRO3DblHXO4t4+36wXml2XgVIso4adIwfP6q/GW
	8bWqpSHUNzLPUpG3X2NY7U3mnKaSLgUSMUCA0RKoVQOA5vW9McA9rPps/tSOJTY2TlSQrqHqAws
	0+ggQ1eAEuTrPysSkZHVSmYblmp1N7vMV1Y2u2APbduLX7AIzzUveO+P0/FXVMVfX66AWdcRb61
	vVrIG5PGvKMB06ZrUOMtIwUPRixurfxzf/J7oGP++p1ZYx3uP4nTIdIGqLtrljw/6rG7dpylHIH
	PAqw8dCryOX5GZAmlA4YspMv/nVvVZ+FcrTzb3U3LK8JPntS6xjMOkSo/EUvsyE4MA==
X-Google-Smtp-Source: AGHT+IEV44L/jP80xEFxHDxYslNjpr4vxk6yxSG6deheV670R1As9ApbDG8AlvPhEH38+8Glf9FKlg==
X-Received: by 2002:a05:6830:210c:b0:727:345d:3b72 with SMTP id 46e09a7af769-7274c1ebaa7mr20788a34.16.1740075261611;
        Thu, 20 Feb 2025 10:14:21 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727329c37d0sm1563186a34.31.2025.02.20.10.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:14:20 -0800 (PST)
Message-ID: <c67c10fe-e279-4b37-ac9d-20485e86fc8f@broadcom.com>
Date: Thu, 20 Feb 2025 10:14:11 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> map_bus methods used these constants, the other used different constants.
> Fortunately there was no problem because the SoCs that used the latter
> map_bus method all had the same register constants.
> 
> Remove the redundant constants and adjust the code to use them.  In
> addition, update EXT_CFG_DATA to use the 4k-page based config space access
> system, which is what the second map_bus method was already using.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


