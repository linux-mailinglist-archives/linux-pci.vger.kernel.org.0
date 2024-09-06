Return-Path: <linux-pci+bounces-12904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAE96FB81
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18BB2829F8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB03FB8B;
	Fri,  6 Sep 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JSTfH/cH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA31B85C8
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648841; cv=none; b=G8adsPEaCVuHIRZNeCUIBfjg7TgXAKI2wstmD8rGI9tIpg2XcyeSldUhJErVEoWBkErmn60pIjDbX+eUE0Y9niUp0UIReBUJ82jphV1BtG7v7QADmLOyCGgyHhOWWLXlyy/M9MzQGjahwNuzLVVvi994U4WOMO894wXuY1wmg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648841; c=relaxed/simple;
	bh=csLMJFKnRw9ejiDzng9uWv9z06uzYm5hjtYR8dNDqmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM+IRQpl4owrwVp6mXzgaqdYDEe++kStelThZMceqdahHGJeGBmVbCQFKYZi0g2U/BgcYrc9qSfsk0ZbhZ/IcIdy0e00a2Ec33dcBnwx4RQjOpnV2D/Fg5p2fFvBYkf5LmkZ//2CdZpDG2A6ToQV1XzBcWbcSrMCP/eM2m3TksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JSTfH/cH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso1802756a91.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725648839; x=1726253639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gxW7zGEcfjHvaccSBeMMlRMsikKLMKllizI6+H0GFvc=;
        b=JSTfH/cHnGpUBaEMZCW+AlvBRM0lLMu5hs+92jCPrzgnrnnUgs3otLCJOZcxPglImr
         r/GN/mU2MpAMdsDEuUld0Lfo8KtyxuguL7WejzmZyIRW4vh/z56WCgkSyrwLSqb8lisz
         fmJmvu7KzUzFLpV8djYm5997pJy6IuURoFWPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725648839; x=1726253639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxW7zGEcfjHvaccSBeMMlRMsikKLMKllizI6+H0GFvc=;
        b=V57UPnX5H52ERQdRGSrQ0mdRpo9oLz4lsekI/vNGsMceWmINNrgcxZx41XNZCkaI2d
         xm+D6Cciv7wUOFNoSYoDRJttCwqfhocpfo1XaXnK6i6zk/+XmHC8T5fh3brvP8DRH4mk
         W2pQ7japQMIcHkbQhu1m8dMxguNqIj6irnsJa7XVUybLPDaMqibCP4Una18neBRfSltY
         SsCGl3vdJlCbSwFZk+AltEaPKXkeZybN6x4bD620ze6mpBR8zQi0pS0MuNaOlqh9bJy+
         hj06sgKyWvyUsOWmhLA0q3J9jZozxPJkjFuRifLc9RtAiyRyMcA/W0EgqvhpM1R3bZ/g
         DdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+JHsFlELxFYJL7p3mE88VBUuw5PnG0YnqWwPuEt7DBfhpyiZg3FdXs247DqjhxgyLIH02DKVS6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XyswrF8+7EpDwZO0BtTuuiMpVDF8bhXxepXXXykh6gVYWyO7
	7DMBfUlfbTrv/pdlr2kDJQ27iC0DwKTXCaafsDWLy75sLlNdavDHqD1tKbGx7w==
X-Google-Smtp-Source: AGHT+IGyuhVdHpgemjSyuB0qAWi4hST+Gklb+OoGAeY8tuDIxPvLJTqBCnQFAn7D4L+NoIEiF2FF/A==
X-Received: by 2002:a17:90b:4c48:b0:2d8:8d34:5b8 with SMTP id 98e67ed59e1d1-2dafcf1b325mr483149a91.10.1725648838788;
        Fri, 06 Sep 2024 11:53:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0a881fsm1951967a91.48.2024.09.06.11.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 11:53:58 -0700 (PDT)
Message-ID: <eeebe625-244d-48b7-9e48-2d26460127c6@broadcom.com>
Date: Fri, 6 Sep 2024 11:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Correctly store and use the output value
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Stanimir Varbanov <svarbanov@suse.de>, kernel@collabora.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240906110932.299689-1-usama.anjum@collabora.com>
 <CA+-6iNw1PCNL6k3bx18VySbgt8m2tjOMokqC-esDfHaSN-dh0A@mail.gmail.com>
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
In-Reply-To: <CA+-6iNw1PCNL6k3bx18VySbgt8m2tjOMokqC-esDfHaSN-dh0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 11:20, Jim Quinlan wrote:
> On Fri, Sep 6, 2024 at 7:10 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> brcm_pcie_get_inbound_wins() can return negative error. As
>> num_inbound_wins is unsigned, we'll be unable to recognize the error.
>> Hence store return value of brcm_pcie_get_inbound_wins() in ret which is
>> signed and store result back to num_inbound_wins after confirming that
>> it isn't negative.
> 
> 
> Hello Muhammad,
> You are correct -- I was asked to make a few variables to be of the
> type u8, but I missed having an int (ret) hold the
> resultof that call. I believe I am still in the process of submitting
> this commit series -- V7 is coming next -- so I will
> take your email as a review instead of adding a fixup commit.
> 
> Unless Bjorn says that V6 was applied.

A similar patch has already been submitted to address this in a slightly 
different way:

https://lore.kernel.org/all/20240904161953.46790-2-riyandhiman14@gmail.com/
-- 
Florian

