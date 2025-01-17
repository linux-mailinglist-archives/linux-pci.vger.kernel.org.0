Return-Path: <linux-pci+bounces-20070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF7A154E6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E116551F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154131A01B0;
	Fri, 17 Jan 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TB05YIK3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D719F495
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132747; cv=none; b=iDH9VWMsToBeljgnI5dW5rSqT9Zrk5puh/sGLTY21+S1Q18hvhrmQdTZeCp9VVPDns4j2HNFmw/+ZPWTR3XQWi7D3DL+fLw7t0GUxgSIzoq4V9NaidkA9ML0xjjIvhBUKj4K1F9HU3pGwiuav3E7v5lA9yOkK5IACy+h3pKzemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132747; c=relaxed/simple;
	bh=GxqGfy7DCS0v9UvoUQoflUG7DqaWios1qCm/ssJ4Cws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BNlf/JaVj4E2W0gmWTOub/+xaEvIEV9U+3JdFxW/B1AOxGjQBxR2cXdCR1ji9l4CPy8eO8NMF/qtNAENevVH4LqeXlomaKzJC/TjqGL9xGt/y0R20zoCst0+89LfBkMSZRyP+BMKL3JqLoaHW8bSh00VJiMDLFb4bYJ3HpNJvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TB05YIK3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a8690dcb35so830343fac.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737132744; x=1737737544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gbPn385nmxgkLr2JTs9xLHKsJGuOpLTuKBJgMVB8y7A=;
        b=TB05YIK3fOSwj0FoijFUNpWv8xRxA2K/B9Xs/Yv0yxohn+TFlU3NVtFh0R1xw2IML0
         WVLjlLD8Ph4sU8XJUdg0BMdrm09LWaL0xweWz/n+Sh2zFNUCQS7FqNs9NztF1xLwiXhe
         63CJKPO+AVZuHlP+6a8Kojb6jZP4w5K8K6aD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132744; x=1737737544;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbPn385nmxgkLr2JTs9xLHKsJGuOpLTuKBJgMVB8y7A=;
        b=uh1P6WzJia/PLGD/xmyWjHQ9auaBsk3BpcjeOBpbCYWtcHeSBcqKVIkGzX8j0aOpTd
         H67zo2CFtlzsBlyD18tLyKTcGvTjJ6bZaEbaTqwDQhZw6CW3cHnVe7cbEs08sqTUTCTQ
         kSwAyBuShPd0emYdGQ81CUge7LrEUcqMwt7otLtPIA/AK3QBx5sXTVvz0CHfiZIVE6IJ
         kVa/6ZtBe04dPVX71rxd64mWpgRBlrXnH1LHYQ3PSsUeI0LGQ2z9lrLu8iLS30HDyWMH
         Jarn/3kqpOht+eDsRp0FMAWpyQdIxCmbbcpYv820b/dM2XJcyPqMNFdmCeBJ/upESJKl
         3gHg==
X-Forwarded-Encrypted: i=1; AJvYcCWc2izVka03A5WcW6NMhUKA0++qbfvKxhVTvGrZT88WySMR96eFrETyNStS00n7GkvICABko1XvE4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHhD5GIynzSFNfDLwfg0AYKZWWeuCVpJmPgpOykKaLp3cY+O9
	1Uj7eSGxamf4d2/whuIFTAexgqN6EeGm25u1fRVuqwAQKFHIn5vY9Xwf3r1SaQ==
X-Gm-Gg: ASbGncupn74OXg73V08rSlGd3OOLPkoCnF/yPB6RRmIpTXz75zNSnd70JRc8jyetsNj
	ecH01vlfUZXmci7cf7Ka/QKGGCgtRG+MAfXpxuAZByN+NnSEmC5Cg82wG9I0gf7wNLOn7K98BC1
	oZOPx4Op9yws8dVGLWCzLJRCGgMOBbewYtR4uHVw0SfACMiWiBQymjRPLuccTxTdymBFfy7ABf+
	LCilyXHj69g5ou7srrvsLOsv5gXY+w0Cg4FUuG0fShpXK4B2f4UKcctv18om7x526QlXTwi/XJJ
	93Oalxx0ennjRfEnZSWc+wW06rD4yWA=
X-Google-Smtp-Source: AGHT+IEPQ2tZri6LlF68yq4mtGcTHaoltWas3irZkTK8fHqf2B06a/y/jkJBQakfa1Dd4rkmWpYZuw==
X-Received: by 2002:a05:6870:4e0d:b0:29e:2f3a:761a with SMTP id 586e51a60fabf-2b1c0a349f5mr2131118fac.20.1737132744451;
        Fri, 17 Jan 2025 08:52:24 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8d4b3c9sm1131584fac.25.2025.01.17.08.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 08:52:23 -0800 (PST)
Message-ID: <339e2337-850c-4201-83ea-eca59e297396@broadcom.com>
Date: Fri, 17 Jan 2025 08:52:20 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1736776658.git.andrea.porta@suse.com>
 <c22fa1e06926cf946ea3cb6647e9e27441f26398.1736776658.git.andrea.porta@suse.com>
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
In-Reply-To: <c22fa1e06926cf946ea3cb6647e9e27441f26398.1736776658.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/2025 6:58 AM, Andrea della Porta wrote:
> The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> schema is intended as minimal support for the clock generator and
> gpio controller peripherals which are accessible through BAR1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


