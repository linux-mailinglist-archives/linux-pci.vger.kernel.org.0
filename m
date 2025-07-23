Return-Path: <linux-pci+bounces-32853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860BBB0FCB2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 00:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B672A563348
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE703D81;
	Wed, 23 Jul 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmXvh8KQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57A2E36FB;
	Wed, 23 Jul 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309565; cv=none; b=IEcZBdwhq9JzVFIliH4peikdBIinuB7/t47pAqyS1L+MDqFlLRud3kpBtRFkIINrJKruyi93BJsgDBge3uUxsVSrd508sG/5TsoF5QqehLqFryqUrTRfwVpdqHY2q2TnxsdHHN8A2P9g1icOSfyMs6mFEsg+xD/ajYRSfubGqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309565; c=relaxed/simple;
	bh=zFXUDrDDVJTpqwYy7j7t8R89cmnJ7VHs0NYcOxCYqc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWlfyxNgdPg+feJZTTA3oMnaEyu2rGEcKLIRiGoKBxsqydwJtD6p+eDLKOBO6PZUIx1Cg5jCCJL4ddoSyrz0B+7jP0LsRM/qGPRgx0YjyUCYUaKG62SyBDttYJ5NV3wuVRKDMbEtMeH0c4pBUPhd3aYHB4xP22aedfpXpYzeaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmXvh8KQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34ab678931so372161a12.0;
        Wed, 23 Jul 2025 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753309562; x=1753914362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mslT30vdDPK6EAhRY73OwbOcxibLrWLfPtTqigtyE3E=;
        b=VmXvh8KQqzVHf0Iz9SvhnLL/K3cbwhyeB66+kAKRx4LgcKXo1zAl7kHD91svwBkrZC
         5Q9F6jBHj4aVp+zqWa7XreCM2pb2erkZNCpwv4dlaMo18bep+GB5UnbZUPA1TPuc44bc
         87hbeWoO1N/j2wgnDvocCivwoa+rmteJkkX5Xzsf+jEOU1uSV1o97bHR3pwqqr6EIZ95
         Xf/V+Ca+01mNg5Nz8xBoVe/yVxXFwV26uVzxiP2N6g0X/UxGwUTdK7LA4qHHEj/nA6/B
         MQ2iKG3oP8tLoh+cXCxgG2//vXBKNvbCDjeB36N9spDzoX6n4jEtxaIBoo56x5nYvxuc
         4saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309562; x=1753914362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mslT30vdDPK6EAhRY73OwbOcxibLrWLfPtTqigtyE3E=;
        b=PEUafwS2SZFmoHf7PqlRxIqoqe69wYB+iuPuwZMo3ZCoAkqeoSZWTGJvz7/7p2X5MF
         DPhPWW18x/uUujVBFVsVTI74JHu1punR2fXrIQ+ef3Kk/9xdNLSbNjaYc6ulnhiOb0BB
         12GjVzA5OZnrQmrcuzFY2t5MuDFDm+r1leIV3CDQ7RGnzx57YsM0D022NYS9cHLTvTz+
         FHwZ4veyJ4wIxIVSGQkodhkK6TNAIz7VUPWo8suBjzMqxYC333ggLk5ZH7pKYwCvGZIB
         IVwzPO41Rm2jUwST3lTZOv938Os7/OO4ZNU1h/VYaUEpBJIRlT09sbX12J5Ahg9zLTSF
         CJhA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ICjufYqSDP0jWaPLiDhU651cIbZy04KaLjd6MaqtiUpjUTRsoKynVl/a7ZjjLQ+145ahO/sGLmnW+28s@vger.kernel.org, AJvYcCVGai2wrYXdGOiEqVgxZo6blkzQxiod+9KwsrNt9xkO4GF1WLdcNME85vBM6xayM9rjolTwbvSQAisyuA==@vger.kernel.org, AJvYcCVW+TZrazHLLLK2kNGGMTvZFNY+TDPbqCboTeJ6sj9RbUmZuMLQBbzi0I/qDO3/LpUTVAvucg9DqEIN@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9GXzzzwdpd0n4eKLXwfaHF7sAD7xGmCDjGMdoG8emovxGxn0
	sBHCtebYK9HTwhCmxHX8iEDMZA6RYjQChU4QMLaCVSz5zfpW0721TSqdw+widA==
X-Gm-Gg: ASbGncuk+Jwyeic/A3lr0JidRf1HczzgMQRz0VzMQEnuaW1U52wui16FmIoNk1CXWWH
	0ru0KJC8V41pUDNyJHVMEboTtMSHSjgdGv+ddfEI9Ew5mRegSeXEgJDDY1J4wokpJ6vgW3baME8
	eKQqECq2VI3oa3EpMweFoPxBhZuhhWzo0k2/zsTGgDf9LijkVD7CGhOD10StieD4lRlCxSZTA18
	mZNllI+nwCX8ItgnDC+FGvqQANKJTyYeJxlgWy1BL+O4zOC/YneyiiS+7BfEGMk3IcWIYQDd0TP
	LtDe7SJ8ANQXihBjEacEpwfdvWflYGjQtuQfrWb4/WX8oMOIogtT9u1D09WXWrBIgIBkixLoWEe
	MyqU3jhBKmJf7P7+IK6TxnUYeRPfFfVrbWpFUF0+CDacUO3K8PBKvtNGxg7IV7Enw0A1fTI4=
X-Google-Smtp-Source: AGHT+IFtRAyK/TnfAptO63yZM0Z2i0WAs3E9tKQ+I9mzkbGG4cLCbqkFm1/W1zyVQwaZrWkkLn9/bg==
X-Received: by 2002:a05:6a20:3ca3:b0:232:93c2:885f with SMTP id adf61e73a8af0-23d4912e24amr6778909637.32.1753309562229;
        Wed, 23 Jul 2025 15:26:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b05b9effsm155465b3a.86.2025.07.23.15.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 15:26:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e56fbda-9174-45d8-8093-b03701c6014e@roeck-us.net>
Date: Wed, 23 Jul 2025 15:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp) Add thermal support for AMD Family
 1Ah-based models
To: Avadhut Naik <avadhut.naik@amd.com>, linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com, yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20250723202735.76440-1-avadhut.naik@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250723202735.76440-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 13:23, Avadhut Naik wrote:
> Add thermal info support for newer AMD Family 1Ah-based models.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>   drivers/hwmon/k10temp.c | 2 ++
>   include/linux/pci_ids.h | 2 ++

I can't touch that file without approval from pci maintainers (copied).

Guenter

>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index babf2413d666..7765cd57d746 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -556,7 +556,9 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e2d71b6fdd84..ae87b6c72981 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -583,8 +583,10 @@
>   #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>   #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
> +#define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3 0x12cb
>   #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>   #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3 0x127b
>   #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>   #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>   #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
> 
> base-commit: a2609b707b58561b9e52f92f3f571d0510201f2f


