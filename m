Return-Path: <linux-pci+bounces-13283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A958397BF83
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D561C21BB6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD501C9DDA;
	Wed, 18 Sep 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp68HPbZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E61C8FD6;
	Wed, 18 Sep 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679671; cv=none; b=UgnSbphU+HrtucoX2CL41ABhZbdMRG8laqYI+xGVFpCyt2L28eAGymfa8ZaAel0dmLRqICkP+93K4bCDIWFHWgGUwnZNy9COr3c8KmyHRH4sAp54fxX5VDmKvDYtip+zmyJsjdrMYu2/iJ+lO7NHA4IM4FkwdiZU+YWZq+l7Eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679671; c=relaxed/simple;
	bh=rViQ3bva6+6FyKcYlUSiAGsveIXqnBw0osY7XFGjjxs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dqYYh2BK4cJ4fV2qWbER+6BulUY5GUYBnYQh+VAkzUta44O7sNbmzgcAQYtgcwPALatgw88hjDM56U+2ysoYlMWmTkKnUnaufhlF8en/W+aCDGmQGmW6/bNL4c1Kxm+HXPR64MtOopbk04vvoUi3s5dfTkgfbIIx1wtAaT9GtK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp68HPbZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so1395530b3a.2;
        Wed, 18 Sep 2024 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726679669; x=1727284469; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8XWEjshIeUyAJDr89/XlRuNEb4mgSG3Wk3IyKgdD2M=;
        b=Fp68HPbZnoONsITiS5G7QVaANmsKoeI5Dbp+R8rIPZSSy2Xbqxl/73CS3HJn8Ii8cx
         ilJtrAIDMdFBBXZka6ykmfCd4BPFdvSdGJ5tvXNMVSaf5iNCxtp2W82K4CZdSgj70DBj
         eUqzWWNMv6A2p6pIRfbghoplZcHVDZuTku+ZXNtRTE9+4Vc7HwaNoapAwme1cRi2lw/R
         zLpPJzUld4J2oneq8zaqojx7CNZJpawiUZKcZdj6bojqXLB57h6+dEUKpqBTeRqsA4pe
         lOjLBFrZIcLvsuXvWschVsri4XSOt3z2RXAAw3OAMJomCpy6z15pWvmZBDv5mXh1RjVE
         gYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726679669; x=1727284469;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8XWEjshIeUyAJDr89/XlRuNEb4mgSG3Wk3IyKgdD2M=;
        b=CbW7thV16wb3WVt3KenYvBudXKtBg3viERRdtlk+VvR7p6c+0iGvYV/YrfJGQDArpT
         TkqJtemdq4y4QohW2Fvgnwu8vFD+Kt9MFUf8NAzZ/LgAkYLZgGsV5ab5287u78EIaxJ4
         4V3Si/nhgfqJFC7vgW1qZCV9ZyPpvUnDsA8fbqm6dCNJCDG1K6iorPWTGio+PX7x7pMO
         2ErlQar3poWNaYOjR46sIjmF6IVbeO89LWEnr4mT3eVzu1w7wHq1Phi9rapL+ElpNoRx
         dyr71sTgF9aTJTIV7IPfMYY3DKii6xuFXOL4sl9M/skqc+QT5HOd9ZUqQ54TJ/ispLlX
         WPIw==
X-Forwarded-Encrypted: i=1; AJvYcCUvnv4jv/eC5ieR8La4zveCrxvjljDpLEOR2l2BcMAgeKBJ+kHtmShLtXd+y62EAbAG3KFsVKuRdXpV@vger.kernel.org, AJvYcCVAE4UC0pwr7vtJUSBC/I4i5JVSHUlTuRfWhQK5vbIX7FEWyojSWDUbjGbARIHWRpXqL4U7zRkGOEbx@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxF1tXPFS9YGOGEo+nWICluDHgkN+dziYSTaKn5727cxXB9UT
	dFp63/z1bnhsuE6dOvxykOHOdn554xbGV+F0rOUuqolz5l7XdWfO
