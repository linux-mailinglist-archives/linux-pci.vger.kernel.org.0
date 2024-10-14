Return-Path: <linux-pci+bounces-14489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9399D533
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578271F2456C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EF1BF7E8;
	Mon, 14 Oct 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PWaKLBKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DD1C3033
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925375; cv=none; b=I4VnBwaebMQrjUN1PLpvqJmkZV2aFHYFCuH3jkK9jd7Qu159bDWjzAMaeOYKXOOrrtgvvgxxU8XxGizz4DguRnZRxXvxBdpCfdlFwNn8vJi9CzVlt9aXlEtkKqCaDMUOp1HLbahTaQR1SVVvlDrhwsmCe6sbINmZltPIk+NyWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925375; c=relaxed/simple;
	bh=g3qtpIvmG8mF3JIPIDHmLDVNMF9OY0FWT8cLgBya/lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ff05nc+HlW9lhqlIal39aUbG8oP7PEO/fgu4mfnclc0kch24Z3m+iuC8ZOm0BsrBgiSZeFqFVMsnSBAIsxeqLXk62XvZUPIC0wwzEyRCVj2GTGffLbOIRoC91GBMmrepn3sEyS64XKOm2Mp1CHY3+zAmGqPHL1cyWPQfWZt4LOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PWaKLBKW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1665974b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728925373; x=1729530173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WeUCkCJvJU9Gb6hBQWUQbGhIHp2zyfnrIfEP6jNnlAc=;
        b=PWaKLBKWyOgMis3I6K562kZ7oDqBOU8DOTl4h7x/N9BuHRkSubkbv28V3oA13YgCtk
         ZNavrSu998w7zquL9dogId34Qv22zY2ZK2dhp2dtHmBtyD6OVaa7uxjZvfJg4+DeNzvA
         uKFmKUIDIdEhP4dDr4WBHG0sdHVLvlU8FFs9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925373; x=1729530173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeUCkCJvJU9Gb6hBQWUQbGhIHp2zyfnrIfEP6jNnlAc=;
        b=eJBaMC3WTujPfqyTDkvuwsSM9eoEHKYMJTYluBaZWamO0lErPD9ZUKpttLl7rY8Upy
         kKPsIOMw/9EWND2VR2N+xtosqBZtO2HZD4HErlY6LpZXm9GEKR7RYkg0clOPGeqhrZJO
         36CHtPnv8Q3XJX9P2e3EVM1bWma2IkzMdCWDa7mOnVQ9/m01h/u4mwNmU2yXDTtwOkU7
         VStK6MQQF/kJMd1xzoUL8LBDqxz/kBc1qMFd+VT/03QDd3p/NA2yO4qDUWN0dcqrwBuy
         ZBTgpRh/amCq/SVeU3Nx2r7+YgtJVJ/F14g675/WSsflqzlNakMTXkhrJF771eGBrL+V
         B3fA==
X-Forwarded-Encrypted: i=1; AJvYcCWLJZM3uz1B07B/PBRQtxaCror3q+rykvt4qC+O0ofqaFVFnAQdKwkRL9S5PXh2w0YndaaIPPl/1oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyrlWLVObYTyl4x9Au4+53I4HIDC6hORTfNaPqxnVYr0Fn0WN
	x5lnnh2HHE5NvQUUcQqGfbv2yfIILjWD86xiunu01BvbeVXSCuepUNEOQtBCQg==
X-Google-Smtp-Source: AGHT+IEMI8KRcfkHDLsZ+p8OCRzjuyLPVkWt3kAxTOHec4Qk7Ut4iejKMCenps7JS7DnkvtF20WFyA==
X-Received: by 2002:a05:6a00:ccd:b0:71e:1cc6:4ed5 with SMTP id d2e1a72fcca58-71e37ec41e0mr21394795b3a.10.1728925373427;
        Mon, 14 Oct 2024 10:02:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e6af68c81sm1663470b3a.116.2024.10.14.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:02:52 -0700 (PDT)
Message-ID: <b8616563-22e9-4c20-8bf7-0f51f303b3c7@broadcom.com>
Date: Mon, 14 Oct 2024 10:02:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
To: Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014170105.GA611115@bhelgaas>
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
In-Reply-To: <20241014170105.GA611115@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 10:01, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 04:07:05PM +0300, Stanimir Varbanov wrote:
>> On PCIe turn off avoid shutdown of bridge reset,
>> by introducing a quirk flag.
> 
> Can you include something here about *why* we need this change?  I
> think the RESCAL comment below would be a good start.
> 
> I think this should be squashed with the next commit that adds the use
> of CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN.  Otherwise this commit doesn't
> have an obvious reason.

Agreed.
-- 
Florian

