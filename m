Return-Path: <linux-pci+bounces-21916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E494A3E273
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A03E1889CC7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011A20485B;
	Thu, 20 Feb 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a3PnPuqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098C20CCE6
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072471; cv=none; b=qMzj6z62YyFAGXO7TTMd4jMZavnOZsvKpAjA6TNXF0lGCJZzuycs4/aQG7QARFzlVXI/iMkv+1sZRSV4BKf61y29if7Lj/sCDorYT6jClRDB/hVDT1Q/nxlnSZf92PSh2FFuQctjXUgbW3QyGebf/o4/IQQ7bZmKZTBow4NYKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072471; c=relaxed/simple;
	bh=kzUcMPp4dBCS1FLhx6ZGyYMvLWLu3JJebAI2k+Ouqug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeOEbNPle6RbOV3aWBA4fELBmcPft5wUJa5zVycNrza9+Ja+KmvZrTYoZ03zhrckZpwt++TIPfhAGZU8l/uXhUOKQfmSEPuCevQB/3mOERmpSAktY+P4TKTu3AhW0tOs7ebwHzaJpqkhx1LeRRarw3dnejSyYDuuBCeTDbtLTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a3PnPuqK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fd0adce179so529601eaf.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072469; x=1740677269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/u13R5KOWq3pv04QD3KJlgVCEhSKv3/X70G4FsiRMMU=;
        b=a3PnPuqKouoepVKUsTNvt7IiOmNyRjTnS3vGcaizYIXVCvRj7l/Ait2ALFf56iMhWv
         kHG+haDrNs+yqIBi5CgJrbafTHHabU8UOk8tWCt3qynID2XvzZ8TJO1Gdob7+l+/F4lW
         z2ovXPH5P+ojAgQ+qVrMY2Pj6L2YBJ8AY6k9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072469; x=1740677269;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u13R5KOWq3pv04QD3KJlgVCEhSKv3/X70G4FsiRMMU=;
        b=BPy9pg0C8ls3KMzpXWOrB2fF1Z5VwttlPZAJvVy4pVA9mFQ94VPxbgm9ENo8ox0gMY
         3P1l9JQL/0444AUCQyk6A27mPyqhGZy/iInT/C/vgKYbiVkBjSP5p0Y2T5gcTLw3owPb
         MjjIF29xmEID4XwBXNMN0r3z2no1Su88sl2D9ZqDWTbMtaV7DxKJRCxjYNO/WMljJeee
         p/WUZj7Dqyr4Nfeop9l3WiIczdThve6EwExCLA/drPeslI/ruN9xDQoWzOwB7uDX7EW8
         lo8/HbDz+XE3SbaVHNP5NsidcN+wNFV46zTklEebmwDF/d3pQqzg5y2sMp2cbcdSzQHu
         0f6g==
X-Forwarded-Encrypted: i=1; AJvYcCXzVxxOoWt2auHtchgAOPt+0KzEFlOMoRgIZSjA/h9TNvyI3xKlfozfVoT2GJP3xM/zPaKbLPHg3Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3V1njuLQKrDaSvbOLTWVawVM7XK09mc+pMYO69xmjTslIZLvL
	Z+diJukg8r+9ioIaAqWyeJK/RDQrK+U6ZGLojBjP5DqC0oG0CdzZ6f85H38oRg==
X-Gm-Gg: ASbGncstHHrsHkinOAqwH3PYVFDOStD4TRLhaBpsvu6+IeeKqunns0t87CzoCTJ7Xfk
	6kcC1oYZM30KVMSEX5MkpRv6hD06v4G8Us36ds6jkzEGhHqmm+RPXQQbVI/SWdsl+5u6OjFxKch
	9UMzbxPQCyXniPNQzoIYRD1Tw3JaPTXQeWAkKxpVqnVE7MBWh2aQpzdSYSU6i3msRM8tYs+cN8y
	miAOMueAbinFFb4dLX2Io5ZjbmZoqCsX4Q1R79QXygEwPMsQrvvIXb6zY0HcmkWJv7gBlNnM4Sa
	IBTH3SVpt+5x4t8Gzu6FvQvheeO32tU1sqyvQVxb4ko6tf6cuguJIpK4DrrSaBfKEHU/5ueiNJd
	0QSBn
X-Google-Smtp-Source: AGHT+IFpe+7WNEMHf/e1K6RN6XXnxM2f+u9ir5hEJr+L2Qg9sOoP7MoRY9KKhkttJDVKbKrszFf5hA==
X-Received: by 2002:a05:6870:6129:b0:296:9c08:51a3 with SMTP id 586e51a60fabf-2bd1052586fmr6219961fac.39.1740072469073;
        Thu, 20 Feb 2025 09:27:49 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548b8b8asm6393725fac.21.2025.02.20.09.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:27:48 -0800 (PST)
Message-ID: <3e2eef77-2aaa-4140-9e91-59173445c929@broadcom.com>
Date: Thu, 20 Feb 2025 09:27:43 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] PCI: brcmstb: Set gen limitation before link, not
 after
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-2-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> When the user elects to limit the PCIe generation via the appropriate DT
> property, apply the settings before the PCIe link-up, not after.
> 
> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Looks like this commit ID should be shortened to 12 digits. Other than that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


