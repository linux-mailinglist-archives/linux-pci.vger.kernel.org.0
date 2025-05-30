Return-Path: <linux-pci+bounces-28742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09ADAC9826
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C4A4A4516
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4228B51F;
	Fri, 30 May 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fCNwhGWt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1722750E5
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748647983; cv=none; b=JMyjisgcnpcqRgDxRynfAdhmaWHAD6yM8ohrG8WXYWNSr3be5sYKoEmI6Xk7bYipON9eMF+IZGkzPY+YI7bcc5IDmPi9J4Bq7hjW8OP5qwB/rSYUm5ThpD7ir2XUSIuzIVx0oYJyMOhGut3ngC+67Dfv6BzavYez18Dmr3nN+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748647983; c=relaxed/simple;
	bh=0Kx5fdeO9kkEbPY5HTMbK9SIDlW+EZkZvQurAeicY58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZUiL2wrN22lTGj+Rv1IzssMjeiyBSSMwa3gntR0cNKpzoxdvf4uKTr9MATsal6c5iM3Kv1/4Ssn+jfbGzbhiTlN5J1/G47aq1gTOrvSHNWC7H2ruQY7qxnJQpsdMhwuON7CwHke1ohRZiscsDeRxUdfLJgcMbMAWvyCCYeiJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fCNwhGWt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234f17910d8so25628455ad.3
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748647981; x=1749252781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fO/4KVyqLd7BgsoaaqAUu12+AA5eN8Wk8zQzu+oUQLU=;
        b=fCNwhGWtkj8qNIR5MbVaquaZvpgpVs9Rbya5tG5DyDOLzWJii4BdCywrIwNbUuOL1h
         APEb1mNymjsfAtSTS4//bzigQtUnBhQeyzP1bVW2Gueho1UdtzXkPj+ze/QGmUdG6A6u
         Kb0/w9pQQ/cwz/r9sQh17RhP+euzs41UIv7+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748647981; x=1749252781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fO/4KVyqLd7BgsoaaqAUu12+AA5eN8Wk8zQzu+oUQLU=;
        b=PhMcIID4Ib+quDrrqVL7bGV20IRuJJWDq7mUZ8KrFpbgokR0FoUH8QMxadoAgAh49e
         uo6ORefE7QQm1K1okmGF0NFrCy64oFBZYEOaEuiamEDAoRQ9TNpt9POqrmLTFsenDUJw
         JrdQMJN5+mLQnGwit9QmnkfYdqJSDHNMCdJL3zlklFA/2YqwlPNmlfbKHkJQWSucbo/0
         pY9atBJYZAMGTxiQANk0NAu5pBI+BmCr1SR//OcPoWqiEUlEOUiYNzz/iBQLKZa3YJ7i
         wLB2fAzBKaUUTsFKYvxInvMSrre6CygBvzf/w8DrVYd8kCEkkqQMiWCcpzLb1BQH3352
         OnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaxH2qOK38R+o4yKzmfBx0PivISRyaWGpA6j1PbPZfmgfanrDRMwH9F9wKEDxYaE1yuqfX+w7sX5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD55gAsO4MGznO8uW0X7LergYxEIxpg/ioFRcIWa+lCd/5ytBN
	LS7jh7kYqeWn+2aEPe9RoCNQT+nhDdbIwf9r3+NQhx4c6O+UY8A7/t1MHNtGB3ljiw==
X-Gm-Gg: ASbGncvJjMQVkI2t7Mr9CFclLgiCgVbLY2F7mb2yo44I7+uSlmoSJL1HVnaNo0lMLsp
	FuiQgrn5RyqvAbsQ4FAyFGmanBtIpMUOAoN6CnOCd2SpO3wulohx5SZLmj+r//mb8QxvpnwWM5w
	Kv5zoQWehnfZVsR2Wb3ca9FJRrHi+KzrFEiXIGfKrF+vWuiZbtZ1HdWiX94cvOFB4NvtQoPazBv
	VmiHjbuzPWFauO4rZTpEnTebt4rHF1JDWIweyqBLDdsVBByI6n5VxOvGXw3MImSHb00ktircwqG
	xXE5taDRf4KdiTUgPdODArE7R3YOXFeTXFYLSnGW95SmOVnoVWKGbj2nqfVMf6KHncqGQlIPFLr
	YpatCRFjsoCj/3RAF+Vvg6TCJDg==
X-Google-Smtp-Source: AGHT+IF9TsYKCXhHP+BKtTXbH09zwj1ypcFvEuEq452X4UyJrKl9DCN8BMUbAtxtyBD0jYmN+eERjQ==
X-Received: by 2002:a17:902:ba85:b0:234:909b:3da9 with SMTP id d9443c01a7336-235395b1dcbmr39401845ad.27.1748647981175;
        Fri, 30 May 2025 16:33:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd7618sm33196345ad.152.2025.05.30.16.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:33:00 -0700 (PDT)
Message-ID: <6c3ec1c3-8f62-4d76-86d3-c1bbe3e1418f@broadcom.com>
Date: Fri, 30 May 2025 16:32:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes
 property
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
In-Reply-To: <20250530224035.41886-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 15:40, Jim Quinlan wrote:
> Add optional num-lanes property Broadcom STB PCIe host controllers.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

