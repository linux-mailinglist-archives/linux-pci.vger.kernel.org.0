Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1405A274D54
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 01:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIVX3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVX3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 19:29:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A963C061755
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 16:29:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so17139232qtu.4
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 16:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8JX6sdt70XHzG6VzFVi89aKc0FqFg6B8FNeUHFk3hU=;
        b=rsB0HiBn1lYhqWUSkPvoY+BSETezvNCrkOIsRm9CnvsxjGRMG5wh4rVjL5JUD1f1cr
         91laBZzJQov8DK2HGzQELiTgz4pSpFYojJHW4Kut8YuaERGZPSlvt8xVIR0itz62Wv8O
         udX153ObakIkfdUyD5dO8yYyH2/21of3ei+4z1sJwu/AQd/fTcqbrHqIN6LZhiM/685l
         Z3swAfwO4l7tFbcfF1yqAt0A3E+8PyTJYWpVaqNTo6J3BrwDkcOeMiDPPVP2GX1x/+Dg
         XDAPRxjCC4ZeMCqGWZVRtm3PYgKa2puLNnFDPuVHdIHHr/rvX37zfZLToVUkl8tACa36
         JM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8JX6sdt70XHzG6VzFVi89aKc0FqFg6B8FNeUHFk3hU=;
        b=hVItXIktfBMh6nUfuMVwEgzi0nJRzL/0d8Zd36eNdjMI4g1RrfVa+TCBGX4fOT/5Os
         1IvPxUI4mYbxoqfmm66An+dFJLVLYeHWQaBYMoxmAKHwuwW/MO8h6u5pPIDOOnLYtEwV
         ND41d+cKG/keQoSQ4oHgNJ94oYc5XAmQ5TwwSdtNMjq+NQ2XbpVC1buYPNzdznHJP0sH
         QhkfI7MAkxITRBPR0jYm1yQVHkbSiF9v+xPDX/VejbnzPZeiluIHU9q/wXPnW16x3d6U
         hENOAyckUrDnHqoqsOME8rDcZQODXnGyDGrTgeUHQ9CAvtZ4cyKOF2USDYUa/HB3ztN6
         2sFg==
X-Gm-Message-State: AOAM532AcDyMVi7Ls9U1xUxrH3GN9haWZO34petl+oY77NN45hzszrwq
        SWGj3AHrxZdoI4mkElkuVZGHvcaDIV02+94wm4w=
X-Google-Smtp-Source: ABdhPJzanIcZ1eQfFXd+BNB06ROFqYVkJuHTMXPdffIrLD75WdLQ1lS1BPkHPBEBdTBlBLRYKWjmVJftKB1T6RGGuJY=
X-Received: by 2002:ac8:7c90:: with SMTP id y16mr7099658qtv.45.1600817369192;
 Tue, 22 Sep 2020 16:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvk_MqYKWBo3pHP+Z2sWyODuxS7Ni2DHfLikq6fJJ6g3Q@mail.gmail.com>
 <20200922230031.GA2230332@bjorn-Precision-5520>
