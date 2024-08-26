Return-Path: <linux-pci+bounces-12200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DDF95F058
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FC4B20BBA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA35156241;
	Mon, 26 Aug 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l6iJXWjC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316E153824
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673814; cv=none; b=j1y7OTdOYMMRwAoZs6wzGlmij6xAcuZekanOomAu2HS9e3t7oDQDZE+S8EtfYEzNyUQ+mbUj+1nJd/rmBfS9ZyqxWujSmpoaK3Ct8ZMzAtUUrH0b7OLJh1ucOCuTRvHg5IBmEEsMwrBq4yEE9a9jAEgRUcB+CXRSUczYT7lVG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673814; c=relaxed/simple;
	bh=snM5Rm0gMzlD08AvqsH0+c3YOt73h0syTAjhL8mg4zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgOkC/UepIMo6sWT62TRPzuCiN1/KQ7ex5PnhXkCS5XPE3m94Jiq2NlA/q2F3RS68Aall0lqCzoSFGuezBsvTSDZ02RI80iJcqruHlUOwYZAe4yj9+Iq+VgqxSrcjWPkx649uLlnIC2EarfLcL+UPnUqsBTsPUOsVNYUUZG1ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l6iJXWjC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 851603F327
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724673809;
	bh=ajfaokdeZHRMyKn6mvHqNgguJUu0Q4E54DToJ/+4STQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=l6iJXWjC15i57Dy0NGNJVULqcbC34v2Jx983q8ssp0iwHzcXrM9g5K5Yyj0vhvCVT
	 pZESuBQpya1mVE7PMbMkoG3pLXndp9TxLEQhT9lBAvNgzSUrhyPvSOQKyNz5IG5nlE
	 q2VYGWVoOqkrD2h0l4ItlXNCK1OkzjDpUSBbm+JsmCSXqXJeoH+3wxUR315B3Gw6xT
	 zY4VepLC3O9eqWFSvwnGKo9Za+C/519nsT4daXZZcztBlzO1Vs5JdSoB023MKwetcY
	 5K537UObarwAierriG9ZB4YqlOZSvHEX+lGsWCoTUMtD3drvD5bTv1q073IdIkrlGE
	 8LgMviDbDHYfQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d5dafe951eso4742042a91.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 05:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673808; x=1725278608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajfaokdeZHRMyKn6mvHqNgguJUu0Q4E54DToJ/+4STQ=;
        b=N94SUBNFt64L0bTz5/uZKrENr/EhyOG0WWHjUd8zRTdI+jKUA0aKH4GimfbC6xoZ8X
         Ons2tlfQyYEkSwfwHqNbSgV7l+NByO8mxV80APwLLSdsy0vmMpVitNCes3oW7LHJ9olz
         uhas4ZQf+uEkYcXj6AeNUu8c5UQOp7pZYNeO5/WvY5E/DJ5caRHdSzk9YkQ8XRp4b0eq
         vXntQqEFBmLetPv503VzPZ0IOF2qtjSmkL0BrrQOhUt9ycCyExvZEp9zt5ahrqyPXUe9
         OkK/g3GnGTbZ50AMDcvCSm0ZzFw4LPcGZO8RVf1HWg/NZU6m54uxuJes0YS1TO8MRsAA
         DN4A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/AE/rP36fnn/4eh18IFvQrDkgv5ZFn5PbMYFkI1rLdsnjhrUn8q78l7TZLFui2NM/4u3qPL5MyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwijIqEl7h2xswIoEToYWzaLsXK1veN8Y2kz44nTR3A/3W1Nwb/
	F1ZGioefTsTTCavgpKk9vCd1R0+7eZr1WQJzHif/l/5IQjHB/Q1q4pn34dlSS2pi+r0q7V/T7IO
	gIqtiYOmgNTvECqJlnN+PP1bnEHXd0FoeNimvXCRqeZaSpLXe6HZ7B7uLo00CxnWx/w5bBd99Zr
	2hekydsCql8WNdgUOJtp5YiRhSmYyCz/P9yt1tAdzXUA/oJZEEwDulvRrD
X-Received: by 2002:a17:90b:3144:b0:2d3:c8ed:f0be with SMTP id 98e67ed59e1d1-2d646d0ae37mr8318604a91.28.1724673807971;
        Mon, 26 Aug 2024 05:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxdSvdFt9fVbKAhweGqLpVEbbex/kMjEPiDlJ1rpZiXNZAj2f5L37oaVUXyQSovQsgnz8J0WOkVwo6b700X+g=
X-Received: by 2002:a17:90b:3144:b0:2d3:c8ed:f0be with SMTP id
 98e67ed59e1d1-2d646d0ae37mr8318575a91.28.1724673807557; Mon, 26 Aug 2024
 05:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712062411.35732-1-kai.heng.feng@canonical.com> <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
In-Reply-To: <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 26 Aug 2024 20:03:15 +0800
Message-ID: <CAAd53p5d6=m9MzC5pRS8HJSP54tiTxMBLR-Nd=fE2Tf2Sf+mpQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:28=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/12/2024 01:24, Kai-Heng Feng wrote:
> > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > connected.
> >
> > The following error message can be found during shutdown:
> > pcieport 0000:00:1d.0: AER: Correctable error message received from 000=
0:09:04.0
> > pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3DD=
ata Link Layer, (Receiver ID)
> > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:09:04.0:    [ 7] BadDLLP
> >
> > Calling aer_remove() during shutdown can quiesce the error message,
> > however the spurious wakeup still happens.
> >
> > The issue won't happen if the device is in D3 before system shutdown, s=
o
> > putting device to low power state before shutdown to solve the issue.
> >
> > I don't have a sniffer so this is purely guesswork, however I believe
> > putting device to low power state it's the right thing to do.
>
> KH,
>
> I did testing with your patch along with a few others, and found that it
> does the best job to put a majority of devices into a low power state
> properly.
>
> I have the details of what happens at S5 outlined on this Gist:
> https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c
>
> * KH column is this patch.
> * ML column is
> https://lore.kernel.org/linux-usb/43594a1c-c0dd-4ae1-b2c4-f5198e3fe951@am=
d.com/T/#m03d0b36f86fb4722009b24a8ee547011128db80b
> * FS column is 0fab972eef49 being applied again
>
> I also have power testing data from an OEM's system that shows that it
> improves things well enough that a previously failing energy star
> certification is now passing.

Thanks a lot for the testing.

Bjorn, do you think this patch is in good form to get included in next -rc1=
?

Kai-Heng

>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/pci/pci-driver.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index af2996d0d17f..4c6f66f3eb54 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev=
)
> >       if (drv && drv->shutdown)
> >               drv->shutdown(pci_dev);
> >
> > +     /*
> > +      * If driver already changed device's power state, it can mean th=
e
> > +      * wakeup setting is in place, or a workaround is used. Hence kee=
p it
> > +      * as is.
> > +      */
> > +     if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> > +             pci_prepare_to_sleep(pci_dev);
> > +
> >       /*
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
>

