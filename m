Return-Path: <linux-pci+bounces-30211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7315AE102E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 02:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C176E7A2C99
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A8191;
	Fri, 20 Jun 2025 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cWbAjkbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55D17E
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750377967; cv=none; b=Qk2OQtdiZEFNbpnCXKC0HMhx6cjdzkXH2AeaV7WDyqpvNynwRYL22UJ836RdoHhrZjHZQFkjvl3jcCKBBXy8WKRjDcblU85IP5zmchHhIw8Tme8Rv/r5UILu1khoWx3p7kdVyld4MM2nc4+B3a0ltx2Sp6cVOLpfcM+BvphaR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750377967; c=relaxed/simple;
	bh=JkFflt00HwGBgpwGpZrGJCFYuhnAd1RuJtPkKV7KaYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA0zEzR6TjjQTSOCEZNgbpfTVzCaP+SnQ5+14Z2Sf+3qWEuXucIbcdLz4MukiWV7AB/F8t/8JaUVcedXI8IjgJprYLbIO2kXiabtE1260AEP1pEXPSW1nNtdT8c3DEP/T1NmM35flCdTpdvouy+4nKIe5R+fY7/fFV0m25Kd6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cWbAjkbs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fba9f962so916635b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750377966; x=1750982766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qOMw0IV4VLyIUr0PdhWaeTYCxS85gyQwv89WQzcbTao=;
        b=cWbAjkbs6vHvLevEsIMMAZj0lVdMxoVKE3fPlkjRDL5pbp2XJusrRBsOJtDSE1lf+x
         KmHXbGw3EuvLjoVR5pLABlckqPQv7J7nfuZyWx2o5gZ9XL/dd6290K5k2z0D9e8pC+rX
         bAZKoBInC2zz3MISZg7wIbP4OOVQ48v+dWpj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750377966; x=1750982766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOMw0IV4VLyIUr0PdhWaeTYCxS85gyQwv89WQzcbTao=;
        b=uQZe7N6zjFBECSYAzxK+IRdxiG42O1A3ZdyBtJ/g61YoYwUpqHVY0I0WD7hukYgo+j
         d+yfbT5JN+4SkwQz7kMTogZHG2BLDOAwzuTGgCbkh3M/0CcrjYw0AsuKJC83BZEvf9UM
         nBxXz25lNJOsIq5iaoTLXKSYTl42PHpmdHb8NHwVMahSjiaQDMvROlT3YlCyIrosqA+t
         nJv8qXSejDtMh5zqHbTpBICrpGWMDgrpszg3HqMg3KlgqAHwk+9T7KrPb99BYNa8Es1V
         WS0tEf7fcy76zW5sAX3zo1g5Mks+yfYdc/kCvWO0iJz4f66Jw/M/9muZcR6+2rtXK7JU
         oYAw==
X-Forwarded-Encrypted: i=1; AJvYcCWCqHfpmpWF/DXsPGi8Q4sTx0kDdOSNMiWYTp/ivEy1Vrfz7fHmO9CGkOixxaDWRc27ZyCIG54yt4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpoiltOUmp4h+K8noT9SvwtxxqUb6tjFT+gz8oB3iMi2JRdcr
	pcs89yDwSTac6synT3BqhDphl2TuGxRDzoOsaK9kdRNhsblLal3Da2FGG06E9IeXWw==
X-Gm-Gg: ASbGncttnjee6d78Wd2Gdc7eCFat7C0AG87vZ2gTo4GdgL1bXInewbtKsljbV5QEJxD
	iCYNRkni4P1iuuDuZ3+3ASWRgDEIZW4n3r4hOMvEbLQ0LuuKMR0DcWMXuwJaJ3TMiO4z9l+78HR
	i4AuOpo0IITAMrBBcJq8divg6p8+r0trZayqRHGmeaFUOT6qRGMiFuyCcPrS12IC0HRxWn7LcGQ
	2zxpJGerBXT4UZX69wL71hcyleOgXXdM6PKU0UixWD+11BMUJw5mVtz6TJ9yCIY/zopRRzE8tv8
	6rgouzon5andvvmlwwqkrFYakbF15ZF7gH+b+FPS9ElP7wckv1ZIngCQeRo4Or5b0KB98SYFbck
	Xs4oUWfpZple2pjJIlQOIq48Wdg==
X-Google-Smtp-Source: AGHT+IEnafTDL9gm3piwR1q4n3x45Hc7s6pR0nuJE4cWcZLpc1ZqJcMtfgvU6BzwJF4ZQGLnw83mlw==
X-Received: by 2002:a05:6a00:4b53:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-7490f54939fmr500231b3a.8.1750377965568;
        Thu, 19 Jun 2025 17:06:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a65ad6bsm704629b3a.133.2025.06.19.17.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 17:06:04 -0700 (PDT)
Message-ID: <fab224f5-fa6f-4df0-8b43-4f296e554f8f@broadcom.com>
Date: Thu, 19 Jun 2025 17:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 Cyril Brulebois <kibi@debian.org>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jim Quinlan
 <james.quinlan@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250527222522.GA12969@bhelgaas>
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
In-Reply-To: <20250527222522.GA12969@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 15:25, 'Bjorn Helgaas' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> On Sat, May 24, 2025 at 02:21:04PM +0530, Manivannan Sadhasivam wrote:
>> On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
>>> On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
>>>> What I would prefer is something like the first paragraph in that
>>>> section: the #ifdef in a header file that declares the function and
>>>> defines a no-op stub, with the implementation in some pwrctrl file.
>>>
>>> pci_pwrctrl_create_device() is static, but it is possible to #ifdef
>>> the whole function in the .c file and provide the stub in an #else
>>> branch.  That's easier to follow than #ifdef'ing portions of the
>>> function.
>>>
>>
>> +1
> 
> I dropped the ball here and didn't get any fix for this in v6.15.

Any chance we could target a fix to be back ported into 6.15 stable? Do 
you need people to help you test it?
-- 
Florian

