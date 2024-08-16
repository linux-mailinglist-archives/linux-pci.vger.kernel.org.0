Return-Path: <linux-pci+bounces-11737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680195419C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 08:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97ACB236FB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624A84039;
	Fri, 16 Aug 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="INFc+7dC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541F6F2E0
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789046; cv=none; b=eQIFmbU96DJZeS28NIvo7J8HicDTfeI4A1lc1H5AgdkU3Swm3rSXE/gS1ZYr6pvaLiJJGgdcyD1RNPf1z1XcLeWkEYjmh/TImk/oX/3EXUKmvZ4ReMD4C+VEqfhnseBq0rK2JR7L6u8NcaSoW46B91W4e/0RAe81odJsL8OQ3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789046; c=relaxed/simple;
	bh=MiQ7dZ4bs9b3OKw2e7b5GoLROhGISJrbGG6GnN3L/eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U45gyM2HvV+F3e6N1okI3ym7CgEjCDiIArfZwvVMBvje81g54CpwjE9ZEPcAlad9ibiU9FWpTMJacZ46uDJ0io5VX7AmFrveFCr0Kqr28lKnFTW6/soeFcsfSAsJQ1peUJCEI4P6iOq7dYNCTmNoBSeRm6c00wpOAjjbUSwM3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=INFc+7dC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB7F43F31C
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 06:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723789038;
	bh=ehzIyWD4eKlgNDPaY1N9jwRF9mkHpKjwLz4FCtpXUHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=INFc+7dCypmfTJSQKv0a8Zfnz6e0fD+3qzVRXzBPIQsOpCV9Jx95YGFkfkW06/dDO
	 BoT548DDAZXeYjb09atZjBcxKMGxKGivou+r1pHijBAyiI+ZUZwYSq2wUmtKoiuAj7
	 ZesHp21zFlmP6JmhYsDUU2l8CpzVxjwIVljjJG0+Fx00GfjbMRmTnuYSzK5z7tW3e6
	 mjs8D+19B7GgUwq5T+CaFLxnWbfSOn7ZhJ+5tpi5jO1WQpCT4W+VLtlo+f4/kPaZXK
	 54lnPfLSOKcG/KnZqy0CEhXA0T/oXj8SowwRLupl8p9PQ5U+zAcntbvwU7nuDbsPx/
	 GUVQCjX0cg8qA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2610f4da9c2so2219555fac.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 23:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789037; x=1724393837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehzIyWD4eKlgNDPaY1N9jwRF9mkHpKjwLz4FCtpXUHA=;
        b=snWt8q4TpWGzY+Ec91zK+TwBq6Uly7Q02ucXFt43TUnou/Ha9LFlTOtF0kmpSiLchi
         dq6MIkkimLkMkhZBd+VIDUVugGpTxSRVQqAyE0tvo0180XtZiDdWjXSlqbT/MjX000zO
         em2mZx1AqsY1YlgqahVC1yYCcVwVJ92F0WIpyBg0a7PRcmdMLsWxoD2z9/s6yKj7yLjF
         hIUangK1k+drUwn4Sn7OlZYPIhG1W/MZgvtlY9KVjeJqjRms42K2IRoHHKMJHpGi9hLb
         nsREx6cf4TZTDJrfPnZJ7Y9sSJe/6mjPo4zjxYEGYcwE8bRbrlTCbYHF+ebIGgsErWQ/
         axcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh5wdBuL9JloTl4yt6N2KUIFny7g70cvTE1AGrwU8nTIsEhOLUVaUJOk3qbgvrPYNfkg8sdGNGsBytRaoKYP2vTaaWZU0+6QoZ
X-Gm-Message-State: AOJu0YwZYdL9ZmKRqIPulZ8K1c0nE0oXyBExrV5TqYNT2mufMM9jnuFj
	JRGfKt5V/qqfmna9gf3a+17QQf1Ib+7s5j46jB4Wg0F5uoeKnR+DyQ7rJtUBCwL05MS0rycJ8s6
	iduqxumVo0wZaELOPwZiHF4keGys626hQzw+8B61VjX6bF9y3SBuUzqNRyUpE5qR16G1hDJ3v5n
	SNGsMhlxfRsYidSTYLDd3tXaTgLPO65jrhcyfw1OT6jns3TX0L
X-Received: by 2002:a05:6870:470a:b0:261:f8e:a37a with SMTP id 586e51a60fabf-2701c39da02mr2249183fac.14.1723789037437;
        Thu, 15 Aug 2024 23:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xGp8G9OGDgd8o1nFBkFJc8sBm5ZT9zC4ZpSfXcDwUlR+eH3YD+8Upb/5ElZY7PKTk6AxWgdQaRyG+568zQI=
X-Received: by 2002:a05:6870:470a:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-2701c39da02mr2249170fac.14.1723789037058; Thu, 15 Aug 2024
 23:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530085227.91168-2-kai.heng.feng@canonical.com>
 <20240802000414.GA127813@bhelgaas> <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
In-Reply-To: <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 16 Aug 2024 14:17:04 +0800
Message-ID: <CAAd53p4NHoqt1=LsSpKS8CMF_-BHg-N_nCF3F5qZpkWDNohU1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD domain
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com, 
	david.e.box@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Aug 2, 2024 at 9:04=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Fri, Aug 2, 2024 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > On Thu, May 30, 2024 at 04:52:27PM +0800, Kai-Heng Feng wrote:
> > > Intel SoC cannot reach lower power states when mapped VMD PCIe bridge=
s
> > > and NVMe devices don't have ASPM configured.
> > >
> > > So set aspm_os_control attribute to let OS really enable ASPM for tho=
se
> > > devices.
> > >
> > > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and =
LTR")
> >
> > I assume f492edb40b54 was tested and worked at the time.  Is the
> > implication that newer Intel SoCs have added more requirements for
> > getting to low power states, since __pci_enable_link_state() would
> > have warned and done nothing even then?
> >
> > Or maybe this is a new system that sets ACPI_FADT_NO_ASPM, and
> > f492edb40b54 was tested on systems that did *not* set
> > ACPI_FADT_NO_ASPM?
>
> I believe it's the case here. Vendors may or may not set
> ACPI_FADT_NO_ASPM, so f492edb40b54 works on some systems but not
> others.

Do you think this is code is ready? Or is there any improvement should be m=
ade?

Kai-Heng

>
> Kai-Heng
>
> >
> > > Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f8=
3dd48@panix.com/
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index 87b7856f375a..1dbc525c473f 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pd=
ev, void *userdata)
> > >       if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> > >               return 0;
> > >
> > > +     pdev->aspm_os_control =3D 1;
> > > +
> > >       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > >
> > >       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > > --
> > > 2.43.0
> > >

