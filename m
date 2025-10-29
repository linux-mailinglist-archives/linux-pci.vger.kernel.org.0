Return-Path: <linux-pci+bounces-39727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C2C1D2BE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 21:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45C31887199
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4837A3C6;
	Wed, 29 Oct 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gxy4Iskh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7235A93E
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768752; cv=none; b=Jz5Z7htesM3SwHK365K5DiZdLFMW3ucssSxt6iT3aUMmN0YVvMCXBRHR5iEhjd2nWsiLXU7K113uHRszLEx2Zn1mtY1pmdXgM+6UXjosf+woBQd8kOlTOjQEsTiVtI9V/WUgEuCHpDvXwrlZOiaYOv5VA68nl6A/QU0MqwYcSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768752; c=relaxed/simple;
	bh=iR5HlGQtmcmSHHCwOzTzIF4RYlsm+yyeAoY4efZXbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ7EuwYZU5or6Bmui2ggBNcVbKTorBPVD2xm404PlElnMRRg00RzES6mYsQjji6GLWUnuHdCNWwGLVMnBGaBnrpI9JukF2odkuBq4oaPmaB+IJ6MO8aSKkjeOZVmvAbCDafV/v7gL4aFOg+HnN+UsF1KtABlAsDxWmFHnnktG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gxy4Iskh; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso328751b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768750; x=1762373550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1OxuFPXRzNkf/jjOfMwnR5HsdSbozk+lpDYi7pEr48=;
        b=EdFqvWuO1gsXf01QIhC3ydYSopmPOvDokFMka5Dyn2zVXz4u2wj7gNUryUCD6SH4Ob
         dfkwg1UJZmjr2ZOMDbqMkL4kwiFGLcuBnypjguv6ciiL9pKMo5APbo7YkusikIHenNbB
         4WgNyQdBXRwkIuJL0CfVntD4dE6kWQRbo8/Su8Gi5ao+SalLYNkL2rpvQz0oApSA8+/8
         UgEuxloH/Yqp3AqBofeugFoCjFz2VerASKXkbg9frgUIr2uQKKuCABAe8Kn+ZiUJzlqZ
         NaNyBlZ9Y+1rMlcHkeB21UEGB6wsEgbAI+B5puPswVVxC7EhzyfZglqHdcjz4qfsFjTq
         fAhA==
X-Forwarded-Encrypted: i=1; AJvYcCVFv891zbTrvauQReOSwIbgbDSLv/PU92eC72Rl0DE3v4Vy1JlangYTjsbGpkJGEyfcMqUaQhv6eAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+DuC3PwFGMXTHsbA8oweojwLY/BThXVUhaoNcennM7Gjp2YA
	k6Dlbal2Z/GCvIqPtA5Qa0jYmkfykpLvf4uioOXvj6CqidGo1vltNnrOSeeZNw6bK/l80KpdY3H
	ePPmIZ6A9QDk/2SiJRsJRjbZ9XgNG8klo32RNYUvLraL22eiNg29/2ge798sQa2cwicXHwwtrci
	OWt+mNOwfkfizMrppfv5zx2wYKO/i9VSChGT5zzXx44iEcfAYtLeVBVnV6RVc/sMp/aEwvi482C
	yPNvge6F/cjIPMkqzZx
X-Gm-Gg: ASbGncunFDhecpp9tAWqrZ+tKoiev06A9WvRGWOtqJ4mEH5YZH7u2MyF0jb2NMvA86A
	3C4d1kVqt4IvYrJ7gA5DhHFeHWvqLscnR+leA4y1u6H6Pdb+Cb1AclMcqiMCGijaaLy5QSpOlfw
	5vYE5Q9tEMTqNq+XuhpiQTt+sKW91L8hmXOhyxC8Xv1duR4P2LCutbg5cCrkrIy/5yI8gOsg4vd
	6YO7uWMn5qR2o6wQDvoUaCwmo9afuCnmoW3XAUP3S/WYaFeWpwzZp9vemgBSxnT7MdGA7EAgM1i
	HVRfbk0zZylmUrQ6DgC7YcnyPpa+U50NJE6mdJepI3Hd81UgSNjjdRSotv2WPWEbFoGbroWmCew
	ugAyu37LrEcJ+IkgxktcjIyVHFB6UWye6iClxCDjI8Tv++8SccHV4q6pOGyRl0hrsFTiyCroYHh
	b5BDBaMbweWjgEmHN2e7Cp1+aK/NGffwLyQlOvdcSPUA==
X-Google-Smtp-Source: AGHT+IHbiDNq8Zs2n0vae9g4QOncAKKxUjCLTx7guxjdj/zWaHkqCHwDFQ0C9i7qFHJaW2+fa3alutCOYOxa
X-Received: by 2002:a17:90b:3a81:b0:33d:ad49:16da with SMTP id 98e67ed59e1d1-3403a2f2005mr4052838a91.31.1761768750246;
        Wed, 29 Oct 2025 13:12:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3405090ce76sm1938a91.4.2025.10.29.13.12.29
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:12:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f81cf8244so120629785a.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761768749; x=1762373549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v1OxuFPXRzNkf/jjOfMwnR5HsdSbozk+lpDYi7pEr48=;
        b=Gxy4IskhNmDgIj0uYMc6sGDQSkagyCqwrQP/MGgn9GeLnTCjSuNqQlC4SOZ5RmEMRA
         6Pc6Sjbn7vPu8APNKj6YFxn8qpa9uH7VvNwftUCjM+qarpK45Id6HA9afaA/RYsLwpPy
         OPM+bJ9R2yg4zncxLgb2+qexnND2bMZfqfyWQ=
X-Forwarded-Encrypted: i=1; AJvYcCXJKCsUa+9MkazJXOHwtFJL92871nXGNID9Cq0SM3dbd3F1OdqPk0Q9jGbipfyhiOiESvjWPJqaFFA=@vger.kernel.org
X-Received: by 2002:a05:620a:44c5:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a8e30e42afmr645985085a.16.1761768749047;
        Wed, 29 Oct 2025 13:12:29 -0700 (PDT)
X-Received: by 2002:a05:620a:44c5:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a8e30e42afmr645981185a.16.1761768748624;
        Wed, 29 Oct 2025 13:12:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f261747efsm1093976585a.55.2025.10.29.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 13:12:27 -0700 (PDT)
Message-ID: <a2ff8f41-816e-4f87-867e-cbb39e513473@broadcom.com>
Date: Wed, 29 Oct 2025 13:12:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
 <20251029193616.3670003-3-james.quinlan@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20251029193616.3670003-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/25 12:36, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> 7216 and its descendants -- have new HW that identifies error details.
> 
> This simple handler determines if the PCIe controller was the cause of the
> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
> occurs.
> 
> Care is taken to read the error registers only when the PCIe bridge is
> active and the PCIe registers are acceptable.  Otherwise, a "die" event
> caused by something other than the PCIe could cause an abort if the PCIe
> "die" handler tried to access registers when the bridge is off.
> 
> Example error output:
>    brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, read, @0x38000000
>    brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

