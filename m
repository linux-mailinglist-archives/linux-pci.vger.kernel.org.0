Return-Path: <linux-pci+bounces-17167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEAD9D4F58
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E62824E4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797421DB375;
	Thu, 21 Nov 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9pceDpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2A1DC734;
	Thu, 21 Nov 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201280; cv=none; b=sVnM3lFIe4GwUqiyoErVFzNm7IGSw+uD3mjh6DGGShuBrakThhjhitJaUwblUqFXZJJ850TyiW4J52/L37uIDGZuR0VPlY05hRIPQI+FSzHNBjVZvN5uFYggtSn9I/FVAfG7Z2L5a8iwNgZ3rgz26kxPz0/gNmjYt62edXTa9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201280; c=relaxed/simple;
	bh=wnKSBMQnO3k1ZzTA3dFZ0+sw/GgW6TAXFzfTmEyB+H0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CwAxjXfyInbk1nP/OmU2zEttS0kQf0dmSZpmAo9ZedQATavuaUej/OSJYnONzFUNgtlnJwolpKiAQqoFCFJibROPRlRmoAKAKYZcaTQ5X371JspS38ZQGPycZQHu7RFK1MNlsCfuhgHGjuOkC7IpcScKeY9O3Rs+jb2DE4bHOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9pceDpo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea4c418488so118823a91.3;
        Thu, 21 Nov 2024 07:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732201278; x=1732806078; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIMnEIrQlc2mtRqL6KiBSU+z+KNnl2MpH+4S/poJBaU=;
        b=e9pceDpowA38DZQhOHcCMPoUmGhTsTN/lw5+ZZg5aC4aKvdfjeFy5kbkMp5SEJX0B3
         Cjgc1Ho4kkaMZ8pY++b1GVI4nJGnJQM7raT2TOBhJwyg0aKNY6p+hVDp/GHlmiSFy2B4
         lZjZK7ZQ4XBy0f2vHYjG5qPunki/QauTvAcoPXCazl8j39tBuY6iaV2yuaUysvDJh0j2
         /4lv3tyjUPJpFv60XWZgl9VkNrmSvRnumO3HPStEx40ShQQ8y98C88ZD13hgPh0NMhlB
         pLf6auRX6ghX+sxev+aoYsfsnXR1H+UKYKTltQLrmZsf0oXDZlC7ZdhbqumFngHlyVSJ
         pNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201278; x=1732806078;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIMnEIrQlc2mtRqL6KiBSU+z+KNnl2MpH+4S/poJBaU=;
        b=JXfCl6UdhEF1Z5h10lVDF9Yy4897ZLPfS6fSP8mpyKfXs4z/ztViwZoAAEtZ23QV86
         7phSROsokr0apPBoTEFsdOXIWytpCY2Ob2sTffslctDE4pbkf5PrXj3vXwL7taIwmQMP
         YzvRKUOEW8BxamjyV7HSKp4o1xTipFXvUwsVXXgg9fDoh1FOtIPQnABtvq7ALVGyO16C
         dTryc3stwA0VMhDM43pPU9vAtzUDj7h1+H7jlAF4VuEOvcC0JLb63jq4D3R5ZwkRNYcu
         pRoezyLlNrybtcBbCMHNsSJj+Kf7hKs4AT04hA+YvOMlbtbZZs32bdB3otHuB2ek8zF0
         iRwA==
X-Forwarded-Encrypted: i=1; AJvYcCXkXzZRg9yPXK+Jktuy0svXKzApQYSqkji91sjA5w2Q/WDm7W+QpYgLmFuErhV0HyxSBrXihNnrL5sA@vger.kernel.org
X-Gm-Message-State: AOJu0YyGd8c7r9iecIfHQtwhrhyRgFWN3O4TWaLHatZkf+aQvwdqME7I
	JOeYFvEGTIfZrDEybpwYUVLptX2uf+qW8FGZupDyelchUsGZys9eLJhDtQ==
X-Gm-Gg: ASbGncuoMmVVg6qJr1gOnywNfrfzg6UhBbnWhROKmHBDkD/hKIXilA8T6a2K+LmQdeu
	KtBqrxKHN63bmY7DLd9bIe+w38W35vmFuE/fq51Zw6g1OIQoRqctB2nKpVCdcxVvvr+zTy2uNAE
	kHLg+5VYBGnmiFSlOvBsChNoXJXoqUOtJs7vPE7zHmsDhxqhTvYpySTdjE0XyHx7SxwX8a5xByK
	x2CyK8W1G0QtcO7f+vFyuD7MNqC2shcnsApuVjz89iTHV/P6P0iw0WsdOIvoDv0iIIT881I9A==
