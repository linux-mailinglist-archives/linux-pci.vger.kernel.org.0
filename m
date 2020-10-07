Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6059F285E26
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgJGLcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGLcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 07:32:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33DC061755
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 04:32:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so2215181qkg.8
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSgck3ZalpxbIXLe8PZBRX2LxRHI/7Q6jyECDGDJ8fg=;
        b=uk28Dojx30Ds2XWik0QdNHVm7XHaPtZM9eceTI0t9lJLtlTMHPzYZ35YKLbZfmg6vW
         sErRdKWg/FQTu2I13hjjXqFvEp87hxvsJwz8ZPFnoh2XgBrfUuhI477AimGT2MjFpyiD
         qI3KMjRUdFhrcA+nKkLPcDJHHMj/J+dI1vIyvgGs1BREv9v0xzmJ8PyUtXL2aJsvJlTw
         4GLOwX7QnAZLncWkJKDaNce00fO3B0UoHHJJt0JMOh4kCyUAobs4+KeHaa3qV4O4Un5v
         na9Pgb9EOanvPwvnqzR2uubg0Ch9nCyh1larNgE3Ka84AhdGE7uEzzFYb1YFFQPe2hVI
         rtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSgck3ZalpxbIXLe8PZBRX2LxRHI/7Q6jyECDGDJ8fg=;
        b=J6HO8YDIs4M+I/yX7fkZy54s0yR8bQxXTdKWZx/qkt0Da/ycUJIIjCqYxrS+/tdX1e
         TTn6LKgol/H74hBmP2vzds4hPLR4kZQuVGcUWOO+Swi7RJqHtzz8L+Weg2g/t3329yjr
         tO1dAgKCOzXqxRtaPT2azHnLwpqn+oI+aum2KWyMI0ipHpLja0vdz8timSXQeoCRHjHh
         jDrf/bESNB94WEwhmgN7fxhsiaOprgar5O70qn9iU3ZmhBPmUuUZLjMpJ8XlcVIBWQqn
         gRrPNDdR3/VosXfM3UczY59J46/Gw4oRrNo1EknrtIU501zYRnYJNfiyLWgMCZLVLxcM
         ZSlQ==
X-Gm-Message-State: AOAM533ld2UZPSAq/O/8wIabPWkENYHkJy99wzG9fGINsCFAIjBdjV27
        YxrbPPnfuKfLNbZc1kF/urQ8AgI5NISojgieBWuRpHVEvSjjhg==
X-Google-Smtp-Source: ABdhPJwtHN+/cvgAJEPd2NSMKeS7+vqrh8PIcXlwE90xRbrwzoxoj/ExcLHbxmhQMVpq2Le/J3sazn8ofiZ9Qb/ggag=
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr2173305qke.175.1602070319425;
 Wed, 07 Oct 2020 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuQgQ=+pVsgdZQCX2HSoRw1-4UHEsyid32=0JSPr01n2g@mail.gmail.com>
 <20201005190954.GA3031459@bjorn-Precision-5520>
In-Reply-To: <20201005190954.GA3031459@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 7 Oct 2020 13:31:48 +0200
Message-ID: <CAA85sZsVKCbcHfxjNA83==YFDP_va=qp8JQEcbMFYJXNJP=1NQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 5, 2020 at 9:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 05, 2020 at 08:38:55PM +0200, Ian Kumlien wrote:
> > On Mon, Oct 5, 2020 at 8:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> > >
> > > On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
> > > > Changes:
> > > > * Handle L0s correclty as well, making it per direction
> > > > * Moved the switch cost in to the if statement since a non L1 switc=
h has
> > > >   no additional cost.
> > > >
> > > > For L0s:
> > > > We sumarize the entire latency per direction to see if it's accepta=
ble
> > > > for the PCIe endpoint.
> > > >
> > > > If it's not, we clear the link for the path that had too large late=
ncy.
> > > >
> > > > For L1:
> > > > Currently we check the maximum latency of upstream and downstream
> > > > per link, not the maximum for the path
> > > >
> > > > This would work if all links have the same latency, but:
> > > > endpoint -> c -> b -> a -> root  (in the order we walk the path)
> > > >
> > > > If c or b has the higest latency, it will not register
> > > >
> > > > Fix this by maintaining the maximum latency value for the path
> > > >
> > > > This change fixes a regression introduced (but not caused) by:
> > > > 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Br=
idges)
> > > >
> > > > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > >
> > > I'm not sure where we're at with this.  If we can come up with:
> > >
> > >   - "lspci -vv" for the entire affected hierarchy before the fix
> > >
> > >   - specific identification of incorrect configuration per spec
> > >
> > >   - patch that fixes that specific misconfiguration
> > >
> > >   - "lspci -vv" for the entire affected hierarchy after the fix
> > >
> > > then we have something to work with.  It doesn't have to (and should
> > > not) fix all the problems at once.
> >
> > So detail the changes on my specific machine and then mention
> > 5.4.1.2.2 of the pci spec
> > detailing the exit from PCIe ASPM L1?
>
> Like I said, I need to see the current ASPM configuration, a note
> about what is wrong with it (this probably involves a comparison with
> what the spec says it *should* be), and the configuration after the
> patch showing that it's now fixed.
>
> > Basically writing a better changelog for the first patch?
> >
> > Any comments on the L0s patch?
>
> Not yet.  When it's packaged up in mergeable form I'll review it.  I
> just don't have time to extract everything myself.

