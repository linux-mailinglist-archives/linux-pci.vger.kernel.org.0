Return-Path: <linux-pci+bounces-3201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4584C9DB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72951C25E58
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BAF1B597;
	Wed,  7 Feb 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZhF1hbbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5661B7F0
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306269; cv=none; b=Pe4c7ufZTyY8LDunTHCVIIKgHhdowR37yU3OICbLNgpO+7yrTx/8N05z1Ngw4iyonlirQeczaE4koU9V6Pp+UwR11j1ZyvrG6spG17+OAE4xGG0ll3AaUjqfS0gSfAjUILNy6rk5nnDSDDbPUP6ManDhEPDPB1wjB3cwzC5Q5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306269; c=relaxed/simple;
	bh=1cT8EwzAgV4muwaKG6TVe8enpSpOX5u7s5jXFQu/01I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCgK4HMIvdnVt1Xw8xKbeT3OrcOdQuoiIdistH0hSed1qk5PRUwUnk7lv6GleCVmydYnHf91ibcE0WONiD7QViG/ZWJrJzGUuqy6WZjfz9Q5Em39+uzBqheP/or041tBOlk0Zwnb/pcqKMrQVGnrP8YAfM09Ezf8NxFWxQbfGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZhF1hbbX; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6c0dc50dcso364518276.2
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707306267; x=1707911067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHQjjIAuLbS5dirxMqHbxELxPNPCwjg4KpsEXJuoJ/0=;
        b=ZhF1hbbX7j7b5b79W1512KtqEa5xb1VwAICuOBaHXaZ7R/S3bTTYf+EmHGn1X+43VI
         9tYI74JxbYsP0xjYGFwUEt4+gGu2JkeQLUttHuzGt7Y+viPbkiWUg/9P2P0fq47yJxPw
         sIBXj3Y+Qh1u1ETck3EhDTzJmZv2QxQ7R6WHWolU4KGQNWQcuH9p+RSlSLR2cU4qQ04c
         T80z4/Tud8nijKlYmiR3Ua+GdkrhKUfZL04/7ck2aP4iWyjmrwv/mrGVmWfMPN4qZs1m
         iTQGTNnviXi/yYTaKdCbXAMn6Xzq3wD2/1QU639c7YRIPYJVYe6/MpuhPKQ0CGzYaPhe
         AV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306267; x=1707911067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHQjjIAuLbS5dirxMqHbxELxPNPCwjg4KpsEXJuoJ/0=;
        b=nmvZm+xtcqTCGuRtH04OtUrgHzBEuYqCfzF9F03JSUcbSZLJ1YPjq692AUqjYC5LP5
         IB4P4n6PZy0Y1397xhwOfCdN7X+4mvGcmur2YD5p9LQuP+MnZ6YLqXtAnHAfbOCp57nQ
         4WxqJo2Xk3CNnd5fwfUGiO2O7RvoH3ge6tVJi0fytN69bgy7zV0F9NGRREemjd5P8B0a
         pEsd3hr2gkTiXJfFttPgaqrYMUzblla6loALne/RVH0fkKvXee4EMWXyTAruz3tnw4mU
         GXgbr86S4us1Wfzau2mqxVPlqTfzQzMjPHfKkUrKCD6fIk0gfY5RiXr6vyBHUdBPXThY
         fh2w==
X-Gm-Message-State: AOJu0YwkIB0Fy9kJb6RCBQUGpTqdil5xAW43ZPJY8b0uo7DHndAd7yR6
	rHx71wUDDcvV3ctAgtrXkc/bF12WRlm9zKoObP40n6W4S+2T+VPg2/gpZFYmbwBa9JWtmiSRMC8
	QsveSf8JMLamngLFCpdMv3g/UAcxF7IzltISPMA==
