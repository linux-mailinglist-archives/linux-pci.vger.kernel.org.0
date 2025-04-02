Return-Path: <linux-pci+bounces-25187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93470A7917C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA233B170D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68423BD0E;
	Wed,  2 Apr 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaFJsyO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051711DFF7;
	Wed,  2 Apr 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605588; cv=none; b=WF+MFxKw/vNlDHe75Tf2SBtJlg1Bx9lXBdi9wt0sSMiru6rCG2u0/D/TO67tVeRXBXZUORRe7AEE0Mh6XvrIB3NtElZO+CtKfsGyMRz5lT6Xgy3a2eNJKJHcbfSmgMRhbaRduWegN4ZLpyVpsREY5Yq3QBssVVyUX/aRjZ2Y4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605588; c=relaxed/simple;
	bh=3psBfHa6q9GaR3lB9SNaBK+ExW2OnGalIiGqg6cGeFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDz+IGIlAziornQQZm0ni4+qpe0FX44l0PF4bzS3KUlwVuON3zjDoSD3KHFxwCN+D46MPXM1uBIKrkF9HD53ekDpPutCV7JKbHbDA9BLXqophkrRuHYWb7VYd4W0moqPLQP31/E25ea5VtjKqkXlWU1NNuNqZUM2eXzKtx/iwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaFJsyO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DE1C4CEE7;
	Wed,  2 Apr 2025 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743605587;
	bh=3psBfHa6q9GaR3lB9SNaBK+ExW2OnGalIiGqg6cGeFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aaFJsyO75XOvD+hkgGkC/pjLpQ9z44qG+qB0EPuhY3h3NNu8SgKYRZLHi6vyZxdls
	 hcRjnwqclfoecT1i/EUU1Nm0lh2GUpdyQ/1G32FXT3z1uGEo7nWg+W1TKtqTlNx7jG
	 zKsMGUgDCr70CcvlJSK4hUlLED3u1GAogAS9kGr5rSkQYqrKaC74TpZrS8uQIn06gM
	 DFRVlzOchg3DEzYUYNDfKdLbklYoLZc1hBrL1i3XDgyQ4T6Ch1pLbXKJF5w3K22+q+
	 72SZLw8sL0GBYcA/QuGKvqh7dbODeshnW9zm59gWnNKT5unlsCTtB5wJ3m8RrYpd4H
	 a0AhjqwjqNuaw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c0b4a038fso4170435a34.0;
        Wed, 02 Apr 2025 07:53:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbRCyFgQrv+Lv53vNdbmyZ7E+nxSOTtNTusb6mfKTX49pUtHkwMBVOyAlmkP6T2GvescNgpExD/zd9@vger.kernel.org, AJvYcCWn3PhBpalWAd/iZ6Or1mNLNBtgSdP6hUALfY4hqNqTa4wmSNSiRHC5wKlYa/HAMLtahFNENJxebUi4@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGUxe2iC8tZIglv/zqSFEQxbciKk2PR07KjOS9hkfHsOadleM
	rAunHEfmnFqVH7g5etWd3XsYMpyCDbESHdhq/yUKQrMMjUobzXLj0LdyYpTxSYzLNoijAqhZVxa
	WTRwtqr7CEPHcoU8c0t3kiaFz1ws=
X-Google-Smtp-Source: AGHT+IEyltbLYDPynv/VzQLX4Ebg0HBz7/B1jIHBOb6/zoWxfWgXBGwqoQ25Jo6yLQIb7QUWPetgCorPQQQ39N8GVbc=
X-Received: by 2002:a9d:3e56:0:b0:72b:8e84:3150 with SMTP id
 46e09a7af769-72dae74a540mr4148634a34.24.1743605586573; Wed, 02 Apr 2025
 07:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hN1qRzU96uAGf1+BoQyqF-1=C4XbCcPA-0xtGt8gj7qQ@mail.gmail.com>
 <20250402142104.GA1714299@bhelgaas>
In-Reply-To: <20250402142104.GA1714299@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 16:52:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juJFTbPJh2rTmFe4gF9LzXsfao0k3ne2eXd5OqubtwCw@mail.gmail.com>
X-Gm-Features: AQ5f1JobU1rpqVnO-t8Fh7ASRqyLnoweW7rZorW3wSWSFIFzCBWC5KgtSMi94XI
Message-ID: <CAJZ5v0juJFTbPJh2rTmFe4gF9LzXsfao0k3ne2eXd5OqubtwCw@mail.gmail.com>
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anshuman Gupta <anshuman.gupta@intel.com>, 
	intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, badal.nilawar@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 4:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 02, 2025 at 01:06:42PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 1, 2025 at 5:36=E2=80=AFPM Anshuman Gupta <anshuman.gupta@i=
ntel.com> wrote:
> > >
> > > Implement _DSM Method 11 as per PCI firmware specs
> > > section 4.6.11 Rev 3.3.
>
> > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 dela=
y_us)
> > > +{
> > > +       union acpi_object in_obj =3D {
> > > +               .integer.type =3D ACPI_TYPE_INTEGER,
> > > +               .integer.value =3D delay_us,
> > > +       };
> > > +
> > > +       union acpi_object *out_obj;
> > > +       acpi_handle handle;
> > > +       int result, ret =3D -EINVAL;
> > > +
> > > +       if (!dev || !ACPI_HANDLE(&dev->dev))
> > > +               return -EINVAL;
> > > +
> > > +       handle =3D ACPI_HANDLE(&dev->dev);
> > > +
> > > +       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_gui=
d, 4,
> >
> > This is something I haven't noticed in the previous patch, but also
> > applies to it.
> >
> > Why is rev 4 of the interface hard-coded here?
>
> Thanks for asking this because it's related to the whole _DSM revision
> question that I don't understand.
>
> If we didn't use rev 4 here, what should we use?  The PCI Firmware
> spec, r3.3, sec 4.6.11, documents this interface and says "lowest
> valid Revision ID value is 4", so that's the source of the 4.

Well, the "lowest vaild Revision ID" does not generally mean the "only
valid Revision ID".

> My argument is that the spec documents rev 4, the kernel code was
> tested with rev 4, so what would be the benefit of using a different
> revision here?

I'm talking about using a symbol to represent the number 4, not about
possibly using a different number, along the lines of using, say,
ACPI_FADT_LOW_POWER_S0 instead of putting BIT(21) directly into the
code.

The value is not likely to change, but using a symbol for representing
it has merit (it can be meaningfully used in searches, it can be
documented etc.).

Now, I'm not sure how likely it is for the PCI Firmware spec to bump
up the revision of this interface (I suppose that it will do so if a
new function is defined), but even if it does so, the kernel will have
to check both the new revision and rev 4 anyway, in case the firmware
doesn't know about the new revision.

