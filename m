Return-Path: <linux-pci+bounces-23106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED030A56661
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107437A3214
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412E215770;
	Fri,  7 Mar 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="IdZODf7G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796162153FD
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346106; cv=none; b=H6rPs0iZwFiF6Eb/tycQytY6i0suQfH2IEhtsRac7t1F7IzbeUIFEk240fLfQ2+SW42BHMhcoBF2Kp/h6hb4F7lz4bE5XWIumy2WaB+DoEJogdEGgF7GNMzCSkTmYYycdu1MPFty04YNWku6inWSayTtUP+D+bGn5jTxGQoAGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346106; c=relaxed/simple;
	bh=4aHTqTb3gvUXo1ipWkNtDafN8wc8cFuNXI+OHO3nDMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiPTOf+XjCD/cYtSNMhIPVrUmYhJyqQMw6UFUnDEqapsEtFHVdwYSYgDOJfLLqSFp0xgne/VJm0tpcrxLBTBTZ9RsqJaTUUNlw0jrLPO0yRtMT+ryep1xxGrqG6XoPIB0aUP6o3amWTIP3sL3is3KFW/9HrEzKEijyJlhchmXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=IdZODf7G; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f68c8083c0so960630b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1741346103; x=1741950903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC+mRq0zftwvLnH56/1dj9mNI5kr+QrZy3+JWI7HWko=;
        b=IdZODf7Gw3ZkZwrJIahyDKJ0hXVJBKk62HKEwu1Oz5GN0MZP0GnbHNtsic2VIyXZ9G
         QmDFHUKb6lLGmIk2d9PLwr+xJ3WlCbyc+y9SMZ8datZ+w1btqYkRFmpaTi80CIf3Z8DG
         WuV8Y48aU781SSj2jXsxclKAUT6wd376F7DJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346103; x=1741950903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC+mRq0zftwvLnH56/1dj9mNI5kr+QrZy3+JWI7HWko=;
        b=gJb0wtw3t6sOX5IzY3oBBn3YM0OALxVK5SPfD403WA2GFuxVnaKDyO9fQrEGuhpki0
         4i1LXbtpAJlGkpGgAWM5KHDqCljfWRLfMmA0G8RtbCdFZBIcxgJxjutQEUoBhRMW1VhG
         VSkfoWarfgyBSjgmeb2E9JetOHRVxb29dpgTtUBS5/LlCnFKbAgU94FIsE3gEd6G15er
         fiRZdozLukcRcfVZt6tGt4GRCScguRkn8eM6xwlsoK9vsA3qj/ZHcqbmwbO+/dYfnwtI
         7EEugXOUeuzEjaAD8bYEZEu18WyfOzNOIDHM3T1w2vc7PiPOuKb9HxniJm4dMTmk0l7R
         koLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFRILHQWHsHovj4dzTr/FQCcoz+skR7tnGp4SfG79gpVT395xWX3UHIkNdjwcsy8GicFS5RYQFcZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA8yCjc2DklIGLfSyAaxnB0KvKt9f8WoszTRHfRX05ROdBxtng
	FFu7TB2MVLrxr+v8Nnb8xxipTOpxW0LmJfK3zJJHxU6BCKB6AuKMuigyajPsD5vTb1rTEG1cy/Z
	PI36MyJUhhV4Xcig4Wfvhj3Ors4VfWYuTUkBC5Q==
X-Gm-Gg: ASbGncuayiOqrUnEcOGf9ATLld29YU3FTC7OGN0yp+yekwjZj+pkQ9SWeyufDv+7n4w
	ADoTaEt0bHewaq4kGSG3e2lmi1oM86sC624lQLldvPcqu2TLert+s2moZtyf5kQpcprdGTMPVC7
	TJKmrp8fEOW2N79A930meF1SrcZw==
X-Google-Smtp-Source: AGHT+IHS+8sjc5YG92F0jPHMOtSWgd5xfM0ddbwObbq034Q1F2GLBGE1S1EJ2zlSWt+Q5PT+yX0vy3cVNnVd7DpetaE=
X-Received: by 2002:a05:6808:2201:b0:3f6:6d32:bdb4 with SMTP id
 5614622812f47-3f697bcd23fmr1526628b6e.24.1741346103371; Fri, 07 Mar 2025
 03:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225140400.23992-1-frediano.ziglio@cloud.com>
 <20250227145016.25350-1-frediano.ziglio@cloud.com> <a14c6897-075c-4b2c-8906-75eb96d5c430@citrix.com>
 <Z8GuItUuhbF1UZ9V@macbook.local>
In-Reply-To: <Z8GuItUuhbF1UZ9V@macbook.local>
From: Frediano Ziglio <frediano.ziglio@cloud.com>
Date: Fri, 7 Mar 2025 11:14:52 +0000
X-Gm-Features: AQ5f1JprH-QX_1EZaSQq9Kv8z1dnQxxStGxVbnOaCg1A07TCPjKd2tyHe_b2rh0
Message-ID: <CACHz=ZjurD-dvVOnOCJv4q02UV4iy78J5hJ8rMh1UPAZBbfaXQ@mail.gmail.com>
Subject: Re: [PATCH v2] xen: Add support for XenServer 6.1 platform device
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
   after all discussions on this thread and Xen-devel, can we agree
that this patch is good as it is and can be merged upstream?
Just to make it clear, it was already acked.

Regards,
   Frediano

On Fri, Feb 28, 2025 at 12:37=E2=80=AFPM Roger Pau Monn=C3=A9 <roger.pau@ci=
trix.com> wrote:
>
> On Thu, Feb 27, 2025 at 03:41:54PM +0000, Andrew Cooper wrote:
> > On 27/02/2025 2:50 pm, Frediano Ziglio wrote:
> > > On XenServer on Windows machine a platform device with ID 2 instead o=
f
> > > 1 is used.
> > >
> > > This device is mainly identical to device 1 but due to some Windows
> > > update behaviour it was decided to use a device with a different ID.
> > >
> > > This causes compatibility issues with Linux which expects, if Xen
> > > is detected, to find a Xen platform device (5853:0001) otherwise code
> > > will crash due to some missing initialization (specifically grant
> > > tables). Specifically from dmesg
> > >
> > >     RIP: 0010:gnttab_expand+0x29/0x210
> > >     Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89=
 fd
> > >           41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49=
 02
> > >           <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff =
ff
> > >           44 39
> > >     RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
>
> I think the back trace might be more helpful here rather than the raw
> code?
>
> Not sure if it helps, but there's a document in upstream Xen
> repository that lists the IDs:
>
> https://xenbits.xen.org/docs/unstable/man/xen-pci-device-reservations.7.h=
tml
>
> It would be good to record the information you have gathered about the
> different devices somewhere.  Maybe xen-pci-device-reservations would
> be a good place to list the intended usage of those device IDs, as
> right now it just lists the allocated ranges, but no information about
> what's the purpose of each device.
>
> > >     ...
> > >
> > > The device 2 is presented by Xapi adding device specification to
> > > Qemu command line.
> > >
> > > Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
> >
> > I'm split about this.  It's just papering over the bugs that exist
> > elsewhere in the Xen initialisation code.
> >
> > But, if we're going to take this approach, then 0xc000 needs adding too=
,
> > which is the other device ID you might find when trying to boot Linux i=
n
> > a VM configured using a Windows template.
>
> Won't adding 0xc000 cause issues?  As then the xenpci driver will bind
> to two devices on the same system (either 0001 or 0002, and
> additionally c000).  As it's my understanding that the device with ID
> c000 will be present in conjunction with either a device with ID 0001
> or 0002.
>
> Thanks, Roger.