So, did it like this, since I don't think the output from my system
actually is important.
(I added some descriptive text that is loosely based on the spec)
----
Use maximum latency when determining L1 ASPM

Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
"5.4.1.2.2. Exit from the L1 State"

Which makes it clear that each switch is required to initiate a
transition within 1=CE=BCs from receiving it, accumulating this latency and
then we have to wait for the slowest link along the path before
entering L0 state from L1.

The current code doesn't take the maximum latency into account.

From the example:
   +----------------+
   |                |
   |  Root complex  |
   |                |
   |    +-----+     |
   |    |32 =CE=BCs|     |
   +----------------+
           |
           |  Link 1
           |
   +----------------+
   |     |8 =CE=BCs|     |
   |     +----+     |
   |    Switch A    |
   |     +----+     |
   |     |8 =CE=BCs|     |
   +----------------+
           |
           |  Link 2
           |
   +----------------+
   |    |32 =CE=BCs|     |
   |    +-----+     |
   |    Switch B    |
   |    +-----+     |
   |    |32 =CE=BCs|     |
   +----------------+
           |
           |  Link 3
           |
   +----------------+
   |     |8=CE=BCs|      |
   |     +---+      |
   |   Endpoint C   |
   |                |
   |                |
   +----------------+

Links 1, 2 and 3 are all in L1 state - endpoint C initiates the
transition to L0 at time T. Since switch B takes 32 =CE=BCs to exit L1 on
it's ports, Link 3 will transition to L0 at T+32 (longest time
considering T+8 for endpoint C and T+32 for switch B).

Switch B is required to initiate a transition from the L1 state on it's
upstream port after no more than 1 =CE=BCs from the beginning of the
transition from L1 state on the downstream port. Therefore, transition from
L1 to L0 will begin on link 2 at T+1, this will cascade up the path.

The path will exit L1 at T+34.

Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
----

> > > > ---
> > > >  drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++-----------=
----
> > > >  1 file changed, 26 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index b17e5ffd31b1..bc512e217258 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *p=
dev,
> > > >
> > > >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > > >  {
> > > > -     u32 latency, l1_switch_latency =3D 0;
> > > > +     u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
> > > > +             l0s_latency_up =3D 0, l0s_latency_dw =3D 0;
> > > >       struct aspm_latency *acceptable;
> > > >       struct pcie_link_state *link;
> > > >
> > > > @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pc=
i_dev *endpoint)
> > > >       acceptable =3D &link->acceptable[PCI_FUNC(endpoint->devfn)];
> > > >
> > > >       while (link) {
> > > > -             /* Check upstream direction L0s latency */
> > > > -             if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > > > -                 (link->latency_up.l0s > acceptable->l0s))
> > > > -                     link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> > > > -
> > > > -             /* Check downstream direction L0s latency */
> > > > -             if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > > > -                 (link->latency_dw.l0s > acceptable->l0s))
> > > > -                     link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > > > +             if (link->aspm_capable & ASPM_STATE_L0S) {
> > > > +                     /* Check upstream direction L0s latency */
> > > > +                     if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > > > +                             l0s_latency_up +=3D link->latency_up.=
l0s;
> > > > +                             if (l0s_latency_up > acceptable->l0s)
> > > > +                                     link->aspm_capable &=3D ~ASPM=
_STATE_L0S_UP;
> > > > +                     }
> > > > +
> > > > +                     /* Check downstream direction L0s latency */
> > > > +                     if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> > > > +                             l0s_latency_dw +=3D link->latency_dw.=
l0s;
> > > > +                             if (l0s_latency_dw > acceptable->l0s)
> > > > +                                     link->aspm_capable &=3D ~ASPM=
_STATE_L0S_DW;
> > > > +                     }
> > > > +             }
> > > > +
> > > >               /*
> > > >                * Check L1 latency.
> > > >                * Every switch on the path to root complex need 1
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
> > > >
> > > >               link =3D link->parent;
> > > >       }
> > > > --
> > > > 2.28.0
> > > >
