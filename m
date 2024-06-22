Return-Path: <linux-pci+bounces-9126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D79135BE
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3EB23265
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D438FB9;
	Sat, 22 Jun 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cE33VdhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE6288DF
	for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719082408; cv=none; b=W2srZnXLFX0buIznHRTAPBYYWOdrnMcEDqy/LkBXQ1w8trYpXiGDh6BOkssF879Ma7G2lSgZxy8AAMTEheR1imkXcgV0WY2C0Jy9MOC1f5+Q2zvrjaD0Hn0G6Xqs1bKsiA3QC4ZRhEvd+ga7rAv+2UQbfVP3h2ILP32M7fMOW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719082408; c=relaxed/simple;
	bh=m1OrJmNO9LwdDEbmkvwbTuZezKxh26mqnnyoNMd0p1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMtd/NZPc3e4B0Yj1b6FgUc15sAKplaSRSpevh0BaQf3DuWXU2MArlDrjVPt/44x2tas9EMq7hF7jUaBpia5MsHDFQnw26hLviCc5ZA+UEA+2Bw8blJHx4EBo1BXqBW1rgl6pmZwzGxYzL5a0/m/Xebh5dgc/HauYBxH/qggHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cE33VdhI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-443580f290dso620411cf.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2024 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719082406; x=1719687206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txY7l5/ugEpTdYb4L91Pc5mOm0tzxQ8JxvQANorTSC4=;
        b=cE33VdhI3pj8tIEbP416ysmfP9Y/NZNEXvLAOgJVX+3gJ6Qt4041for/Lpv05281UK
         faNjvcp1gIWo3TAiYi2ktq+8eQhy2HMKHit3P9IzsadXGyygZqHq7B8HtNb71qGI/t0s
         Pm2ug5MyoyNGp4EGesxO2TSRqeOPlrxNh/gVohSbqaIWOxF9cC4qYh9ONuSZAbmnjH9Y
         4mMgqxXO9hkJI9KoI3ua6lJMVjs8NFkXoaxRzfgDPkzPeU7s3EGCXTt5/Exue8Mmmxbo
         Q99voj0cENh+PWP7Skxwu0WBlAlQasu9XWhaKJaVqjVUmveCIKSpbUcT8x6x4GoDwigl
         f47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719082406; x=1719687206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txY7l5/ugEpTdYb4L91Pc5mOm0tzxQ8JxvQANorTSC4=;
        b=Zy7otP+a5eeYNtz0SSc3WG/SttyJKGo31lgmDB1zcYpRiHpMvw47UvxMm3i+TLbuwf
         d/gOXdL5bxaRp0lbNTSF8fyhFS1D19cCcbzBW+A/eRxZiv7ng8JCmXll8qaxvW5ABPwD
         OP+H8e0OO2zyseeEDbEGz9QFuB+ubqWeF/fUpFkmnrpDy8bzqvgF8/1T13y6+xE0whUX
         19rv4IoAqhYxgJhXJosCY+5OorOcBxi32oZMfkGReRNoQvs8u3GyyaTi0GAd6ODtWJQw
         t2xZ6z03VJbPdBDp0TaeClq40gX5cAGaKId+MK7j4RP0OigbKA+XRnFTlC2iYfA2YRtd
         9UGA==
X-Forwarded-Encrypted: i=1; AJvYcCWsurECXyeZOfyJ1lSnlCwaMF5PS1p3JsLA6Atnf5zR3RgTX4T8NRfbK9TB3vxlTfOMss8g76if5onCybAAAD6X1AGu+XuEZEIf
X-Gm-Message-State: AOJu0YyDDyxwaqQLtVb3XvitrUMc3HCtFwUl5s64ixcpK2IBcJqRFWSW
	tSr20WW837iwLOzfXWTsWP+E91958x5qAc0meb8c+12vgtn8InWmdZrl3ymlzRjCm/N5QGUbxtS
	rwekPxUJMJjMAl7/fCV5WAl55KPfnAE9LbtGK87xvyUd7zMPlpQok
