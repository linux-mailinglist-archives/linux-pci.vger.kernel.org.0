Return-Path: <linux-pci+bounces-12684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F996A5AF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA8285F15
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA9191F7E;
	Tue,  3 Sep 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aGoszKsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFF1917EC
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385546; cv=none; b=YOhwWlcOYoBWmjKv0jpirflqXMjkL68XgPL3zgYTu2+jj+hGVtsR++Kct5VuZiZWhGYUQ+ll6jF1JhNy4pkJaZA0Mo2NtIR32k+hQoX5K+Wss1jUHZ+276I48dQcK1ZbCGH10/EePsPH44iNTJRD56df7lKiQc7pkXf94wRnIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385546; c=relaxed/simple;
	bh=nTdrb9uR7/jd8t4QLRscoBSzgtYa4mrJOywfJWfrOe8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qefoIhFpdexWa8AdjKdFHWgbDABial6jPfJcHaTQVsej3kKSZphn0wjxXCL3vehsRZTugmONj9WvNhnWQ/gHITHBfGggZkv7sOqF524G/ETiTxRhD/RxGPP8Kssx44emoefoTTiNiIcwgk++PJSQt7HduYQpt8ose8vzma7xtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aGoszKsh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7176645e4daso1397130b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725385545; x=1725990345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3U/qOEAcWb5c4MQDovr6aE/At0h1Z9coG62wGqmbh7c=;
        b=aGoszKshg/0z2UhQdp3rJvRIZpIWUKkxmCLEDP2kyK2L6cLsgIFq0bZEHPKMCGpXw0
         aUGrZ5hcwCZbLZQmByN8bt4KQhGLfe/0oo3UHBKIkTO1vjgfga0dWpOjvQugZv2YGNKQ
         SF3mRCbFv+82WX5vd4rNQZYB2LIyOveNKRBDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385545; x=1725990345;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U/qOEAcWb5c4MQDovr6aE/At0h1Z9coG62wGqmbh7c=;
        b=Q8OVSIxCO/UtcygVBZ6Yd6frsuwLXIKSyqXrfgrwRiI2syWuYR44LlNVjjqjIxvZ7w
         gnCLgm+cEYUsUZ6PI9VP85CNu3tfuX32zkzWdLXmW2aY/v/t9u+yhm+7X2EARQ00Pwv/
         hxvm0o0wrnLGwN+bhLHVc6/4r3Hz6Vczl/t6WAU8tlkfcow8FwmQ7foBuGn2mJapq0sA
         O3bHZc0uvJvS2weNe5U23Hov4U65gZ/z+IWKnTxnR1zgj7j55WguRQ9qxL+laGG3Y2zx
         V/Lpo2U+MPZDIjBRsW5UrYhYVa8ok+ZXjGQcqPwvW9KO1HCJNEaZG22W5e5Xa6zbW8za
         RGVQ==
X-Gm-Message-State: AOJu0YxThqMU0GH8COoF+mAH7KAg/rQU4WescRfw1+Vm7Oi8dE8HU+Bu
	a1Oq+uGSEwj5AFmr0i5m6kXs8rR+qnsq2mMkkeBTcya0LHHp6aahIDuINHR59A==
X-Google-Smtp-Source: AGHT+IGM+TTtHmKs1QSDI2elSVemAmtiLyWfX+nlSvkMSsZAECRrfa7OaE627B71XLU6LRmGdYHT7Q==
X-Received: by 2002:a05:6a00:22d5:b0:70d:2a88:a483 with SMTP id d2e1a72fcca58-7173f8adafdmr10905636b3a.0.1725385544296;
        Tue, 03 Sep 2024 10:45:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785996d0sm137258b3a.145.2024.09.03.10.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:45:43 -0700 (PDT)
Message-ID: <2f3e01d0-9b4b-4678-b05b-226074579b8a@broadcom.com>
Date: Tue, 3 Sep 2024 10:45:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v6 07/13] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240902194649.GA224705@bhelgaas>
Content-Language: en-US
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
In-Reply-To: <20240902194649.GA224705@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 12:46, Bjorn Helgaas wrote:
> On Thu, Aug 15, 2024 at 06:57:20PM -0400, Jim Quinlan wrote:
>> Do prepatory work for the 7712 SoC, which is introduced in a future commit.
>> Our HW design has changed two register offsets for the 7712, where
>> previously it was a common value for all Broadcom SOCs with PCIe cores.
>> Specifically, the two offsets are to the registers HARD_DEBUG and
>> INTR2_CPU_BASE.
> 
>> @@ -1499,12 +1502,16 @@ static const int pcie_offsets[] = {
>>   	[RGR1_SW_INIT_1] = 0x9210,
>>   	[EXT_CFG_INDEX]  = 0x9000,
>>   	[EXT_CFG_DATA]   = 0x9004,
>> +	[PCIE_HARD_DEBUG] = 0x4204,
>> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>>   };
>>   
>>   static const int pcie_offsets_bmips_7425[] = {
>>   	[RGR1_SW_INIT_1] = 0x8010,
>>   	[EXT_CFG_INDEX]  = 0x8300,
>>   	[EXT_CFG_DATA]   = 0x8304,
>> +	[PCIE_HARD_DEBUG] = 0x4204,
>> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>>   };
>>   
>>   static const struct pcie_cfg_data generic_cfg = {
>> @@ -1539,6 +1546,8 @@ static const int pcie_offset_bcm7278[] = {
>>   	[RGR1_SW_INIT_1] = 0xc010,
>>   	[EXT_CFG_INDEX] = 0x9000,
>>   	[EXT_CFG_DATA] = 0x9004,
>> +	[PCIE_HARD_DEBUG] = 0x4204,
>> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>>   };
> 
> What's the organization scheme here?  We now have:
> 
>    static const int pcie_offsets[] = { ... };
>    static const int pcie_offsets_bmips_7425[] = { ... };
>    static const int pcie_offset_bcm7712[] = { ... };
> 
>    static const struct pcie_cfg_data generic_cfg = { ... };
>    static const struct pcie_cfg_data bcm7425_cfg = { ... };
>    static const struct pcie_cfg_data bcm7435_cfg = { ... };
>    static const struct pcie_cfg_data bcm4908_cfg = { ... };
> 
>    static const int pcie_offset_bcm7278[] = { ... };
> 
>    static const struct pcie_cfg_data bcm7278_cfg = { ... };
>    static const struct pcie_cfg_data bcm2711_cfg = { ... };
>    static const struct pcie_cfg_data bcm7216_cfg = { ... };
>    static const struct pcie_cfg_data bcm7712_cfg = { ... };
> 
> So we have pcie_offsets_bmips_7425[] and pcie_offset_bcm7712[] (with
> gratuituously different "offset" vs "offsets") which are all together
> before the pcie_cfg_data.
> 
> Then we have pcie_offset_bcm7278[] (again gratuitously different
> "offset") separately, next to bcm7278_cfg.
> 
> It would be nice to pick one scheme and stick to it.
> 
> Also a seemingly random order of the pcie_cfg_data structs and
> .compatible strings.
> 
> Also a little confusing to have "bmips_7425" and "bcm7425" associated
> with the same chip.  I suppose there's historical reason for it, but I
> don't think it's helpful in this usage.

All fair points, especially the lack of consistency, thanks for cleaning 
that up.
-- 
Florian

