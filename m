Return-Path: <linux-pci+bounces-20209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F35A1853E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 19:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476083A10C1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052C1F473E;
	Tue, 21 Jan 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YfhaSojQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0831537D4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484345; cv=none; b=tA1GZFtNl/GlG+T/kQ1mkFgR6fRu51bq7b9sKdg991U8Ha5xl8G4niEJiULnYbacrhBCvqXqGhZ9AOj+1tAHjInNvEeUVkiSPVBUp+mu3fTm4NpidJDeNL86o8T51p8YjhZnp1V6gOK0fPIqd3IPfhFN6acUzmtFfCeObA+J1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484345; c=relaxed/simple;
	bh=Zicm6hmx+Ya5yupv+MwT6SD1/ZogZGxbyz7z3euwhls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCvE4fGTtP72kOCfmcOQ8zus3Q/dnqlj3KLzDgmrkwy5ytv/1FiefDluAo5wSXidEUbz4J7cNJybvBNtrUU9PgtTdH4NQsumK7Mk2O826kFcnLRNK3xMmV9L22jiPAmnG+Y9ljLHe87izRBWVzv42I72N3HWfFUBw0dkCwnBgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YfhaSojQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f32fab5de9so1350340eaf.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737484342; x=1738089142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I6g/CX+/dSwtyMMTLVD/KiU50D2jdXyznwECf80QCyY=;
        b=YfhaSojQz3ZC1U7/d1TlBrV+83po+BkDcy6D0YmTuGOZV85lRIIiA6+6H/Sg5yrRYo
         SSUBnoy8Y3JlCKEhWiWftCwcQWTfjBAB/Gp7R3bXdQ2BXt7xiEeeQIBSDwaj1agNtCBs
         AbBWHWqlFrsP9EmLJ9KPFxkIEsNOj2oGFxpkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484342; x=1738089142;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6g/CX+/dSwtyMMTLVD/KiU50D2jdXyznwECf80QCyY=;
        b=Lqq90Fr/TnQxyh44XH+X9Q6G//v6n4pSwBBYW+6nimflVK6q8uYZk9mrBjHLqjGGxR
         nYv99pvPu/gfHBxD8n+5iEWOAn+8Fcf8dNu1UqVaKELTZfqkqryGGyDdjTX7w2+x2DAF
         PyIhq71QpnfhuH8ul/YsUlyEk4i7Itp2uCMubJI3JIr/sQmEhgqWkf1Q3AL3CfuMjoHq
         LxwAT6YD1dUGOY8SMsJY+TqGNOoB7/XJApgoOPBvQKeKW6mayrT8Gbj/oKaTqDrdjOwl
         IfC+LsQvGlxjpBJE5DG7hqyN1Yjf4d1zyIS28TeQhcmF/rabWFwaUrmZIEw47w6768Sy
         nQDw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBiULR5LN9yMZbha6kiSc9fgySmSnpRuJpCH8XipIa31A47yDu/PTmUsXSQxz5dviEsIrvWOg9Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSOLt67QhR9UcHVweKOweQfq+3Upl3+4E5Fzlo+OxLcvCNVao
	7O/Z7E65+lnuwiFjttoOUJpMCfWQAO6yR9iUgJCo06VBWcFoiMF9zqckj6kHPg==
X-Gm-Gg: ASbGnctBTxB319HhVUaOqdQmYuVY95qCKcc3R3Nvg7IbAc57TBrt25U3EFuuDMY3cya
	ZypCrPKVI9MQ1FY09GoFj7i2o2bXDRGqkQTaHnHVXwfzmj0w7D08uuS5JM5FBk1vAWoia/B0Ygc
	2rQuUDkoVYwkEuI/gWj2czKc0xKllBDVym8sI7xrGaFPYVheETlS/9SBUl8dKoT4ep+HCAtPeOK
	RSvHZDvVWi8wO3RIKO5JWSxPac0wi8SubITUJ6UDV8+5xEzlElMG8EiimIJ2B5UpYA3Smmn2RBv
	2wQE5M4D8eXPDsXSoox0r3mmJr/IxK1kkg==
X-Google-Smtp-Source: AGHT+IEdmBRPRkWmokta3IssK592zHSuLuOAdbq0f0sxdCFGkG6xlMjxeEXZTzeb5T9HD5OCPu6HQw==
X-Received: by 2002:a05:6870:4f17:b0:29e:5df2:3e50 with SMTP id 586e51a60fabf-2b1c09c5d8fmr10307404fac.15.1737484342205;
        Tue, 21 Jan 2025 10:32:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8cef45bsm3757647fac.20.2025.01.21.10.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:32:19 -0800 (PST)
Message-ID: <1abdd175-280a-442a-a27a-9bc01c0a04c0@broadcom.com>
Date: Tue, 21 Jan 2025 10:32:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 09/11] PCI: brcmstb: Fix for missing of_node_put
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
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 stable@vger.kernel.org
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-10-svarbanov@suse.de>
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
In-Reply-To: <20250120130119.671119-10-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/25 05:01, Stanimir Varbanov wrote:
> A call to of_parse_phandle() increments refcount, of_node_put must be
> called when done the work on it. Fix missing of_node_put() on the
> msi_np device node by using scope based of_node_put() cleanups.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v4 -> v5:
>   - New patch in the series.
> 
>   drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 744fe1a4cf9c..546056f7f0d3 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1844,7 +1844,8 @@ static struct pci_ops brcm7425_pcie_ops = {
>   
>   static int brcm_pcie_probe(struct platform_device *pdev)
>   {
> -	struct device_node *np = pdev->dev.of_node, *msi_np;
> +	struct device_node *msi_np __free(device_node) = NULL;

In the interest of making this a straight back port to 5.10 that does 
not have all of the __free() goodies, I would just add the missing 
of_node_put() where necessary.

Also, since this is a bug fix, you should probably make it appear 
earlier in the patch series, or even sent it as a separate fix entirely.
-- 
Florian

