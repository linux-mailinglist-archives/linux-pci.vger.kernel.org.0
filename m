Return-Path: <linux-pci+bounces-13006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B7973E06
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0898E1C2420B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BA19ABC6;
	Tue, 10 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ULxOLIAd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BE1922E3
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987895; cv=none; b=c2WZZgWBT22G24ZhCh7EN44tTfMOZttALjFA4LzqAblQnfTjblQe2FfPvtJOohEWzmHfOul8z/F0/J/5arVQaR3bznzbZgub8/VlxKFDYGJiVaVBuNTMzkU3CNn9DzkWnYmdLwWcXueQzPK+dQx8TxSkPytga+w8mSpjYheWLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987895; c=relaxed/simple;
	bh=LW8FEX9mkCpB1RVUvuseZXdPeOEksUAqYyTZgqApHnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNWhlYkSlMTIpz0r2hjbmq3nZmDOLysCrRPVXrk4O9CPF4yXawTq5EhMEUY5YcDAVql+ujnKls96LFicgdKdojLOL5+K699Wudn1nKMfy4YJlYFzaEA+5Lnyet5384cP3ZwxvL0Ar67fAteQhaIx+klnn80EotUD5Mdsc8GmgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ULxOLIAd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a23fc16fso100109185a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725987892; x=1726592692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+VV4INpQE5dil1UicDv8WEVlgmBThvwhZa9jQ/i9V3A=;
        b=ULxOLIAd0WTp6qE6tUXl6bA4oBQlXSk4RiUuDlTWhFFT0sr/+iOjigOow+BVZaENTh
         lucjeDeexI2Tfs+MJVHxgfI8HjTAHompUMdNErbMCmjHyBbqXWw9bpfrdKAmaZk6iHKH
         JPqje7PIpbwaY0MyRWadDrJItkXB8FtIVJSRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987892; x=1726592692;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VV4INpQE5dil1UicDv8WEVlgmBThvwhZa9jQ/i9V3A=;
        b=begX+zPbsaedhAzqCzSGk3q2x1fxsJOs3y/5LK9/twIopN406piDCzXXdOMHh1P0is
         oOG0N7uxchILDoO4cBwlQBF6dquk1iHyKoR5Vk3llF8DOcSnRNfHwAL8okVmGH7aQpkh
         0D/HjNafiTc+WMISyCCWZGfqS+H88YJwJ0qjuIUicZBOQYMWOD9DF4l+JHV0ga8c/qMB
         iOpcqQ9pv+ivnh/Bm9i2BVmAZqILY/akeqp+LE47+LoZXfA23JqoVCGxt1Rg1ddDmGB7
         ddEhmMcAT/t1c9BByanGS5PcJk6o/AxndZ0Pig4T7d5bLV8Iyij/+oR1FUvfuTUUd+Q0
         G5ag==
X-Forwarded-Encrypted: i=1; AJvYcCXIosnHab7de4GJ3K2f+aMUwVJ80RMTl5h5KK+X4iZPLSlAVv7cyQoD2KvOFadBLoUHtosCBJLLSMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWqZB87bmNIHFuxDMcGL+mh+t1XIMQ3sh9so+ZjsMAcepqyux
	7k7YdDv7Pv+66hAcUc7Fs90T/SNIs/GcAPoEbNNyh30vdNGIftCZpNm31rJhGA==
X-Google-Smtp-Source: AGHT+IEGESbHlEgOq14msNVhQByCIEg2VpukIkmwt0wZ4JkLOSYM2I4SAcQcWdRV2CPiiiYw+cergg==
X-Received: by 2002:a05:620a:2a02:b0:7a9:aca7:e270 with SMTP id af79cd13be357-7a9d3a433c4mr34612985a.22.1725987892372;
        Tue, 10 Sep 2024 10:04:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796d1d7sm321527585a.52.2024.09.10.10.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:04:51 -0700 (PDT)
Message-ID: <89ff93ce-edb5-48f0-9f56-4e033990966e@broadcom.com>
Date: Tue, 10 Sep 2024 10:04:48 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 09/11] PCI: brcmstb: Reuse config structure
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
 <20240910151845.17308-10-svarbanov@suse.de>
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
In-Reply-To: <20240910151845.17308-10-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 08:18, Stanimir Varbanov wrote:
> Instead of copying fields from pcie_cfg_data structure to
> brcm_pcie reference it directly.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelil <florian.fainelli@broadcom.com>
-- 
Florian

