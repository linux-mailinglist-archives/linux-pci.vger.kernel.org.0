Return-Path: <linux-pci+bounces-15853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA49BA1BE
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4642A1F215D3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184419DF4B;
	Sat,  2 Nov 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wq5RETX1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE54EB50
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569025; cv=none; b=ojZgZQ+hdnFJtN09K9KtKeEtbBm70YR3GS0yt4Lv4jAhRmzc4FKaugayGBImEOOTJTmpYZwhOQx5i3o218SzLzAJ3//3t1LzRHGnFrRGT/RGkvOcfeSf6MvKVbEBNvEiWEhGxFoEIKtm952lexjEsn5NTaK8rH1Wcd5tO5BdZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569025; c=relaxed/simple;
	bh=TX5Fb3VSulwjsBNqPXJNSjjat4RfgtIHTJXMlwBZdyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOnp9risvai3dYAQ88VntrYOk1c4GS3aENBUtWcLOmjZOicctnuynjlNJg3HCgrtT1EKeZHheXqGOnbXFNkI58thSIjSITBR/WadtuEqlk3ZmCJdc2dVoBkmmDB0kiOL7pnPDtsLoZaYSUPbPne8kzj2zXxkltrdlyWotjZqtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wq5RETX1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe9914487so19591756d6.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730569023; x=1731173823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cDjUTnPhAWqKwpEJKZPL5PAhtXqP+CRLXlCOCnEWTrw=;
        b=Wq5RETX154p05shjE7ibh+o12gflhoLUn8dkGmbWiWjjb+wzL564OismVj2fkFpeQD
         PPgINJLFPu8CfveXtI4S6wmhN9oMXCNwnCnOB+mOsfUPvabpzaxhbh8kdVr8ozjHPZmv
         sd7/BOU61YjoQ7KLa4pSyXgS6DP8Wlm5wQoZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569023; x=1731173823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDjUTnPhAWqKwpEJKZPL5PAhtXqP+CRLXlCOCnEWTrw=;
        b=DFj2skaY19zxOxVDh+08xcRI4nhvYtQ3iBjvdpjP/lmTBcKiLd6ffzeXBfvoyr/57n
         ndmXv9W+pD9gIHE/7BIyhexpc0rdh+epda7/Pxuar/j7lmcmTI1GZrZ25u/xWoSogI0H
         Lj8HFORFc1Uf/ivDgp8vYP6JiKDeGBVwlTPhSKkjK+scM6wK38l//NG2N4zOQFqxVFG5
         rc0GPOGd/PVV1zS7iSq/V7BiZSFR8ZUB0rv2IPjJdX+fh+eU8fojMujbUyNEFASrPRYL
         xnMI6OzbR4NTLgUEUOM1JSwdFe9TKWHfRgTunBvg/fIRS8P8Zn38R13+XgdfBQL4JGfN
         HarQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKKZElGkeofhSWbPNH1NQB6vlTA3mua0Nah806f933+KCMTAfKJ77s0cfTrVIFyNAudsbTVWH5iG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUnC0ZOHdDVJjzqdfWr4GUcu57WGGp3pE6HuLHA/w7yBwTxIT
	BfGWbkvIE5yOFWXg4d/Uq2vSbxxMz/Zz4D0wxMUDXzfXu7pWEdyAvXWfiLZpqQ==
X-Google-Smtp-Source: AGHT+IEXmjORPXz6+S0cOcfpkIhS2iXiN5h5SM12Fmt8haXmSiXiF12S4EWhypU10zUEQGnFF2xFLg==
X-Received: by 2002:a05:6214:398a:b0:6cb:5d17:62df with SMTP id 6a1803df08f44-6d351ad3f2cmr163825216d6.26.1730569022853;
        Sat, 02 Nov 2024 10:37:02 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35efe67b4sm18599296d6.124.2024.11.02.10.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 10:37:01 -0700 (PDT)