X-Google-Smtp-Source: AGHT+IE+i5LWdNUe6PR8k75SmTTcvVV9Y6nATtBS/1glIlY6gLIXD/0ksh+iikUhtwWzBtlzU+fF4A==
X-Received: by 2002:a17:90b:3144:b0:2ea:956b:deab with SMTP id 98e67ed59e1d1-2eaca7d236bmr3642213a91.4.1732201277587;
        Thu, 21 Nov 2024 07:01:17 -0800 (PST)
Received: from smtpclient.apple ([23.247.139.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212878bd8f9sm14758655ad.109.2024.11.21.07.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:01:17 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3] ACPI: PCI: check if the root io space is page aligned
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <9CBE412E-25B3-4C36-80F6-5EA9248B9085@gmail.com>
Date: Thu, 21 Nov 2024 23:01:00 +0800
Cc: linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C557A80A-0242-4D80-AE68-B21BCDB824AE@gmail.com>
References: <20240814163711.GA351420@bhelgaas>
 <86348A3F-6AF4-4DC0-ACF5-08EC52E3828C@gmail.com>
 <F6307927-BCC8-4F61-A089-B26555D51E45@gmail.com>
 <9CBE412E-25B3-4C36-80F6-5EA9248B9085@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)


> It seems that there is no reply from linux-mm about this. I believe =
even if
> there might be a better place for the mm subsystem to check the =
alignment,
> it is still necessary to do the check here, because details about =
which ACPI
> entry is causing the problem is only available here. If in the future, =
we would
> developed another better place to do the alignment check, we may =
refactor the
> code here.

Hi, all

Ping on this patch.

>=20
>>>>=20
>>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - Adjust code formatting.
>>>>> - Reword the commit message for further description of the =
possible reason
>>>>> leading to misaligned IO resource addresses.
>>>>> - Link to v2: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v2-1-a03c8c9b498b@g=
mail.com
>>>>>=20
>>>>> Changes in v2:
>>>>> - Sorry for posting out the draft version in V1, fixed a silly =
compiling issue.
>>>>> - Link to v1: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@g=
mail.com
>>>>> ---
>>>>> drivers/acpi/pci_root.c | 14 +++++++++++---
>>>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>>> index d0bfb3706801..a425e93024f2 100644
>>>>> --- a/drivers/acpi/pci_root.c
>>>>> +++ b/drivers/acpi/pci_root.c
>>>>> @@ -858,7 +858,7 @@ static void =
acpi_pci_root_validate_resources(struct device *dev,
>>>>> }
>>>>> }
>>>>>=20
>>>>> -static void acpi_pci_root_remap_iospace(struct fwnode_handle =
*fwnode,
>>>>> +static void acpi_pci_root_remap_iospace(struct acpi_device =
*device,
>>>>> struct resource_entry *entry)
>>>>> {
>>>>> #ifdef PCI_IOBASE
>>>>> @@ -868,7 +868,15 @@ static void =
acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
>>>>> resource_size_t length =3D resource_size(res);
>>>>> unsigned long port;
>>>>>=20
>>>>> - if (pci_register_io_range(fwnode, cpu_addr, length))
>>>>> + if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
>>>>> +     !PAGE_ALIGNED(pci_addr)) {
>>>>> + dev_err(&device->dev,
>>>>> + FW_BUG "I/O resource %pR or its offset %pa is not page =
aligned\n",
>>>>> + res, &entry->offset);
>>>>> + goto err;
>>>>> + }
>>>>> +
>>>>> + if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>>>>> goto err;
>>>>=20
>>>> This change verifies alignment for the ACPI case that leads to the
>>>> pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, =
but=20
>>>> there are others even in drivers/pci/, e.g., pci_remap_iospace() is
>>>> also used in the DT path, where I suppose a defective DT could =
cause a
>>>> similar issue.
>>>>=20
>>>>> port =3D pci_address_to_pio(cpu_addr);
>>>>> @@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct =
acpi_pci_root_info *info)
>>>>> else {
>>>>> resource_list_for_each_entry_safe(entry, tmp, list) {
>>>>> if (entry->res->flags & IORESOURCE_IO)
>>>>> - acpi_pci_root_remap_iospace(&device->fwnode,
>>>>> + acpi_pci_root_remap_iospace(device,
>>>>> entry);
>>>>>=20
>>>>> if (entry->res->flags & IORESOURCE_DISABLED)
>>>>>=20
>>>>> ---
>>>>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
>>>>> change-id: 20240813-check_pci_probe_res-27e3e6df72b2
>>>>>=20
>>>>> Best regards,
>>>>> --=20
>>>>> Miao Wang <shankerwangmiao@gmail.com>