X-Google-Smtp-Source: AGHT+IH6UrksX18YRMK53M8BYR7liw/I9T3GTtpyZHqa/05mpaP5k4izxrS5OWeY4OfGxRz7cwV6hg==
X-Received: by 2002:a05:6a21:6da2:b0:1cf:2be2:5e5a with SMTP id adf61e73a8af0-1cf764cdd7bmr16397918637.10.1726679668417;
        Wed, 18 Sep 2024 10:14:28 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4a5a8cf3sm6769905a12.85.2024.09.18.10.14.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 10:14:27 -0700 (PDT)
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
In-Reply-To: <F6307927-BCC8-4F61-A089-B26555D51E45@gmail.com>
Date: Thu, 19 Sep 2024 01:14:11 +0800
Cc: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CBE412E-25B3-4C36-80F6-5EA9248B9085@gmail.com>
References: <20240814163711.GA351420@bhelgaas>
 <86348A3F-6AF4-4DC0-ACF5-08EC52E3828C@gmail.com>
 <F6307927-BCC8-4F61-A089-B26555D51E45@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)


> 2024=E5=B9=B48=E6=9C=8821=E6=97=A5 12:43=EF=BC=8CMiao Wang =
<shankerwangmiao@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Sorry for directly looping Andrew in. I think Andrew may be familiar =
with
> the code in question.
>=20
> Some backgrounds: Mis-aligned addresses from ACPI table can pass along=20=

> pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, =
leading to a
> loop overrun in vmap_pte_range(). Bjorn and I wonder why all those
> vmap_*_range() functions don't validate the alignment, assuming the =
addresses
> page-aligned. We want to know the best place to do this check.
>=20
>> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 12:28=EF=BC=8CMiao Wang =
<shankerwangmiao@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Hi,
>>=20
>>> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 00:37=EF=BC=8CBjorn Helgaas =
<helgaas@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> [+cc linux-mm for vmap page alignment checking question]
>>>=20
>>> On Wed, Aug 14, 2024 at 08:09:15PM +0800, Miao Wang via B4 Relay =
wrote:
>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>>=20
>>>> When the IO resource given by _CRS method is not page aligned, =
especially
>>>> when the page size is larger than 4KB, serious problems will happen
>>>> because the misaligned address is passed down to =
pci_remap_iospace(),
>>>> then to vmap_page_range(), and finally to vmap_pte_range(), where =
the
>>>> length between addr and end is expected to be divisible by =
PAGE_SIZE, or
>>>> the loop will overrun till the pfn_none check fails.
>>>=20
>>> What does this problem look like to a user?  Panic, oops, hang,
>>> warning backtrace?  I assume this is not a regression, but maybe
>>> something you tripped over because of a BIOS defect?  Does this need
>>> to be backported to stable kernels?
>>=20
>> Panic, or actually BUG in vmap_pte_range() at the =
!pte_none(ptep_get(pte))
>> check, since misaligned addresses will cause the loop in =
vmap_pte_range
>> overrun and finally reach one of the already mapped pages. This =
happens on
>> a LS2k2000 machine, the buggy firmware of which declares the IO space =
of
>> the PCI root controller as follows:
>>=20
>> QWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, =
EntireRange,
>>     0x0000000000000000, // Granularity
>>     0x0000000000004000, // Range Minimum
>>     0x0000000000009FFF, // Range Maximum
>>     0x000000FDFC000000, // Translation Offset
>>     0x0000000000006000, // Length
>>     ,, , TypeStatic, DenseTranslation)
>>=20
>> At first, I thought there might be some overlapping address spaces. =
But when
>> I added some debug output in vmap_page_range(), I realized that it =
was
>> because a loop overrun.
>>=20
>> Normally, loongarch64 kernel is compiled using 16K page size, and =
thus the
>> length here is not page aligned. I tested my patch using a virtual =
machine
>> with a deliberately modified DSDT table to reproduce this issue.
>>=20
>>> It seems sort of weird to me that all those vmap_*_range() functions
>>> take the full page address (not a PFN) and depend on the addr/size
>>> being page-aligned, but they don't validate the alignment.  But I'm
>>> not a VM person and I suppose there's a reason for passing the full
>>> address.
>> Ah, I also have this question.
>>>=20
>>> But it does mean that other users of vmap_page_range() are also
>>> potentially susceptible to this issue, e.g., vmap(), vm_map_ram(),
>>> ioremap_page_range(), etc., so I'm not sure that
>>> acpi_pci_root_remap_iospace() is the best place to check the
>>> alignment.
>> My first idea was that the misaligned address is introduced from DSDT
>> table and the check would be better to be done inside the ACPI =
system.
>> However, lets wait for replies from  linux-mm to decide where should =
be
>> the best place.

