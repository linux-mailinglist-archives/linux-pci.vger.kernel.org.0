Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F0274A88
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVVCs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVVCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:02:48 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D0C061755
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 14:02:47 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h1so10319876qvo.9
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WrLBW+eHX9WFwjAHnGZIf0qn5lftLm2Hq7KYfIdw3vA=;
        b=LjAwYxaFawLNTmsWimkyD0Gy6OCUYp67IUhmP8CnGKD2vrU2NYS5QQgg5KnmvxIWSF
         zsBKLugCocThF4pEi0TDUtIbI/YZj5PdqQUZat1ym2mQFi92CODY/3c+9vA03d7f2WTU
         kAzEJJI5wFjsxa/NnDX8G8te1yqQeLzHshxKqVZoISctVatRBLnPd71hYOEp3j0/bFQg
         HdaVA/HGMl5VcIr+yHQDE2AqAFij57BEVKQDQc7rfD67cqUgrxDmFk4kLhfkpCUpYTTw
         tRYvFBO0YDZNq3Fsf56NZr+Z5hH9IOBiwIefuOoUlTi/U/dzL8jx4Y7p9M3Ya72XMxyE
         akzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WrLBW+eHX9WFwjAHnGZIf0qn5lftLm2Hq7KYfIdw3vA=;
        b=eMOuyUYJa+0qArJH9h0fbCdAFE3N7ZlMrUC0nNQhP0hXWNVXXxfJQ4wrYyDeVnl8Mq
         hVmzsFnisHLP8uREmCQs7yPpMYHa5Mwb6s9lmBPXp8spmsYxevaNKx4tkqZTkGs+EhrM
         X2JuQWVJLnT/vcmJZ6D9vbraJascM0G0IDWkNOFRYfRfAnXCh9uxziTDIwFvN7zt3DaY
         DBrZZRCOK08bV3JRCPyAO7zYz78Mfq77BkRjnmseRnrEvC1+Ae0lGoDSppw/eyUfeUXf
         pHfTH3g0IVrR4zqyyjLj2gdAIz5BCmsd9K37q2BEG8g/42ZlR5r55P7zCrgsThAvs8cm
         uXeA==
X-Gm-Message-State: AOAM532n93si3YVspMCDVEbQZiCWAblCBSyWKKRdWzeNi9ao0H7HSRQU
        13kQZkawsj4ZgJe6u2ELz2e/WT8xt5lwxQ1ZvAc=
X-Google-Smtp-Source: ABdhPJxVoo5keef/Ltla/zzl2bKGc/IVWxdGKQ3oFVB3G7MkGwYXDXlUlFHgzSwAFYapYXIj/sQYyRsvSLz3Xc4gmys=
X-Received: by 2002:a05:6214:a52:: with SMTP id ee18mr7891064qvb.39.1600808566852;
 Tue, 22 Sep 2020 14:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200803145832.11234-1-ian.kumlien@gmail.com> <20200922201905.GA2224139@bjorn-Precision-5520>
In-Reply-To: <20200922201905.GA2224139@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 22 Sep 2020 23:02:35 +0200
Message-ID: <CAA85sZvk_MqYKWBo3pHP+Z2sWyODuxS7Ni2DHfLikq6fJJ6g3Q@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 10:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Saheed, Puranjay]
>
> On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
> > Changes:
> > * Handle L0s correclty as well, making it per direction
> > * Moved the switch cost in to the if statement since a non L1 switch ha=
s
> >   no additional cost.
> >
> > For L0s:
> > We sumarize the entire latency per direction to see if it's acceptable
> > for the PCIe endpoint.
> >
> > If it's not, we clear the link for the path that had too large latency.
> >
> > For L1:
> > Currently we check the maximum latency of upstream and downstream
> > per link, not the maximum for the path
> >
> > This would work if all links have the same latency, but:
> > endpoint -> c -> b -> a -> root  (in the order we walk the path)
> >
> > If c or b has the higest latency, it will not register
> >
> > Fix this by maintaining the maximum latency value for the path
> >
> > This change fixes a regression introduced (but not caused) by:
> > 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridge=
s)
>
> We need to include some info about the problem here, e.g., the sort of
> info hinted at in
> https://lore.kernel.org/r/CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0Fj=
bMZg@mail.gmail.com
>
> It would be *really* nice to have "lspci -vv" output for the system
> when broken and when working correctly.  If they were attached to a
> bugzilla.kernel.org entry, we could include the URL to that here.

