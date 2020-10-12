Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080A628B21B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgJLKUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJLKUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 06:20:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A56C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 03:20:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x20so10234354qkn.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7n+0r5q0Qz+hXEw9G55GjZMD41pxEKPsDPT1IobZLXE=;
        b=pvrSYSDgwzywQ06X/8ldJK2OQo8PFLKK0EeqYVbNMCVNE/5uOz+Y8pjBzD+Z4PF8HO
         +0M7l9c7p8AcTpT/j8iYZwG03I3pZWIJutPIJ4ZQHqTZ2kT/wCLPiU2h/Cp6wgJn1SCo
         B+WeoYROwL2zf1uuECklj2824QaG3mzp8KMiNaYhk+b5ggt9EwgW3EdVcOqkLDMdJz0S
         YrqE4FEVzCA/7+c9UvEajphgCdMUVH0RZLi7tIX5Nx5K5u4t222XUfRAkvAIY/DOAu6G
         QE/IP6H2tb0oxepyGiObVh2ELzpOTiVDJk03O/MbAzmJZPxp+I152Zog594Q8H/WAS9V
         SjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7n+0r5q0Qz+hXEw9G55GjZMD41pxEKPsDPT1IobZLXE=;
        b=nsMtml7HzObzP/h9GwtI4xvW3/cmKrpPXUMTBzaNGFJMGYcTBEXOeEvNJrDQEep8yI
         1p1kNgwlZCaFLKVazqdH+oRC26aDlE7hGg+a9NM+hNQAE05Ui7sgl7RtNzejif9TTnmM
         U+sXTmCb0cfwZdjreHSKVVVT1XRjgBB4KGm5euhP1H7O1iGJZHx1Kb/n1snobW3FAlhZ
         Xq0oTyi6SzcdMRDcP9M5jsWsjQhaE+1MhohmgR5Y3IkG8Oz/wYIFzGatnjATeMZyJZJs
         KdkYLwgBy9/6IAHyP+00Xk6g3DXwaZA9PNe8/IjK5OOJePZ5PthhDuwTYxIeFbfTckZR
         w1DQ==
X-Gm-Message-State: AOAM533AnPYjV9TJhmyTotfW6oix8PELvs/tLjiwukDMy9GOviFNDEmR
        7n5RUPMRqcp/OeTAWVnltmuOrlav4DuVb3zaGGY=
X-Google-Smtp-Source: ABdhPJyZFV36dhJirXsqzZ2yq9eKS+Zlj650a+ZrXy+AeuMJHy36ftpVJ4vVLV1Fmh94vqpJ5ArhLPi95hEgL4uFMn0=
X-Received: by 2002:a37:4d13:: with SMTP id a19mr8983456qkb.159.1602498039370;
 Mon, 12 Oct 2020 03:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201007132808.647589-1-ian.kumlien@gmail.com> <20201008161312.GA3261279@bjorn-Precision-5520>
In-Reply-To: <20201008161312.GA3261279@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 12 Oct 2020 12:20:28 +0200
Message-ID: <CAA85sZsxLZ5m9SNe=5RD9oA7FV0mdwEvGqnXkdtbp_-e_6G5LQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 07, 2020 at 03:28:08PM +0200, Ian Kumlien wrote:
> > Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> > "5.4.1.2.2. Exit from the L1 State"
> >
> > Which makes it clear that each switch is required to initiate a
> > transition within 1=CE=BCs from receiving it, accumulating this latency=
 and
> > then we have to wait for the slowest link along the path before
> > entering L0 state from L1.
> >
> > The current code doesn't take the maximum latency into account.
> >
> > From the example:
> >    +----------------+
> >    |                |
> >    |  Root complex  |
> >    |                |
> >    |    +-----+     |
> >    |    |32 =CE=BCs|     |
> >    +----------------+
> >            |
> >            |  Link 1
> >            |
> >    +----------------+
> >    |     |8 =CE=BCs|     |
> >    |     +----+     |
> >    |    Switch A    |
> >    |     +----+     |
> >    |     |8 =CE=BCs|     |
> >    +----------------+
> >            |
> >            |  Link 2
> >            |
> >    +----------------+
> >    |    |32 =CE=BCs|     |
> >    |    +-----+     |
> >    |    Switch B    |
> >    |    +-----+     |
> >    |    |32 =CE=BCs|     |
> >    +----------------+
> >            |
> >            |  Link 3
> >            |
> >    +----------------+
> >    |     |8=CE=BCs|      |
> >    |     +---+      |
> >    |   Endpoint C   |
> >    |                |
> >    |                |
> >    +----------------+
> >
> > Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
> > transition to L0 at time T. Since switch B takes 32 =CE=BCs to exit L1 =
on
> > it's ports, Link 3 will transition to L0 at T+32 (longest time
> > considering T+8 for endpoint C and T+32 for switch B).
> >
> > Switch B is required to initiate a transition from the L1 state on it's
> > upstream port after no more than 1 =CE=BCs from the beginning of the
> > transition from L1 state on the downstream port. Therefore, transition =
from
> > L1 to L0 will begin on link 2 at T+1, this will cascade up the path.
> >
> > The path will exit L1 at T+34.
> >
> > On my specific system:
> > lspci -PP -s 04:00.0
> > 00:01.2/01:00.0/02:04.0/04:00.0 Unassigned class [ff00]: Realtek Semico=
nductor Co., Ltd. Device 816e (rev 1a)
> >
> > lspci -vvv -s 04:00.0
> >               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <5=
12ns, L1 <64us
> > ...
> >               LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit=
 Latency L0s unlimited, L1 <64us
