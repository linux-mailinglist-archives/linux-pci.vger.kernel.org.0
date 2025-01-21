Return-Path: <linux-pci+bounces-20208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D86A18534
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 19:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DB2188A73D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666801F7064;
	Tue, 21 Jan 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aeFdr0k7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885481F4E50
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484163; cv=none; b=ozDa/KDTId4z5yRFddQu5G8CAoO9vh0EvFL475goUszHvxN0nGUo3GlG8FZ3Ba5oKI5LhPFsOj+a2gt5sC+vdoBFsul8M1z+T19I0GwcDAOaXVKA53UrH+KQe51dLi0Tk6SE6j0Src6n1vfJQ9MqCLiJknlCGUd5UKp2nu8YwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484163; c=relaxed/simple;
	bh=Hab+TsOD/rAlksUb5f98aFac0T41/XCfFHsdkOJ7D6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN8j4YmA+rEOXpFglb1czspmk7vGO4l3aA04u+GPqAOqKtrEbyiSfzrqgnDZxetZUL7hT81a0vEYmJfXk8O5/T2YPzqXEbfeBOfPGznxLYoH7K973M0hxme/QubxVquS8Bl4P6RdA3G+Ka0fhOIJY6yd8eC+JFnpVxy6Hrd4Snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aeFdr0k7; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2aa17010cbcso2461300fac.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737484159; x=1738088959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CAvOK/vXUJ3DR3zGC7PEbA5edbkAP+/9CECVTn9NqUM=;
        b=aeFdr0k7AkUyHiB+VX4qHV2kdfFP1NVH/uk3cF69c3/3diuydzL0bt8QZObEjGagFE
         EQ7GTaVJJDZZuCRkkyi+3VdxcahxIixsTG7NC7nyT2JKIt16mjCaQsUmm2R3wl5lL5Gt
         koRAEaMRWT657lq0FUbb/JMf1fNZS55XrJX8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484159; x=1738088959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAvOK/vXUJ3DR3zGC7PEbA5edbkAP+/9CECVTn9NqUM=;
        b=YQgs2GJhXbqmTIFBddnF3TYgc69awQo9+H4cFXW8t3j6N3iBuwrVO3Sm7+DnAwcLPW
         Gzf/3oHat/3UNxrukTSXrCGlZG1htZyanlDsqi4bNQ108wBpZUWCNgPEZnuPZPjZSgCS
         5rhFSriabh0A67bV4Qtv4uRYVYh9Z+m4+PvmRPbUPTRuzIFvGQEJYfxRPivYHlKyviGu
         bPce5JHxN3XehzsZdpSZwvInvBY2G0dp6Os1Q5fZTkpkfEuhDId51IN8mM2jdC/dk6wn
         070q8FlS9We59MtjKy2JVj/3NN/Dqx1CYHYIf1XKhTGzjTQjO2KHl/8xQgWX43yET9AZ
         ICGA==
X-Forwarded-Encrypted: i=1; AJvYcCXmcl7xQ16e+VDGofvapjsN+r1rSUvDq5JlqWhTmotftODrDJwayvT08R3uQc+zOzIXsnU9SWKsjCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwZfC3dgU3oSwzUD3wh5+uRXDLWmEiyEwrdoDp7oZcvNBmPR1
	lrasfADCBzCS0n2iJeUjJSn/4Za9b3tv+dquJ0DJTidQC/7oQVg4J8uYiKA7TA==
X-Gm-Gg: ASbGncuhWzszU1xGcIRyh38m5pB5RxCfdD9aXfPnG+9vkYzvLtWFh+QABWzOx53JD8L
	DggFxQFx8mWTwhr+L47+FQzOeBObwe0tWXQ5F6IYhNyguwSEUgN6xX3FFklBp2jHoAHC+eWeN6p
	e0uchEt7jYPObEO+UOFxmb6nr//S4XmnNSJEBL6SA1VUT6+XkwwiWiODy8K0Jhxr2RG8ct/vXzE
	RzLPxyWNDBGNQVTs4jFJGpbSREjtzXVD2gfSHFmn2B9nPB+rYDkrEAht8EqDM9D82Vj0ocCwohN
	XIkJZsggnrvWloS+oaL/ytR24GLpjLLZZQ==
X-Google-Smtp-Source: AGHT+IFSsOMr97oNRmSERDhQ0fDUB3aBFX5IWM/A/ZTN4m/C1LuCKfN/vp7fge9pEMOwqfeC94zaTA==
X-Received: by 2002:a05:6871:538e:b0:29e:5894:9de7 with SMTP id 586e51a60fabf-2b1c0cd8350mr10775730fac.33.1737484159544;
        Tue, 21 Jan 2025 10:29:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8f75872sm3864256fac.36.2025.01.21.10.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:29:18 -0800 (PST)
Message-ID: <be8fdeba-4707-467b-be18-d132de9f89f7@broadcom.com>
Date: Tue, 21 Jan 2025 10:29:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 08/11] PCI: brcmstb: Adding a softdep to MIP
 MSI-X driver
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-9-svarbanov@suse.de>
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
In-Reply-To: <20250120130119.671119-9-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/25 05:01, Stanimir Varbanov wrote:
> In case brcmstb PCIe driver and MIP MSI-X interrupt controller
> drivers are built as modules there could be a race in probing.
> To avoid this add a softdep to MIP driver to guarantee that MIP
> driver will be load first.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

