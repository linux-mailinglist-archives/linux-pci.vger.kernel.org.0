Return-Path: <linux-pci+bounces-31105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BFFAEE75B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5157A2E45
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E62291880;
	Mon, 30 Jun 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RdvyOrlX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A231A3178
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311054; cv=none; b=GL2CvbrFDRjkGOQu1+MeuR5LFx5/NUPi3GouOE8Pp6uGacAdjYPZN3Nlc2Skb5cuEa20sGkApmD7oaz8BFtp8nMWQn/KKp+BkCW5kP23vBc2qUzndsq8GgVZfsjSH0M43Cyh2P4vPlN3eyxiy1lptlo9NMEUPRqYhkLzeMJREbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311054; c=relaxed/simple;
	bh=lgRqjNK57P/pT7MRMMd5GG7KE5rQwAii6UcuUqlhc6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GC5j6Cf3oeU75vaarh5reqaEjqiQ/tkKpGX2iQr2QrOue8hRDVdnOjFAx6e4jTz7VGSo/Im2m0+dqvfxmugjDHtb1DVq3foDlBf4GyLA2XPt41e8yUcT6jsiuvH9EZx9p7zCHqPIn59wsrexCm4Eoj8kmDY4FIPpExHkYG3aGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RdvyOrlX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4985113b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751311052; x=1751915852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/icnc7Os7AoQTpBWqs6e62GRa9dnHnzsYDszjaelMPM=;
        b=RdvyOrlXurTea1bFF1NhgDMrt69061KzK7Suc0NT6baFI2TfZzp7XE+1AyIOjkEwdu
         BgNx7hB/Wt5/YjvAYBNVjJ1Ph/t99wTELFFjch+lJ+cCte/tuVJFcvgrUD7zStSLJMrn
         IQo5yTu/vtB9j4PgeghVYTXEDbpQJCrUaxoBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311052; x=1751915852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/icnc7Os7AoQTpBWqs6e62GRa9dnHnzsYDszjaelMPM=;
        b=fL7sWshHLBH/OqkEfSxMnnTQrevnRovdsrX/cYnw3HdGQwYVNOEHf5Dv0JBGMCmkgG
         OsaX1KEkcS+zVp78OogfbKBjrM6j7xQi89N4PtYAw+8ryfzR+yMQSrKhEa2gI/XZUk0G
         rCTSrFzK06QNprLcqJyBkAAA4DmKPCSLgdkpL6T+hiRtm/BfQ/7wUUgqi1rTBREMBH4Z
         BWA9luzbsdmOYoBsyaLY+TFv6pP1puBIMvU3oyBgQQoPsxhoVXp5k0/aQAW4yAQ7ZnOs
         GKaegZru5LfxSWx1VH8XBcLzXNr+inAfyF903eXfIrE4fhDzvDi7jU6+DI9jPTtGPwF0
         kMlg==
X-Forwarded-Encrypted: i=1; AJvYcCUAnjOlCBbG2/CvQWr1cGOxhy9PM10xW1odBSmMiuzIw+YK3ukb2M8BwgabkeFRRH1JCIrQGQjNbNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dbsAHgUc+NRwvlAdJjOwO7eYHUrkhkEAhaBhsvAkYlvVu5tc
	4zi3GS5xUx8Bi/0WcACCnVQ8F5EAgHojpIS3sNCOlnZ/hHu0aatpEBtGHfnWktSMMA==
X-Gm-Gg: ASbGncuEFtrt6noryf/EYIB0ITU0D7onkyvfxWjcjcS+SkUJFsuiZR2yBTd+dODGI1g
	waD/y0U9b9e3jIkp38jWib5FQD7W2xqCMgSrIrBzP/zpNfGVctMa87yM7pofyXYuBs8+UhvwCGT
	JA7s003v+lvD/225a/HT1xK7YjfsYwruYncWKtFGtgLUBtpVmjbfR5shTzK/6RuA6uq3zLzaWmf
	uTTdLU5syqX+sdAawr3hIxV9fJlCLy5kT1tckxp3KfnQuKbscbBDl13TU6Z2r/zOEMvvNO1t3GL
	xGLNOWtKzGl29ZMvJLywazj3hXhDOdwzNe9g3lRL6d3fCQ0J8WHnOxqTlgES4HihTV0tbqMfWM0
	MraU+lH5wjtET90oY/GzDHoeCfQ==
X-Google-Smtp-Source: AGHT+IEki0KdQAjRMkHvaX3/gkmEnLE6D4qqKuPqbMXVfDYcUkTnDLdWtpcfzqFXZLm1SNTNGyqJEw==
X-Received: by 2002:a05:6a00:845:b0:749:540:ca72 with SMTP id d2e1a72fcca58-74af6f5b39amr21961216b3a.24.1751311051789;
        Mon, 30 Jun 2025 12:17:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e8fasm9787662b3a.67.2025.06.30.12.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 12:17:31 -0700 (PDT)
Message-ID: <d90c0d21-9544-44f7-b987-8d7b7c71f135@broadcom.com>
Date: Mon, 30 Jun 2025 12:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] PCI: iproc: Switch to
 msi_create_parent_irq_domain()
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1750858083.git.namcao@linutronix.de>
 <53946d74caf1fd134a1820eac82c3cf64d48779f.1750858083.git.namcao@linutronix.de>
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
In-Reply-To: <53946d74caf1fd134a1820eac82c3cf64d48779f.1750858083.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 07:47, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