In-Reply-To: <20200922230031.GA2230332@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 23 Sep 2020 01:29:18 +0200
Message-ID: <CAA85sZs5f09uh+eCcZ+2Mh4Hj=GVVncZjyGR8Ru3vBQ3Z-_nNA@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alexander]
>
> On Tue, Sep 22, 2020 at 11:02:35PM +0200, Ian Kumlien wrote:
> > On Tue, Sep 22, 2020 at 10:19 PM Bjorn Helgaas <helgaas@kernel.org> wro=
te:
> > > On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
>
> > > > @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pc=
i_dev *endpoint)
> > > >                * L1 exit latencies advertised by a device include L=
1
> > > >                * substate latencies (and hence do not do any check)=
.
> > > >                */
> > > > -             latency =3D max_t(u32, link->latency_up.l1, link->lat=
ency_dw.l1);
> > > > -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> > > > -                 (latency + l1_switch_latency > acceptable->l1))
> > > > -                     link->aspm_capable &=3D ~ASPM_STATE_L1;
> > > > -             l1_switch_latency +=3D 1000;
> > > > +             if (link->aspm_capable & ASPM_STATE_L1) {
> > > > +                     latency =3D max_t(u32, link->latency_up.l1, l=
ink->latency_dw.l1);
> > > > +                     l1_max_latency =3D max_t(u32, latency, l1_max=
_latency);
> > > > +                     if (l1_max_latency + l1_switch_latency > acce=
ptable->l1)
> > > > +                             link->aspm_capable &=3D ~ASPM_STATE_L=
1;
> > > > +
> > > > +                     l1_switch_latency +=3D 1000;
> > > > +             }
> > >
> > > This accumulates the 1 usec delays for a Switch to propagate the exit
> > > transition from its Downstream Port to its Upstream Port, but it
> > > doesn't accumulate the L1 exit latencies themselves for the entire
> > > path, does it?  I.e., we don't accumulate "latency" for the whole
> > > path.  Don't we need that?
> >
> > Not for L1's apparently, from what I gather the maximum link latency
> > is "largest latency" + 1us * number-of-hops
> >
> > Ie, just like the comment above states - the L1 total time might be
> > more but  1us is all that is needed to "start" and that propagates
> > over the link.
>
> Ah, you're right!  I don't think this is clear from the existing code
> comment, but it *is* clear from the example in sec 5.4.1.2.2 (Figure
> 5-8) of the spec.
>
> > @@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
> > pci_dev *endpoint)
> >
> >         while (link) {
> >                 /* Check upstream direction L0s latency */
> > -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > -                   (link->latency_up.l0s > acceptable->l0s))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> > +               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > +                       l0s_latency_up +=3D link->latency_up.l0s;
>
> It's pretty clear from sec 5.4.1.2.2 that we *don't* need to
> accumulate the L1 exit latencies.  Unfortunately sec 5.4.1.1.2 about
> L0s exit doesn't have such a nice example.
>
> The L0s *language* is similar though:
>
>   5.4.1.1.2: If the Upstream component is a Switch (i.e., it is not
>   the Root Complex), then it must initiate a transition on its
>   Upstream Port Transmit Lanes (if the Upstream Port's Transmit Lanes
>   are in a low-power state) as soon as it detects an exit from L0s on
>   any of its Downstream Ports.

"it detects an exit"

>   5.4.1.2.1: A Switch is required to initiate an L1 exit transition on
>   its Upstream Port Link after no more than 1 =CE=BCs from the beginning =
of
>   an L1 exit transition on any of its Downstream Port Links.  during
>   L1 exit.

vs "from the beginning of"

So to me, this looks like edge triggering - only sense i could make of
it would be cumulative

(you should also note that i have no L0s issues, but I suspect that
the code is wrong currently)

> So a switch must start upstream L0s exit "as soon as" it sees L0s exit
> on any downstream port, while it must start L1 exit "no more than 1 =CE=
=BCs"
> after seeing an L1 exit.
>
> And I really can't tell from the spec whether we need to accumulate
> the L0s exit latencies or not.  Maybe somebody can clarify this.
>
> > commit db3d9c4baf4ab177d87b5cd41f624f5901e7390f
> > Author: Ian Kumlien <ian.kumlien@gmail.com>
> > Date:   Sun Jul 26 16:01:15 2020 +0200
> >
> >     Use maximum latency when determining L1 ASPM
> >
> >     If it's not, we clear the link for the path that had too large late=
ncy.
> >
> >     Currently we check the maximum latency of upstream and downstream
> >     per link, not the maximum for the path
> >
> >     This would work if all links have the same latency, but:
> >     endpoint -> c -> b -> a -> root  (in the order we walk the path)
> >
> >     If c or b has the higest latency, it will not register
> >
> >     Fix this by maintaining the maximum latency value for the path
> >
> >     See this bugzilla for more information:
> >     https://bugzilla.kernel.org/show_bug.cgi?id=3D208741
> >
> >     This fixes an issue for me where my desktops machines maximum bandw=
idth
> >     for remote connections dropped from 933 MBit to ~40 MBit.
> >
> >     The bug became obvious once we enabled ASPM on all links:
> >     66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Br=
idges)
>
> I can't connect the dots here yet.  I don't see a PCIe-to-PCI/PCI-X
> bridge in your lspci, so I can't figure out why this commit would make
> a difference for you.
>
> IIUC, the problem device is 03:00.0, the Intel I211 NIC.  Here's the
> path to it:
>
>   00:01.2 Root Port              to [bus 01-07]
>   01:00.0 Switch Upstream Port   to [bus 02-07]
>   02:03.0 Switch Downstream Port to [bus 03]
>   03:00.0 Endpoint (Intel I211 NIC)
>
> And I think this is the relevant info:
>
>                                                     LnkCtl    LnkCtl
>            ------DevCap-------  ----LnkCap-------  -Before-  -After--
>   00:01.2                                L1 <32us       L1+       L1-
>   01:00.0                                L1 <32us       L1+       L1-
>   02:03.0                                L1 <32us       L1+       L1+
>   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
>
> The NIC says it can tolerate at most 512ns of L0s exit latency and at
> most 64us of L1 exit latency.
>
> 02:03.0 doesn't support L0s, and the NIC itself can't exit L0s that
> fast anyway (it can only do <2us), so L0s should be out of the picture
> completely.
>
> Before your patch, apparently we (or BIOS) enabled L1 on the link from
> 00:01.2 to 01:00.0, and partially enabled it on the link from 02:03.0
> to 03:00.0.

