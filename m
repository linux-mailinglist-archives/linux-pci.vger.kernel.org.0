Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F312D90CA
	for <lists+linux-pci@lfdr.de>; Sun, 13 Dec 2020 22:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLMVkr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Dec 2020 16:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLMVkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2020 16:40:47 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602FC0613CF
        for <linux-pci@vger.kernel.org>; Sun, 13 Dec 2020 13:40:07 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so13980961qke.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Dec 2020 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4c4neTVOFsGDUt3LCFjAFkgJyTz1fkr6l9+419UUb0=;
        b=NHT0ZtoGY2/wpsKkte+/wd9Vj22NYt3czZHjB9TQu1zBCtK5JOpdO4GG6NK1ry0Jze
         GeHSqpVEH1jUVAJDcn0Pl9mkWvDQTZujGGQDgfC+9bjvaQZL6PHBcuX1bSiTR9zT4ixZ
         bsVvA3Uk9p9LC/X6PHAJN+RGf0mJLRtZ4dqlm6Kv4dlIucU8j6c5AqqW/IrLtEY3RS2P
         P6/tgFRikUxeV+FnbG48CPGK+ke7DqIU4kBMRlOrjZbrNyJeX84t9USWa3OaLj9DUlWk
         qzhxihlY8W4EEwz05CGn6NSeZJbJf1QGguOz08m0sOyfYzoMDDedEFxuo4ekdyKOGc7x
         H2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4c4neTVOFsGDUt3LCFjAFkgJyTz1fkr6l9+419UUb0=;
        b=DJE73wmIaYLee4Db4x07RfYXibos+La5HQmfR7Y2WVfzb1FCyz8/2XHplgg9cr5FXA
         ZMWbyUUW5jjXmPeHdhLqyaWCHG+kO63xus3NrsXNbSCzjpbKjwaJJh7AenglXJ7Wm8VG
         h4VysYkcSW34o05P9UTzS3pXKpbzEG5DbC41+eBTTHUmg1Gt01+Xwi1ofigecqP/rZQo
         mw8GbIL+q87yV8ooj7+9NfsV97ruOckQU0QGZUeY02nDdgbEDbjTz8fB1d5uuhQTQv4t
         twr8OuxPToqCJAqjrdq9OujfioJXyUCcFCEsavpLklLRPLwdsanKl9yHM6viHn+2dpso
         4h+Q==
X-Gm-Message-State: AOAM531wAl3hKDPHY9ts0FH4nxOBh35VkTBNJwzIQ4Y5T/aKOP+PRkSA
        FWBbYoCMeJg4qKB1hm1hkPdfrjY0Zz9YhLlV30CJmaJL2tN/oQ==
X-Google-Smtp-Source: ABdhPJz7XnIsIlsBV2QMHkhQvNz1KJaNrZYRa2rqs8FX4u3Rr7ZQnOqGGMViJZULoWBJP6GfW+7CT07+wQI0mYKcjYQ=
X-Received: by 2002:a05:620a:2009:: with SMTP id c9mr3457941qka.159.1607895604599;
 Sun, 13 Dec 2020 13:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20201024205548.1837770-1-ian.kumlien@gmail.com> <20201212234737.GA130506@bjorn-Precision-5520>
In-Reply-To: <20201212234737.GA130506@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 13 Dec 2020 22:39:53 +0100
Message-ID: <CAA85sZuuS=UHzhk0DabN45jCu-GYD-DxMOY8dd68Znnk5wsXVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 13, 2020 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Oct 24, 2020 at 10:55:46PM +0200, Ian Kumlien wrote:
> > Make pcie_aspm_check_latency comply with the PCIe spec, specifically:
> > "5.4.1.2.2. Exit from the L1 State"
> >
> > Which makes it clear that each switch is required to initiate a
> > transition within 1=CE=BCs from receiving it, accumulating this latency=
 and
> > then we have to wait for the slowest link along the path before
> > entering L0 state from L1.
> > ...
>
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
>
> There are two paths here that share a Link:
>
>   00:01.2 --- 01:00.0 -- 02:03.0 --- 03:00.0 I211 NIC
>   00:01.2 --- 01:00.0 -- 02:04.0 --- 04:00.x multifunction Realtek
>
> 1) The path to the I211 NIC includes four Ports and two Links (the
>    connection between 01:00.0 and 02:03.0 is internal Switch routing,
>    not a Link).

>    The Ports advertise L1 exit latencies of <32us, <32us, <32us,
>    <16us.  If both Links are in L1 and 03:00.0 initiates L1 exit at T,
>    01:00.0 initiates L1 exit at T + 1.  A TLP from 03:00.0 may see up
>    to 1 + 32 =3D 33us of L1 exit latency.
>
>    The NIC can tolerate up to 64us of L1 exit latency, so it is safe
>    to enable L1 for both Links.
>
> 2) The path to the Realtek device is similar except that the Realtek
>    L1 exit latency is <64us.  If both Links are in L1 and 04:00.x
>    initiates L1 exit at T, 01:00.0 again initiates L1 exit at T + 1,
>    but a TLP from 04:00.x may see up to 1 + 64 =3D 65us of L1 exit
>    latency.
>
>    The Realtek device can only tolerate 64us of latency, so it is not
>    safe to enable L1 for both Links.  It should be safe to enable L1
>    on the shared link because the exit latency for that link would be
>    <32us.

