Return-Path: <linux-pci+bounces-11841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA11957427
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8688C28472B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052AE26AD3;
	Mon, 19 Aug 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b56IQb7G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF201D54EE
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094445; cv=none; b=GdTXWOZyTunHYkXyonBQqHFIWb+1WO1CN6ECBl17V6qrssQVIkmIDna+wlInVNPWW6wZKMf+qXfkeKzz0Qmn5fNGuNkSmHg/3jS80kMlG9CG4+IEd2zc1v4Y2tIjO1x7Z3sVIerB0nFLzHLUZq2Wa2ltz43ESJ5Xg8KCOi1+lB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094445; c=relaxed/simple;
	bh=U96aCh+kP+kD8HG1T/BEmI0F1FivyXuALxhPoL/bQTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2JcorHPe8yK0WjNcAUwPqLC9s0f7zjc4+LtO19g1SeGEdIeBBFmCEd9+3Ly05qcr37dpety8ll1RvEuR2eIfl29VmhMji+H2Jdlr6Sn/uQ+jTiNFBS9gn5GyzKkxbqD5y1cFTnA6uUREskL1o50GUk9D4U7y3avgFqCX790uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b56IQb7G; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201d5af11a4so43406235ad.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724094444; x=1724699244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PigGVeP9fWkt2ziYkYFY4MjVKS0wO7lePaduv9u4Eqs=;
        b=b56IQb7GiFfRzsRwfSI9B9lrU9cYRpC11+nXc5cU4kUm41c1fP4ISxVr3z51KiuBQ1
         IbEPr5OAllU9DQ5d/MrCT3wb533ObnHyuZ30rqLXuavS9xPDCcbhi4NFALmWokUgFyue
         IYUpRTdcDbZ0CwPqn2EaGoM91L6piWqcP+a/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094444; x=1724699244;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PigGVeP9fWkt2ziYkYFY4MjVKS0wO7lePaduv9u4Eqs=;
        b=OB5rm7QVvkE26QjtY76ByX5P0FwEX9HNjgAz/yM+JTDoeODYvC2BdkB1CY0hO5PFT7
         WISXPVVdtPKhNLXlQ/d6/HSCPN7kH55KpgXge/WOWf8QvjOl/6JSgujiYRvkumQSJIs9
         oYf94pTQVyFzP4wwbKIETrYTiBfQECmf/3ruiMZNU7+qr1t5+PmbqnzNe0giQ3m9uVRb
         Tdyad7jur6vBfSTs472dVEetrlMnueGVH8DXOYiRdIGoDoiDsA/UK1dcueQ1zaIZ+5DO
         Lzh4SrkrI7OTquCNBhDIH6QIDcZxhuiOMGXPxxgPguF3dfC0E0q7EAhxCSrsPYrhFhSG
         nPMw==
X-Forwarded-Encrypted: i=1; AJvYcCV+0iChX9/0GNv5Vjv0fFm1Wad79dtwDINUHLFQjBHtiUvcvsiqmr4v4sB5sUKkKErUwszZNbdT+XIwcbDTu88WStRejP8esUMu
X-Gm-Message-State: AOJu0YztsQwLPdxn+bQULdGE6b//Xkp7t0yajtO8+yOtRNmCzmaWCLEN
	/pRp330tWciVVJmR5vVyiOtBPPOSlDH0wnlhbHxsyBZ+M835XQ+NZrTumd1ICw==
X-Google-Smtp-Source: AGHT+IF9wcR96nk7xMM8w89wfnQA/EQxKY3IP0cKcgJ9JF3OmqhV1jwCwzeWkcKXLmnxTxXDKv82vw==
X-Received: by 2002:a17:903:2307:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-20203e5518fmr178728535ad.6.1724094443559;
        Mon, 19 Aug 2024 12:07:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03793b6sm65373135ad.127.2024.08.19.12.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:07:22 -0700 (PDT)
Message-ID: <2fb74b23-a862-4b1c-b1e1-a3e3abc4571b@broadcom.com>
Date: Mon, 19 Aug 2024 12:07:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Stanimir Varbanov <svarbanov@suse.de>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
 <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
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
In-Reply-To: <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 10:41, Stanimir Varbanov wrote:
> Hi Jim,
> 
> On 8/16/24 01:57, Jim Quinlan wrote:
>> The 7712 SOC has a bridge reset which can be described in the device tree.
>> Use it if present.  Otherwise, continue to use the legacy method to reset
>> the bridge.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> 
> One problem though on RPi5 (bcm2712).
> 
> With this series applied + my WIP patches for enablement of PCIe on
> bcm2712 when enable the pcie1 and pcie2 root ports in dts, I see kernel
> boot stuck on pcie2 enumeration and I have to add this [1] to make it
> work again.
> 
> Some more info about resets used:
> 
> pcie0 @ 100000:
> 	resets = <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
> 	reset-names = "swinit", "bridge", "rescal";
> 
> pcie1 @ 110000:
> 	resets = <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
> 	reset-names = "swinit", "bridge", "rescal";
> 
> pcie2 @ 120000:
> 	resets = <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
> 	reset-names = "swinit", "bridge", "rescal"; >
> 
> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
> south bridge at all.

The value 9 is unused, so I suppose it does not really hurt to use it, 
but it is also unlikely to achieve what you desire. 32 is the correct 
value since pcie2_sw_init is bit 0 within SW_INIT_1 (second bank of resets).

The file link you provided appears to be lacking support for the 
"swinit" reset line, is that intentional? I don't think you can assume 
this will work without.
-- 
Florian


