Return-Path: <linux-pci+bounces-37262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A4BAD55A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD4B1760DE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949A3043C4;
	Tue, 30 Sep 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VrsUI5u2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D821F1302
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244070; cv=none; b=XPdGvLBVoVK5EtkalaJoFMghAl5zz5A3hKYEc6fcWIC9fqhAyGhTZE/l5Wvg4P2rCFac9oKytRAzvAMVatVq4qPDc6MZP8nzK8I0t/mMmTPsjfWa9ixItW+7EC0S2ILxbIMLI9oMnn3uNBZFVaAUeEKXT80qq06k2ND+GqfRR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244070; c=relaxed/simple;
	bh=ZaEVr4or5cOiiWh76vrIwiPcXn98KNEC6FATw2gVXH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjakmjDedU4rq+MTi/e8wAHSRHcekGOaehv3wbc1yTsTpLiSAomZvwv/gUPugnKFfExMzbbvWCwyk3GDqVlY+InBAcpK87GPJfl4i8t+ihez60qAe8f85X8bU7q8LHI0jA2uwK0oFADD7RZ3q4bwPaV4I6AbPP6IVRO997v/nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VrsUI5u2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4de584653cfso67538701cf.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759244067; x=1759848867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=VrsUI5u2aLDo8TiJlCvgmiP1oRPX5zQ1Rd/VgP2tVuuHFQO8Wgr9yAIlI6lPPe6Slp
         MM/AQixaX4DWa/YUyCbQZrGuBkeo6JwffJhcgMgEi4pbLU89NlGr7Kzsxq8NJBB1qzq9
         kR0Sm9oQpP0n/O2OJ+LuEZqy3cX2Md+PrufBcTNOtwMFBEKb4Ga1XgdbmvwVZzPNTtok
         jMJ9hcazzzs6/Ih21A9hq8OUchkTF6w0D4QZ5GwKl+FBnOeye/edSk1xT3/1ryERYDJX
         1ZpL1kmKxojsfcRlw/KuEvRRxyX4wO/bZZdMcbR33xYihrOjrQW76x5omqbnDhQy6UYf
         k7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244067; x=1759848867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=adqMCeWhrFhcGUg5g4ScbbZTSCbw+EK1jNmqlFoGDX4w23Jn7BTg7Lq/SMgBw+z/NN
         3E8JZFj5nYyjczy87WWeyfzzbOesb2Uq6jYB5UlrfV9eDcaOpiyD7bornF5j5oYSV7Qm
         bEip0ht0Hr2qo82P8cgwIYU5CA5/NwBdW0qwXbEwhkXoZgWHaK1E/Ftq1R+KziV+qZC1
         f7myxn0irApuHppK4auXPBunz1Tkqyg5I01Eb0FsVX9bYa+3Mu2adpNHgw7j/vhgfagL
         wbN6SKwRZGZ/sApuiwOg9i2xsQlv/mc72tCMEn829kUQ83zVHYV5FfSLj6h0STKDBX3Z
         5d3A==
X-Forwarded-Encrypted: i=1; AJvYcCWR8p22ZWqTBPuqDXDh+bfouFG9Chc4JMoHfqr5kTn7U8jFSW5lyGSMDC1I3dZ2waRmcwgiaSV7qxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbmYudk8960UI0CxLI2qa84v0qUEBwgBgGGxGRrHIK1ujO2J+
	EHNyrtUtimJzgb0DBsCspN3Wy8J5iG5C2PfpmQKuZXkw/aRbupg1HzS8NeZn+OiOolgGbo6SP9N
	lt2AB0jSRKvsfkqh9xP7qmIa7prNxF9e/PVGmty74YA==
X-Gm-Gg: ASbGnctgDGpmkWZVW6lGKtFL5kqTqhbrM3BbnHj+exvQARq3epRzvJ5rEmO6UctGr5B
	Yv7o8LiWUcgppwuDfL6rjjAUPSkOM/ulr04SpAlzkD+nVBrD24ResTIISHZnfjqghiIzdGH+2vF
	5arY2xdXN6F1a20/WehhnYOBeOv0SukA6baVkHeWcPeuxvxKIvbFKMfd5raHq6mCNA9VhS8fjZr
	FQpUKMMblelu30F+VcxPZutHj/x/6i68wUwoTo=
X-Google-Smtp-Source: AGHT+IFOfelJUk0OlrUf28WQ82S2leR2E6nLxLlUD+/+zPuAH+3piu1oethsTrwzU7V8ASeo0taITg+SlRBUebjqnyU=
X-Received: by 2002:a05:622a:2598:b0:4b3:65e:76ff with SMTP id
 d75a77b69052e-4da4782da69mr239644941cf.15.1759244067321; Tue, 30 Sep 2025
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <2025093030-shrewdly-defiant-1f3e@gregkh>
In-Reply-To: <2025093030-shrewdly-defiant-1f3e@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 10:53:50 -0400
X-Gm-Features: AS18NWDw8pvmBCS0-6-XLE_nnPEk2xIPcwJH7fRLekDAunX6m_kspIDqEfOyowQ
Message-ID: <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > > prepare callback.
> > > > >
> > > > > After kexec, use driver_set_override() to ensure the device is
> > > > > bound only to the saved driver.
> > > >
> > > > This doesn't seem like a great idea, driver name should not be made
> > > > ABI.
> > >
> > > Let's break it down with baby steps.
> > >
> > > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > > same driver after kexec?
> > > To me that is a firm yes. If the driver binds to another driver, we
> > > can't expect the other driver will understand the original driver's
> > > saved state.
> >
> > Hi Chris,
> >
> > Driver name does not have to be an ABI.
>
> A driver name can NEVER be an abi, please don't do that.
>
> > Drivers that support live
> > updates should provide a live update-specific ABI to detect
> > compatibility with the preserved data. We can use a preservation
> > schema GUID for this.
> >
> > > 2) Assume the 1) is yes from you. Are you just not happy that the
> > > kernel saves the driver name? You want user space to save it, is that
> > > it?
> > > How does it reference the driver after kexec otherwise?
> >
> > If we use GUID, drivers would advertise the GUIDs they support and we
> > would modify the core device-driver matching process to use this
> > information.
> >
> > Each driver that supports this mechanism would need to declare an
> > array of GUIDs it is compatible with. This would be a new field in its
> > struct pci_driver.
> >
> > static const guid_t my_driver_guids[] =3D {
> >     GUID_INIT(0x123e4567, ...), // Schema V1
> >     GUID_INIT(0x987a6543, ...), // Schema V2
> >     {},
> > };
>
> That's crazy, who is going to be adding all of that to all drivers?  And

Only to the drivers that support live updates, that would be just a few dri=
vers.

> knowing to bump this if the internal data representaion changes?  And it
> will change underneath it without the driver even knowing?  This feels
> really really wrong, unless I'm missing something.

A driver that preserves state across a reboot already has an implicit
contract with its future self about that data's format. The GUID
simply makes that contract explicit and machine-checkable. It does not
have to be GUID, but nevertheless there has to be a specific contract.

Pasha