According to the spec, this is managed by the OS - which was the
change introduced...

> It looks like we *should* be able to enable L1 on both links since the
> exit latency should be <33us (first link starts exit at T=3D0, completes
> by T=3D32; second link starts exit at T=3D1, completes by T=3D33), and
> 03:00.0 can tolerate up to 64us.
>
> I guess the effect of your patch is to disable L1 on the 00:01.2 -
> 01:00.0 link?  And that makes the NIC work better?  I am obviously
> missing something because I don't understand why the patch does that
> or why it works better.

It makes it work like normal again, like if i disable ASPM on the nic itsel=
f...

I don't know which value that reflects, up or down - since we do max
of both values and
it actually disables ASPM.

What we can see is that the first device that passes the threshold is 01:00=
.0

How can I read more data from PCIe without needing to add kprint...

This is what lspci uses apparently:
#define  PCI_EXP_LNKCAP_L0S     0x07000 /* L0s Exit Latency */
#define  PCI_EXP_LNKCAP_L1      0x38000 /* L1 Exit Latency */

But which latencies are those? up or down?

> I added Alexander to cc since it sounds like he's helped debug this,
> too.
>
> >     Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 253c30cc1967..893b37669087 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -       u32 latency, l1_switch_latency =3D 0;
> > +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> >         struct aspm_latency *acceptable;
> >         struct pcie_link_state *link;
> >
> > @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct
> > pci_dev *endpoint)
> >                 if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> >                     (link->latency_dw.l0s > acceptable->l0s))
> >                         link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > +
> >                 /*
> >                  * Check L1 latency.
> > -                * Every switch on the path to root complex need 1
> > -                * more microsecond for L1. Spec doesn't mention L0s.
> > +                *
> > +                * PCIe r5.0, sec 5.4.1.2.2 states:
> > +                * A Switch is required to initiate an L1 exit transiti=
on on its
> > +                * Upstream Port Link after no more than 1 =CE=BCs from=
 the
> > beginning of an
> > +                * L1 exit transition on any of its Downstream Port Lin=
ks.
> >                  *
> >                  * The exit latencies for L1 substates are not advertis=
ed
> >                  * by a device.  Since the spec also doesn't mention a =
way
> > @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct
> > pci_dev *endpoint)
> >                  * L1 exit latencies advertised by a device include L1
> >                  * substate latencies (and hence do not do any check).
> >                  */
> > -               latency =3D max_t(u32, link->latency_up.l1, link->laten=
cy_dw.l1);
> > -               if ((link->aspm_capable & ASPM_STATE_L1) &&
> > -                   (latency + l1_switch_latency > acceptable->l1))
> > -                       link->aspm_capable &=3D ~ASPM_STATE_L1;
> > -               l1_switch_latency +=3D 1000;
> > +               if (link->aspm_capable & ASPM_STATE_L1) {
> > +                       latency =3D max_t(u32, link->latency_up.l1,
> > link->latency_dw.l1);
> > +                       l1_max_latency =3D max_t(u32, latency, l1_max_l=
atency);
> > +                       if (l1_max_latency + l1_switch_latency > accept=
able->l1)
> > +                               link->aspm_capable &=3D ~ASPM_STATE_L1;
> > +
> > +                       l1_switch_latency +=3D 1000;
> > +               }
> >
> >                 link =3D link->parent;
> >         }
> > ----------------------