> > ...
> >
> > Which means that it can't be followed by any switch that is in L1 state=
.
> >
> > This patch fixes it by disabling L1 on 02:04.0, 01:00.0 and 00:01.2.
> >
> >                                                     LnkCtl    LnkCtl
> >            ------DevCap-------  ----LnkCap-------  -Before-  -After--
> >   00:01.2                                L1 <32us       L1+       L1-
> >   01:00.0                                L1 <32us       L1+       L1-
> >   02:04.0                                L1 <32us       L1+       L1-
> >   04:00.0  L0s <512 L1 <64us             L1 <64us       L1+       L1-
>
> OK, now we're getting close.  We just need to flesh out the
> justification.  We need:
>
>   - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
>     and follow the example.

Will do

>   - Description of the problem.  I think it's poor bandwidth on your
>     Intel I211 device, but we don't have the complete picture because
>     that NIC is 03:00.0, which doesn't appear above at all.

I think we'll use Kai-Hengs issue, since it's actually more related to
the change itself...

Mine is a side effect while Kai-Heng is actually hitting an issue
caused by the bug.

>   - Explanation of what's wrong with the "before" ASPM configuration.
>     I want to identify what is wrong on your system.  The generic
>     "doesn't match spec" part is good, but step 1 is the specific
>     details, step 2 is the generalization to relate it to the spec.
>
>   - Complete "sudo lspci -vv" information for before and after the
>     patch below.  https://bugzilla.kernel.org/show_bug.cgi?id=3D208741
>     has some of this, but some of the lspci output appears to be
>     copy/pasted and lost all its formatting, and it's not clear how
>     some was collected (what kernel version, with/without patch, etc).
>     Since I'm asking for bugzilla attachments, there's no space
>     constraint, so just attach the complete unedited output for the
>     whole system.
>
>   - URL to the bugzilla.  Please open a new one with just the relevant
>     problem report ("NIC is slow") and attach (1) "before" lspci
>     output, (2) proposed patch, (3) "after" lspci output.  The
>     existing 208741 report is full of distractions and jumps to the
>     conclusion without actually starting with the details of the
>     problem.
>
> Some of this I would normally just do myself, but I can't get the
> lspci info.  It would be really nice if Kai-Heng could also add
> before/after lspci output from the system he tested.
>
> > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 253c30cc1967..893b37669087 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -     u32 latency, l1_switch_latency =3D 0;
> > +     u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> >       struct aspm_latency *acceptable;
> >       struct pcie_link_state *link;
> >
> > @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_de=
v *endpoint)
> >               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> >                   (link->latency_dw.l0s > acceptable->l0s))
> >                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > +
> >               /*
> >                * Check L1 latency.
> > -              * Every switch on the path to root complex need 1
> > -              * more microsecond for L1. Spec doesn't mention L0s.
> > +              *
> > +              * PCIe r5.0, sec 5.4.1.2.2 states:
> > +              * A Switch is required to initiate an L1 exit transition=
 on its
> > +              * Upstream Port Link after no more than 1 =CE=BCs from t=
he beginning of an
> > +              * L1 exit transition on any of its Downstream Port Links=
.
> >                *
> >                * The exit latencies for L1 substates are not advertised
> >                * by a device.  Since the spec also doesn't mention a wa=
y
> > @@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct pci_de=
v *endpoint)
> >                * L1 exit latencies advertised by a device include L1
> >                * substate latencies (and hence do not do any check).
> >                */
> > -             latency =3D max_t(u32, link->latency_up.l1, link->latency=
_dw.l1);
> > -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> > -                 (latency + l1_switch_latency > acceptable->l1))
> > -                     link->aspm_capable &=3D ~ASPM_STATE_L1;
> > -             l1_switch_latency +=3D 1000;
> > +             if (link->aspm_capable & ASPM_STATE_L1) {
> > +                     latency =3D max_t(u32, link->latency_up.l1, link-=
>latency_dw.l1);
> > +                     l1_max_latency =3D max_t(u32, latency, l1_max_lat=
ency);
> > +                     if (l1_max_latency + l1_switch_latency > acceptab=
le->l1)
> > +                             link->aspm_capable &=3D ~ASPM_STATE_L1;
> > +
> > +                     l1_switch_latency +=3D 1000;
> > +             }
> >
> >               link =3D link->parent;
> >       }
> > --
> > 2.28.0
> >