X-Google-Smtp-Source: AGHT+IHogO09eVkiQsY/h9voan3VKsmeXrVbuRNJT7VekYNC+puC0fcVX+/vkGPnLFPB7ZmppPi1l2k9bjOS+FcmBgQ=
X-Received: by 2002:a05:622a:4b06:b0:444:d3c5:3b0 with SMTP id
 d75a77b69052e-444d3c5048emr1096181cf.12.1719082406053; Sat, 22 Jun 2024
 11:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429034112.140594-1-smostafa@google.com> <87zftbswwo.ffs@tglx>
 <ZjAuJV87RjOu7gSy@google.com>
In-Reply-To: <ZjAuJV87RjOu7gSy@google.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Sat, 22 Jun 2024 19:53:14 +0100
Message-ID: <CAFgf54rFL0rF2KxGP883Vk8APnSgtNnXJYSO_oYsSqnEjf4-ig@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
To: Thomas Gleixner <tglx@linutronix.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

This has been here for a while without fixing, I will respin V2 with
your proposed changes,
please let me know if I should add any tag by you.

Thanks,
Mostafa

On Tue, Apr 30, 2024 at 12:32=E2=80=AFAM Mostafa Saleh <smostafa@google.com=
> wrote:
>
> Hi Thomas,
>
> On Mon, Apr 29, 2024 at 11:04:39PM +0200, Thomas Gleixner wrote:
> > On Mon, Apr 29 2024 at 03:41, Mostafa Saleh wrote:
> > >  err:
> > > -   pci_msi_unmask(entry, msi_multi_mask(entry));
> > > +   /* Re-read the descriptor as it might have been freed */
> > > +   entry =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
> > > +   if (entry)
> > > +           pci_msi_unmask(entry, msi_multi_mask(entry));
> >
> > What unmasks the entry in the NULL case?
>
> Apparently nothing, I missed that. (PCI isn=E2=80=99t really my area, I
> prefer dealing with non standardised platform devices :))
>
> >
> > The mask has to be undone. So you need something like the uncompiled
> > below.
> >
> > Thanks,
> >
> >         tglx
> > ---
> >
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -349,7 +349,7 @@ static int msi_capability_init(struct pc
> >                              struct irq_affinity *affd)
> >  {
> >       struct irq_affinity_desc *masks =3D NULL;
> > -     struct msi_desc *entry;
> > +     struct msi_desc *entry, desc;
> >       int ret;
> >
> >       /* Reject multi-MSI early on irq domain enabled architectures */
> > @@ -374,6 +374,12 @@ static int msi_capability_init(struct pc
> >       /* All MSIs are unmasked by default; mask them all */
> >       entry =3D msi_first_desc(&dev->dev, MSI_DESC_ALL);
> >       pci_msi_mask(entry, msi_multi_mask(entry));
> > +     /*
> > +      * Copy the MSI descriptor for the error path because
> > +      * pci_msi_setup_msi_irqs() will free it for the hierarchical
> > +      * interrupt domain case.
> > +      */
> > +     memcpy(&desc, entry, sizeof(desc));
> >
> >       /* Configure MSI capability structure */
> >       ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> > @@ -393,7 +399,7 @@ static int msi_capability_init(struct pc
> >       goto unlock;
> >
> >  err:
> > -     pci_msi_unmask(entry, msi_multi_mask(entry));
> > +     pci_msi_unmask(&desc, msi_multi_mask(&desc));
> >       pci_free_msi_irqs(dev);
> >  fail:
> >       dev->msi_enabled =3D 0;
>
> I tested it with my stub, but since I didn't write the code, here
> is my tag, let me know if you want me to respin.
>
> Tested-by: Mostafa Saleh <smostafa@google.com>
>
> Thanks,
> Mostafa
>

