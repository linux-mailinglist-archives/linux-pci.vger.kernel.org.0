Return-Path: <linux-pci+bounces-28756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BEAC986F
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE07B67A9
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B396A21CC40;
	Fri, 30 May 2025 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gm/dZo+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE51AAC9
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648797; cv=none; b=UkwHEFNxmW67RykRHeXxEuXFm5MlL7j7R5pKtObim+P5GbilHik1ea4Sq2sDu3Iqh2xS6pPsnzJGic7AxPGbC8d8ayiBWhzlaXV1kxJLQiAR7rsU4rFDmcJaDkW6k1aDzIPiJKOm5AFlsyxc1dwT8w2+v1wzRpONI2P2Q7ikiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648797; c=relaxed/simple;
	bh=ZSDszH6DLZu8UGHrETxkA+vaMK7FtZI8vbb53B5onD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxK/00To4+Fd2oYVkhq3rOQ1MfTBn5NU6Mzz1oq/A4hbO/gD3iEjNvmhI45oH9izLTt1ezXzSYKGOZY5dm5sYlY+wqiugoTvG2f3CpdG5LkMlsm9xjTgjXjHsfW1GUbo1fjrZfYMveOynykDdVHtTFtX1/vDstkPGYJNirAQKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gm/dZo+m; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2349f096605so31754385ad.3
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748648795; x=1749253595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uw+SDAnpbyE75QriiKMqcjkIQkdnuBseYuvRivKp4tE=;
        b=gm/dZo+mF7EsyjCVM2ztZxfVsTT2mWkD9O7uKt4n0yvWpp8YJXI8/6KsN+R/eQKnH9
         7lxaCzxZ8O9x7RQP0idHwz0fZksjabbK8R8kD4J/bulOZRPWLi3HglaNqQ2YJuhrRQdk
         bLTRa7wi8bRIdNdJQVY+To+4D4SBYCXVYo+ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748648795; x=1749253595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw+SDAnpbyE75QriiKMqcjkIQkdnuBseYuvRivKp4tE=;
        b=hZvCm2C1VC0k+4SlhaQEEK5Ldok6quehCTlO42DqshiMJkx16u9vQ5nCpCGhn+dCIu
         Ac7gk/zLPuIIAEbwUrYSCSnhf3NrFM9E+SViRqKaQFagxn03dRfu61jikCIwR7ilq5rD
         NxYXZJbTl+ERV+MYTOErMyxQQcq9FBDicTN5VGy+CMpk2Xvt9GVavn6+htMP4s+r5S6h
         KYOU0DPna4R7dzevNPrI6tk2pTRvWKVhFTT/6vFO9uHYuH3pn4c+TgU70tkPKnr4PWd6
         IGoUrQI1tO1bZZb8iKhaBrof9EJtRfCE9yhZCSF5HlzusqHYPrreoxLco3UujjiNIRbt
         +C0A==
X-Forwarded-Encrypted: i=1; AJvYcCWtDR3k6i0MRuonzrnUH3Qzqyf4dFqd8Z133ABX9KMAT1RRy8E0kw1AA07+lZ0ODkKPLUeir8l4APM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4Zlx62R7wsSIQGpLvSxUc4GpVIwRXpUH3Teb+yJ/RBnfUB2k
	5FY2UHkXmgGvdOa9z8FnrqgOX057AUipPYbuMpjXPe/O2Zlw+HgU/sIePHhZUAVGRw==
X-Gm-Gg: ASbGncuiOImaCDk+5Gj1Dtsd6hXuPx+Tq4C6rUcjS/hQH6I/UjaGZf8qWbEEwfavWtf
	Kq2Vnmov9E0+glQxExHq2s/jvvWgV5QnwiN8JUw0IRex5qbFdlCOSlMWjUpEVTmrfQ3j5oasS+p
	UdlLxayqXB4a/gu3vVhQ5GFN2poCZX6IwUn47nXxY9Q1WiYYwgJUQTxB0GcCcbe8UyyuIbawaj/
	SfV+3z7DR81vBtEhQVCSBVvVoubQmhggSPO7XIEKOrAW81xX5vqovZXd5fp2bv0MAMv8/3jmqSD
	ZkeDFmTyXWDBWLkUnQWml+rqHREEq65pI3wxC4ZdijFmaxLeddQyP2GxEK00B3yN76kDlZAucCO
	sUjJ1yDF5kX/HTQQ=
X-Google-Smtp-Source: AGHT+IG83D6Hba6mlpJeLWEewKcWggxnySdPP7v+S+J2gMmNbRwekT+k4Hu5mnjnjd6GtQ0EvgHHiQ==
X-Received: by 2002:a17:902:f792:b0:22e:3e0e:5945 with SMTP id d9443c01a7336-2355fa0125dmr1403535ad.50.1748648795586;
        Fri, 30 May 2025 16:46:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb0a005sm1768319a12.7.2025.05.30.16.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:46:34 -0700 (PDT)
Message-ID: <0e154ae3-e0ab-4a4e-aa39-999ea1c720ed@broadcom.com>
Date: Fri, 30 May 2025 16:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/13] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Arnd Bergmann <arnd@arndb.de>, Andrea della Porta
 <andrea.porta@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com>
 <0580b026-5139-4079-b1a7-464224a7d239@kernel.org>
 <aDholLnKwql-jHm1@apocalypse>
 <7934ae2a-3fc5-4ea2-b79a-ecbe668fd032@app.fastmail.com>
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
In-Reply-To: <7934ae2a-3fc5-4ea2-b79a-ecbe668fd032@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 23:03, Arnd Bergmann wrote:
> On Thu, May 29, 2025, at 16:00, Andrea della Porta wrote:
>> Hi Krzysztof,
>>
>> On 15:50 Thu 29 May     , Krzysztof Kozlowski wrote:
>>> On 29/05/2025 15:50, Andrea della Porta wrote:
>>>> *** RESENDING PATCHSET AS V12 SINCE LAST ONE HAS CLOBBERED EMAIL Message-Id ***
>>>>
>>> Can you slow down please? It's merge window and you keep sending the
>>> same big patchset third time today.
>>
>> Sorry for that, I was sending it so Florian can pick it up for this
>> merge window, and I had some trouble with formatting. Hopefully
>> this was the last one.
> 
> That's not how the merge window works, you missed 6.16 long ago:
> 
> Florian sent his pull requests for 6.16 in early may, see
> https://lore.kernel.org/linux-arm-kernel/20250505165810.1948927-1-florian.fainelli@broadcom.com/
> 
> and he needed time to test the contents before sending them to me.
> 
> If the driver is ready to be merged now, Florian can pick it up
> after -rc1 is out, and then include it in the 6.17 pull requests
> so I can include them in the next merge window.

I have applied all of the patches in the respective branch as we had 
discussed with Andrea and also merged all of the branches into my "next" 
branch so we can give this some proper soak testing. Once 6.16-rc1 is 
available, all those branches (devicetree/next, defconfig-arm64/next, 
drivers/next, etc.) will be rebased against that tag such that the 
patches that are already included will be dropped, and only this patch 
set plus what I have accumulated will be applied on top (if that makes 
sense).

As Arnd says though, this is too late for 6.16 so this would be included 
in 6.17. Andrea, thank you very much for your persistence working on 
this patch series, and sorry that the request to merge those patches 
came in during a time where I was away. The good news is that I am not 
doing that again anytime soon.

Thank you!
-- 
Florian

