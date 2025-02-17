Return-Path: <linux-pci+bounces-21631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77ECA38805
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB10918816F9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AF2253A6;
	Mon, 17 Feb 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JALxipCE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA7225388
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807164; cv=none; b=R8/Xn193U2VsWZBOtCjFnEwBc/aIhecNdzd6ORxHEc15/ikS8let2OIZiGcWm6BmAygQQB0EFKEuxu69s6esHBGZQlExKLhPZN1AUTHaNYo4pAFfTXP6X2H9+SKitMr3o8Rl2I3J5nn2/GgmRdWHOs03mxlGeSOdv+WSqnnEuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807164; c=relaxed/simple;
	bh=xxETXniWbq5atwpenAGdrSobL6UOlLzJNQA31mmclnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNxk3kpIoBITPy51GPSwr3WSZTuv8Fc83037poLtgXZ95/KfHVSoQa9K2iiUMllFsyrETunfTviYZeFlqVtVDrTMBNG0fXT5nQVGKGYc4qTO5CJ5dgYYRbLnEb6/Fcq7eCF5ExDLDgc2EyDNjKxZk3BRZ9Cw0p47oTNlRTQqnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JALxipCE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so93132a91.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739807162; x=1740411962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dPtYYNth/a64LIJH7c4OEDw+dSC4UYyJPpFlvHQ3Bo=;
        b=JALxipCEKR/iSYnWnaqBnVnhB+iDZ7zWLKOewETtFhd2QNid2aeMDAz1M7M9mmBxUx
         6k/VrEI5NcYcSgfnmPlhvkZtEGpMykp8eS+88ce50XMpdUbkJK7dVXc6+1Y6yW3+Ir+a
         aeEG8Sqhh5E3EQGANn7tfs/9l8znTrp99QVVFltWitMnuDY2+8cHN6EUpCxaLHIb/3/x
         LDg9PlcJDGMDI2BoIkAYrMScF/s5Af0YlgJqEjte2UmZkANCIm55h7lxNyM/DM2AY0W8
         Vs1aRPxDdEQR4wbf4ENL7cWrB4bE+Dc0/fAQYYbaWlEFdZJfgxFaCAKERes2xiQQa8Ux
         Uvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807162; x=1740411962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dPtYYNth/a64LIJH7c4OEDw+dSC4UYyJPpFlvHQ3Bo=;
        b=V5wfLGiQ1z9WB2si22lv4xvUMaKVi8FmEo6Zv7DvJry8rgXg+E/9+gHPQbqQAjXk9u
         hpPxIHNjc1Dx4CgnmtdrW+Ujb6ueumhoEAYPxGgkxZnwmhuqHWzwrkp4PMbCNnY1kD4W
         R/BTqswBZPGX2lXEK9HztG7av/FygqJQx72yqGug2cwpUpLvxoeNN6CDQh6h/VghpqoL
         U8k/jap+7WWwOGLj9T3ZsWgwUxnBZulp7qZp4rU1OZS/OS5a2YwFOyKBjKI1ZpWfQ5s5
         RyGxJn4tcW6EFoQ8/e9v+I+2nHvKJbbvgwKBSsfJRwHdwNpaL5AsT6sXkku1DUJxiE97
         5FuA==
X-Forwarded-Encrypted: i=1; AJvYcCUzePE4YGDHBSiG3qqE2jv9tVTTlVcw7H2IRnl9WnMUpU77+Q1KzgusWefkgM0+ArqfZ6dWdWUoeA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22xgKsQYP1JSjgP1ycifYPkuwoBAhJJDpRawUI7ofPx+gJNyy
	GWHdWW/jU7DEbfqqjH10Q5Lt1dR8dy9HOBy5NhGIv8QQ3AJjSjybZiAB4E/cI5W3cCiZaqISymJ
	qZEyUOD29kj2XwbrBPhlFAgc4wsc=
X-Gm-Gg: ASbGncv0f1X3bJXpScx9HTG2+4fzJFcCiWjX6PBGkkhTvR4CIabkPYldhhhc4tAc8SI
	XajikQb0q8PF3gEP9NlMf9ieC4+zCOSKdKZbUai2ELV4tBFpl+QjhEBKDREiQwVo9HpjOh+9s
X-Google-Smtp-Source: AGHT+IFFWHytK57mGA99ICNsVDnMJMRw/i0z7QQunG4a6xJoh5vLQDs+r8+l/cO4cW4JhlRyc/yF+ZydD/oy4NjVr/o=
X-Received: by 2002:a17:90b:2fc3:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2fc41173deemr5813946a91.7.1739807162134; Mon, 17 Feb 2025
 07:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com> <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
In-Reply-To: <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 10:45:49 -0500
X-Gm-Features: AWEUYZmMaHIRFPjSC-GAve1xDgr6WT1YWCE5e7Iw0EX36gqQYc6WVYOgu2sZMdU
Message-ID: <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	Mario.Limonciello@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:38=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.02.25 um 16:10 schrieb Alex Deucher:
> > There was a quirk added to add a workaround for a Sapphire
> > RX 5600 XT Pulse.  However, the quirk only checks the vendor
> > ids and not the subsystem ids.  The quirk really should
> > have checked the subsystem vendor and device ids as now
> > this quirk gets applied to all RX 5600 and it seems to
> > cause problems on some Dell laptops.  Add a subsystem vendor
> > id check to limit the quirk to Sapphire boards.
>
> That's not correct. The issue is present on all RX 5600 boards, not just =
the Sapphire ones.

I suppose the alternative would be to disable resizing on the
problematic DELL systems only.

>
> The problems with the Dell laptops are most likely the general instabilit=
y of the RX 5600 again which this quirk just make more obvious because of t=
he performance improvement.
>
> Do you have a specific bug report for the Dell laptops?
>
> Regards,
> Christian.
>
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

^^^ this bug report

Alex


> > Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 =
XT Pulse")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> > ---
> >  drivers/pci/pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 225a6cd2e9ca3..dec917636974e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *=
pdev, int bar)
> >
> >       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 *=
/
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=3D =
0x731f &&
> > +         pdev->subsystem_vendor =3D=3D 0x1da2 &&
>
>
>
>
> >           bar =3D=3D 0 && cap =3D=3D 0x700)
> >               return 0x3f00;
> >
>

