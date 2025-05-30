Return-Path: <linux-pci+bounces-28744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA1AC982D
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480D01BA63BB
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093DF21CC41;
	Fri, 30 May 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PF9j/UgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3722688B
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648045; cv=none; b=HuO+m4smxNcFDaqJaLJ/tEJjB/hbG3GN0hl7VqouDz+axTiYouQ4KMTYKD44ScZp0FPbLw7IxHiXxks+idPcNx1Uy475r6jlLMl3jV795CbqXrgAhVYGC28YPXSFH0KUb6CYRh73TRFUy8kHJF0ItCGkj/25l4fjalh34LtxeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648045; c=relaxed/simple;
	bh=ElSbyZQHAdZtVaIBNqlbVN8swLObIp6FMGMvuzQjxho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCrElOa6x8TbFwj5LtZd68fmOLPfmo229P4axtEb9tZN1FGESuCDLuS3y2ivaVl0kDwG0YgZ1uuvd8/3mf5/R+gqcWHiKmMlFr6jfr2yjvbUgFiUNwQzYVbl8DhWPq7sF971pZLJU0zOQeviprv5vVtth/EtISBPgUemL5njhKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PF9j/UgG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-310cf8f7301so2095771a91.1
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748648044; x=1749252844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/crfMUaUSr7Hvxl7AwB/ydPc7uMgzGaWk+2fxYyCuRQ=;
        b=PF9j/UgGT8l/FkHRm2G3QqDJEauK12bYaujcN/BeScr/8HoMin9vJVs6x2m2uI7SdI
         Z6Vg8uohrhYyBsEXPZqy2ICN7gUUYPZrZGT699m5swEFw5YnEL05iSZv9eVALx+8JIEc
         ncM+Lug/Stw+5ethqFycrAJHOG1rT/alkKl9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748648044; x=1749252844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/crfMUaUSr7Hvxl7AwB/ydPc7uMgzGaWk+2fxYyCuRQ=;
        b=Hh3fZjXjg9Vv9U1Fy8qWmry1u5BohgE4pMgDPrsvcGysYVEZYm6X0BQSk/if5WlRlt
         SeDZvXWAXinH93kXwgr4kZJ9HXnCf0JAsIdAVkeXi93HDmxgpSWsf+IDw1U2tg+XI7Yj
         EQvVX7YGTDWxQJGynUfFa6qCN4ur1ubkuxZKfHWkJXumrjrSbBJluPPFXgnN5D7dB/L5
         WH3NhbmQjQcy9yWU1733Sqb+gua1SbWLJygJnEV5ws+jo1s6IKo1+6xQ+CClpCnhnbVI
         BCXLEmYCU/EhnozEWS4G7ETxyQ15jV0AqGdoSsxD3Ngld5WozI+9CVdvwOe+Oxw/3LP9
         u6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0dYUWCiGMvn9yjAbMCA44M8yZyuix+ciCPBbN2LVbE8zfr9XIDtVlT8vYRwr8jW6EtVqgl7kk+lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9Om9rASP/A0Oq5RUs/DzDioaJOjcSnQ4PY12Knc7t6yM+BRz
	m/mIy+ueOgzYnOnUBngmqmjdcZUx2G79zuGSjXYA2DJnt7TuOFxaUDjAsqKuQjN4hA==
X-Gm-Gg: ASbGnctNWHyKy40PFARuTSV7qT0VjDoBY5mUvAz14JXbPes5HdbA/N0mv38u83fxksg
	FUR7XUDxC5Kqwe1IrewR21RT5YoIPa+bS7FMxkMlRkvRUQSMcZIpF3N30wGZYk0XxCk32BrUGck
	yfvG4GAyuai5n1SUjhpQlbViXFyWv3aTGK4unO+ka5ce8J4uOiFYaK8HcszjX54rox3Nughr8/Q
	EHnbVXd87qNrmc2Y/SApLYBXGs5WqyCWUi2mBu1ATDSSprGK2OHSrsnKctS+n3MgacncP1XxTsu
	qX+2MW8dtglkEgkjnXfh8uw94dO+DjACjdHgv0RVd4DkeysIg8jWj4Szk9GUCb2J/OiguC8P1LJ
	o+b34jtFzRB3xOLrJ5nBvdU3I8Q==
X-Google-Smtp-Source: AGHT+IH8xoUQ7HZKe3s4g11l9T+D/ytNA2kGbgDPz7ZW8AsmVJXcmTTpj9J9ACTwaSJgs0MLJB3hAA==
X-Received: by 2002:a17:90b:2f03:b0:30a:9feb:1e15 with SMTP id 98e67ed59e1d1-31214e2efabmr15616943a91.8.1748648043815;
        Fri, 30 May 2025 16:34:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b51f5sm1728093a91.9.2025.05.30.16.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:34:02 -0700 (PDT)
Message-ID: <7b4f2dfb-cf4d-495b-8bcf-82e802bd3eca@broadcom.com>
Date: Fri, 30 May 2025 16:34:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: brcmstb: Use "num-lanes" DT property if present
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
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
In-Reply-To: <20250530224035.41886-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 15:40, Jim Quinlan wrote:
> v2:
>    -- DT bindings: Add default, maximum values for 'num-lanes' (Rob)
>    -- Add 'if' clause to clamp maximum requested num-lanes

Subjects should have been "PATCH v2", FWIW.
-- 
Florian

