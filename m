Return-Path: <linux-pci+bounces-11688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E70952885
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 06:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41A7B242DF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 04:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAC3A268;
	Thu, 15 Aug 2024 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXxLDXGe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D42C182;
	Thu, 15 Aug 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696144; cv=none; b=juKv2CDw400Ck/D2CIYn3PkTibZlB15gs/9NyrUnpcn1ClTsF/wAcLQ3Qxua/0j74uD94biX2W7vchfqmbTYv7VnePwDgqrpcyEoa7Q5WDE3swNxCu2/Vb6Ai/YQlrnWoXha66Bqy1sikPDmd7FqQGJXBImspsGXEaxSOOBbQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696144; c=relaxed/simple;
	bh=N8DYGBmbnKeKlw+uJt+PzZWIwngcTg2XH1U8WyHClSY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fLUErmLm/4WLfNI7vbjRhRl7xT/SLi5Nhj9sQ2eyr5Dqzvot45RcHyFSUwzc9cR3LlRJdFHpryssY2no5J7g1X3XxRGq9oyRcDMBlH2VlBiLau1hPsGBIAkxmdmE9GIitumj2/vWB6tzzV+fDiwiYXuIKULioZ9873CFqC1tF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXxLDXGe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso371267a91.2;
        Wed, 14 Aug 2024 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723696142; x=1724300942; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFLslw7cUuZWfGL4McVvZQx5aa0QedRZOUE2A7L2GMU=;
        b=GXxLDXGetybRTcjjx+YHq8paENUWM8KNRT71prE7Xn/Aj3cx3dXkx+OujhvBSOfCOV
         D0EVSgWuSc+Ia9hqI2dLXaOFID2FZ7Ob75n5KhU02xMBEn0ZOsmrh+F8VnGohukpraD3
         N2pWHOt+5i+bmGZJpAi3KHkLgvEZl/7uXYBHDXYH9o8JFAJY6gcKtHxnvFz1rTnHY6cQ
         7TGinzeKeN2bkJN+zcsHKJRJwPIOKHjUa0yrcl477oyvXDwKdDDQQGU1FknJLS+sWLia
         jWgLWRWnsUTXoOlfCAqFHJDAVSZP4vlahE/9uR0jwVadyFUKCxr/4qSn5jFT/MbKnbFw
         OIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696142; x=1724300942;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFLslw7cUuZWfGL4McVvZQx5aa0QedRZOUE2A7L2GMU=;
        b=f+ItYnLnDYJVu48f5LJGkurabaXeeeKJdpQD4oJY3ZIY2YKzFx7vn4Fd6wwHbZZRJe
         3b5Lc5UpMHQdOi1sBShA7qUgQGKbtGPIICOa740YNZQwdGSkoYTThTFpbHjdVg4C/4oQ
         LTtX7ubY911BGGGqqYhDVk35j2OqdOooxv5P19Q5KRdz01R3mXZ2Ke1JWQX/FQJNRQht
         doS7X5K1XbMpqMhmeXh6QUmSbx0AB/JziPv32iC9PZV135AUTzpzTmTKsHbe6WYTilRq
         DcCYHGiC2jwqiUtuZwh1VLjSgTKdZJpAxaTpljJqft0KyppLAQP8fo1Y+7fpDOYpSEXC
         Ne4w==
X-Forwarded-Encrypted: i=1; AJvYcCWYJo6i97Uyft4jnJc9JrkGB13VOUDn8XatB4pIXyH55aq2i61vEXLKrZTCsvsFJ/BXREs+EDh1109cKyiEqjnYsDmfWwL1cmAZnPbd0KYLHOrlQKm7+pAgkmoafDcDuAZPwwpbRw==
X-Gm-Message-State: AOJu0Yz+aOdXEq6L7YIygfe945J5zdVS6tPb5IXXB/MWClUu/Z5pspQk
	BXzIw8UDNjpO/6c+JskU3sb9TRtQRibftCmnM+0r/vK2pUgJ4d9D
X-Google-Smtp-Source: AGHT+IFY9vXcQcIZcdE97WC6zB//oh2Tta9UfS2JDs4QwCFUFQd2HCWfJ5naFWtlIJriWpRLHCXkCw==
X-Received: by 2002:a17:90a:be0b:b0:2d3:c2a9:1c07 with SMTP id 98e67ed59e1d1-2d3c2a91cd6mr2222565a91.9.1723696142142;
        Wed, 14 Aug 2024 21:29:02 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f21d2sm2655982a91.28.2024.08.14.21.28.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 21:29:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] ACPI: PCI: check if the root io space is page aligned
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <20240814163711.GA351420@bhelgaas>
Date: Thu, 15 Aug 2024 12:28:44 +0800
Cc: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86348A3F-6AF4-4DC0-ACF5-08EC52E3828C@gmail.com>
References: <20240814163711.GA351420@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

Hi,

> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 00:37=EF=BC=8CBjorn Helgaas =
<helgaas@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> [+cc linux-mm for vmap page alignment checking question]
>=20
> On Wed, Aug 14, 2024 at 08:09:15PM +0800, Miao Wang via B4 Relay =
wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>>=20
>> When the IO resource given by _CRS method is not page aligned, =
especially
>> when the page size is larger than 4KB, serious problems will happen
>> because the misaligned address is passed down to pci_remap_iospace(),
>> then to vmap_page_range(), and finally to vmap_pte_range(), where the
>> length between addr and end is expected to be divisible by PAGE_SIZE, =
or
>> the loop will overrun till the pfn_none check fails.
>=20
> What does this problem look like to a user?  Panic, oops, hang,
> warning backtrace?  I assume this is not a regression, but maybe
> something you tripped over because of a BIOS defect?  Does this need
> to be backported to stable kernels?

Panic, or actually BUG in vmap_pte_range() at the =
!pte_none(ptep_get(pte))
check, since misaligned addresses will cause the loop in vmap_pte_range
overrun and finally reach one of the already mapped pages. This happens =
on
a LS2k2000 machine, the buggy firmware of which declares the IO space of
the PCI root controller as follows:

  QWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
      0x0000000000000000, // Granularity
      0x0000000000004000, // Range Minimum
      0x0000000000009FFF, // Range Maximum
      0x000000FDFC000000, // Translation Offset
      0x0000000000006000, // Length
      ,, , TypeStatic, DenseTranslation)

At first, I thought there might be some overlapping address spaces. But =
when
I added some debug output in vmap_page_range(), I realized that it was
because a loop overrun.

Normally, loongarch64 kernel is compiled using 16K page size, and thus =
the
length here is not page aligned. I tested my patch using a virtual =
machine
with a deliberately modified DSDT table to reproduce this issue.

> It seems sort of weird to me that all those vmap_*_range() functions
> take the full page address (not a PFN) and depend on the addr/size
> being page-aligned, but they don't validate the alignment.  But I'm
> not a VM person and I suppose there's a reason for passing the full
> address.
Ah, I also have this question.
>=20
> But it does mean that other users of vmap_page_range() are also
> potentially susceptible to this issue, e.g., vmap(), vm_map_ram(),
> ioremap_page_range(), etc., so I'm not sure that
> acpi_pci_root_remap_iospace() is the best place to check the
> alignment.
My first idea was that the misaligned address is introduced from DSDT
table and the check would be better to be done inside the ACPI system.
However, lets wait for replies from  linux-mm to decide where should be
the best place.
>=20
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>> Changes in v3:
>> - Adjust code formatting.
>> - Reword the commit message for further description of the possible =
reason
>>  leading to misaligned IO resource addresses.
>> - Link to v2: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v2-1-a03c8c9b498b@g=
mail.com
>>=20
>> Changes in v2:
>> - Sorry for posting out the draft version in V1, fixed a silly =
compiling issue.
>> - Link to v1: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@g=
mail.com
>> ---
>> drivers/acpi/pci_root.c | 14 +++++++++++---
>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index d0bfb3706801..a425e93024f2 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -858,7 +858,7 @@ static void =
acpi_pci_root_validate_resources(struct device *dev,
>> }
>> }
>>=20
>> -static void acpi_pci_root_remap_iospace(struct fwnode_handle =
*fwnode,
>> +static void acpi_pci_root_remap_iospace(struct acpi_device *device,
>> struct resource_entry *entry)
>> {
>> #ifdef PCI_IOBASE
>> @@ -868,7 +868,15 @@ static void acpi_pci_root_remap_iospace(struct =
fwnode_handle *fwnode,
>> resource_size_t length =3D resource_size(res);
>> unsigned long port;
>>=20
>> - if (pci_register_io_range(fwnode, cpu_addr, length))
>> + if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
>> +     !PAGE_ALIGNED(pci_addr)) {
>> + dev_err(&device->dev,
>> + FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
>> + res, &entry->offset);
>> + goto err;
>> + }
>> +
>> + if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>> goto err;
>=20
> This change verifies alignment for the ACPI case that leads to the
> pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, but=20=

> there are others even in drivers/pci/, e.g., pci_remap_iospace() is
> also used in the DT path, where I suppose a defective DT could cause a
> similar issue.
>=20
>> port =3D pci_address_to_pio(cpu_addr);
>> @@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct =
acpi_pci_root_info *info)
>> else {
>> resource_list_for_each_entry_safe(entry, tmp, list) {
>> if (entry->res->flags & IORESOURCE_IO)
>> - acpi_pci_root_remap_iospace(&device->fwnode,
>> + acpi_pci_root_remap_iospace(device,
>> entry);
>>=20
>> if (entry->res->flags & IORESOURCE_DISABLED)
>>=20
>> ---
>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
>> change-id: 20240813-check_pci_probe_res-27e3e6df72b2
>>=20
>> Best regards,
>> --=20
>> Miao Wang <shankerwangmiao@gmail.com>



