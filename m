Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78C12327C9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgG2XCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgG2XCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 19:02:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E743C061794
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:02:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so18973261qtn.7
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3+GERmFSPZYroScy/h9ujatWLx9qIdWlhD4XOIqieYc=;
        b=MLZENPEUUdTnPFoSWXu3feiXvu/QFkbxI9sb2G/3u7CF75c7mtLTarExZbVBMtFHmj
         Z8cCi+pnU+JTUAm9QvKnkgnNglG07NzseEFAI+5MFlq91z8QGErqFzE7sCye2F2dw+5F
         Q1AfNXXzpFgfl2yS6twee5Jl9Fqwd5KVlJc4VzH8eZH+vSApd3NKMKw3SSLizWa7H4eq
         J7wgcGe2JRrJJYgVFnpVjlZMsVtanamcZJioOZLrnJY0dL5hJ0Er1nBaNvDGmKJP1Wr1
         /n/ofQfr35EeEieBaoPuvf5PQkHHjPoYuw0x+e+vNSM8mE+80+uzfhZ0iSkhDK/Jdxmq
         Li5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3+GERmFSPZYroScy/h9ujatWLx9qIdWlhD4XOIqieYc=;
        b=s7icTxXHuH2THh9SISjmrQEUbkkxQ4MhwU3JQkCqGkoIp+kdkJ3nLHL+oD6C9MMS0E
         6wmdISnL3jneMlR54REqOyaZlRHnEtB+DxKTn3LOLGkLBwVs0S314csTP5BBGPegpykd
         vRzdleXSud0JHvAVIhYh8gBmGgRbvO9nB/Yc2LrRRQM2RqoT9jHP02/P3koU2Hc9o5CS
         Ld26ddt1BeMfNvkoN2hUXS5hN1P/dZMra+GyFjlDR10QFpYhor8KzyRrx2LABaGbo+Fm
         JBT+AJWZwc8WSyts3nDsnA1hz5pb7NZZGflfp+VHmbrtQ5vCMRsDxQd69vjdwsk85sAX
         uHOA==
X-Gm-Message-State: AOAM531vWfKgi0mL/ibfh1P8t4kjHcgxyFT6RueQ0HKdfoMC1akVKJ+M
        amdC1N2TKPNTjgM43YWuXkMJ/V5h2L/HzkXIMmdAQv3Q
X-Google-Smtp-Source: ABdhPJwF1WKTIZUdcdxivSGeolNiKh49HZTVJkJkfKM8vDi386vgFT4AdLTpQwYPIUXhRILdcoZ0qVjk5aT2+5yt1n0=
X-Received: by 2002:aed:2821:: with SMTP id r30mr252375qtd.3.1596063733318;
 Wed, 29 Jul 2020 16:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
 <20200729224710.GA1971834@bjorn-Precision-5520>
In-Reply-To: <20200729224710.GA1971834@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 30 Jul 2020 01:02:02 +0200
Message-ID: <CAA85sZt7xHJc85Ok8j2QDmB-E_r-ch5kBKqYeUe1KnA6Gt-iDw@mail.gmail.com>
Subject: Re: [RFC] ASPM L1 link latencies
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 12:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Jul 25, 2020 at 09:47:05PM +0200, Ian Kumlien wrote:
> > Hi,
> >
> > A while ago I realised that I was having all kinds off issues with my
> > connection, ~933 mbit had become ~40 mbit
> >
> > This only applied on links to the internet (via a linux fw running
> > NAT) however while debugging with the help of Alexander Duyck
> > we realised that ASPM could be the culprit (at least disabling ASPM on
> > the nic it self made things work just fine)...
> >
> > So while trying to understand PCIe and such things, I found this:
> >
> > The calculations of the max delay looked at "that node" + start latency=
 * "hops"
> >
> > But one hop might have a larger latency and break the acceptable delay.=
..
> >
> > So after a lot playing around with the code, i ended up with this, and
> > it seems to fix my problem and does
> > set two pcie bridges to ASPM Disabled that didn't happen before.
> >
> > I do however have questions.... Shouldn't the change be applied to
> > the endpoint?  Or should it be applied recursively along the path to
> > the endpoint?
>
> I don't understand this very well, but I think we do need to consider
> the latencies along the entire path.  PCIe r5.0, sec 5.4.1.3, contains
> this:
>
>   Power management software, using the latency information reported by
>   all components in the Hierarchy, can enable the appropriate level of
>   ASPM by comparing exit latency for each given path from Root to
>   Endpoint against the acceptable latency that each corresponding
>   Endpoint can withstand.

One of the questions is this:
They say from root to endpoint while we walk from endpoint to root

So, is that more optimal in some way? or should latencies always be
considered from root to endpoint?
In that case, should the link ASPM be disabled somewhere else?
(I tried to disable them on the "endpoint" and it didn't help for some reas=
on)

> Also this:

[--8<--]

>   - For each component with one or more Endpoint Functions, PCI
>     Express system software examines the Endpoint L0s/L1 Acceptable
>     Latency, as reported by each Endpoint Function in its Link
>     Capabilities register, and enables or disables L0s/L1 entry (via
>     the ASPM Control field in the Link Control register) accordingly
>     in some or all of the intervening device Ports on that hierarchy.

> > Also, the L0S checks are only done on the local links, is this
> > correct?
>
> ASPM configuration is done on both ends of a link.  I'm not sure it
> makes sense to enable any state (L0s, L1, L1.1, L1.2) unless both ends
> of the link support it.  In particular, sec 5.4.1.3 says:
>
>   Software must not enable L0s in either direction on a given Link
>   unless components on both sides of the Link each support L0s;
>   otherwise, the result is undefined.
>
> But I think we do need to consider the entire path when enabling L0s;
> from sec 7.5.3.3:
>
>   Endpoint L0s Acceptable Latency - This field indicates the
>   acceptable total latency that an Endpoint can withstand due to the
>   transition from L0s state to the L0 state. It is essentially an
>   indirect measure of the Endpoint=E2=80=99s internal buffering.  Power
>   management software uses the reported L0s Acceptable Latency number
>   to compare against the L0s exit latencies reported by all components
>   comprising the data path from this Endpoint to the Root Complex Root
>   Port to determine whether ASPM L0s entry can be used with no loss of
>   performance.
>
> Does any of that help answer your question?

Yes! It's exactly what I wanted to know, :)

So now the question is should I group the fixes into one patch or
separate them for easier bisecting?

> Bjorn
>
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index b17e5ffd31b1..bd53fba7f382 100644
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
> > @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev
> > *endpoint)
> >                  * substate latencies (and hence do not do any check).
> >                  */
> >                 latency =3D max_t(u32, link->latency_up.l1, link->laten=
cy_dw.l1);
> > +               l1_max_latency =3D max_t(u32, latency, l1_max_latency);
> >                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> > -                   (latency + l1_switch_latency > acceptable->l1))
> > +                   (l1_max_latency + l1_switch_latency > acceptable->l=
1))
> >                         link->aspm_capable &=3D ~ASPM_STATE_L1;
> >                 l1_switch_latency +=3D 1000;
