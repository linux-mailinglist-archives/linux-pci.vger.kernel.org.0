Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D1283EB2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgJESjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgJESjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 14:39:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C052C0613CE
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 11:39:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so6487774qvb.13
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZMbw02ji2VfGx4XJXciVpIoLB9O4c+md2Jm76gRgFU=;
        b=pe2GUXzXrxANpPocifkGHsF5cOnqiJGSViQJOYBStdgW+xZeGnW15ZXo0C6u1lz0wL
         RidCKDSy9SbzWwfMysE/+rGCp1IsO8wPmrQ7coTYIQGnFa74rhMuJGYu4WQwjZfDt+3E
         PUvEPNvz50lu6zFvhiI1umfmUlVFbPeyYIua2TpnWTQSKhkEr21s6ibbxT2CwHuyyQQ5
         bH3enGcervWolA/70DH5wD2PXVU2GgF+RP9rR2C9ArirTDDfA4CZZLWwcuUjrgGsq6lR
         X7GZZlxVb27Kz7Cr5HP8RmUs1Xorp1IUgNO+pbF0F4LwdPSlZRnyL+Vq7hAIeq/U/q7C
         Yp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZMbw02ji2VfGx4XJXciVpIoLB9O4c+md2Jm76gRgFU=;
        b=HoIIf7LVicCgCPWIQ12x+V7ROuezvyqKLYzqcRZhPf3eSKDuZBFOcQu4E+Xog2y7WB
         MIWLQfNgtAhFcG2oYJiJoj5KgJydKyMlj+QO8sphNKmRIM3Pfdfs5NfSWuLBZOmeqVOl
         U71t8ioIAQNSsJ1fTum6hotaTB7iQekR2L7sHK0sHTHUX2MI7FLle+KsLPuI0Erkhy9k
         w9SrvBlZk8ofROh29N2zlR9XwHS6T1YPcxPdgNAm1b5DUjHcwhxbJYcLsxOqNQ9/DavZ
         rh9hkco4h86ynJs0RaZZOK7nvU51nHSS02lYrQuCY1vgodlZjMdN3UevYGTfvuCs6N6N
         9lQw==
X-Gm-Message-State: AOAM531vx3N4XE6Wmry/DunwU+1wclBrElUxynLyxkJILNBkIAM0Ibld
        toUsGVDDyFy75sy8rDZ84n9b9Ku61fwaN1CvSOY=
X-Google-Smtp-Source: ABdhPJwSZu0pzDJ32W4jp+qeXU/qdAplSVHoEiqJA1Xv+r8rL6hOPKCy8KvjgVCBv+KPb05w5UXMt0sMzlzIJpf33nI=
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr1038607qve.25.1601923146022;
 Mon, 05 Oct 2020 11:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200803145832.11234-1-ian.kumlien@gmail.com> <20201005183141.GA3028319@bjorn-Precision-5520>
In-Reply-To: <20201005183141.GA3028319@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 5 Oct 2020 20:38:55 +0200
Message-ID: <CAA85sZuQgQ=+pVsgdZQCX2HSoRw1-4UHEsyid32=0JSPr01n2g@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 5, 2020 at 8:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Aug 03, 2020 at 04:58:32PM +0200, Ian Kumlien wrote:
> > Changes:
> > * Handle L0s correclty as well, making it per direction
> > * Moved the switch cost in to the if statement since a non L1 switch has
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
> > 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
> >
> > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
>
> I'm not sure where we're at with this.  If we can come up with:
>
>   - "lspci -vv" for the entire affected hierarchy before the fix
>
>   - specific identification of incorrect configuration per spec
>
>   - patch that fixes that specific misconfiguration
>
>   - "lspci -vv" for the entire affected hierarchy after the fix
>
> then we have something to work with.  It doesn't have to (and should
> not) fix all the problems at once.

So detail the changes on my specific machine and then mention
5.4.1.2.2 of the pci spec
detailing the exit from PCIe ASPM L1?

Basically writing a better changelog for the first patch?

Any comments on the L0s patch?

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
> > -     u32 latency, l1_switch_latency = 0;
> > +     u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
> > +             l0s_latency_up = 0, l0s_latency_dw = 0;
> >       struct aspm_latency *acceptable;
> >       struct pcie_link_state *link;
> >
> > @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >       acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
> >
> >       while (link) {
> > -             /* Check upstream direction L0s latency */
> > -             if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> > -                 (link->latency_up.l0s > acceptable->l0s))
> > -                     link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> > -
> > -             /* Check downstream direction L0s latency */
> > -             if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> > -                 (link->latency_dw.l0s > acceptable->l0s))
> > -                     link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> > +             if (link->aspm_capable & ASPM_STATE_L0S) {
> > +                     /* Check upstream direction L0s latency */
> > +                     if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> > +                             l0s_latency_up += link->latency_up.l0s;
> > +                             if (l0s_latency_up > acceptable->l0s)
> > +                                     link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> > +                     }
> > +
> > +                     /* Check downstream direction L0s latency */
> > +                     if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> > +                             l0s_latency_dw += link->latency_dw.l0s;
> > +                             if (l0s_latency_dw > acceptable->l0s)
> > +                                     link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> > +                     }
> > +             }
> > +
> >               /*
> >                * Check L1 latency.
> >                * Every switch on the path to root complex need 1
> > @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >                * L1 exit latencies advertised by a device include L1
> >                * substate latencies (and hence do not do any check).
> >                */
> > -             latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > -             if ((link->aspm_capable & ASPM_STATE_L1) &&
> > -                 (latency + l1_switch_latency > acceptable->l1))
> > -                     link->aspm_capable &= ~ASPM_STATE_L1;
> > -             l1_switch_latency += 1000;
> > +             if (link->aspm_capable & ASPM_STATE_L1) {
> > +                     latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > +                     l1_max_latency = max_t(u32, latency, l1_max_latency);
> > +                     if (l1_max_latency + l1_switch_latency > acceptable->l1)
> > +                             link->aspm_capable &= ~ASPM_STATE_L1;
> > +
> > +                     l1_switch_latency += 1000;
> > +             }
> >
> >               link = link->parent;
> >       }
> > --
> > 2.28.0
> >
