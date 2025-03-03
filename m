Return-Path: <linux-pci+bounces-22741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB93A4BAAF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDBE1891051
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE41F0E2B;
	Mon,  3 Mar 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="Fe4MPNMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4222E630
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993699; cv=none; b=Y4gJXN1bsgOghvY5SdrmsdVcAxSI/XCNMs0Bg1J8jsT9vHGD5TbMk4mlElgyrsCpjzNoWDaicHevs5hJY1nU81JArHExtvngfsiTZ60Xr2rs0Ipu2hYTAMzypvxtFOosdM29BduqJsGF8hv3orrRdxO7tzJc5jugLSSxmAHv5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993699; c=relaxed/simple;
	bh=pv7JhxNl2I28whP9+adbwP3IvdPyCk6EghnFcKHSLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Caku+a+fHRra6BLTMwYdd/L7/PVQquun7iRyx3jvNSsFuh8K4A7Hyn1ys2ddS2K0X2qFPgY+GIyQ31GkmDWnpVTAv2dxliWaj2rnbNxAz/k1i/zP1Pu3kJ5mfeqan+ochP3fnbVYTvetru60024Y0gbfah9sxzb40AIZ39aq54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Fe4MPNMk; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8671441a730so1619959241.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1740993696; x=1741598496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAeXWNkuPZBt1nYKfkioC0KxXx+i2L54nyTk7vpYv0Y=;
        b=Fe4MPNMk65VWMwDTVoVbm44SCgEeM0RqEDsMk9XX7DwXL3BNTC0rlTaBBpXCpq5RI6
         Ly0SKdi+ioooUzBJ2TRNB440+biEwvdcK7EDbY2aMJNu2l4MfVLamte1Uq+HRxA0QBgJ
         dS7oE9TIXHmLGp+l/54eku17Rqe0n5h6hKFUBqvVmyYjSsuhPKZs5QG/UATUDsgN4EJK
         S+wG072fuZQ9/dChJsYluPWVr2QRCHISBtNavf0tji5dO9eQGIcztn9ctFY07bCTQgQP
         iNeOzx97L87ISFbwTrbEHPjDWXbdRXipL58GXMPnzuOn91svCU6WD1vZ3fBRhDYe5UaJ
         uE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993696; x=1741598496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAeXWNkuPZBt1nYKfkioC0KxXx+i2L54nyTk7vpYv0Y=;
        b=e/5i/SbcoR/padiE426n2j42Ma8lytYUQfGEJA6c0DguPNJ+4loKfF0fJKcJNxqA3T
         NbU/qr0UqR2XqaXLJXa6T/N3zdQgCsSpBIt0Cj4E5JUAzHk++oo05U1Li9Ejvc/WPvCJ
         Nmf6Vy7NZ4gt3BJaiu8jdv8X3W8P/4XEgPRaSx9IQqt72+l5LYwPvqZCflQub8ZOedEl
         c/XFQyI2odsEXT/BaaBqE4/LNAlNG2nisfry5tXkv/yzcFYMiDppGQ41b5LshXMHbGNj
         v0N2hYIrfl5YyQN8A/9EulVk9oNZs7NUfCeKj40ci4LjxPH0F3p1iUU97EUQ0LvDA5QQ
         PQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZzpgmFYePnxvEK4AyAZPPwtrx/kWZlRwcAY9xZar/zlF4GwgWWpcGGyqqnZTNXu9bkx+9xw1O2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVX77/IjGLzHwJqu6+T7yHYVirMHfsOO8Ob6wDPAnNU0nUGhBH
	QC6+NpnWKk9zIhnvq7gP6PPoX04T1eAZcDuhLiW/KbWjdKa/DHj7Mro+XDRHNUxKWFi8Ve2x5EI
	gQIDLhqt1wtOmucoqwbHRVXsf80zlKDN8H4/bPg==
X-Gm-Gg: ASbGnct/3Jb0aDJ7wJcaydchhkYpiJCqUfeNz0E5Tabxum8IclE/MmX5oDAUTB2+DVh
	2FhhTsFj/hGrJOwKlMkoYmI4Rx774UJyr2j15iHN7kZ7jt6wDFQSIy4kCElJW92COY7G+ZNIi0W
	IFqApSf7EF6D+rmTkpFH9A3OCU
X-Google-Smtp-Source: AGHT+IFZbG2eyoSsPmw+ur7eqkya0lr99VJq5r7PqD3pp3CraBkFznVj3MvpZxxCJ8G8DlJOSQmNVFqoW7d+QViHpa8=
X-Received: by 2002:a05:6102:3f89:b0:4bb:f1f0:1b34 with SMTP id
 ada2fe7eead31-4c044857a38mr8417315137.2.1740993696264; Mon, 03 Mar 2025
 01:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com> <Z78uOaPESGXWN46M@gmail.com>
In-Reply-To: <Z78uOaPESGXWN46M@gmail.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Mon, 3 Mar 2025 10:21:25 +0100
X-Gm-Features: AQ5f1Jo0EX3pEM_GVM8NTI1LcFTTbxuaz98gbzh7kKRC0tNKU0-DotXfKkWTSrk
Message-ID: <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Ingo Molnar <mingo@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi,

> Rostyslav, I would like to ask you, do you have patches / updates for
> enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> adjust my lspci changes for new machines.

Pali, sorry for the late reply. Do I understand correctly, that even
though you have access to the ECS via
the MMCFG you still want the legacy (direct IO) to work for the
debugging purposes? I can prepare a
simple patch that will allow you to do so if that's the case.

>
> So what is the practical impact here? Do things start breaking
> unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled?
> Then I'd suggest fixing that in the Kconfig space, either by adding a
> dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those
> must-have pieces of infrastructure.
>

Ingo, thank you for the reply.

The way I understand the access to the PCI ECS (via raw_pci_ext_ops)
works, is the following:
1. If CONFIG_ACPI_MCFG or CONFIG_PCI_MMCONFIG are enabled - set the
raw_pci_ext_ops to use
    MMCFG to access ECS. See pci_mmcfg_early_init() / pci_mmcfg_late_init();
2. If CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled - set the
raw_pci_ext_ops to use
    the 'direct' access to ECS. See pci_direct_init(). The direct
access is conditional on the PCI_HAS_IO_ECS
    flag being set.

On AMD, the kernel enables the ECS IO access via the
amd_bus_cpu_online() and pci_enable_pci_io_ecs().
Except those functions have no desired effect on the AMD 17h+ family
because the register (EnableCf8ExtCfg),
they access, has been moved. What is important though, is that the
PCI_HAS_IO_ECS flag is set unconditionally.
See pci_io_ecs_init() in amd_bus.c

Therefore I was wondering whether we should add support for the 17h+
family in those functions to have
the direct access work for those families as well.

Regarding your suggestion to address this in the Kconfig space - I'm
not quite sure I follow, since right now the kernel
will use raw_pci_ext_ops whenever access beyond the first 256 bytes is
requested. Say we want to make that
conditional on CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG, does it also
mean then we want to drop support
for the 'direct' PCI IO ECS access altogether?

Best regards,
Rostyslav

