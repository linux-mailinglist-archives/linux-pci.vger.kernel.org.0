Return-Path: <linux-pci+bounces-28877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F02ACCB33
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BD31891D5C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6E22F767;
	Tue,  3 Jun 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Frdbpzwg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597844B5AE
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967856; cv=none; b=mQV/UbeJUtpAsUuJD/597wbrcCl+Hw9FsVqhegsg99bikRVQp8am+1lc4vp1StGDN9WdhBEjZP4w5MMIKYt+MzDHlR22mPvUimnEz4BI6IEWWuc1orm+T8w5s4h83vIeSNq/IutbEarzqjWQbevEdN5/kMK/o4NWU9Jsye453Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967856; c=relaxed/simple;
	bh=N7BCQ3oqAnCjFSJnJmZX5Dctlb/sTvgV4iyi3FNvIgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V7MJpuBnQe+jrMw+o/VAG2+lh4nA6vzM/kJlAyMIYRNczbePDJxEJfDsrLEzgt2IW+tVrGFdnGgtImLom+G/mSrTS1vXaVmBJVrXXqrpk9urhoQyZYgmfXUOJKOeD11womXO3n5GA8GLrLYkJOTTyydf0qP7qgfNpAuYvV5/tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Frdbpzwg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso6411490b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748967854; x=1749572654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PsTtB+z1bvDl4NGrrXN+rO6t/978g31yCeEcylF7R2E=;
        b=FrdbpzwgDBWEn3irvUPXUHH7YYdy2zc+s2m8OhB1WvvOHxTCHZfwFWFdfOnQJC4cQg
         /K3GdgLZ/cpFusd6EAivhwfGnGPCDoNT3YCBE+cqM7LEBDhfuSsseBxueequc675nkGz
         VyePX0v5s1y1jAYZJnhqnlAZ72Dce/EqrHdwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967854; x=1749572654;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsTtB+z1bvDl4NGrrXN+rO6t/978g31yCeEcylF7R2E=;
        b=Nnmdzop+z+X8HqToFvhuKUlsZ27mWrVHPo5D13IkePQdGTANynBXiT6w/PiJVGGMwM
         d2fgAx2ZSA+yfnLIh1vBNfRkE3wL2vPptwiir5/zyNpBXyh3QPhjOyIQjG3YJQlF88+o
         mVXRzXT91kKqDylcrD2EkTAqRXms37lvgR1FlGhTnULX4oMwu8suAspWfjsKkGDIccK/
         nWaO1GT80lwvb6XuSL8A1uvsdNtxj+6xxS2mpN3beC2Ru5y88ftAVSxENONaHxE0Lnxz
         PcDXpQMJT688WwEY5IGIAsBGSDmOXNcAPykdTxbuEbqIMiV2AWYqLZquEyx5FSVPDZw9
         zdvw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ50OaPfmhZNotgrWIP5h+ulIe9OLgPXCPJPdkNmjsHb8rTYWHDQS4qQgSPPrBacP9A9eaEojrtSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EwX3/FWdB3OyWXJx1tfcu5Htuo6Vohnc0HBTf5BMGACmZCC+
	ODvOwk7c51vQW/T9FhrP5gznC6sVY9iYyqRV3puLRkbAa9vrgNSJ1SS7ZTtH/a3r1w==
X-Gm-Gg: ASbGncsSOFXPIMZo1KYxSY5VhgFXFpr6YYXR3+ECwNCm+7f6+G+iKX1AGj8XM/43Hmz
	hh/Z9RgvlVOLmIAWdClM0OHPafpPWW7cbKPZYuGWtPVA5BOSlYcH7ZP5KSOc0gfxwhZ4Z1tS5yD
	z6K1VI2z//KT3s2DsyfahF5ctj1e3U+RZAVSqCzBykLBPy5VsYlYpsImLyFtRq6F98Q4JbmKi9R
	afpq/L8Jjy30nhCwPnEM1mdKyqXKS+5Dyt0tgN915cwzl8Hq5YFeEII5qUeugcivoQmpYbTxu7s
	SF57arDw3SMMfrJm0IIAcPiNFCwFYIKWX4cRMaZ3e4IWejMomcsgArmWxdrl811wr6mP4p8qrg2
	/DzhuAuzSI1XcOmk=
X-Google-Smtp-Source: AGHT+IFKXHZ6CeWKl/ulfOEKEnune82cj+P2dFCkcmW9aLp6lK2qD/Lt2Jxz06XEpxzVljkgg6VJ0A==
X-Received: by 2002:a05:6a00:b49:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-747bd9e6d31mr25070378b3a.19.1748967854532;
        Tue, 03 Jun 2025 09:24:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeadda3sm9579151b3a.71.2025.06.03.09.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 09:24:13 -0700 (PDT)
Message-ID: <2f79ae4e-6349-472c-b0cc-ea774b8ac7cf@broadcom.com>
Date: Tue, 3 Jun 2025 09:24:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-2-james.quinlan@broadcom.com>
 <6c3ec1c3-8f62-4d76-86d3-c1bbe3e1418f@broadcom.com>
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
In-Reply-To: <6c3ec1c3-8f62-4d76-86d3-c1bbe3e1418f@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 16:32, Florian Fainelli wrote:
> On 5/30/25 15:40, Jim Quinlan wrote:
>> Add optional num-lanes property Broadcom STB PCIe host controllers.
>>
>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sorry I take that back, I think this should be:

num-lanes:
   enum: [ 1, 2, 4 ]

We are basically documenting the allowed values, not specifying that we 
can repeat the num-lames property between 1 and 4 times.
-- 
Florian