X-Google-Smtp-Source: AGHT+IH3v6VYtO+OTg9Wy0EhHrxKGg2g3IBj2TUN+YMrZmXU54Yu6Nahvd1UX8Fh32Kb8UNMx7ry4ukOpDNF7rDBEbk=
X-Received: by 2002:a5b:991:0:b0:dbd:d617:7f14 with SMTP id
 c17-20020a5b0991000000b00dbdd6177f14mr4298338ybq.10.1707306267205; Wed, 07
 Feb 2024 03:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <CAPpJ_eeV45QErAYRADUAHJUsGP0q5DqQJBQsgDdGZL0H0Q1isA@mail.gmail.com>
In-Reply-To: <CAPpJ_eeV45QErAYRADUAHJUsGP0q5DqQJBQsgDdGZL0H0Q1isA@mail.gmail.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 19:43:51 +0800
Message-ID: <CAPpJ_eeAOjdERye=Br6r0LgzEGf_OnpD+osTGHahjTQ6PdioWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:44=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > The Asus B1400 with original shipped firmware versions and VMD disabled
> > cannot resume from suspend: the NVMe device becomes unresponsive and
> > inaccessible.
> >
> > This is because the NVMe device and parent PCI bridge get put into D3co=
ld
> > during suspend, and this PCI bridge cannot be recovered from D3cold mod=
e:
> >
> >   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
> >   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
> >   setpci -s 00:06.0 CAP_PM+4.b=3D03 # D3hot
> >   acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
> >   acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
> >   setpci -s 00:06.0 CAP_PM+4.b=3D0 # D0
> >   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
> >   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
> >   # NVMe probe fails here with -ENODEV
> >
> > This appears to be an untested D3cold transition by the vendor; Intel
> > socwatch shows that Windows leaves the NVMe device and parent bridge in=
 D0
> > during suspend, even though these firmware versions have StorageD3Enabl=
e=3D1.
> >
> > Experimenting with the DSDT, the _OFF method calls DL23() which sets a =
L23E
> > bit at offset 0xe2 into the PCI configuration space for this root port.
> > This is the specific write that the _ON routine is unable to recover fr=
om.
> > This register is not documented in the public chipset datasheet.
> >
> > Disallow D3cold on the PCI bridge to enable successful suspend/resume.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> > Signed-off-by: Daniel Drake <drake@endlessos.org>
>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

Change to Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > ---
> >  arch/x86/pci/fixup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > v2:
> > Match only specific BIOS versions where this quirk is required.
> > Add subsequent patch to this series to revert the original S3 workaroun=
d
> > now that s2idle is usable again.
> >
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index f347c20247d30..6b0b341178e4f 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -907,6 +907,51 @@ static void chromeos_fixup_apl_pci_l1ss_capability=
(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl=
_pci_l1ss_capability);
> >  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_a=
pl_pci_l1ss_capability);
> >
> > +/*
> > + * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
> > + *
> > + * On this platform with VMD off, the NVMe's parent PCI bridge cannot
> > + * successfully power back on from D3cold, resulting in unresponsive N=
VMe on
> > + * resume. This appears to be an untested transition by the vendor: Wi=
ndows
> > + * leaves the NVMe and parent bridge in D0 during suspend.
> > + * This is only needed on BIOS versions before 308; the newer versions=
 flip
> > + * StorageD3Enable from 1 to 0.
> > + */
> > +static const struct dmi_system_id asus_nvme_broken_d3cold_table[] =3D =
{
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
304"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
305"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
306"),
> > +               },
> > +       },
> > +       {
> > +               .matches =3D {
> > +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMP=
UTER INC."),
> > +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.=
307"),
> > +               },
> > +       },
> > +       {}
> > +};
> > +
> > +static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
> > +{
> > +       if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
> > +               pci_d3cold_disable(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme=
_d3cold);
> > +
> >  #ifdef CONFIG_SUSPEND
> >  /*
> >   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3c=
old, but
> > --
> > 2.43.0
> >

