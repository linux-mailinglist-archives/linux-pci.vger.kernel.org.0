Return-Path: <linux-pci+bounces-37631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC7BBF1B7
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D9D189A93E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D41D54FA;
	Mon,  6 Oct 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CRdj2owh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94E2AF1B
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779329; cv=none; b=G131VAH/r1oQNO+iXg+521yxj2TdSDuavcgdsrZPSV3ywXu2q52+520CpvmnOxuETUV9SiYuQTUoV7PB15Ni14FkpMMNUO1mlepRL9pDV8PizzYWS7XDbWgb33h7sBj7rPiZkzzA1ngwxz3fNg6lJhzqdPPaoeld30IBpIFQXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779329; c=relaxed/simple;
	bh=UUrlo6eNKtzgr0l8FTV3bJGJ+IUdWejRxpJ905/N5Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJV+purF0M+VIF7Y0FP6kf1T75M7CYGMkN+g4TKfNhqBUupr0xH5hJyzrWRdScwUI0FS4zkpfZWXnKZDOL91ao67PS3TSPf7UKDFttqvwVX+37+c2aAoEJyX8N4lnOAh6DhFyChQfSDuC6FPfuX3Goyk303v2T4pKhGNvEM9E8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CRdj2owh; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-71d603acc23so59126707b3.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 12:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779326; x=1760384126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g33QJENoKMBd4tbu8sSihTDRSw0h67rGYA9n8lHSYDU=;
        b=Bwyn2Mq5eQoIyISa7IaYKNGDMOPEBuGFw/8BzEMMzqlVytzCL5ATM/kYLGLBGeaIoY
         f1yoqIk5o3RjFsnoyMw+Yeolwjmw4qRQhshWvKNZR+mAjhX/dSg8G4BikwS16amZmwym
         OnRaWC8MZ9WDZ/HMXiWCssvBWx+I7Uon472wzb4ExMP6h0LHj5ISQ+xphwWNcKH89Lbt
         FK4mCN77g7gxaYOeHMj6GkiBuK9FqjgbBRLMaBSJ4/7f4OR8BvICtZ8X/PYzB8Y4ltDJ
         mULrd01Tjgu2/59wWW+v4Be05EtdhfZuXYzlA0MVBmgYqgi+YsSLsT/hsb+PTZGPu9Ph
         KSRw==
X-Forwarded-Encrypted: i=1; AJvYcCWlGiT5VWe1hh+bzJg8qOy8U0ZUSxDrTEsDbKjyDMn8YPGIp9y4OWMS7du0yF+1u4dlRUVPmPmjsgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxccm2BeKnT3YMo4c0LXfqNhpArkLX/3YxNKb7e2vf4RVB54W3a
	qsDT+1taeRJq7ObAmUeasOAjLyvhESTs+edMOnOb3OcSWLkmsgOFDt6KWtzXX4/au5Nd6UaBndn
	C2wKpQDrbxxVwyGhhB84qnIQ62RIgdZXU0XH88aEvPm/fT+oxdbAQKki6MfrT+vQ3FNee7w0vqq
	/kf+lczO8iHLyUu8e9uKXk5gR7Txk97G8ry+eJSCV9VKhKetdT+6ogIfSse91SjhMXxx47zwdtm
	ILyLzKdxliJoIvpy+Jz
X-Gm-Gg: ASbGncvHVSK4mV10kKPOdGxuLgNhViLh7OCW/PNmeH/OxHlqGkN6queXx0S35DUKXqa
	Lx0K0jOPitvzKGIJjmmU8BR3G5Fm9o2k0gMVlglYNdSs02HhULdEw71m9rUT9Bz6gJS7s9+VKDz
	o3hp2ljpAM8sAYqb763txTBb+ywIZc7yfkusd43xy50Y7YFf1StmxcA5GD0uR3SuyaVtXjF6mhX
	dEtCdxOcA5U1aad9vud9DBLyNczGISVMc/Wx1I9KUZ8fQQZou/MG3LIdxJOGSsFjW8G4Qa7JH7A
	53KNR651Skp1S8qzF+dPf33LW7bjU5NXWWobrF9o7bK5VlSiJXUfV/RAusQjGyh7ABmi6aSb58i
	Es+WVXNIH5Txhv9NfHa9MiEhOHodB362tZl4itMAJIglOzCF72JPOwMCq6uF9JhkCmQ5OxD9WWP
	RlDj4oGQsc76i/
X-Google-Smtp-Source: AGHT+IHvKHlnRfXkuu2ZpwGnx2YKtMPazXfm/hzYiCkp7Z50sj+4d4eAJ4s/orYTiYK2gFpuLcYSS2cROgnt
X-Received: by 2002:a05:690e:1b67:b0:63b:9347:1a5c with SMTP id 956f58d0204a3-63b9a10624cmr9708013d50.40.1759779326308;
        Mon, 06 Oct 2025 12:35:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-77f81c35a26sm7540577b3.10.2025.10.06.12.35.26
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:35:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2632396a12.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Oct 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759779325; x=1760384125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g33QJENoKMBd4tbu8sSihTDRSw0h67rGYA9n8lHSYDU=;
        b=CRdj2owhQmz2ewAra3x/4GIvkAzXBMD50Gtqn7yuee/kzVb8T0UMSB0hqgPo6qgQLO
         FHNQWlAtyag26CtZvuvvuzGkldOdfjhKtvrTx5vC44Xq5O7O0tz7y1A8So8zCD+fWVuc
         YVn8KBAYPO+7Zq8A/HeZ7EEdH0DzPlBPitvyg=
X-Forwarded-Encrypted: i=1; AJvYcCWS5HaAxnWjkt9rUntjO3pCriH+ud5gPT1vWSkfx0xkGOCo2E+KExPDbrdNgm3HGQtAsoSaZryLDPo=@vger.kernel.org
X-Received: by 2002:a17:902:f78d:b0:28e:a70f:e882 with SMTP id d9443c01a7336-28ea70feae1mr113856365ad.11.1759779325011;
        Mon, 06 Oct 2025 12:35:25 -0700 (PDT)
X-Received: by 2002:a17:902:f78d:b0:28e:a70f:e882 with SMTP id d9443c01a7336-28ea70feae1mr113856075ad.11.1759779324589;
        Mon, 06 Oct 2025 12:35:24 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f19ddsm141472345ad.127.2025.10.06.12.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:35:22 -0700 (PDT)
Message-ID: <23cc004b-f3e9-4685-880d-362619c180e6@broadcom.com>
Date: Mon, 6 Oct 2025 12:35:19 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
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
References: <20251003170436.1446030-1-james.quinlan@broadcom.com>
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
In-Reply-To: <20251003170436.1446030-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/3/2025 10:04 AM, Jim Quinlan wrote:
> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
> setting the private PCI_EXP_LNKCAP register, but this constant is
> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
> the value of this constant was correct for its usage until after 6.1, when
> its value changed from BIT(1) to BIT(2);
> 
> In addition, the driver was assuming that the HW is ASPM L1 capable when it
> should not be telling the HW what it is capable of.
> 
> Fixes: caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


