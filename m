Return-Path: <linux-pci+bounces-22760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C868A4C027
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C89216FDFE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76F20FAB5;
	Mon,  3 Mar 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="Sk+UKf2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0741E9B32
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004435; cv=none; b=YHMSsnkfi6WfRj2bQseBaaN9JDVDal+oGH4E7PcFpqA3tYVc8OTGwTbZemTbcyT4PsBMPaVORrnABmPmpPXqLx/UHrvndUFm0nYLQqxgg057EPkrQ4g4itsC+nvcnJtE2Y3lAGBR8mac9Pav/dsXesI0wREq/AUZaOWmHjq0pRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004435; c=relaxed/simple;
	bh=4vaNmrECdpuE+nItquTFFAmKXEmFwMLgvHiXIQ29GAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRrkk9mdideu3yiAbwAG2KViXtzkxCIU/BiJ6DpBQeW15wCt4Bs+d2NxhMiRER9wE9ooaP7rOQvpnTTDKPsCQrA+aWby2HTFoUGrLSSfjpD91Nru63Urx0TKpAcC3JfXrJAuW/nSCGEJ9s56SPg8GBziq+dl7PyJZpf7zlDoD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Sk+UKf2H; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52384afabdeso1128891e0c.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 04:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1741004432; x=1741609232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qiGCJuTjOW1WL+AlkLJto17ISROJENZ2Hmeb3N2a/0=;
        b=Sk+UKf2HRVMVk4jI/KiPQDdz0hTp3jopj92eaMCSOl1d7JNnRfD7W86ZYkOhya4ZH7
         nEL1JYE4DWZWXKJjr3ZiR3/CY/4BbFQQJt04rFAj2M87Ez7mxS6uf8+I14El9fDLj+Pf
         da7Xu9e83LO3DmC8KT9lZ57pVf2gp5pHFTgLgNTrgR37wjgAk9sWA44EpGc9wGYivxJ/
         xEkngTI2KaRNvUcB/CpaIymXRE53ugeGVxirFe8qYh+zeY0stgvBI2dJPTj74NB2IVC8
         TEJHHFlK0ff1BOmOWlixlV210WO72ixclfLDF04zvt+GfYsMXujrjtsTThr06Gst5DWv
         68kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004432; x=1741609232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qiGCJuTjOW1WL+AlkLJto17ISROJENZ2Hmeb3N2a/0=;
        b=Xf6KzOyyXqAALNlLHHvY2WVCd+OpKYkuUr/Ns76F5OidFgmh3u4l50KPIuaqWqcytz
         QLr8SZD646BM4eZtovrDYZteQE0d15gdObmViexl7Pnbk5F8+EBNqYeg9QycL3MBVNrU
         YMAmgJF3L1l2uBWPNbuj7l7c3TY3ALIhmsEInuZJh4l6RcCMnKODTtlxhvbVNyNsVGR1
         JYAGXTkgOKcRNWo7SiLZtKXcWpELcI3BiaakU0PjMlNtJD1C0U33qUM7D6vCAlk6gLcv
         Xkh/os6rxQqjcbcsO+CXGiFwAVY5MlalZ1Ep9u4yb0w5uxVixdpurN0vr+ahAe7R4/Ou
         quAw==
X-Forwarded-Encrypted: i=1; AJvYcCXl0Ru+dXZ9OJ95SQxcdnXf7ZuZ/QgWXMDhWhnxnFFUDx/he3TsRxAVNIL8A2s14ZDvoJOsWBbmJmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYBYd001S+83nZXa0NTcjLlh8lIY0PjY69nuA/1oigyp3xc5J
	+uESkEcWFGF9FrkQfIoMVWKDzZddnbvHwS8oP9riAYoxxHO6UGbgvJOs2JpBjQUWdjuu12nuKzk
	zEflHeljvauuAr1nL1oGVorfBAYlicYdXCWgS9VXpHaBzQ/Zjpmg=
X-Gm-Gg: ASbGncvfAYJI/+eNVO+j+qwm6mEj+zBhis27lLHptbZ050+O2o/nWmMWYHkUpBCHucz
	6lCFMXGLCptlJx8WZMXmWjG4dlJ8on4jEjmVxDBu/83k9B2Uin3kcFA6+9uXIb9hQxPLmCfSjfn
	38Df+NjkSf6H+GbUZbWrulQSpP
