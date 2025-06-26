Return-Path: <linux-pci+bounces-30754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC575AE9D85
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE37B32A9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D92E11AF;
	Thu, 26 Jun 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyO2EjkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C792E0B49
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941107; cv=none; b=BnHhw8ISvCzEYzd6aLrQGyFnH87XexcnwzZOJ+9TGA1bdTY7CT19/oFhPXPfdq9cwJ76l+D6gv1B3CWWfiY3sUAuw/b5jIwAxW9ySrX/P+h/KwPwY22TWbo4sqiVpbx7MJVZFXRe0ewzwNZTYYnmiJViQKzaX+/sTnVi5Z+m4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941107; c=relaxed/simple;
	bh=s/6xAq5JcsmnwpJCn+qKQHhvorkkaEEq2YfVPgRfOgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVUDOuB7oO327YcAvc/CLjcXY5M2/U12zJzELz68FlNUk5xIh+ad+bWWNStwPL7S449b5wXbZ9mWalAftWXIvyrhkvT3ickI7vjdp1I78TZs7y7AOBb/DG/8ONB/LmIU2dxhdcU+n7cimpIZ7Gdk3glkdpRV78O8CSTAo/zrYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyO2EjkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096ADC4CEEB
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941107;
	bh=s/6xAq5JcsmnwpJCn+qKQHhvorkkaEEq2YfVPgRfOgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GyO2EjkIHGIz0CZOXaZXOle9/q7sasZgZMKEyqQHDQg53m1+MulYL2J0zztXdg2ZY
	 jYAEz96jMWsu0mLadsAYAVtkmcn+/wo8hsmIq+HV89e0IVS6dKvU78HL3MP/18ml40
	 dtd74zmoBH6A4Z99Cd8wkbswl2zgC+qnwZR2z27aswc+og2ESoLLkv0qYgLi64vMMy
	 grV3+SV9LfSx2nBZ8ohx+qkgeyLEoB2Q9IFJzPp79sMkcJTYeDRcdTosjzeo8R0eQm
	 J3iko7CGSvMTnGmQ7vGbP3XeuaUsbVBGbzMbxF/UoSi+gSJqfNeTCpagakW8+mbUZa
	 uPFp2wh2axybg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-404e580bf09so214811b6e.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 05:31:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa1jUHKWNCtZa2E0FX0fW7x+2kvxOtN1twcwvl4mMP/zpahj2uk3QOYYwf+qMUXqqQVPJKPoRbbUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrCCXogRcOb3CkflVd0X7gbCZKjSkq2Uyn4K76OkpNo0RDdiY
	aLBQBTwUOPNt5caiqKNNJKgkUKA0QdIRooZJmAbVvwR54jb1RZc9o6j/CSaCdDF+iVFwOq11Nbv
	sA+wnMVXHI6ube26LfeYmYMI3Wn1BmMU=
X-Google-Smtp-Source: AGHT+IFg0JXfjYsrQp3NFnHomv7BdgOcQwJSS3tQeUEDzdVaxAwB9mVcvC8Gj0Pasf4uFrJw+WDl0PdrZuzpq2msaLo=
X-Received: by 2002:a05:6808:4a4a:20b0:40b:2b2e:89c9 with SMTP id
 5614622812f47-40b2b2e967emr455998b6e.16.1750941106316; Thu, 26 Jun 2025
 05:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623191335.3780832-1-superm1@kernel.org> <aFpSTT_UHakY91_q@wunner.de>
 <CAJZ5v0gjCdpARy5NzCZ71xb_M0-LU0110F_eGaPZsuCHGWWARg@mail.gmail.com> <b21f3d5a-bc46-4e04-8dcc-657f1146378e@kernel.org>
In-Reply-To: <b21f3d5a-bc46-4e04-8dcc-657f1146378e@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 14:31:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzJixpckMwGTUAADGAqEK2nm+qUn6MRiPomiADXitfOg@mail.gmail.com>
X-Gm-Features: Ac12FXwmN2VaisC7BjOscNtupCO6ihAr-EiGOpePJ5pnvhWd7l28h_QrlZq8ggU
Message-ID: <CAJZ5v0gzJixpckMwGTUAADGAqEK2nm+qUn6MRiPomiADXitfOg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, mario.limonciello@amd.com, linux-pci@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:08=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 6/24/25 5:24 AM, Rafael J. Wysocki wrote:
> > On Tue, Jun 24, 2025 at 9:22=E2=80=AFAM Lukas Wunner <lukas@wunner.de> =
wrote:
> >>
> >> [cc +=3D Rafael, Mika]
> >>
> >> On Mon, Jun 23, 2025 at 02:13:34PM -0500, Mario Limonciello wrote:
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> >>> issue a "Link Down" and "Card not detected event". The PCI core will
> >>> treat this as a surprise hotplug event and unconfigure all downstream
> >>> devices. This involves setting the device error state to
> >>> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will ch=
eck.
> >>>
> >>> It doesn't make sense to runtime resume disconnected devices to D0 an=
d
> >>> report the (expected) error, so bail early.
> >>>
> >>> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> >>
> >>> ---
> >>> v4:
> >>>   * no info message
> >>> v3:
> >>>   * Adjust text and subject
> >>>   * Add an info message instead
> >>> v2:
> >>>   * Use pci_dev_is_disconnected()
> >>> v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1=
@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
> >>> ---
> >>>   drivers/pci/pci.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>> index 9e42090fb1089..160a9a482c732 100644
> >>> --- a/drivers/pci/pci.c
> >>> +++ b/drivers/pci/pci.c
> >>> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
> >>>                return -EIO;
> >>>        }
> >>>
> >>> +     if (pci_dev_is_disconnected(dev)) {
> >>> +             dev->current_state =3D PCI_D3cold;
> >
> > Why not PCI_UNKNOWN?
>
> It was following what other situations of failure did:
> * existing error in pci_power_up()
> * error in pci_update_current_state()
> * error in pci_set_low_power_state()
>
> I view all of these cases as unrecoverable failures.
>
> So perhaps if changing this one to PCI_UNKNOWN those three should those
> also be PCI_UNKNOWN?
>
> Bjorn, Lukas, thoughts?

Note that pci_device_remove() sets power_state to PCI_UNKNOWN, but
only if the old value is PCI_D0, so it would be good to make all of
that consistent at one point.

Anyway, feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch.

Thanks!

