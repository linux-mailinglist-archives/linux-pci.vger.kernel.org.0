Return-Path: <linux-pci+bounces-11437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E794A9D4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AF01F2B1D9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139C6F315;
	Wed,  7 Aug 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c8JqGOe/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A056F2F0
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040210; cv=none; b=KXqQaqUpFdKcOYSTJcgMWCMUGfJe9N9JDozBsUjZCoy/yN3Sm9kxIyArnSTKiBKiyrgJqo4WUhtCevMKXvH9YO9+pj7O4J2oFGJZQewHJUgtHxeI1vxxUtAPw4dMS43Mfv9332PSPVTCVhE/2e7iJdDnW0iy5L00oKlNQc9lsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040210; c=relaxed/simple;
	bh=JQH1L2/dOhE+N+iQy0YvuVMg6Dr6e1XGGFaJkKgKEPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMXiR3/TP4oHkMx7K5yK9PCyTslHyX0qZfAo6QNlc4vs/k56/4UknUacg2zJXOREqDunNx2y/u1uot5Uwwj4l7uVypiNXGiGBuE3P+7fGvhbYllVyB2dYR+Lq8O7E8FMxudKDn6k+BTiwG2dUcJ2u4kiZ+aw4zi3cPg3ldwfm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c8JqGOe/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-451b7e1d157so9565961cf.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723040208; x=1723645008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OYjWOa/hLPaVN5PNqXkqyI06NRvtLXymCzruaWqdxNg=;
        b=c8JqGOe/lEo68Jrk3hQ2WZWSMRjHpW29+BdNyvG0bVmurvVfRDQdZhP2PIMEaNOa1n
         8FapTsdh5LavrQsF/ua0hZAmxoWexXOMF1G9tZ0v1POK+IEIzNS4nq+K8wcGRZsInsCA
         OtNZos04dbvfMbop1lkj4N3XchqUInvPlWzLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040208; x=1723645008;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYjWOa/hLPaVN5PNqXkqyI06NRvtLXymCzruaWqdxNg=;
        b=oq3nZz1z3RJNBw3ME14S6iUJEDQvm8O8YhqKwhlRQ2RkW00VPD5XQdRuEefL+xt98j
         03kPRtwd6giuT8VtyWVYrxkEBTP77QVOk8MYE6C0WaLeub7ADA7kO4d82TeihXIKcvsc
         D0jGKAD+21BAN+rZ1noRgweBPhFCq9khwaG8rL3/xVVUKZpIXj4Hh7ES5FySKsy2DNBJ
         cSdNB1HERoZYHZZHMrzaJKmTnSbpXOQELzeGcre4AJsGFIIGkF+5n+cDML0FP3ifcyyz
         0jKLPW755RugdbTWFuqV6Y5K5VCvh1ybIYM6xZ/YqmgH1esCH4S0DtUhQTEijMe9uK1n
         zZXg==
X-Gm-Message-State: AOJu0YwxX/qYM6e5hJWeEEp9+7tlcE1Z6eQUpEAYrhiipgkJM1AMmbw8
	MzmeAsoNZKO4a+34r3j2f5g6Yj92XNBHIYvM+z/rbnyVOn1tES3QnFO/Dc22gA==
X-Google-Smtp-Source: AGHT+IG7K89vZilE6Sz2dUud7gYcixB3g1TtZS0AZlSh6gPKYmppOaVM05ZwsSY4/bwiVXdFFXwmvQ==
X-Received: by 2002:ac8:5d8c:0:b0:447:dbe8:5268 with SMTP id d75a77b69052e-45189286d41mr213923601cf.37.1723040207539;
        Wed, 07 Aug 2024 07:16:47 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870066csm5317501cf.4.2024.08.07.07.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 07:16:46 -0700 (PDT)
Message-ID: <c32a28f3-aa64-4e89-a8f7-acfaed8ac090@broadcom.com>
Date: Wed, 7 Aug 2024 07:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
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
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
 <20240807140401.GJ3412@thinkpad>
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
In-Reply-To: <20240807140401.GJ3412@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/7/2024 7:04 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 31, 2024 at 06:28:23PM -0400, Jim Quinlan wrote:
>> Provide support for new chips with multiple inbound windows while
>> keeping the legacy support for the older chips.
>>
>> In existing chips there are three inbound windows with fixed purposes: the
>> first was for mapping SoC internal registers, the second was for memory,
>> and the third was for memory but with the endian swapped.  Typically, only
>> one window was used.
>>
>> Complicating the inbound window usage was the fact that the PCIe HW would
>> do a baroque internal mapping of system memory, and concatenate the regions
>> of multiple memory controllers.
>>
>> Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
>> drop the internal mapping while providing for multiple inbound windows.
>> This works in concert with the dma-ranges property, where each provided
>> range becomes an inbound window.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>> ---

[snip]

>> +static void set_inbound_win_registers(struct brcm_pcie *pcie,
>> +				      const struct inbound_win *inbound_wins,
>> +				      int num_inbound_wins)
>> +{
>> +	void __iomem *base = pcie->base;
>> +	int i;
>> +
>> +	for (i = 1; i <= num_inbound_wins; i++) {
>> +		u64 pci_offset = inbound_wins[i].pci_offset;
>> +		u64 cpu_addr = inbound_wins[i].cpu_addr;
>> +		u64 size = inbound_wins[i].size;
>> +		u32 reg_offset = brcm_bar_reg_offset(i);
>> +		u32 tmp = lower_32_bits(pci_offset);
>> +
>> +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
>> +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
>> +
>> +		/* Write low */
>> +		writel(tmp, base + reg_offset);
> 
> Can you use writel_relaxed() instead? Here and below. I don't see a necessity to
> use the barrier that comes with non-relaxed version of writel.

Out of curiosity what is the reasoning here for asking to use 
writel_relaxed(), this is not a hot path, this is a configuration path 
anyway. I am not certain clear on the implication of using 
writel_relaxed() on systems like 7712/2712 where the busing is different 
from the other STB chips.
-- 
Florian


