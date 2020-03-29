Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C141970B8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 00:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgC2WLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 18:11:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39613 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2WLl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2020 18:11:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so18516099edf.6
        for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2020 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NZFfHk6gT7pbNgaqUN9K1aRpMgR9fhh8o/yCxCDvWbA=;
        b=P30c2j2MhABBV5IAU6K/pXB4aW1QY4ywCgnSRI8lNdZhU4L2B/Ht+zUNgpPqknRryC
         qnarGLoLhIJp6O3y/pIM/hEloxN392jdFpY5dqLt10sEnF7sNfrv9dNaY1TTCtIcGuM8
         yew4Kg7965kXgGwhnIStQUJ3LjaYB1A33kmZT5sEysxOlhdMrRPWvBEBhkTOQsqdhy0L
         JbiOYL/01tNw/CYJ5BZYmrphu8xbx6YJB/kPD9h3KicyMtSJCavxmVFb4AbDFe/dUoTo
         TbrGw76lwO6x0zPvhprGXpSj6lSHeZGAy1d68xBeVHTzoU0T/NwXm75esQ5UmWUUzrCG
         KNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NZFfHk6gT7pbNgaqUN9K1aRpMgR9fhh8o/yCxCDvWbA=;
        b=tdV9x700Srtaqw/IiiiKcNDoQjdgLKQCLA+jHy1LxS8mWQeoFQCEsJ47kuA+KnsYuH
         cXvkX0Vlnus1HIzJDuqWPSprpiU5Dw0WyZsZZHaBHd9liQn3JIaObRM14P44BEVr0f67
         +bg+ShubhvFTWKIBn+ZVNnwF5BTCERPOJMqhrTbzbYEzOJbYZFo38VeNskl6pwhkGUEX
         BcIrSkNaMX5d99+pFfOHL+weXnSm8VkXmp9IP9TXvld8LnPGo4BuQskWVt2SZZaL/Efd
         ypuYJMrv75DL14xG8Le5FKIJjzSKmUoQ2+Nd5Dh2aiAl03NThJdTnBHr8iwRBLlUPYUP
         T8RA==
X-Gm-Message-State: ANhLgQ1dE7rKV4qnAmVTcp2rSe3937Zfb6X/bVQp/ICuewj+GVEQoQd1
        DqaBm22VQfJ2nyjhdloeiWHU/xFgC/f9vYNcnjQ=
X-Google-Smtp-Source: ADFU+vufk7CGyuSb00rdAi9fpknRfYQUmlTVjTocixMnxhJOy2BYMZI3vHty4vLbVOXDX1c4aHpqh1BJCHxolS3kn1M=
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr5125433edu.264.1585519899799;
 Sun, 29 Mar 2020 15:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
 <20200307213853.GA208095@google.com> <PSXP216MB04382D268822AD1C3D9A57C780E10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CAEzXK1o27oUXFYydcvRb2oOV4Q7AF2zef=AsnH9ks5eQ30Qk8w@mail.gmail.com> <CAEzXK1oPME9-PiA5uv9+6NjfwsBP8DKnOGtEpk5Sg+RbVW3xrA@mail.gmail.com>
In-Reply-To: <CAEzXK1oPME9-PiA5uv9+6NjfwsBP8DKnOGtEpk5Sg+RbVW3xrA@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sun, 29 Mar 2020 23:11:28 +0100
Message-ID: <CAEzXK1pFFEw+FdAyC6=yxkk5cXMJkVxxkxMiHrB6sH7pwGMkFQ@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas, Bjorn,

I was able to make the apex driver work on a X86_64 system with the
Coral Edge TPU PCIe device.
So, now the PCI enumeration problem is now clearly an ARM and ARM64
platform issue. What are the recommended steps for debugging this? I
hava a JTAG interface and openOCD supported configuration for it.

On X86_64 the PCI device did enumerate properly, but the driver would
fail to load due to a bug. That is now fixed and it did run a couple
of examples, on X86_64 only, after applying  a patch that I submitted
to the Gasket driver maintainers:
Fix incongruency in handling of sysfs entries creation.
This issue could cause invalid memory accesses, by not properly
detecting the end of the sysfs attributes array.

Signed-off-by: Luis Mendes <luis.p.mendes@gmail.com>
---

 gasket_sysfs.c |    3 +--
 gasket_sysfs.h |    4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

Kind Regards,
Lu=C3=ADs

> On Mon, Mar 9, 2020 at 11:21 AM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com=
> wrote:
> >
> > Hi Nicholas,
> >
> > Thanks for your help.
> > Replies follow below.
> >
> > Kind Regards,
> > Lu=C3=ADs
> >
> > On Sun, Mar 8, 2020 at 5:51 AM Nicholas Johnson
> > <nicholas.johnson-opensource@outlook.com.au> wrote:
> > >
> > > Hi,
> > > > > On Sat, Mar 7, 2020 at 12:11 PM Lu=C3=ADs Mendes <luis.p.mendes@g=
mail.com> wrote:
> > > > > > This issue seems to happen only with the Coral Edge TPU device,=
 but it
> > > > > > happens independently of whether the gasket/apex driver module =
is
> > > > > > loaded or not. The BAR 0 of the Coral device is not assigned ei=
ther
> > > > > > way.
> > > > > >
> > > > > > Lu=C3=ADs
> > >
> > > So the problem only occurs with the Coral Edge TPU device, so there i=
s a
> > > possibility that it is not a problem with the platform, or something
> > > caused by the combination of the TPU and platform. Is it possible to =
put
> > > the TPU into an X86 system with the same kernel version(s) to add mor=
e
> > > evidence to this theory? If it works on X86 then we can focus on the
> > > differences between X86 and ARM.
> >
> > I've tested two Coral TPUs on two x86_64 platforms and the BARs seem
> > to be assigned, however the driver fails to load, during probe and the
> > system is unable to shutdown cleanly, but I think that is a driver
> > issue when setting up sysfs entries. I can blacklist gasket/apex, if
> > it helps in some way, or try an older kernel.
> > Dmesg log for one of the x86_64 system is here:
> > https://pastebin.ubuntu.com/p/FHhHNN6XTF/
> > lspci -vvv for the same x86_64 system is here:
> > https://pastebin.ubuntu.com/p/xbSNWFQ9TS/
> >
> > >
> > > Also, please revert c13704f5685d "PCI: Avoid double hpmemsize MMIO
> > > window assignment" or try with Linux v5.4 which does not have this
> > > commit, just to rule out the possibility of it causing issues. This
> > > patch helps me and also solved the problem of one other person using =
an
> > > ARM computer who came to us regarding a problem. However, it could al=
so
> > > adversely affect unknown use cases - it is impossible to completely r=
ule
> > > out, due to the nature of how drivers/pci/setup-bus.c is written.
> >
> > On armhf with 5.4.14 the problem remains, BAR 0 and BAR 2 are not
> > assigned: https://pastebin.ubuntu.com/p/9H2qqqMNJN/
> > I've also tried kernel 4.20.11 and the problem also exists.
> > I've got JTAG on this system with OpenOCD. I believe I can debug the
> > kernel, if needed.
> >
> > >
> > > Kind regards,
> > > Nicholas
