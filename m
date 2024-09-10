Return-Path: <linux-pci+bounces-13002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43941973DE6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683E61C2148D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3901A2570;
	Tue, 10 Sep 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JHEB+Ngm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F251A0B16
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987570; cv=none; b=A/tJWx9qxmCm+cmhNpJR4jFVlsMk/b1vQmztmAQr9XrAlxNB4mqCNBZxBQAW+4kOOVd4f9qOJfeW8lggyDpoezhE/JtWZ3YUByTF6utudxrvT49uXaQ927hhXqZyaOm6TWvMrjtmCrtOyej+Njup7pp5DUO8Dg6PqRKZ0P9lMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987570; c=relaxed/simple;
	bh=CV/+Xsvud6NgAwF9/16qZCiWRnmYLavG4/G69hQhyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7Zp3JfDgEFtaaGxXxyrJe3udSu58wLHsFcS2JNEAkVj+i/BcjEpslW7yuTVPq1vr6if3BIwmj0BFsfpAkqmeueBFJBYlF6m8HFku9ZmlkRIkCgOAnPytPpYLWwBVzv3r1rTCBqkznYusS4STbPRR5dzxlv+Yo9LlJR2JQvxKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JHEB+Ngm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6db9e47ee79so6400057b3.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725987568; x=1726592368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/6PuAoHVqwJAn9H3E/ApoOgwWszRBjm1/LVCy6+Tvk=;
        b=JHEB+Ngm8k0inM/GRD81oVFuzlyPPlH6DdefJYEDSKJcsEFxMJPFW5a95cXg7FGNA8
         1siubzLEqiz+PhCzCncWpR3Ofx07hdXqSI3yrvHC9X/NHR+JA/dgvuMluoZK6LapCq37
         nfA3gr3QZ9bJVTGiaXJSw3K2uQ0Ziu6ooFWqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987568; x=1726592368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/6PuAoHVqwJAn9H3E/ApoOgwWszRBjm1/LVCy6+Tvk=;
        b=AZABKrucg2RISC1H6+rgcf1xAnkz3VeicFkl9CtqW1he6G7e7ZLIZUUeyl+WcYc3Oi
         zZ3u4jrXnCvUMJp4Vq1j4jIuHXNpGSSRm2zyMjklEcydESIlhrsuhes1PQ7nRrwYeyNz
         4fWM8JF3X+Nzdu22emwZmUerTyeJd8K/YoWByLFplYep5J6G9MTEt0dLmtuCCHQfZtqX
         7Htt99QuhYZ1yY/775BhyzIuCNpRd6DVnAcMm/f79NF+8Rp+RG6bbQdKQbQQ+jHWu5CI
         9Qtf8f5ARq3TzPjVTY2JkXC7W1xIxM9vFROAxEiv+WcYwQEjebDiPwLwPbwb8uVp2Msq
         eE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnIxJuGUrewvqAw+SlDXbfrjz+X1JWJDhDxeJZWxaNEGE4B8oW98zB1hscw0UxoBVw7VpqWj+u/6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZUYMmHGbGpNP/uCWQxh6HopAfGNfssSoEZr4PvehyDBz9vDL
	R6aSKNd+tDUtj9t9hX2jf5ZG6J824nLl7AgP4cQr2mK+MkCQFZYRdyc+fZyiag==
X-Google-Smtp-Source: AGHT+IFvOdcW30wX0d70oj+1ll0GHS5mjd10vuBsPBd87hScoQyIYWMaCVt44EOZ8QoHtMQsNNIIPQ==
X-Received: by 2002:a05:690c:4982:b0:6db:2d71:916 with SMTP id 00721157ae682-6db44df3824mr193377797b3.14.1725987568340;
        Tue, 10 Sep 2024 09:59:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d6a2sm31678716d6.90.2024.09.10.09.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:59:27 -0700 (PDT)
Message-ID: <9de505c5-d9a2-44b7-8db1-0686c61a0fb4@broadcom.com>
Date: Tue, 10 Sep 2024 09:59:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 05/11] PCI: brcmstb: Restore CRS in RootCtl after
 prstn_n
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
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-6-svarbanov@suse.de>
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
In-Reply-To: <20240910151845.17308-6-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 08:18, Stanimir Varbanov wrote:
> RootCtl bits might reset by perst_n during probe, re-enable
> CRS SVE here in pcie_start_link.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

This looks like a bug fix, and we should explain what is the user 
visible effect of that, if any.
-- 
Florian

