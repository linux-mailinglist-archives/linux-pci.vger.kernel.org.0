Return-Path: <linux-pci+bounces-28743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFECAC9829
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2651BA3A6D
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D728467B;
	Fri, 30 May 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gfxsjuh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AB219A71
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648011; cv=none; b=i4axFUbYukNjc2VdHDZU16nHqJ1KjvBbxTSfzl6TYS22d3qo5piTTWudwtIW/PcVo0f3jk6rv50vHFXWROHTcRMi7y/Hh0CqhswUbDIvihozjmiFJcn54fOzItSIIO0VNoBbTYeW9EZJLtB03wfgigZg1jAoUDOC/l3fz8w1Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648011; c=relaxed/simple;
	bh=pn4QFCV3CHfh3+7x/m/9a4a7XF04y5DcT06zSHWRrH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMa+HDKt4yKG1iSHfvnl2+cD+oEfrXm5wCqCA33+ljULXRDp6wQOSRScqpLMiPbrLhCoT6suOB6/fBroNgkXcuSD+ASMCIDkzTxS690uqIvjZaGdmriftXNw6yTwUxcQ4VDimPDuvahhsv+5SJMv/iJQhvEIzMLlCq48B0P4L3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gfxsjuh2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2347012f81fso33868765ad.2
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748648010; x=1749252810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DvYBu1zMyFcdvaUSF433JILDGe1kYh6174QKF4dubts=;
        b=Gfxsjuh2MOAPdfoGd2UNa4NTRHIW+iGOdovQC+N6VzU65l8JoSoMcjGJhCX6uD+y+K
         7HCr87yHtEYG9K1gAHMl1Sq/0VIkK1CiOcsFGNMYDlya/hsKUKXQdpW4qDvA6K1Iu/X3
         J/oSkowVSrrZ3c6YJ80ua82uhhEFbxdu+eYRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748648010; x=1749252810;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvYBu1zMyFcdvaUSF433JILDGe1kYh6174QKF4dubts=;
        b=scKuf2wjTc0ttyOXdSoUJlNZnOsxsBcW3o/0HJqey9FQWp9q2sX2ksWOLHX1jodVNM
         vz+eSt61vE59YPCcb/RlFtwWxNUPuQ5W7gQhJuxgrW5mC4Ko8dWO8J4D0BRR+9CJp5LC
         oaBTygYwk9WiJwRsnhs9CNilrxCx+x0a/yVsUyrPrWw0I5//Ii6H1nbIMbCXbQvuT2/t
         5yuBTJMZo/csDe+G08S6GnwKNyeYOmCd2ua/QuyQ/9R2F4+xAqFBrwSTsodTsQu1mVAT
         KF7jGmrtDbq62PU+5rmTRl5iHTMFUS8kiZ/ckMedqG530rd7j9xzZAhZeKNo4RnxpjRJ
         4R1w==
X-Forwarded-Encrypted: i=1; AJvYcCW6EH5j9yBpjSt8X7239aIqmzYR4zVIhM+XHGttJmL2yf7MT9PJF/LtNFkQk9vcQqNKswQWMLUldss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uHez0/oe5XNeEh6wXpS/gDLYIycUWAYbNEVlVJwskISdo+RS
	gBqZdTWKb9anjkDGW0dPcTYX67jk/XUUA6OdHjwFZYziQ9gNLsSvJxK4fNJHXO3TFQ==
X-Gm-Gg: ASbGncuI2rBJ9fqf1VowFxGXSLW2YxAiic6CldHzxhQLn5VgOBDBjq1yfMJ0VHEjgX8
	Q8fe2MipmdjYwJFOSOE+wEy7G6ys5rjgNFi3IpZJEgm4/J7OXvQ7a5emp9Jq5EfxGkgi248Z4Kg
	+lB2H30JRJ6VhmXgy95MVEWv//QUr9dmy8cmFOZljgIhc9tTQy2heNI12GYYvJBRBNwX05UfvHL
	ATp1ADvBoTEVYufD/1f36QwTHeQ2fMrvmcOdDbP8v9Nt1ijTmGer68VGsq+vZJR+al7xMEi1AMy
	IAv/LTAhBExkF7kkuTMdhnTcDceN96J4Q3RhbkN/P09IFD6pq7Uojk56nFlUaPZl4/h9siW89DG
	cREIa4jeGneBULb0=
X-Google-Smtp-Source: AGHT+IEvSKsPxXesvS90MDpaHZgCv5Cx6Qzx3uPDHbElMUWPPIWKm/guAjLLmyBVXKbR6GLBqOyEaA==
X-Received: by 2002:a17:902:d4cd:b0:234:f4da:7eef with SMTP id d9443c01a7336-2353968853dmr52579665ad.52.1748648009734;
        Fri, 30 May 2025 16:33:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14adfsm33352075ad.219.2025.05.30.16.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:33:28 -0700 (PDT)
Message-ID: <8ee3f021-a706-42d5-b916-ef2786de2150@broadcom.com>
Date: Fri, 30 May 2025 16:33:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20250530224035.41886-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 15:40, Jim Quinlan wrote:
> By default, we use automatic HW negotiation to ascertain the number of
> lanes of the PCIe connection.  If the "num-lanes" DT property is present,
> assume that the chip's built-in capability information is incorrect or
> undesired, and use the specified value instead.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

