Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2F2D0E9E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 12:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLGLFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 06:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgLGLFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 06:05:46 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64804C0613D0
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 03:05:00 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so9060060qtr.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wQUtW7jikauwqTQr8dLjwxw4r6fuHgOOZ29TKVTvDms=;
        b=qMQ4dZhSm1abDJsYgCi1illKNDpzigV0wkX8tAJR0goPo4NiWwcYGjTuBfPdsXY/XB
         1VAKHE8Q8KqhB/auTpGRsmzIw8aEA1a71e1syB9pnnv7Vr0M47o1Q2bZuaWF8XRz2Mc0
         0FdLqgxeRkkKT2aiCRaDjOj3JLbdQR6Vs95AgbjayuavwKkMb8Lkywk1ikGcrKzxukGA
         KXpbBVDN/+Gzg9ulJvB4mLWzO9y4wv5jKWLD4WlZ4mN/QJduPSxrsaSiPSgRXdDbxBj9
         B8+ItSFcfuOl6Z9MYzqh+iPWmcqW8NzdTian3Or9i/qVwuVGY0FiRoJViWaQlbYB4DRt
         6+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wQUtW7jikauwqTQr8dLjwxw4r6fuHgOOZ29TKVTvDms=;
        b=OYMBQGtu2SljeyEGUCveU0UPfslQtmtjf6aVLuy/K2JjTbBN3WxbqurLNnf5r6LOKB
         GvxSNb202a4rseQRguCdnCsmOwJZnNdudULz/P5D6Ktf23z1vcJV/YqO2zRVEV0YJFOD
         HoPLiYuhi2euMg1Od4jwJH4x1f2QSaXnLAjSIyWhsoQhWGh4cN2V34yR2w/VRb3D2FRg
         Hid+KT1HcJIFjGT4v0YyovblPt/syHT6o1jFz+cZe5x/ojOyOYi95AQNkPHeapNlJGXL
         Gf6eN8RwB54AQ/KhQCLa7qH5OjvKo076eTQwC1FWqfpkppgqaxMRtBXp2K8e/P9nQrVS
         f3hw==
X-Gm-Message-State: AOAM53373mmMKb/TuMweuin3ofnSk/5PMUZr/QIEG17ysfHjnpWVYQfw
        OIlY9w+cdM+ilF15PhNsSvgtYMwLoPpr2QXu69E=
X-Google-Smtp-Source: ABdhPJwYL8kqq3XwPEtJRJ8HQP0TefKbnamE/DIL1j13zos8E2Z7C6YjcPl598I8j1t2PwEz6Iy3SnAIwBgxWILSb2s=
X-Received: by 2002:aed:2827:: with SMTP id r36mr4423955qtd.337.1607339099297;
 Mon, 07 Dec 2020 03:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20201022183030.GA513862@bjorn-Precision-5520> <20201024205548.1837770-1-ian.kumlien@gmail.com>
 <CAA85sZs_9hUFU233qBeZenyheBaLyhjGFCm+zFHgEseL=JuC3A@mail.gmail.com>
In-Reply-To: <CAA85sZs_9hUFU233qBeZenyheBaLyhjGFCm+zFHgEseL=JuC3A@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 7 Dec 2020 12:04:48 +0100
Message-ID: <CAA85sZueuMGeaQxZsJw4FvE6RzVdMMSVQNkR3=hyYVQapSLmiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I was hoping that this patch would get in to 5.10 since it'll be a LTS
release and all... but it doesn't seem like it.

Any thoughts?

On Sun, Nov 15, 2020 at 10:49 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Is this ok? Or what's missing?
>
> On Sat, Oct 24, 2020 at 10:55 PM Ian Kumlien <ian.kumlien@gmail.com> wrot=
e:
> >
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
> > 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Con=
nection (rev 03)
> > 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device=
 816e (rev 1a)
> >
> >             Exit latency       Acceptable latency
> > Tree:       L1       L0s       L1       L0s
> > ----------  -------  -----     -------  ------
> > 00:01.2     <32 us   -
> > | 01:00.0   <32 us   -
> > |- 02:03.0  <32 us   -
> > | \03:00.0  <16 us   <2us      <64 us   <512ns
> > |
> > \- 02:04.0  <32 us   -
> >   \04:00.0  <64 us   unlimited <64 us   <512ns
> >
> > 04:00.0's latency is the same as the maximum it allows so as we walk th=
e path
> > the first switchs startup latency will pass the acceptable latency limi=
t
> > for the link, and as a side-effect it fixes my issues with 03:00.0.
> >
> > Without this patch, 03:00.0 misbehaves and only gives me ~40 mbit/s ove=
r
> > links with 6 or more hops. With this patch I'm back to a maximum of ~93=
3
> > mbit/s.
> >
> > The original code path did:
> > 04:00:0-02:04.0 max latency 64    -> ok
> > 02:04.0-01:00.0 max latency 32 +1 -> ok
> > 01:00.0-00:01.2 max latency 32 +2 -> ok
> >
> > And thus didn't see any L1 ASPM latency issues.
> >
> > The new code does:
> > 04:00:0-02:04.0 max latency 64    -> ok
> > 02:04.0-01:00.0 max latency 64 +1 -> latency exceeded
> > 01:00.0-00:01.2 max latency 64 +2 -> latency exceeded
> >
> > It correctly identifies the issue.
> >
> > For reference, pcie information:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D209725
> >
> > Kai-Heng Feng has a machine that will not boot with ASPM without this p=
atch,
> > information is documented here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D209671
> >
> > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 253c30cc1967..c03ead0f1013 100644
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
> > @@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct pci_de=
v *endpoint)
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
 the beginning of an
> > +                * L1 exit transition on any of its Downstream Port Lin=
ks.
> >                  *
> >                  * The exit latencies for L1 substates are not advertis=
ed
> >                  * by a device.  Since the spec also doesn't mention a =
way
> > @@ -469,11 +473,13 @@ static void pcie_aspm_check_latency(struct pci_de=
v *endpoint)
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
> > +                       latency =3D max_t(u32, link->latency_up.l1, lin=
k->latency_dw.l1);
> > +                       l1_max_latency =3D max_t(u32, latency, l1_max_l=
atency);
> > +                       if (l1_max_latency + l1_switch_latency > accept=
able->l1)
> > +                               link->aspm_capable &=3D ~ASPM_STATE_L1;
> > +                       l1_switch_latency +=3D 1000;
> > +               }
> >
> >                 link =3D link->parent;
> >         }
> > --
> > 2.29.1
> >