04:00.0:
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
unlimited, L1 <64us

So maximum latency for the entire link has to be <64 us
For the device to leave L1 ASPM takes <64us

So the device itself is the slowest entry along the link, which means
that nothing
else along that path can have ASPM enabled

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
>
> [Nit: I don't think we should add 1 for the 02:04.0 -- 01:00.0 piece
> because that's internal Switch routing, not a Link.  But even without
> that extra microsecond, this path does exceed the acceptable latency
> since 1 + 64 =3D 65us, and 04:00.0 can only tolerate 64us.]

It does report L1 ASPM on both ends, so the links will be counted as
such in the code.

I also assume that it can power down individual ports... and enter
rest state if no links are up.

> > It correctly identifies the issue.
> >
> > For reference, pcie information:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D209725
>
> The "lspci without my patches" [1] shows L1 enabled for the shared
> Link from 00:01.2 --- 01:00.0 and for the Link to 03:00.0 (I211), but
> not for the Link to 04:00.x (Realtek).
>
> Per my analysis above, that looks like it *should* be a safe
> configuration.  03:00.0 can tolerate 64us, actual is <33us.  04:00.0
> can tolerate 64us, actual should be <32us since only the shared Link
> is in L1.

See above.

> However, the commit log at [2] shows L1 *enabled* for both the shared
> Link from 00:01.2 --- 01:00.0 and the 02:04.0 --- 04:00.x Link, and
> that would definitely be a problem.
>
> Can you explain the differences between [1] and [2]?

I don't understand which sections you're referring to.

> > Kai-Heng Feng has a machine that will not boot with ASPM without this p=
atch,
> > information is documented here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D209671
>
> I started working through this info, too, but there's not enough
> information to tell what difference this patch makes.  The attachments
> compare:
>
>   1) CONFIG_PCIEASPM_DEFAULT=3Dy without the patch [3] and
>   2) CONFIG_PCIEASPM_POWERSAVE=3Dy *with* the patch [4]
>
> Obviously CONFIG_PCIEASPM_POWERSAVE=3Dy will configure things
> differently than CONFIG_PCIEASPM_DEFAULT=3Dy, so we can't tell what
> changes are due to the config change and what are due to the patch.
>
> The lspci *with* the patch ([4]) shows L0s and L1 enabled at almost
> every possible place.  Here are the Links, how they're configured, and
> my analysis of the exit latencies vs acceptable latencies:
>
>   00:01.1 --- 01:00.0      L1+ (                  L1 <64us vs unl)
>   00:01.2 --- 02:00.0      L1+ (                  L1 <64us vs 64us)
>   00:01.3 --- 03:00.0      L1+ (                  L1 <64us vs 64us)
>   00:01.4 --- 04:00.0      L1+ (                  L1 <64us vs unl)
>   00:08.1 --- 05:00.x L0s+ L1+ (L0s <64ns vs 4us, L1  <1us vs unl)
>   00:08.2 --- 06:00.0 L0s+ L1+ (L0s <64ns vs 4us, L1  <1us vs unl)
>
> So I can't tell what change prevents the freeze.  I would expect the
> patch would cause us to *disable* L0s or L1 somewhere.
>
> The only place [4] shows ASPM disabled is for 05:00.1.  The spec says
> we should program the same value in all functions of a multi-function
> device.  This is a non-ARI device, so "only capabilities enabled in
> all functions are enabled for the component as a whole."  That would
> mean that L0s and L1 are effectively disabled for 05:00.x even though
> 05:00.0 claims they're enabled.  But the latencies say ASPM L0s and L1
> should be safe to be enabled.  This looks like another bug that's
> probably unrelated.

I don't think it's unrelated, i suspect it's how PCIe works with
multiple links...
a device can cause some kind of head of queue stalling - i don't know how b=
ut
it really looks like it.

> The patch might be correct; I haven't actually analyzed the code.  But
> the commit log doesn't make sense to me yet.

I personally don't think that all this PCI information is required,
the linux kernel is
currently doing it wrong according to the spec.

Also, since it's clearly doing the wrong thing, I'm worried that dists
will take a kernel enable aspm
and there will be alot of bugreports of non-booting systems or other
weird issues... And the culprit
was known all along.

It's been five months...

> [1] https://bugzilla.kernel.org/attachment.cgi?id=3D293047
> [2] https://lore.kernel.org/linux-pci/20201007132808.647589-1-ian.kumlien=
@gmail.com/
> [3] https://bugzilla.kernel.org/attachment.cgi?id=3D292955
> [4] https://bugzilla.kernel.org/attachment.cgi?id=3D292957
>
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
> > @@ -469,11 +473,13 @@ static void pcie_aspm_check_latency(struct pci_de=
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
> > +                     l1_switch_latency +=3D 1000;
> > +             }
> >
> >               link =3D link->parent;
> >       }
> > --
> > 2.29.1
> >