I did create a bugzilla entry, and i see what you mean, will fix

> > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index b17e5ffd31b1..bc512e217258 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -     u32 latency, l1_switch_latency =3D 0;
> > +     u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
> > +             l0s_latency_up =3D 0, l0s_latency_dw =3D 0;
> >       struct aspm_latency *acceptable;
> >       struct pcie_link_state *link;
> >
> > @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_de=
v *endpoint)
> >       acceptable =3D &link->acceptable[PCI_FUNC(endpoint->devfn)];
> >
> >       while (link) {
> > -             /* Check upstream direction L0s latency */
> > -             if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > -                 (link->latency_up.l0s > acceptable->l0s))
> > -                     link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
> > -
> > -             /* Check downstream direction L0s latency */
> > -             if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > -                 (link->latency_dw.l0s > acceptable->l0s))
> > -                     link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
> > +             if (link->aspm_capable & ASPM_STATE_L0S) {
> > +                     /* Check upstream direction L0s latency */
> > +                     if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > +                             l0s_latency_up +=3D link->latency_up.l0s;
> > +                             if (l0s_latency_up > acceptable->l0s)
> > +                                     link->aspm_capable &=3D ~ASPM_STA=
TE_L0S_UP;
> > +                     }
> > +
> > +                     /* Check downstream direction L0s latency */
> > +                     if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> > +                             l0s_latency_dw +=3D link->latency_dw.l0s;
> > +                             if (l0s_latency_dw > acceptable->l0s)
> > +                                     link->aspm_capable &=3D ~ASPM_STA=
TE_L0S_DW;
> > +                     }
> > +             }
>
> The main point of the above is to accumulate l0s_latency_up and
> l0s_latency_dw along the entire path.  I don't understand the
> additional:
>
>   if (link->aspm_capable & ASPM_STATE_L0S)
>
> around the whole block.  I don't think it's *wrong*, but unless I'm
> missing something it's unnecessary since we already check for
> ASPM_STATE_L0S_UP and ASPM_STATE_L0S_DW.  It does make it arguably
> more parallel with the ASPM_STATE_L1 case below, but it complicates
> the diff enough that I'm not sure it's worth it.

Yeah it's a leftover from a earlier version of the patch actually,
sorry about that

> I think this could also be split off as a separate patch to fix the
> L0s latency checking.

Ok, will do!

> >               /*
> >                * Check L1 latency.
> >                * Every switch on the path to root complex need 1
>
> Let's take the opportunity to update the comment to add the spec
> citation for this additional 1 usec of L1 exit latency for every
> switch.  I think it is PCIe r5.0, sec 5.4.1.2.2, which says:
>
>   A Switch is required to initiate an L1 exit transition on its
>   Upstream Port Link after no more than 1 =CE=BCs from the beginning of a=
n
>   L1 exit transition on any of its Downstream Port Links.

Will do!

> > @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_de=
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
>
> This accumulates the 1 usec delays for a Switch to propagate the exit
> transition from its Downstream Port to its Upstream Port, but it
> doesn't accumulate the L1 exit latencies themselves for the entire
> path, does it?  I.e., we don't accumulate "latency" for the whole
> path.  Don't we need that?

Not for L1's apparently, from what I gather the maximum link latency
is "largest latency" + 1us * number-of-hops

Ie, just like the comment above states - the L1 total time might be
more but  1us is all that is needed to "start" and that propagates
over the link.

> >               link =3D link->parent;
> >       }
> > --
> > 2.28.0
> >

Included inline for discussion, will send it separately as well - when
i know it's ok :)


So this now became:
commit dde058f731f97b6f86600eb6578c8b02b8720edb (HEAD)
Author: Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue Sep 22 22:58:19 2020 +0200

    PCIe L0s latency is cumulative from the root

    From what I have been able to figure out, L0s latency is
    cumulative from the root and should be treated as such.

    Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 893b37669087..15d64832a988 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0,
+               l0s_latency_up =3D 0, l0s_latency_dw =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)

        while (link) {
                /* Check upstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
-                   (link->latency_up.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
+                       l0s_latency_up +=3D link->latency_up.l0s;
+                       if (l0s_latency_up > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_UP;
+               }

                /* Check downstream direction L0s latency */
