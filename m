Return-Path: <linux-pci+bounces-37253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE0BACF5B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD07B1924FEB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4652D3237;
	Tue, 30 Sep 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TWiuystH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C53253957
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237404; cv=none; b=Ws1BefrdypMIpp99xOtpLVey8Kj/ytBx67PNHswSlJWm8+NeIyXus1rDzkntDbN2nYxzLubrg3Yj5x5/oHajKXtuntJyVyjMlRoZTaVgo6RXoQsN63k25HS1nX85zr50c5MalOyVsdrz2G4cM2H+hRCoYN3xsnP0J+SIG3/WW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237404; c=relaxed/simple;
	bh=tNy5hIlubLvYXn7jng64XrQQhZOwIs4X532FSAnk+BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgwgPLFFTCCCwcWM9kxXssvn1kugq5i3/YEusL25VpCMx/UlPhx5qvBdSg9x9xPRkz4Trpy0O4zwx5033mDfBgeC83j9TXw+X+k3QvWAVa/2hJXYSMxWWVBVwvxLZJUaBx4mjNqcONzInpxuJKvAer+axJ0cGyUP0DlOh0KitIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TWiuystH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-86278558d6fso308384285a.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759237401; x=1759842201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC1oKAVwY5VttRhmKJUPbe7CpWFm1J+jVh6aRaRkZ4s=;
        b=TWiuystHBuXRlefecO6hfqPhr5LMIcm928h305R2enDO3PMEIhDYpP2qWvHmQMv/NV
         6omRIUYqI/nZWl1PrIHz3dNcDDJCy5kPQQD45bg+gCdD+NVoz/xKufiQqakbmE3vqZub
         sfsEv3xNFHDR7/+nSTrBxNi90O2DKu4Mtb4smrAnPaGUlTywBpMd1Xk2a6E5U86aCRBs
         V1NoUY+0HLLl1h+3HFb+YnG5ruSG3SyVMVHWx0H7MCyKOeT9yT8dgSIIZi79zRD6WmK2
         z9IBv411xGSkgOgGlvof5eBHFAn1XgS8x7cnkwgJtukZb7+vlMuX1kNCMQi4DFq+UUhN
         WRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759237401; x=1759842201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC1oKAVwY5VttRhmKJUPbe7CpWFm1J+jVh6aRaRkZ4s=;
        b=G6l7PnQxDmMQw6XIX6b0s7MyHcgdHVv1j25tjS4LER03mN6IxG9TN16xtohoLJcweS
         eQr4YZ59EXA6kn0n4quq6HPBd0eYGd2BTTZrxuOECMy/wRkrVqO1abC88T4CZVyu9aBA
         abXTsuuFawvLH20DsBDy1655mX2nz8cwSGi/Jdfy7RiOPRw3Tufbtpx2qkrrd5+hI0XT
         ktP4DF/hRJbrM7OjXueJzp697eArYte1odAvclcCxsJkNatAt4rRhRG56c1Jf8R34Woc
         Gw/9eacJnPT3whQzHbrXtbUA0bQwUEN+b7Vt6Gmd6jglBxhK9FpUYJa7uRhHkx1kwkEw
         1AFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBQfVAkcAcFcyfT5Zpf8s7ChMuKyPY2ywuyHEZavTfVJa6KQ8bO5wgtCy0ZwKpHb3uq8X3cWgMOkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSPtUhpsO5pf2kQvKNXij8Isuq/xomxKIvn9cKoMYV9f0Zfqs
	DrPd4G6UpMXXDGcvPEwgeUgj1cMAglXt2J8R7D9DuSoV/Oyx1/DM3qDaNu3dB5KiFMmr4LxRPDt
	4imlPLpTBVEZEfhSD+N+w0/Yw6FU61zDfjQtBwiPt2Q==
X-Gm-Gg: ASbGncuDltOELtiUnSoMmWD/BUFLpvojXRIcyHgG/jlj9et89yMd+IXYMBMw+9wuTjl
	ZaePRHDGXTK3QyaXLYdNPsdVw8vV9gcazwJannhJMqQXImTn3A4WrASKThRo5P4hp/mmGGm2kuy
	OoX1NW5LAAsUp0fRX7QoB65KOmNFDLy/fOEtrbKx0gwzT/rL0AGq8dGC5wy8wZqq7dIhH3ifKJK
	Su/xostIc1/l6CybsS2T0Fs+CCsmXDf5tU8Jt0=
X-Google-Smtp-Source: AGHT+IEXsl0l6CFv2XrbeldBTkph/BWzHMDIl1mPG9fMR2Gop2fULhnOuqxlzYbsJ40ATbeEXf4K4rr4nreQirK4/i4=
X-Received: by 2002:a05:620a:640b:b0:85b:cd94:71ff with SMTP id
 af79cd13be357-85bcd947af3mr1982298785a.48.1759237401174; Tue, 30 Sep 2025
 06:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
In-Reply-To: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 09:02:44 -0400
X-Gm-Features: AS18NWASRT0LPsx9qEKAelbHRFbMF3MsrgJioJy2jlydT_xCYMVTX_yMZN6zf_g
Message-ID: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Chris Li <chrisl@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> >
> > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > prepare callback.
> > >
> > > After kexec, use driver_set_override() to ensure the device is
> > > bound only to the saved driver.
> >
> > This doesn't seem like a great idea, driver name should not be made
> > ABI.
>
> Let's break it down with baby steps.
>
> 1) Do you agree the liveupdated PCI device needs to bind to the exact
> same driver after kexec?
> To me that is a firm yes. If the driver binds to another driver, we
> can't expect the other driver will understand the original driver's
> saved state.

Hi Chris,

Driver name does not have to be an ABI. Drivers that support live
updates should provide a live update-specific ABI to detect
compatibility with the preserved data. We can use a preservation
schema GUID for this.

> 2) Assume the 1) is yes from you. Are you just not happy that the
> kernel saves the driver name? You want user space to save it, is that
> it?
> How does it reference the driver after kexec otherwise?

If we use GUID, drivers would advertise the GUIDs they support and we
would modify the core device-driver matching process to use this
information.

Each driver that supports this mechanism would need to declare an
array of GUIDs it is compatible with. This would be a new field in its
struct pci_driver.

static const guid_t my_driver_guids[] =3D {
    GUID_INIT(0x123e4567, ...), // Schema V1
    GUID_INIT(0x987a6543, ...), // Schema V2
    {},
};

static struct pci_driver my_pci_driver =3D {
    .name       =3D "my_driver",
    .id_table   =3D my_pci_ids,
    .probe      =3D my_probe,
    .live_update_guids =3D my_driver_guids,
};

The kernel's PCI core would perform an extra check before falling back
to the standard PCI ID matching.
1. When a PCI device is discovered, the core first asks the Live
Update framework: "Is there a preserved GUID for this device?"
2. If a GUID is found, the core will only attempt to bind drivers that
both match the device's PCI ID and have that specific GUID in their
live_update_guids list.
3. If no GUID is preserved for the device, the core proceeds with the
normal matching logic
4. If no driver matches the GUID, the device is left unbound. The
state gets removed during finish(), and the device is reset.

Pasha

