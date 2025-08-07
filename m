Return-Path: <linux-pci+bounces-33570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C837B1DC1D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED817E0E53
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812632727EE;
	Thu,  7 Aug 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dflYzmQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43E26AAB5
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586062; cv=none; b=r/Z0HX98F3moTMFWmXQv4AZYJ5lBNjKCwyacZf2bTbr5NBsbKtipBtnvgyS5V3b/qhM1a7lGNF7QyDo/K/qMAazSSv08ZWOrkxVrNRoTCLgW7ZOL4GMhyWxnueI5ge7ApyurXfiJPQRUweJa4//DLVek5YICnd3m3fam68wSqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586062; c=relaxed/simple;
	bh=L5WxlG8R52B3mkxh38XVgLLiqLg/KA0oY51mwkvB8Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHe+Yp4roksEYimlfp2rKONA8BP4SLGnFv0aL8n0DnrdDC24wjObGEBscQcERpuOeyvZdEc0b9xw/v8cbF5ATr3jo+iDIUsJcrOaeEhiTjln8HovF3rI3c6hk3Fpep9INh4BqUwYRF5QMhYfkAt9J3JDSRfMMRE7Yj3CamnmLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dflYzmQs; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-619a603b7cdso501317eaf.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2025 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754586060; x=1755190860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2XQEZz8DrQTR1mxU/ualC1FnFYm75rDAYl+kFwmjZuU=;
        b=dflYzmQsI8GtyLErloMZiDo/TK8XGb00dIgnGFx8gLB9BT5Us/8872X2Agmby5AY1S
         NdYLKhzDN3EbfAPFygxz857AFSlehENCqZx44MDywhWR1/0W/kVXU5KYudBTPcb+D+MV
         tuXhvZRXJu6HCb1EskxKO6m61quR0fCtjKeAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586060; x=1755190860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XQEZz8DrQTR1mxU/ualC1FnFYm75rDAYl+kFwmjZuU=;
        b=BjqLobMgNouzXeD3l9mBrPuklZRVXw3hW3GZTh6+B3XwCLF4qzdUiepQlfMLeKfjhl
         JHI1PmnwUmXgBHaoO06y8LHu6INV9ZimPjqjWZTfrxGkp2JJtoVrX7bWb8XvnFCW3IIp
         vYxO+0vedZAEAw26FztL+Jho3B51t1XGO13NdKpSQyQqxU1Ns0XSMIWSUkUwdnG1Vj/1
         QmnCJ/1uOA1tZx2s8T0Xy+dTBw3kojxGOZinIjJK5LO3+uYrqPFaoZ5WHJiww8C3bQF7
         jS5E+PMs6rlpnUZvVF4wgynGT1Qi2JvUV4uZuVoBHm2gBi1XfBhZfAjMv89olEYS45YY
         rnKw==
X-Forwarded-Encrypted: i=1; AJvYcCVZoTmcrBfh2BHpnvIhBYka9NNRlPElBt7MXJyb+3c1mKOpQf6eJ8CSKGmXyFreUzi63i6QAKo41oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5LUBaRKSCzjNToYKI/5ZXn7G4dXijOe3nPlu4dGW1ys9E3aZ
	M/leDMxoSKp4NK9NoT2mbXY5L/3AuuWYeZxznKDhP6z3w18/YHEb7qRaTwRs6elnRn9sVuFrzwz
	y34Hhfg==
X-Gm-Gg: ASbGnctbNT4X4JzUOX2viPqd1vudSHGPMIXtqV/GqyaMwofIT20CZIMJUCxOp28xC/m
	Ra8ftNJL0OcY06QflV6lQS41O4TheYCIWlUABBoaiEySZYp92ud8rrsKjTnCQZgQfVbkUeU86ox
	LWNn5MVqA3g+TfumiP8mrFRM4FlAbg0orSl4oKsgI5Rff7FPT18/S69wVvTISucWpTuqes4+0W6
	XjhYW4BoXSgK6CiKh7B87cW/n8yOpsDDaVEyQNlQm4FP9KsPaEUcy8UYNLVnLPqEAbbYsrZMwwV
	o2J8Rij3t9cV4J7QDOFlYQze9xzmpg/3A/elcwbsaB0kgVQsH/fJg+U+2k34/Sps7318gYxe3Uf
	om21hp37h0IvYuixGbD5LmkCEvYzLKpRWnAfpP+ZMaBpscKuVYgmwW22qsfZFfg==
X-Google-Smtp-Source: AGHT+IG1bBL2oQySi+K0k5iOJwT9pr8OKXIeKQOlPuvjdUAnInwVIDuPNbh6rF/ytsTKp8wb3JxMMA==
X-Received: by 2002:ad4:5cc5:0:b0:707:2472:dc3b with SMTP id 6a1803df08f44-7097afbe83emr93427616d6.42.1754586047987;
        Thu, 07 Aug 2025 10:00:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca464acsm102096016d6.36.2025.08.07.10.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:00:47 -0700 (PDT)
Message-ID: <8ff6c436-74bc-43f0-b5a6-3085ded52d02@broadcom.com>
Date: Thu, 7 Aug 2025 10:00:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250806185051.GA10150@bhelgaas>
 <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>
 <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
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
In-Reply-To: <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 22:26, Manivannan Sadhasivam wrote:
> On Wed, Aug 06, 2025 at 01:41:35PM GMT, Florian Fainelli wrote:
>> On 8/6/25 11:50, Bjorn Helgaas wrote:
>>>> I'm not sure I understand the "racy" comment.  If the PCIe bridge is
>>>> off, we do not read the PCIe error registers.  In this case, PCIe is
>>>> probably not the cause of the panic.   In the rare case the PCIe
>>>> bridge is off  and it was the PCIe that caused the panic, nothing
>>>> gets reported, and this is where we are without this commit.
>>>> Perhaps this is what you mean by "mostly-works".  But this is the
>>>> best that can be done with SW given our HW.
>>>
>>> Right, my fault.  The error report registers don't look like standard
>>> PCIe things, so I suppose they are on the host side, not the PCIe
>>> side, so they're probably guaranteed to be accessible and non-racy
>>> unless the bridge is in reset.
>>
>> To expand upon that part, the situation that I ran in we had the PCIe link
>> down and therefore clock gated the PCIe root complex hardware to conserve
>> power. Eventually I did hit a voluntary panic, and since all panic notifiers
>> registered are invoked in succession, the one registered for the PCIe RC was
>> invoked as well and accessing clock gated registers would not work and
>> trigger another fault which would be confusing and mingle with the panic I
>> was trying to debug initially. Hence this check, and a clock gated PCIe RC
>> would not be logging any errors anyway.
> 
> May I ask how you are recovering from link down? Can the driver detect link down
> using any platform IRQ?

Just to be clear, what I was describing here is not a link down 
recovery. The point I was trying to convey is that we have multiple 
busses in our system (DRAM, on-chip registers, PCIe) and each one of 
them has its own way of reporting errors, so if we get a form of system 
error/kernel panic we like to interrogate each one of them to figure out 
the cause. In the case I was describing, I was actually tracking down a 
bad DRAM access, but the error reporting came from the on-chip register 
arbiter because prior to that we had been trying to read from the clock 
gated PCIe bridge whether the PCIe bridge was responsible for the bad 
access. This leads you to an incorrect source of the bad access, and so 
that's why we guard the panic handler invocation within the PCIe root 
complex with a check whether the bridge is in reset or not.

If this is still not clear, let me know.
-- 
Florian

