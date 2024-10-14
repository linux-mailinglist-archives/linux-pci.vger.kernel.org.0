Return-Path: <linux-pci+bounces-14492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A599D551
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DF71F24F30
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D01C304B;
	Mon, 14 Oct 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LT7MheF6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18291C2439
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925816; cv=none; b=qd356Sht+qUA92hKPpS4PnpYRIPn2tX3coBJfBTArqL4pBYkB/lcb5Id2I5qVjG1gYL1myXyut4ycpedigAbMMt6aGvc6XxtSkMsEGHxzLUW0DxKs1a2B/gxrYV2lDCqxMmY/L2R4D+IrXXwLQ36DjESt8OTR6ATKiAogzccbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925816; c=relaxed/simple;
	bh=oHc52P7m8VFk4NjNVYsFi65iNDfIXx3sGpxt1JVnbFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYFekVtLc3m30ffrCTGIbP/xcm321qViCmu9xf9u5pwngEb09sZevl1BRzcKbwKbZ6aA+uq9LJj8qYcKbpGk6olL9dMmnx7PlhtB7SfKp0iq3MAgha5Pzan4kb7LO9KdWpAWDZItwyNm8s8qLAdz5HpfM5KL8iH3NVxdFii3RZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LT7MheF6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c805a0753so36554095ad.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728925814; x=1729530614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UsgEoRnWXXUKflQR0xKvChheqGwtV13X+dTdfU/fSLs=;
        b=LT7MheF6mMN0kATHGsOZYanWq+A7FbLyAxeu2nP+YPJEgmdA8GpAtBjuSevzBFpQS4
         bCwmoHC9SQLHONVfTaTrydYsLVtrPj/u1xHBWjIPSz0NMSJ9oknrYzrKT8N/kXob9TvU
         dpp1yLpkTqB7pheq3N+oQEjhVe7BiBapCnep8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925814; x=1729530614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsgEoRnWXXUKflQR0xKvChheqGwtV13X+dTdfU/fSLs=;
        b=TMBMZFByLWfuMCgKu5M/ziGW9fAVYAtSA73T8UBjkRwygjWIXKbcmVFKLW3ilWl1jd
         uCcn8eqxk29Z5Ko0UOfAFmL3AwhodPWmRoUYrsDBlHw2ZUUgbmruqlrQs7khI+P1kwko
         faeqXX5CbUGzd+Py7HbDP5+3+Ssxchol5ECJ6qVvv5Fgpeo3vngbmAlHdla0DlGeYeh+
         e225kjp3tPAoHPg3VtQzuiOAxeAJ3tgbGh1oVgbSbcN5uRyAhfdE8a+0RA+UcHt2gtRo
         eCuXb8DgQSXdqWIQs22iiAgSb69XYOM5NsP5k9KraMidRiUeSVfhe8ibW+zpx/6le8uP
         qFMw==
X-Forwarded-Encrypted: i=1; AJvYcCV9WTyf04PSrbyZV/9JRO0YynYyiUAyQPjNzcUPx1xU/VMjVKf4+ZC4AWYJnlDRbPadFLMvBRgDoo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQgwYPN9Ziz1W6riiMPTZh7VHO0uHj2VSwq91LU4iKjldRoAN
	dWxEYEGtWLTxr/Plcl4IpEujb5cEJ1JqcekjHy7iMn+3z8Uvut+NkGrDSaWIjA==
X-Google-Smtp-Source: AGHT+IF+5JEwuyPgsv7TgW+LcqbythE1/vib73JnkbvQ1dRjDisewu+jbiIm8CS9UhoWB78JEn5J/g==
X-Received: by 2002:a17:903:228d:b0:20c:a04f:927d with SMTP id d9443c01a7336-20ca167865cmr164941135ad.33.1728925814176;
        Mon, 14 Oct 2024 10:10:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8badc3c8sm68169995ad.21.2024.10.14.10.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:10:13 -0700 (PDT)
Message-ID: <69c2f4ac-896d-4cfc-8068-45bd58aef6dd@broadcom.com>
Date: Mon, 14 Oct 2024 10:10:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
To: Bjorn Helgaas <helgaas@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241014165752.GA611670@bhelgaas>
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
In-Reply-To: <20241014165752.GA611670@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 09:57, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
>> BCM2712 memory map can supports up to 64GB of system
>> memory, thus expand the inbound size calculation in
>> helper function up to 64GB.
> 
> The fact that the calculation is done in a helper isn't important
> here.  Can you make the subject line say something about supporting
> DMA for up to 64GB of system memory?
> 
> This is being done specifically for BCM2712, but I assume it's safe
> for *all* brcmstb devices, right?

It is safe in the sense that all brcmstb devices with this PCIe 
controller will adopt the same encoding of the size, all of the 
currently supported brcmstb devices have a variety of limitations when 
it comes to the amount of addressable DRAM however. Typically we have a 
hard limit at 4GB of DRAM per memory controller, some devices can do 2GB 
x3, 4GB x2, or 4GB x1.

Does that answer your question?
-- 
Florian

