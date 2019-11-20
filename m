Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B316310392F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfKTLzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:55:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbfKTLzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 06:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574250900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ/suR9lwab8Vmoit+8fApDfagM+XQzhiSMoLQs89Ks=;
        b=bDrINodHA2FpSa8kl4p7gXqIl7p7yKfsSIBpLDpyE/LpSTwY3hxJIqL82YPm+7epuAgQZ2
        SWOtAHrcpREaYWAx2fq9busyZs9IT+doS/faRIW7J26rtKF3bUIrRs4r4d9sY8+KR1s3kL
        JHS3QfkRZuxxkqPL0+7xb6YqmvlNgtA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-wqH9Iw99OFmZt2LLFk_A5Q-1; Wed, 20 Nov 2019 06:54:59 -0500
Received: by mail-qk1-f199.google.com with SMTP id p68so15692884qkf.9
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXFyh8kBLvmSj4EaxcIf64KvYzB8eENY53AuUwLsMY8=;
        b=Z1anC9AWpHM8+H5MlcyGSkollps7TAapQ1VjLDoggfwD6mED878Wfslpu3A9DZuTX9
         d4MfOQLDx0UDF1CiQFZbJxEovxXXGhdei8g8iNeGyqAHr+QVRS6onINbWTkiPKzBuWHW
         r9Icrgh5l/cnIllRBqXuiWynhhJWHGbtYqKkzCJjwhIVP2gDXEUmZCHgC/rjaZrUZgH9
         zY9IZ5zHHhUmkdqUFjYjcYSdTTRmwO6XfmZru6E8bf2byA8s0DDXxB3wGzO796C78ZlQ
         NHd99gHFyLwjpCo74B8u0cWzXny47WXqM5h6TO8rxPcIN6JDqiCmLv5Eb3+CBemTftHm
         6FMA==
X-Gm-Message-State: APjAAAU7ytDMJ0p8xyX5N4Qes7GqQV8+sFFRu6I6NZyiVtOJIekKiG7Z
        YjHd5rBDe7iakvJRmipNurI67gLWV4MU4/Dm0JHkY09pqoA/yYxE0gUsLN/YmjlausOAYwDiTu6
        YSVfyQ6GuAYCs6MhnVl6+oj2KEFSVgI5nBtYd
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147337qtc.254.1574250899268;
        Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgzPbhFAy1Wx/TLioNWRRw8v7Dky3juARvT+xkh08MnU9EQEHgjj6TnBsmHsTkQgM/Z6Vs1zzOXcqygfmJowM=
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147324qtc.254.1574250899096;
 Wed, 20 Nov 2019 03:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
In-Reply-To: <20191120115127.GD11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 12:54:48 +0100
Message-ID: <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
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
X-MC-Unique: wqH9Iw99OFmZt2LLFk_A5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

for newer Windows the firmware uses bit  0x80 on 0x248 (Q0L2 being the
field name) on the bridge controller to turn of the device, on other
versions it uses the "older"? 0xb0 register and the P0LD field, which
is documented, where the former is not.

On Wed, Nov 20, 2019 at 12:51 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 01:22:16PM +0200, Mika Westerberg wrote:
> >             If (((OSYS <=3D 0x07D9) || ((OSYS =3D=3D 0x07DF) && (_REV =
=3D=3D
> >                 0x05))))
> >             {
>
> The OSYS comes from this (in DSDT):
>
>                 If (_OSI ("Windows 2009"))
>                 {
>                     OSYS =3D 0x07D9
>                 }
>
>                 If (_OSI ("Windows 2012"))
>                 {
>                     OSYS =3D 0x07DC
>                 }
>
>                 If (_OSI ("Windows 2013"))
>                 {
>                     OSYS =3D 0x07DD
>                 }
>
>                 If (_OSI ("Windows 2015"))
>                 {
>                     OSYS =3D 0x07DF
>                 }
>
> So I guess this particular check tries to identify Windows 7 and older,
> and Linux.
>
> >                 If ((PIOF =3D=3D Zero))
> >                 {
> >                     P0LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P0LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P0RM =3D One
> >                     P0AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D One))
> >                 {
> >                     P1LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P1LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P1RM =3D One
> >                     P1AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D 0x02))
> >                 {
> >                     P2LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P2LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P2RM =3D One
> >                     P2AP =3D 0x03
> >                 }
> >
> >                 If ((PBGE !=3D Zero))
> >                 {
> >                     If (SBDL (PIOF))
> >                     {
> >                         MBDL =3D GMXB (PIOF)
> >                         PDUB (PIOF, MBDL)
> >                     }
> >                 }
> >             }
> >             Else
> >             {
> >                 LKDS (PIOF)
> >             }
> >
> >             If ((DerefOf (SCLK [Zero]) !=3D Zero))
> >             {
> >                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
> >                 Sleep (0x10)
> >             }
> >
> >             GPPR (PIOF, Zero)
> >             If ((OSYS !=3D 0x07D9))
> >             {
> >                 DIWK (PIOF)
> >             }
> >
> >             \_SB.SGOV (0x01010004, Zero)
> >             Sleep (0x14)
> >             Return (Zero)
> >         }
>

