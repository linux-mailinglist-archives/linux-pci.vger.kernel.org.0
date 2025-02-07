Return-Path: <linux-pci+bounces-20879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05378A2C003
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846EE169D51
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32441DE3AB;
	Fri,  7 Feb 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="WOKA8iiT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4C192D77
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922200; cv=none; b=jlRhPHB7A2YdEK7zdhBef1YWvi9NNkrdIymqx7DtBb0a3OZln8z86sncT4QF0vUB+BnAxuE2pf7eJhP7sg3Y3YY7S2A9fATS4qFFZyWSNxaWMdF8K7lA+FPlCt0eg5x9QHbkcGHlKHl+4Sg/9N9HDBlxGgcBUsKMLttCKwhjsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922200; c=relaxed/simple;
	bh=8dSp7jpKHxboTrZ29vEvzIoTaKmW9cItRIc7qe/m/qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUj6Ppi7MAR4CXhOdT3jNDsTn89+MsRv+1hNYJJARlPBj8DwP2n6KBe/zcjqv96v3FjT94MsNj9iRnhlbMj70cEkhf7q3ptiU7rfUUd+0P7hWm48qX61i8bXbw4e+YjXrqgQlTRpG6qAWVBUfqx6Jvwbb2AtvJKrdarBBFUFrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=WOKA8iiT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f2f386cbeso32713435ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1738922197; x=1739526997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFa0TwOfaeXeN6TUv3CVAI4nkkhAF2OdqwCTnqd5M/Y=;
        b=WOKA8iiToA1iq46FdNlA6XW4IQbhDFLACJ2RnvJMe3yV/ETcAlry9xlQ6Kx1LP9IXM
         lAdgduHGgQdq1Qd+d5c06ye6ZIgWDy5uZfjS1QJnixBYdibc/cVRWb7cIfdKT6ABNz0o
         P0PXYUyQpbU8yh6GB5rTfVwvhnzaCSInAHAl30bA1+Nd0o77K6PolilMrDSo5A2pW6DT
         YoQ/09SvgzlPHnIvhDEC+zsjhlmiu7vzAAgcxXOc8QTPtGPJhGkd+JsqfrBjKRPceQ2q
         AjFZOYksURfu18I3TZ7ibLLWAjjFc5xElHAyLSPHr7EGPafHg0y4SR+SgOci509M1/FI
         fycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738922197; x=1739526997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFa0TwOfaeXeN6TUv3CVAI4nkkhAF2OdqwCTnqd5M/Y=;
        b=Ltjiixvr2Bo73mVDy17iU4wYsa0wFIWlosdbP7IMIsSbtv0YBrN6LfMkEshgV5gui7
         nATTa95ssHdGASb26hRuVzgImOTeGCj2X/ROP8+hdjEUqOLJ7UIR1cG09Q8rO1JHA3ag
         dXQcCg7MoU0ZAzpvc71r2hgQf5d1S2DsA6IYqjT1JDF9xaBTbP20JPxVyXTwxA3buHWP
         64u7Nij47eAlzmhzcymvzYLELC+IRy3MAgVf1FZmzQvpWBKl8v+ARXQi27t5ryuY6G3j
         +36LxrEWk6BZGzg8IGSKh/OWUQZsxzv3YBIiFSI/MWdyXIg75GZ2rnSV/fv//fPKMCAA
         YpkA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ju2CmjWrVihCCbRfS+MbPJwJAub1PKbynq6J4CUw4sYNeTG+YNnp26wF3prRqMlKU2ApkskVeFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkU5lKpR+RflhPQ02x+6kBXfjX9itWDyGDTneOharE0E9INDJ
	j9PcTzKd6IZddVQnfgcqC2FrqKYJqnqL3wYAxiQu62tUpUcEbaGBq7jufvQfOACJl9qVEw1qGQp
	l4ecQIeaM7JDAbLfN36sLf9Uj3o6rY9TPRxfUbg==
X-Gm-Gg: ASbGncttNi4t+MPvFlh3fNjb0DrFCN9znDTBTE9tfLGGHy7zcq88vQKsHS2byKdl5VJ
	yRUjgolh8E3jYE7ncDKqX/7QbXtvibKqRFOwntADYfcpk8zr/qUxDOB51iRkM45zNyLRXIlDD
X-Google-Smtp-Source: AGHT+IHFsq67V9fZ6rUZE9lwc+hW9hSgTgLl260hi13irnaaHCOdFVGrplRNPaMrZzRN26tBc6n2xDx1800vyAUMGlM=
X-Received: by 2002:a17:903:32cb:b0:21d:dfae:300c with SMTP id
 d9443c01a7336-21f4e6a064dmr47724015ad.3.1738922197049; Fri, 07 Feb 2025
 01:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <167dfe31-89cb-6135-aafc-ece0cb234daa@linux.intel.com> <20250205133707.GA910099@bhelgaas>