-               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
-                   (link->latency_dw.l0s > acceptable->l0s))
-                       link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
+                       l0s_latency_dw +=3D link->latency_dw.l0s;
+                       if (l0s_latency_dw > acceptable->l0s)
+                               link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+               }

                /*
                 * Check L1 latency.
--------------------------

And:
commit db3d9c4baf4ab177d87b5cd41f624f5901e7390f
Author: Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun Jul 26 16:01:15 2020 +0200

    Use maximum latency when determining L1 ASPM

    If it's not, we clear the link for the path that had too large latency.

    Currently we check the maximum latency of upstream and downstream
    per link, not the maximum for the path

    This would work if all links have the same latency, but:
    endpoint -> c -> b -> a -> root  (in the order we walk the path)

    If c or b has the higest latency, it will not register

    Fix this by maintaining the maximum latency value for the path

    See this bugzilla for more information:
    https://bugzilla.kernel.org/show_bug.cgi?id=3D208741

    This fixes an issue for me where my desktops machines maximum bandwidth
    for remote connections dropped from 933 MBit to ~40 MBit.

    The bug became obvious once we enabled ASPM on all links:
    66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridge=
s)

    Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..893b37669087 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,

 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-       u32 latency, l1_switch_latency =3D 0;
+       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
        struct aspm_latency *acceptable;
        struct pcie_link_state *link;

@@ -456,10 +456,14 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
                    (link->latency_dw.l0s > acceptable->l0s))
                        link->aspm_capable &=3D ~ASPM_STATE_L0S_DW;
+
                /*
                 * Check L1 latency.
-                * Every switch on the path to root complex need 1
-                * more microsecond for L1. Spec doesn't mention L0s.
+                *
+                * PCIe r5.0, sec 5.4.1.2.2 states:
+                * A Switch is required to initiate an L1 exit transition o=
n its
+                * Upstream Port Link after no more than 1 =CE=BCs from the
beginning of an
+                * L1 exit transition on any of its Downstream Port Links.
                 *
                 * The exit latencies for L1 substates are not advertised
                 * by a device.  Since the spec also doesn't mention a way
@@ -469,11 +473,14 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                 * L1 exit latencies advertised by a device include L1
                 * substate latencies (and hence do not do any check).
                 */
-               latency =3D max_t(u32, link->latency_up.l1, link->latency_d=
w.l1);
-               if ((link->aspm_capable & ASPM_STATE_L1) &&
-                   (latency + l1_switch_latency > acceptable->l1))
-                       link->aspm_capable &=3D ~ASPM_STATE_L1;
-               l1_switch_latency +=3D 1000;
+               if (link->aspm_capable & ASPM_STATE_L1) {
+                       latency =3D max_t(u32, link->latency_up.l1,
link->latency_dw.l1);
+                       l1_max_latency =3D max_t(u32, latency, l1_max_laten=
cy);
+                       if (l1_max_latency + l1_switch_latency > acceptable=
->l1)
+                               link->aspm_capable &=3D ~ASPM_STATE_L1;
+
+                       l1_switch_latency +=3D 1000;
+               }

                link =3D link->parent;
        }
----------------------