Message-ID: <26c4c8fd-6afd-44fe-83a9-adebc1a281bc@broadcom.com>
Date: Sat, 2 Nov 2024 10:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcie_bwctrl fails to probe on Rpi 4 (linux-next-20241101)
To: Stefan Wahren <wahrenst@gmx.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Jim Quinlan <jim2101024@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, kernel-list@raspberrypi.com
References: <dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net>
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
In-Reply-To: <dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 11/2/2024 9:53 AM, Stefan Wahren wrote:
> Hi,
> I tested linux-next-20241101 with the Raspberry Pi 4 (8 GB RAM,
> arm64/defconfig) and during boot the driver pcie_bwctrl fails to probe.
> Since this driver is very new, I assume this never worked before:
> 
> [    6.843802] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000
> ranges:
> [    6.843851] brcm-pcie fd500000.pcie:   No bus range found for
> /scb/pcie@7d500000, using [bus 00-ff]
> [    6.843900] brcm-pcie fd500000.pcie:      MEM
> 0x0600000000..0x0603ffffff -> 0x00f8000000
> [    6.843940] brcm-pcie fd500000.pcie:   IB MEM
> 0x0000000000..0x00bfffffff -> 0x0400000000
> [    6.859915] vchiq: module is from the staging directory, the quality
> is unknown, you have been warned.
> [    6.885670] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
> [    6.885704] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    6.885725] pci_bus 0000:00: root bus resource [mem
> 0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
> [    6.885823] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400 PCIe
> Root Port
> [    6.885858] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    6.885876] pci 0000:00:00.0:   bridge window [mem
> 0x600000000-0x6000fffff]
> [    6.885954] pci 0000:00:00.0: PME# supported from D0 D3hot
> [    6.909911] pci_bus 0000:01: supply vpcie3v3 not found, using dummy
> regulator
> [    6.910159] pci_bus 0000:01: supply vpcie3v3aux not found, using
> dummy regulator
> [    6.910251] pci_bus 0000:01: supply vpcie12v not found, using dummy
> regulator
> [    6.922254] mmc1: new high speed SDIO card at address 0001
> [    7.013175] brcm-pcie fd500000.pcie: clkreq-mode set to default
> [    7.015309] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
> [    7.015526] pci 0000:01:00.0: [1106:3483] type 00 class 0x0c0330 PCIe
> Endpoint
> [    7.015626] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
> [    7.015954] pci 0000:01:00.0: PME# supported from D0 D3hot
> [    7.062153] pci 0000:00:00.0: bridge window [mem
> 0x600000000-0x6000fffff]: assigned
> [    7.062191] pci 0000:01:00.0: BAR 0 [mem 0x600000000-0x600000fff
> 64bit]: assigned
> [    7.062221] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    7.062237] pci 0000:00:00.0:   bridge window [mem
> 0x600000000-0x6000fffff]
> [    7.062255] pci_bus 0000:00: resource 4 [mem 0x600000000-0x603ffffff]
> [    7.062269] pci_bus 0000:01: resource 1 [mem 0x600000000-0x6000fffff]
> [    7.062590] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    7.062812] pcieport 0000:00:00.0: PME: Signaling with IRQ 39
> [    7.072890] pcieport 0000:00:00.0: AER: enabled with IRQ 39
> [    7.091767] v3d fec00000.gpu: [drm] Using Transparent Hugepages
> [    7.124274] genirq: Flags mismatch irq 39. 00002084 (PCIe bwctrl) vs.
> 00200084 (PCIe PME)
> [    7.124391] pcie_bwctrl 0000:00:00.0:pcie010: probe with driver
> pcie_bwctrl failed with error -16

Yes this is a new failure for sure. So PME requests the interrupt line 
with IRQF_TRIGGER_HIGH | IRQF_SHARED | IRQF_COND_ONESHOT whereas the 
bwctrl driver does: IRQF_TRIGGER_HIGH | IRQF_SHARED | IRQF_ONESHOT. 
Reading through the comment of IRQF_COND_ONESHOT, that does not seem to 
be an incompatible configuration, but maybe it is an ordering issue 
here? That is, bwctlr should claim the interrupt line first, and then 
PME would too, and they would be OK with the flags?
-- 
Florian