In-Reply-To: <20250205133707.GA910099@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 7 Feb 2025 17:56:01 +0800
X-Gm-Features: AWEUYZmSIbYXwpTueTUNZARdYQzw_ZN0Jf23ei1FezC0aIP7wNJvJt6gC5HE750
Message-ID: <CAPpJ_edsGMBobHaG+9YYpdSgp2tR5CDqDhDY-MuD606hp5Q-=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2025=E5=B9=B42=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Feb 05, 2025 at 10:38:24AM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 4 Feb 2025, Bjorn Helgaas wrote:
> >
> > > [+cc Rafael]
> > >
> > > On Fri, Jan 31, 2025 at 05:29:13PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > > The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
> > > > pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for =
both
> > > > the Upstream Port and its upstream bridge when handling an Upstream
> > > > Port, which matches what the L1SS restore side does. However,
> > > > parent->state_saved can be set true at an earlier time when the
> > > > upstream bridge saved other parts of its state.
> > >
> > > So I guess the scenario is that we got here because some driver calle=
d
> > > pci_save_state(pdev):
> > >
> > >   pci_save_state
> > >     dev->state_saved =3D true                <--
> > >     pci_save_pcie_state
> > >       pci_save_aspm_l1ss_state
> > >         if (pcie_downstream_port(pdev))
> > >           return
> > >         # save pdev L1SS state here
> > >         if (parent->state_saved)           <--
> > >           return
> > >         # save parent L1SS state here
> > >
> > > and the problem is that we previously called pci_save_state(parent),
> > > which set "parent->state_saved =3D true" but did not save its L1SS st=
ate
> > > because pci_save_aspm_l1ss_state() is a no-op for Downstream Ports,
> > > right?
> >
> > Yes! An unfortunate interaction between those two checks.
> >
> > > But I would think this would be a very common situation because
> > > pcie_portdrv_probe() calls pci_save_state() for Downstream Ports when
> > > pciehp, AER, PME, etc, are enabled, and this would happen before the
> > > pci_save_state() calls from Endpoint drivers.
> > >
> > > So I'm a little surprised that this didn't blow up for everybody
> > > immediately.  Is there something that makes this unusual?
> >
> > I agree it should be very common and was quite surprised that -next
> > did not catch it. What I recall though is you modified the patch while
> > applying it by adding those Downstream Port checks so the fix
> > patch's Tested-by was for different code from what got applied (and it
> > would have been caught would the original author have tested also the
> > modified commit).
>
> Sigh, that makes sense, it's probably my fault, sorry.  I apologize
> for messing this up and causing all this extra work.
>
> I applied this to pci/for-linus yesterday, so it should make it for
> v6.14-rc2.

Just back from holidays.

Thanks to Nikl=C4=81vs' bug report, Ilpo's quick fix and Bjorn's cooperatio=
n.

Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > Unfortunately, I cannot think of anything that would be so unusual to
> > warrant not detecting it earlier. Maybe it was just the holiday period
> > causing less testing and lower level of awareness in general? The machi=
ne
> > doesn't always hang because of the problem as was the case with Nikl=C4=
=81vs,
> > so it might have occurred but went unnoticed if it occurred for a devic=
e
> > that is not critical.
> >
> > > > Then later when
> > > > attempting to save the L1SS config while handling the Upstream Port=
,
> > > > parent->state_saved is true in pci_save_aspm_l1ss_state() resulting=
 in
> > > > early return and skipping saving bridge's L1SS config because it is
> > > > assumed to be already saved. Later on restore, junk is written into
> > > > L1SS config which causes issues with some devices.
> > > >
> > > > Remove parent->state_saved check and unconditionally save L1SS conf=
ig
> > > > also for the upstream bridge from an Upstream Port which ought to b=
e
> > > > harmless from correctness point of view. With the Upstream Port che=
ck
> > > > now present, saving the L1SS config more than once for the bridge i=
s no
> > > > longer a problem (unlike when the parent->state_saved check got
> > > > introduced into the fix during its development).
> > > >
> > > > Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save=
_aspm_l1ss_state()")
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219731
> > > > Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@g=
mail.com>
> > > > Tested-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gma=
il.com>
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  drivers/pci/pcie/aspm.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index e0bc90597dca..da3e7edcf49d 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *p=
dev)
> > > >   pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> > > >   pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> > > >
> > > > - if (parent->state_saved)
> > > > -         return;
> > > > -
> > > >   /*
> > > >    * Save parent's L1 substate configuration so we have it for
> > > >    * pci_restore_aspm_l1ss_state(pdev) to restore.
> > > >
> > > > base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
> > > > --
> > > > 2.39.5
> > > >
> > >
> >
> > --
> >  i.
>

