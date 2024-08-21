Return-Path: <linux-pci+bounces-11913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B499593B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 06:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08821F230B9
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EB15C13E;
	Wed, 21 Aug 2024 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/sbYVJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57486AFA;
	Wed, 21 Aug 2024 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724215432; cv=none; b=riSm9x+tDOGF7DFmc7SioDYQj9XiHPWUeZcNJVXz6cBiETiJaxsmUm25Yb5Pnz7Kt+OelFbaZja/bMsUcwMoq0szEeDfrKpIpUBlhY8yGH7b6maIwDkrxoFcm9nfVckE6yMwoArN+Vnvf18M+fUgsBExJSIDUg1BYV8fDFSPSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724215432; c=relaxed/simple;
	bh=BUl4WZIOTp6bRjoAcLxbr7UyBflCBjbx7CEstH05xZM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UeP5nG1Dbwx4toW7G8orQ9j937XXX6E6iGTOPGtV/meXB5fsmWG9IQb5AGk/pNUiHhPR479Eaix2gcYCAxPdSGiWWs95DgUWaHtYNKBZIobWBC5zzaCqqBmnpCZ5LN5XWUAH6xon1oPninuoPqrXfkFlek3O3qlHXg+antQK4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/sbYVJl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cd894e2adfso10025a12.2;
        Tue, 20 Aug 2024 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724215430; x=1724820230; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P3Hk9XNXX67Z9XxlANZXs0svzlSvZih1xysLj6CbmM=;
        b=Y/sbYVJlFZxTX3oThZIboCR5RSl50Kl/tc4h1RstX3ght+ue8dwYI4UME6M9NDRhkO
         9LkmwLu0xX5L48rOVkl+e41jC4opWgZFqDw9PmAOLBcsyzRmkPYbr5RuJ4usmalrUFY8
         x/Sm4Ol5hrciUWewAKHAYw3CBy9COu6Nb+yhuLXt54n1ZOYJgu3cGaZwWb7LfLA1xhL/
         JUEGEnLqn86bcBZHs2VZh8QM8g0Kb6aKTH8krri5wDMciW/vo6RywHkEPB/EW+s3FzQL
         akIGvKWAihSJu6A1XR3kDJb9Jjn09zUBBXlncG9AzsS5IPnRyC+G5DCUeoqU1jhlkiwQ
         7Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724215430; x=1724820230;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P3Hk9XNXX67Z9XxlANZXs0svzlSvZih1xysLj6CbmM=;
        b=tajJBa63tFSsChv569eu0lWVYGzNHzd6+W11/TbTjI8r/CTHCWg0oJrhFpvxvxrex1
         su5xE5YMRE4CeY3PyAYeXh6aHYqDv3yS22zNKbMJAa8QrU1VB0ZjgzIjKsK3gPakSmkn
         XPlD3WckX65AJJRzpVhabzmyp9Gr6waeiS4f4z3ywes0SpQk+3unlIt2nobwHat3AyfI
         XIU7MJALtV3AU1+LQh3516u8bVA6CEh9t9b5TYT/B5LLY3zfm9FXQo+98dXRiI6cgBvX
         JimXxRaaHbv/UKo/RZNx5EvCLUtsPIQ79Ijo3KjcWxxDsk2N2SbDhJr7C9CLPaz7UMqz
         0ywQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGt1yRj4WROo/GkA0+8vOfkeIK/bFbvEqj7WVln/MfL6jH/vdkHUjIwhfyqo2PbPTdX8nwzXce4M+p@vger.kernel.org, AJvYcCUL/DpzFE6Mt3U4uqpV/CfYwnoKc4lG4GZCM1EcYqOsQq7frb+0Yem2kAfxKsi4bmXdNnAjiNoMeX8T@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGU2CCZ82pDNYJoC4hld9ZWQP/oJkF+zxK4QW8JQbvr8lVWXV
	kKV8/mCtaqEEMMLclLc2TQsbcAp/6PjrjNvvYan/9MH7v7kLmkZN
X-Google-Smtp-Source: AGHT+IH+ozAZ+jz6m72kC+HtpaDsVUaOzExvPIGhiOIYtJTBStrUt/otPT/jHSUZPA+86wGWbG9jHQ==
X-Received: by 2002:a05:6a20:3951:b0:1c4:84ee:63d1 with SMTP id adf61e73a8af0-1cad82e8cf0mr944326637.9.1724215429403;
        Tue, 20 Aug 2024 21:43:49 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b43dsm85164685ad.210.2024.08.20.21.43.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 21:43:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3] ACPI: PCI: check if the root io space is page aligned
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <86348A3F-6AF4-4DC0-ACF5-08EC52E3828C@gmail.com>
Date: Wed, 21 Aug 2024 12:43:32 +0800
Cc: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6307927-BCC8-4F61-A089-B26555D51E45@gmail.com>
References: <20240814163711.GA351420@bhelgaas>
 <86348A3F-6AF4-4DC0-ACF5-08EC52E3828C@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3776.700.51)

Sorry for directly looping Andrew in. I think Andrew may be familiar =
with
the code in question.

Some backgrounds: Mis-aligned addresses from ACPI table can pass along=20=

pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, =
leading to a
loop overrun in vmap_pte_range(). Bjorn and I wonder why all those
vmap_*_range() functions don't validate the alignment, assuming the =
addresses
page-aligned. We want to know the best place to do this check.

> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 12:28=EF=BC=8CMiao Wang =
<shankerwangmiao@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
>> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 00:37=EF=BC=8CBjorn Helgaas =
<helgaas@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> [+cc linux-mm for vmap page alignment checking question]
>>=20
>> On Wed, Aug 14, 2024 at 08:09:15PM +0800, Miao Wang via B4 Relay =
wrote:
>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>=20
>>> When the IO resource given by _CRS method is not page aligned, =
especially
>>> when the page size is larger than 4KB, serious problems will happen
>>> because the misaligned address is passed down to =
pci_remap_iospace(),
>>> then to vmap_page_range(), and finally to vmap_pte_range(), where =
the
>>> length between addr and end is expected to be divisible by =
PAGE_SIZE, or
>>> the loop will overrun till the pfn_none check fails.
>>=20
>> What does this problem look like to a user?  Panic, oops, hang,
>> warning backtrace?  I assume this is not a regression, but maybe
>> something you tripped over because of a BIOS defect?  Does this need
>> to be backported to stable kernels?
>=20
> Panic, or actually BUG in vmap_pte_range() at the =
!pte_none(ptep_get(pte))
> check, since misaligned addresses will cause the loop in =
vmap_pte_range
> overrun and finally reach one of the already mapped pages. This =
happens on
> a LS2k2000 machine, the buggy firmware of which declares the IO space =
of
> the PCI root controller as follows:
>=20
>  QWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
>      0x0000000000000000, // Granularity
>      0x0000000000004000, // Range Minimum
>      0x0000000000009FFF, // Range Maximum
>      0x000000FDFC000000, // Translation Offset
>      0x0000000000006000, // Length
>      ,, , TypeStatic, DenseTranslation)
>=20
> At first, I thought there might be some overlapping address spaces. =
But when
> I added some debug output in vmap_page_range(), I realized that it was
> because a loop overrun.
>=20
> Normally, loongarch64 kernel is compiled using 16K page size, and thus =
the
> length here is not page aligned. I tested my patch using a virtual =
machine
> with a deliberately modified DSDT table to reproduce this issue.
>=20
>> It seems sort of weird to me that all those vmap_*_range() functions
>> take the full page address (not a PFN) and depend on the addr/size
>> being page-aligned, but they don't validate the alignment.  But I'm
>> not a VM person and I suppose there's a reason for passing the full
>> address.
> Ah, I also have this question.
>>=20
>> But it does mean that other users of vmap_page_range() are also
>> potentially susceptible to this issue, e.g., vmap(), vm_map_ram(),
>> ioremap_page_range(), etc., so I'm not sure that
>> acpi_pci_root_remap_iospace() is the best place to check the
>> alignment.
> My first idea was that the misaligned address is introduced from DSDT
> table and the check would be better to be done inside the ACPI system.
> However, lets wait for replies from  linux-mm to decide where should =
be
> the best place.
>>=20
>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>> ---
>>> Changes in v3:
>>> - Adjust code formatting.
>>> - Reword the commit message for further description of the possible =
reason
>>> leading to misaligned IO resource addresses.
>>> - Link to v2: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v2-1-a03c8c9b498b@g=
mail.com
>>>=20
>>> Changes in v2:
>>> - Sorry for posting out the draft version in V1, fixed a silly =
compiling issue.
>>> - Link to v1: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@g=
mail.com
>>> ---
>>> drivers/acpi/pci_root.c | 14 +++++++++++---
>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>> index d0bfb3706801..a425e93024f2 100644
>>> --- a/drivers/acpi/pci_root.c
>>> +++ b/drivers/acpi/pci_root.c
>>> @@ -858,7 +858,7 @@ static void =
acpi_pci_root_validate_resources(struct device *dev,
>>> }
>>> }
>>>=20
>>> -static void acpi_pci_root_remap_iospace(struct fwnode_handle =
*fwnode,
>>> +static void acpi_pci_root_remap_iospace(struct acpi_device *device,
>>> struct resource_entry *entry)
>>> {
>>> #ifdef PCI_IOBASE
>>> @@ -868,7 +868,15 @@ static void acpi_pci_root_remap_iospace(struct =
fwnode_handle *fwnode,
>>> resource_size_t length =3D resource_size(res);
>>> unsigned long port;
>>>=20
>>> - if (pci_register_io_range(fwnode, cpu_addr, length))
>>> + if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
>>> +     !PAGE_ALIGNED(pci_addr)) {
>>> + dev_err(&device->dev,
>>> + FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
>>> + res, &entry->offset);
>>> + goto err;
>>> + }
>>> +
>>> + if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>>> goto err;
>>=20
>> This change verifies alignment for the ACPI case that leads to the
>> pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, =
but=20
>> there are others even in drivers/pci/, e.g., pci_remap_iospace() is
>> also used in the DT path, where I suppose a defective DT could cause =
a
>> similar issue.
>>=20
>>> port =3D pci_address_to_pio(cpu_addr);
>>> @@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct =
acpi_pci_root_info *info)
>>> else {
>>> resource_list_for_each_entry_safe(entry, tmp, list) {
>>> if (entry->res->flags & IORESOURCE_IO)
>>> - acpi_pci_root_remap_iospace(&device->fwnode,
>>> + acpi_pci_root_remap_iospace(device,
>>> entry);
>>>=20
>>> if (entry->res->flags & IORESOURCE_DISABLED)
>>>=20
>>> ---
>>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
>>> change-id: 20240813-check_pci_probe_res-27e3e6df72b2
>>>=20
>>> Best regards,
>>> --=20
>>> Miao Wang <shankerwangmiao@gmail.com>



