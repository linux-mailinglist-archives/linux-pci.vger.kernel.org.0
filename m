Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB510393D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfKTL6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:58:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25918 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728933AbfKTL6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 06:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c18RNqeQqZJJjoZDe1IOCPHd07cYIVcsGN1k1gJQ+aE=;
        b=eCSwv20BNcQ6Xe1d+JzKSopeDJbMwbW0LjD+59dYWZU/uxj3jC1XfJtPcu2laIR/ZZadLs
        ah47gsFI5UTOu9i5w4RtD2DlB/BFkvjtWHNya3VQ5vwaTdOcQTyjNhpNobnEV00D9UHQeX
        dLWTIMZCNpinWEkK+bfjb6ZbFj5G9/M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-kclnspXUP1ioUwqZE4CkDA-1; Wed, 20 Nov 2019 06:58:12 -0500
Received: by mail-qt1-f199.google.com with SMTP id g5so16909987qtc.5
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2019 03:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOCL9BxQIaJyHhhqANHCxmzOITQkpYoVUEJdfnrVoo4=;
        b=PVfM9NFJDd5blfPVS4fmDqgGYq9o4bLD1YVZwMyCm8mslgUFtNuVq4a00jrpNic4pB
         9y0RU5atQy+D45w8pwM7FkjwgkpRqeO3AIaaQvTosveTTq6qd1uPkcCmAefUQAgA+XWQ
         zl+AaHUfClcy0yI9++p01X0FzP7WHgEQfP9hQoIrFUBEsVjaUb69Pgjtjyp9HYZBsxbq
         zwdcSESpItaMX1ElwBKVNqep3mwa0LoLAcCqRSVBcKj73Wc+l09uFqlZYiGCXdsV8IZC
         88kx/ImmUVeFBWHEQM4Je2taiIg2AzUPHhuifU5GfmJrQYd7WAV4YWExOTFdQf5hAjtF
         Lqkg==
X-Gm-Message-State: APjAAAXWwPj91UH1g7bPmbGjl9ZVdEg3ikii1R1/Q3az98rNtkX4mx29
        46I5lR2K/dVrb+ti99/WXZ/GFx5y6QTxDKFIxoZCWQ31jWPnH86UZdrcu87FfKmBooHhvYrsxIO
        319SQf4rOfS3PNc40M2jppJNvYJUWfEuTVAw1
X-Received: by 2002:a37:9083:: with SMTP id s125mr1985627qkd.192.1574251092232;
        Wed, 20 Nov 2019 03:58:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwy18wz9I0hHOUfu1VGn3VlV3VWdU/sUqh2ltG6Y8Qd1I8OiMvt6Zowg+9iEuB6F1yoevUNI56w5XarEZdsbSI=
X-Received: by 2002:a37:9083:: with SMTP id s125mr1985616qkd.192.1574251091976;
 Wed, 20 Nov 2019 03:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
In-Reply-To: <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 12:58:00 +0100
Message-ID: <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: kclnspXUP1ioUwqZE4CkDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

overall, what I really want to know is, _why_ does it work on windows?
Or what are we doing differently on Linux so that it doesn't work? If
anybody has any idea on how we could dig into this and figure it out
on this level, this would probably allow us to get closer to the root
cause? no?

On Wed, Nov 20, 2019 at 12:54 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> for newer Windows the firmware uses bit  0x80 on 0x248 (Q0L2 being the
> field name) on the bridge controller to turn of the device, on other
> versions it uses the "older"? 0xb0 register and the P0LD field, which
> is documented, where the former is not.
>
> On Wed, Nov 20, 2019 at 12:51 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 01:22:16PM +0200, Mika Westerberg wrote:
> > >             If (((OSYS <=3D 0x07D9) || ((OSYS =3D=3D 0x07DF) && (_REV=
 =3D=3D
> > >                 0x05))))
> > >             {
> >
> > The OSYS comes from this (in DSDT):
> >
> >                 If (_OSI ("Windows 2009"))
> >                 {
> >                     OSYS =3D 0x07D9
> >                 }
> >
> >                 If (_OSI ("Windows 2012"))
> >                 {
> >                     OSYS =3D 0x07DC
> >                 }
> >
> >                 If (_OSI ("Windows 2013"))
> >                 {
> >                     OSYS =3D 0x07DD
> >                 }
> >
> >                 If (_OSI ("Windows 2015"))
> >                 {
> >                     OSYS =3D 0x07DF
> >                 }
> >
> > So I guess this particular check tries to identify Windows 7 and older,
> > and Linux.
> >
> > >                 If ((PIOF =3D=3D Zero))
> > >                 {
> > >                     P0LD =3D One
> > >                     TCNT =3D Zero
> > >                     While ((TCNT < LDLY))
> > >                     {
> > >                         If ((P0LT =3D=3D 0x08))
> > >                         {
> > >                             Break
> > >                         }
> > >
> > >                         Sleep (0x10)
> > >                         TCNT +=3D 0x10
> > >                     }
> > >
> > >                     P0RM =3D One
> > >                     P0AP =3D 0x03
> > >                 }
> > >                 ElseIf ((PIOF =3D=3D One))
> > >                 {
> > >                     P1LD =3D One
> > >                     TCNT =3D Zero
> > >                     While ((TCNT < LDLY))
> > >                     {
> > >                         If ((P1LT =3D=3D 0x08))
> > >                         {
> > >                             Break
> > >                         }
> > >
> > >                         Sleep (0x10)
> > >                         TCNT +=3D 0x10
> > >                     }
> > >
> > >                     P1RM =3D One
> > >                     P1AP =3D 0x03
> > >                 }
> > >                 ElseIf ((PIOF =3D=3D 0x02))
> > >                 {
> > >                     P2LD =3D One
> > >                     TCNT =3D Zero
> > >                     While ((TCNT < LDLY))
> > >                     {
> > >                         If ((P2LT =3D=3D 0x08))
> > >                         {
> > >                             Break
> > >                         }
> > >
> > >                         Sleep (0x10)
> > >                         TCNT +=3D 0x10
> > >                     }
> > >
> > >                     P2RM =3D One
> > >                     P2AP =3D 0x03
> > >                 }
> > >
> > >                 If ((PBGE !=3D Zero))
> > >                 {
> > >                     If (SBDL (PIOF))
> > >                     {
> > >                         MBDL =3D GMXB (PIOF)
> > >                         PDUB (PIOF, MBDL)
> > >                     }
> > >                 }
> > >             }
> > >             Else
> > >             {
> > >                 LKDS (PIOF)
> > >             }
> > >
> > >             If ((DerefOf (SCLK [Zero]) !=3D Zero))
> > >             {
> > >                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
> > >                 Sleep (0x10)
> > >             }
> > >
> > >             GPPR (PIOF, Zero)
> > >             If ((OSYS !=3D 0x07D9))
> > >             {
> > >                 DIWK (PIOF)
> > >             }
> > >
> > >             \_SB.SGOV (0x01010004, Zero)
> > >             Sleep (0x14)
> > >             Return (Zero)
> > >         }
> >

