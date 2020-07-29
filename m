Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39482327EB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgG2XNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgG2XNI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 19:13:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77813C061794
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:13:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so23973928qkg.5
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8/Z4ASsXxuwnAX8I60fWeW2rNERT2/VGbS8p9jLToaY=;
        b=dfhYEaFl6guXXARqcNHVhCSPbIMXSmoUGJLh01rn160z6Nu0L8D2MV4aqE9sBXEDEa
         ABoEZ6479TrqYEzVuvx9G6oOLsFCwuG4zc+lN2Icyx55cc+QXgFtQhesXLLarLJn58nU
         JvHYugj8DO8E+va8jSQg6XBlSvjIr2WE/ouWIs6fNnOSzHlEpR+6NncarG3Os7nsMQRA
         S9fYjdLQ7UE9yOQ6ijmHlG/UukRlAB5jvIdyeO7sSTLz2ZStwxEjJ2dEOoPlaaH7qcj0
         QzZS9V7FJ0Onjiay9PGvsc0+GdCwdKsDAdyN2QiY5iBJHb17gUtIQaW3wHNlisu0PvwS
         QTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8/Z4ASsXxuwnAX8I60fWeW2rNERT2/VGbS8p9jLToaY=;
        b=gHRLC+Bb2AHrOJfvTFnvOc0d1kHsvQlRKf38Goms7FM1x6JrgAqzlzvaCNtJ14FdyR
         k5iKezvQR8pQVOdvSxxOv6xLBuMTM/VomF7qsDMP6np2iUzNhyEF5fuJqz+qxjyD6sVa
         jxDSKl1msaF6jHVVO+0zPc9N1ABUznajFLwzZohAuJ6d5SSRG1HpQporqY48qQrEspFP
         p7QSKmpkeVdpf+o138qKwxU5Gk4GIR9rkvqgLo3RAHN2nxB2IwrNQCYtzjTJlOPwb0jq
         cO1qvTniGJ1d3B9q7ugB9w2e0PKdBxQU6COd9UQIdLoqjXAIbGIagTEcSBsLzVCJUqrR
         PLUw==
X-Gm-Message-State: AOAM5321eicnp19ZT479S5yxMBYA+JOXyr2xCeaRnKCuQjrlLRv/Ho3c
        AmAVIFuzoVRkaoH7VqOfjvAyyEAXNdwikvxyIoCvR4RhUTo=
X-Google-Smtp-Source: ABdhPJxSUuXWDFxshA/Uj06wY5L8cyNCM1yUUucIBFnfnUm2lvXIy0fhFdIXYCjvTFu33HDiWsmpXjVpZlGyZlcCsJk=
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr36777764qke.168.1596064387531;
 Wed, 29 Jul 2020 16:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
 <20200729224710.GA1971834@bjorn-Precision-5520> <CAA85sZt7xHJc85Ok8j2QDmB-E_r-ch5kBKqYeUe1KnA6Gt-iDw@mail.gmail.com>