It seems that there is no reply from linux-mm about this. I believe even =
if
there might be a better place for the mm subsystem to check the =
alignment,
it is still necessary to do the check here, because details about which =
ACPI
entry is causing the problem is only available here. If in the future, =
we would
developed another better place to do the alignment check, we may =
refactor the
code here.

>>>=20
>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>> ---
>>>> Changes in v3:
>>>> - Adjust code formatting.
>>>> - Reword the commit message for further description of the possible =
reason
>>>> leading to misaligned IO resource addresses.
>>>> - Link to v2: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v2-1-a03c8c9b498b@g=
mail.com
>>>>=20
>>>> Changes in v2:
>>>> - Sorry for posting out the draft version in V1, fixed a silly =
compiling issue.
>>>> - Link to v1: =
https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@g=
mail.com
>>>> ---
>>>> drivers/acpi/pci_root.c | 14 +++++++++++---
>>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>> index d0bfb3706801..a425e93024f2 100644
>>>> --- a/drivers/acpi/pci_root.c
>>>> +++ b/drivers/acpi/pci_root.c
>>>> @@ -858,7 +858,7 @@ static void =
acpi_pci_root_validate_resources(struct device *dev,
>>>> }
>>>> }
>>>>=20
>>>> -static void acpi_pci_root_remap_iospace(struct fwnode_handle =
*fwnode,
>>>> +static void acpi_pci_root_remap_iospace(struct acpi_device =
*device,
>>>> struct resource_entry *entry)
>>>> {
>>>> #ifdef PCI_IOBASE
>>>> @@ -868,7 +868,15 @@ static void acpi_pci_root_remap_iospace(struct =
fwnode_handle *fwnode,
>>>> resource_size_t length =3D resource_size(res);
>>>> unsigned long port;
>>>>=20
>>>> - if (pci_register_io_range(fwnode, cpu_addr, length))
>>>> + if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
>>>> +     !PAGE_ALIGNED(pci_addr)) {
>>>> + dev_err(&device->dev,
>>>> + FW_BUG "I/O resource %pR or its offset %pa is not page =
aligned\n",
>>>> + res, &entry->offset);
>>>> + goto err;
>>>> + }
>>>> +
>>>> + if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>>>> goto err;
>>>=20
>>> This change verifies alignment for the ACPI case that leads to the
>>> pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, =
but=20
>>> there are others even in drivers/pci/, e.g., pci_remap_iospace() is
>>> also used in the DT path, where I suppose a defective DT could cause =
a
>>> similar issue.
>>>=20
>>>> port =3D pci_address_to_pio(cpu_addr);
>>>> @@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct =
acpi_pci_root_info *info)
>>>> else {
>>>> resource_list_for_each_entry_safe(entry, tmp, list) {
>>>> if (entry->res->flags & IORESOURCE_IO)
>>>> - acpi_pci_root_remap_iospace(&device->fwnode,
>>>> + acpi_pci_root_remap_iospace(device,
>>>> entry);
>>>>=20
>>>> if (entry->res->flags & IORESOURCE_DISABLED)
>>>>=20
>>>> ---
>>>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
>>>> change-id: 20240813-check_pci_probe_res-27e3e6df72b2
>>>>=20
>>>> Best regards,
>>>> --=20
>>>> Miao Wang <shankerwangmiao@gmail.com>
>=20
>=20


