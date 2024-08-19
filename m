Return-Path: <linux-pci+bounces-11829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CC957261
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B881C23157
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A8187FFF;
	Mon, 19 Aug 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IRZaRE6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B4186E25
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089743; cv=none; b=HbHm8mRSKXPz/K1+4cMlXtM4WYcOr+HsLCWwP9JXLehRvxst5fypT2bMo78TyW5Hq27IpgStUwJedyXlNA2o2hPOkyOI5cIbaOX0xBj9t+uFLT0KqMZmIh/lFDCJFRsh3s8R4hYo0UI/d7/7c3Es2T9euk9Ls4lrTnOAvYYrGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089743; c=relaxed/simple;
	bh=hTkS8vP3YzXCEbFw1RgnxthdF3hAz+BTI113awHZorw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeRhCNmjxU6+1wfdokNs/3FR6Kt6Ly0m37xqRUyRCEQ+I3BoDatjx7zvs+hVjPlHoIUKOVIjuUEO0FF4meeudFQ5s6Yx+icTu0ritRlSUQ7RyaOsB39VrrLi6m699eJampmKNGJjW9fgzHYWR+ToQza8bWug4mSSIJXrEPNo158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IRZaRE6W; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d024f775so350159585a.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724089741; x=1724694541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8kiYpity7QE9fjnTaEN0Otfc5NaWtjeUHbIZaw5EgeU=;
        b=IRZaRE6W3/sgnt+/lDT3Uoi6ZTQ19xXjKsXTZJ4XJ15ZrMWTWYwnOnsjjlH0id9rm8
         o7M2yfYkXrG4zHMfCmdfIvd0CPlB8LgBBcGyd18CBylZ5YmzFvp/ON9UCQnU4ZTB/bjU
         bKbSpqVlRLOmPehp0d3xkMrlE68Zq7i7P+LN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089741; x=1724694541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kiYpity7QE9fjnTaEN0Otfc5NaWtjeUHbIZaw5EgeU=;
        b=gOZaCVeIkHogwM7GCa+ACd8LJnMI1mQiNBTmkCmTlsqTwP3D6Aj0pCQb/kJ8k/a4/4
         uGIDTPKI/wlQ/qZKEOq6//ZoCjrRvEJu0EW2shu7mlpUWo5b24C3ljq2tUxl76qNLJKi
         pAJdwjgRB66Q0yD6k1Xe4fZ/LYzTUoDX+LIPRND9w1Eh3sJCbrlFREYCjE1m2LVbGFeH
         coSvf/3npRqTFp4ML8hSMvHRgmfU2PnbjJlFPIZ1ALPzahNImaptKbvfLTFVZjAKksMI
         h/z0bT83UAo5F9s2EGlafPdbIyr2kNpW9TUErqLYJz9SSZddvwU7GcuT9HpG8VwSb+tB
         CU8A==
X-Gm-Message-State: AOJu0Yw+OqVy11TuVFeMQwHY9uwM65Fo7KYF+QgJe0y4eRV4TzDlPjBG
	8zMX864rJbVysm1YbKtX17VzuwZK379kKYuL5tokE6ZXWe2aGwI+SXAEBjxGJw==
X-Google-Smtp-Source: AGHT+IEjyKNVNzbiz9tq6nMYcRZoQu3gCMdJn9f0E8cT9KI+QQeYl6RdoIIb8dSnN6MK5wEoCPF6AQ==
X-Received: by 2002:a05:620a:4312:b0:79c:fbf:6381 with SMTP id af79cd13be357-7a5069df09cmr1005035485a.70.1724089740635;
        Mon, 19 Aug 2024 10:49:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e4f2sm42095151cf.69.2024.08.19.10.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:48:59 -0700 (PDT)
Message-ID: <f1e8d543-6144-4664-934c-38f988550162@broadcom.com>
Date: Mon, 19 Aug 2024 10:48:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] PCI: brcnstb: Enable STB 7712 SOC
To: Jim Quinlan <james.quinlan@broadcom.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240816071822.GO2331@thinkpad>
 <CA+-6iNz4+xP4abf6w6bcVwFxvjx8OhDZXNi5bwfaCNvyF2Mtng@mail.gmail.com>
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
In-Reply-To: <CA+-6iNz4+xP4abf6w6bcVwFxvjx8OhDZXNi5bwfaCNvyF2Mtng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/24 10:44, Jim Quinlan wrote:
> On Fri, Aug 16, 2024 at 3:18 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Thu, Aug 15, 2024 at 06:57:13PM -0400, Jim Quinlan wrote:
>>> V6 Changes
>>>    o Commit "Refactor for chips with many regular inbound windows"
>>>      -- Use u8 for anything storing/counting # inbound windows (Stan)
>>>      -- s/set_bar/add_inbound_win/g (Manivannan)
>>>      -- Drop use of "inline" (Manivannan)
>>>      -- Change cpu_beg to cpu_start, same with pcie_beg. (Manivannan)
>>>      -- Used writel_relaxed() (Manivannan)
>>>    o Use swinit reset if available
>>>      -- Proper use of dev_err_probe() (Stan)
>>>    o Commit "Use common error handling code in brcm_pcie_probe()"
>>>      -- Rewrite commit msg in paragraph form (Manivannan)
>>>      -- Refactor error path at end of probe func (Manivannan)
>>>      -- Proper use of dev_err_probe() (Stan)
>>>    o New commit "dt-bindings: PCI: Change brcmstb maintainer and cleanup"
>>>      -- Break out maintainer change and small cleanup into a
>>>         separate commit (Krzysztof)
>>>
>>
>> Looks like you've missed adding the review tags...
> 
> 
> I didn't mention this in the cover letter but I update the review tags
> at each version.  The problem is that if someone has reviewed a
> commit, and then that commit is subsequently changed due to another
> reviewer, I have to remove the existing tag of the first reviewer
> because the code has changed.

It seems to me like you did the right thing here, the changes you did 
between v5 and v6 were substantial enough they invalidated the 
Reviewed-by tag(s) you had gotten previously.
-- 
Florian