X-Google-Smtp-Source: AGHT+IEC/vHh7lhfByiJpQpHoysjvMszoqK4nnU6aR9Ze8Weud8WLm71QreZaPK3lTFkwbV0/OLzz6Z5Z5PrNOquPWw=
X-Received: by 2002:a05:6122:3410:b0:520:3d87:5cdb with SMTP id
 71dfb90a1353d-5235bd4a0c4mr7056166e0c.9.1741004431724; Mon, 03 Mar 2025
 04:20:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <Z8WTON2K77Q567Kg@gmail.com>
In-Reply-To: <Z8WTON2K77Q567Kg@gmail.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Mon, 3 Mar 2025 13:20:21 +0100
X-Gm-Features: AQ5f1Jqj87LmMek2lwxlwKr_Zx7BUcuB-tXvcLY_zqrnI1St3EnzrPSCENn2zG8
Message-ID: <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Ingo Molnar <mingo@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

* Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Rostyslav Khudolii <ros@qtec.com> wrote:
>
> > Hi,
> >
> > > Rostyslav, I would like to ask you, do you have patches / updates for
> > > enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> > > adjust my lspci changes for new machines.
> >
> > Pali, sorry for the late reply. Do I understand correctly, that even
> > though you have access to the ECS via
> > the MMCFG you still want the legacy (direct IO) to work for the
> > debugging purposes? I can prepare a
> > simple patch that will allow you to do so if that's the case.
> >
> > >
> > > So what is the practical impact here? Do things start breaking
> > > unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled?
> > > Then I'd suggest fixing that in the Kconfig space, either by adding a
> > > dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those
> > > must-have pieces of infrastructure.
> > >
> >
> > Ingo, thank you for the reply.
> >
> > The way I understand the access to the PCI ECS (via raw_pci_ext_ops)
> > works, is the following:
> > 1. If CONFIG_ACPI_MCFG or CONFIG_PCI_MMCONFIG are enabled - set the
> > raw_pci_ext_ops to use
> >     MMCFG to access ECS. See pci_mmcfg_early_init() / pci_mmcfg_late_init();
> > 2. If CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled - set the
> > raw_pci_ext_ops to use
> >     the 'direct' access to ECS. See pci_direct_init(). The direct
> > access is conditional on the PCI_HAS_IO_ECS
> >     flag being set.
> >
> > On AMD, the kernel enables the ECS IO access via the
> > amd_bus_cpu_online() and pci_enable_pci_io_ecs().
> > Except those functions have no desired effect on the AMD 17h+ family
> > because the register (EnableCf8ExtCfg),
> > they access, has been moved. What is important though, is that the
> > PCI_HAS_IO_ECS flag is set unconditionally.
> > See pci_io_ecs_init() in amd_bus.c
> >
> > Therefore I was wondering whether we should add support for the 17h+
> > family in those functions to have
> > the direct access work for those families as well.
>
> Yeah, I think so, but I'm really just guessing:
>
> > Regarding your suggestion to address this in the Kconfig space - I'm
> > not quite sure I follow, since right now the kernel will use
> > raw_pci_ext_ops whenever access beyond the first 256 bytes is
> > requested. Say we want to make that conditional on CONFIG_ACPI_MCFG
> > and CONFIG_PCI_MMCONFIG, does it also mean then we want to drop
> > support for the 'direct' PCI IO ECS access altogether?
>
> I thought that enabling CONFIG_ACPI_MCFG would solve the problem, and
> other architectures are selecting it pretty broadly:
>
>  arch/arm64/Kconfig:     select ACPI_MCFG if (ACPI && PCI)
>  arch/loongarch/Kconfig: select ACPI_MCFG if ACPI
>  arch/riscv/Kconfig:     select ACPI_MCFG if (ACPI && PCI)
>
> While x86 allows it to be user-configured, which may result in
> misconfiguration, given that PCI_HAS_IO_ECS is being followed
> unconditionally if a platform provides it?
>
> Thanks,
>
>         Ingo

So it seems that the config option that needs to be enabled is
CONFIG_PCI_MMCONFIG.
The MCFG kernel support depends on it (aka not compiled when disabled).
With that said - the IO ECS question remains. Do we want to support it
for AMD 17h+ or
it's not required anymore?

Regards,
Rostyslav

