Return-Path: <linux-pci+bounces-33480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C9B1CDF5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1016118C6A4A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6832BDC33;
	Wed,  6 Aug 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bZO2x0lq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B22206B8
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512901; cv=none; b=ZpCpQcrNlf1FSp6t8RksEPcxoLsJ7k+AUq3O3GkKbcetgJSNYasu9FLJPaLEDDb8jc5OA8fFSz3GArDiGPA8TxEzAdAuHkmqoldwjJurFQ8rxD5lfMeylCnS98IFYVFhECZYKucParQ+FVfz+dLFs+RatqFjnvD2FM9IUH4cO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512901; c=relaxed/simple;
	bh=fYPEqrR/QtkwB39VAKloiAiFpQmxZ6OXgbDQdeZLYvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4ozY3zbE3KClnLKtABwew1igi7S18MePwmEWQ1FBFqeco0d0TvB8t9SQHnCACkWAb4vv2zCVO0mRObbQ5WMABOVCSi3WDtNiJ1/m6/utSYP+pDr/AR4N9cM7u5/8SGxEvvqdhgtu8wNJXKmjEO0Vf+agKUy78em074iRMsCjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bZO2x0lq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so1922015ad.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754512898; x=1755117698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ia3SLEzSRc8nG56lmpcOP8Y+PfXfHWZspV0p+jrskHQ=;
        b=bZO2x0lqz1Ng4qUuoyqnhiBNoToH3iWQ8GzE15NUH0ZsP2zpz4cJ3grsDyQGQE4BQP
         KBme6T6uEWOP0H8sZ+HG9EQy/FXop/42UjDik0qw5VGjsCtgggFFgECj1wzzly/x3OBk
         QmQ6rpq97oFsEexblf31htv+dXbvNYeus37Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512898; x=1755117698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia3SLEzSRc8nG56lmpcOP8Y+PfXfHWZspV0p+jrskHQ=;
        b=nvATufwp8m+q6T7LtutWNoRw52nDcebFQvVozKlIe744eo3qWeDZHJGF7zR8ix3com
         +ie761t90R65Iii3QatPY/FxQnnTbzbN6JoNOKrmWYGFSaf69u7FeDv0YLzHPVWMrmBc
         ndFl1rjS6gxuzNp+fMxinWSLr/+2RBYLgb6f4jo4hjVQJnYOvc0KYhHNnKOYF1kk+0tJ
         QwWeIgxDppx94/kvd4al9UnPEMUZEGzyBPu6PNnMBXUt9xBvIhzBs8soASs0N4RSiKdL
         5goXVpI/oiOHR/O/AB2mCeaM0eafNHWpIdqpQTjfIIiZj/qhRF+9ZX783CQabiZRt2tu
         bNrQ==
X-Gm-Message-State: AOJu0YzX22VjHsneZ5YhX3e7NPbFOdogetnfFsOZtjrED3AYYjDevq50
	s6NB1V/7+S2q/knLHgteana2/A5hfJHtz2kyRKM227kieX9r3V67r5x4sdYxgLTuvg==
X-Gm-Gg: ASbGncsSFdkO43qWdYlrb28uXq39qpnO7ha66/cGzuDB6uUr/E+8nGQbZI0sh5gMeC/
	/Pa74PHW6FBG02z3F1qacDnREN+lPioqDTwnujK8q8KesdhTBz4VBmg1NK7y0WE4WhzQhxeOrl9
	AoZa61Q6GH0U2richOESi/ABysNA8gOqnx2uC5fc0CMB2Adl0HOdpOnqq47+wnbNkkC+DprcoTp
	UPyRYFMbfG6rw3R9AHCiAQpx3wytiCAZSodKMJ40a/ZW7OYq0NoTZjShZ15x+qP9O74tLdJNdg1
	Ol1X5Ukgfx1VLoofog3H+GykICyKnUPiZbf5txDACyhXvXI96iRRv7YWs74j5W7BV3f2uR8upo+
	9TCuZy4Ynq+2rPKsqBq+Hmo/0MNM/M2W5ql54YUr1r1R5FHOoK6lk//+Em4rZaw==
X-Google-Smtp-Source: AGHT+IGsVmEZizu/BQRtnZByDcXVDlU2OY7UH+LY0vzm1LBEU8C8nipRQoH5hnET3JlTZpJECTO39A==
X-Received: by 2002:a17:903:124d:b0:235:f70:fd37 with SMTP id d9443c01a7336-242a0aa6a40mr53194985ad.19.1754512898109;
        Wed, 06 Aug 2025 13:41:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm167085995ad.79.2025.08.06.13.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:41:37 -0700 (PDT)
Message-ID: <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>
Date: Wed, 6 Aug 2025 13:41:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250806185051.GA10150@bhelgaas>
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
In-Reply-To: <20250806185051.GA10150@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 11:50, Bjorn Helgaas wrote:
>> I'm not sure I understand the "racy" comment.  If the PCIe bridge is
>> off, we do not read the PCIe error registers.  In this case, PCIe is
>> probably not the cause of the panic.   In the rare case the PCIe
>> bridge is off  and it was the PCIe that caused the panic, nothing
>> gets reported, and this is where we are without this commit.
>> Perhaps this is what you mean by "mostly-works".  But this is the
>> best that can be done with SW given our HW.
> 
> Right, my fault.  The error report registers don't look like standard
> PCIe things, so I suppose they are on the host side, not the PCIe
> side, so they're probably guaranteed to be accessible and non-racy
> unless the bridge is in reset.

To expand upon that part, the situation that I ran in we had the PCIe 
link down and therefore clock gated the PCIe root complex hardware to 
conserve power. Eventually I did hit a voluntary panic, and since all 
panic notifiers registered are invoked in succession, the one registered 
for the PCIe RC was invoked as well and accessing clock gated registers 
would not work and trigger another fault which would be confusing and 
mingle with the panic I was trying to debug initially. Hence this check, 
and a clock gated PCIe RC would not be logging any errors anyway.
-- 
Florian