In-Reply-To: <CAA85sZt7xHJc85Ok8j2QDmB-E_r-ch5kBKqYeUe1KnA6Gt-iDw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 30 Jul 2020 01:12:56 +0200
Message-ID: <CAA85sZvL4_mR=w2MU7JUx5eksnCt1yBZD=jbhAMoMVz38OJ5aA@mail.gmail.com>
Subject: Re: [RFC] ASPM L1 link latencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 1:02 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> On Thu, Jul 30, 2020 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote=
:
> > On Sat, Jul 25, 2020 at 09:47:05PM +0200, Ian Kumlien wrote:
> > > Hi,
> > >
> > > A while ago I realised that I was having all kinds off issues with my
> > > connection, ~933 mbit had become ~40 mbit
> > >
> > > This only applied on links to the internet (via a linux fw running
> > > NAT) however while debugging with the help of Alexander Duyck
> > > we realised that ASPM could be the culprit (at least disabling ASPM o=
n
> > > the nic it self made things work just fine)...
> > >
> > > So while trying to understand PCIe and such things, I found this:
> > >
> > > The calculations of the max delay looked at "that node" + start laten=
cy * "hops"
> > >
> > > But one hop might have a larger latency and break the acceptable dela=
y...
> > >
> > > So after a lot playing around with the code, i ended up with this, an=
d
> > > it seems to fix my problem and does
> > > set two pcie bridges to ASPM Disabled that didn't happen before.
> > >
> > > I do however have questions.... Shouldn't the change be applied to
> > > the endpoint?  Or should it be applied recursively along the path to
> > > the endpoint?
> >
> > I don't understand this very well, but I think we do need to consider
> > the latencies along the entire path.  PCIe r5.0, sec 5.4.1.3, contains
> > this:
> >
> >   Power management software, using the latency information reported by
> >   all components in the Hierarchy, can enable the appropriate level of
> >   ASPM by comparing exit latency for each given path from Root to
> >   Endpoint against the acceptable latency that each corresponding
> >   Endpoint can withstand.
>
> One of the questions is this:
> They say from root to endpoint while we walk from endpoint to root
>
> So, is that more optimal in some way? or should latencies always be
> considered from root to endpoint?
> In that case, should the link ASPM be disabled somewhere else?
> (I tried to disable them on the "endpoint" and it didn't help for some re=
ason)
>
> > Also this:
>
> [--8<--]
>
> >   - For each component with one or more Endpoint Functions, PCI
> >     Express system software examines the Endpoint L0s/L1 Acceptable
> >     Latency, as reported by each Endpoint Function in its Link
> >     Capabilities register, and enables or disables L0s/L1 entry (via
> >     the ASPM Control field in the Link Control register) accordingly
> >     in some or all of the intervening device Ports on that hierarchy.
>
> > > Also, the L0S checks are only done on the local links, is this
> > > correct?
> >
> > ASPM configuration is done on both ends of a link.  I'm not sure it
> > makes sense to enable any state (L0s, L1, L1.1, L1.2) unless both ends
> > of the link support it.  In particular, sec 5.4.1.3 says:
> >
> >   Software must not enable L0s in either direction on a given Link
> >   unless components on both sides of the Link each support L0s;
> >   otherwise, the result is undefined.
> >
> > But I think we do need to consider the entire path when enabling L0s;
> > from sec 7.5.3.3:
> >
> >   Endpoint L0s Acceptable Latency - This field indicates the
> >   acceptable total latency that an Endpoint can withstand due to the
> >   transition from L0s state to the L0 state. It is essentially an
> >   indirect measure of the Endpoint=E2=80=99s internal buffering.  Power
> >   management software uses the reported L0s Acceptable Latency number
> >   to compare against the L0s exit latencies reported by all components
> >   comprising the data path from this Endpoint to the Root Complex Root
> >   Port to determine whether ASPM L0s entry can be used with no loss of
> >   performance.
> >
> > Does any of that help answer your question?
>
> Yes! It's exactly what I wanted to know, :)
>
> So now the question is should I group the fixes into one patch or
> separate them for easier bisecting?

Actually this raises a few questions...

It does sound like this is sum(link->latency_up.l0s) +
sum(link->latency_dw.l0s) of the link vs acceptable->l0s

But, would that mean that we walk the link backwards? so it's both sides?

Currently they are separated - and they are not diaabled as a whole...

How should we handle the difference between up and down to keep the
finer grained control we have?

> > Bjorn
> >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index b17e5ffd31b1..bd53fba7f382 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pde=
v,
> > >
> > >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> > >  {
> > > -       u32 latency, l1_switch_latency =3D 0;
> > > +       u32 latency, l1_max_latency =3D 0, l1_switch_latency =3D 0;
> > >         struct aspm_latency *acceptable;
> > >         struct pcie_link_state *link;
> > >
> > > @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_de=
v
> > > *endpoint)
> > >                  * substate latencies (and hence do not do any check)=
.
> > >                  */
> > >                 latency =3D max_t(u32, link->latency_up.l1, link->lat=
ency_dw.l1);
> > > +               l1_max_latency =3D max_t(u32, latency, l1_max_latency=
);
> > >                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> > > -                   (latency + l1_switch_latency > acceptable->l1))
> > > +                   (l1_max_latency + l1_switch_latency > acceptable-=
>l1))
> > >                         link->aspm_capable &=3D ~ASPM_STATE_L1;
> > >                 l1_switch_latency +=3D 1000;
