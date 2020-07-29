Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14DC2327AA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 00:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2Wna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2Wna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 18:43:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE69C061794
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 15:43:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h21so12559548qtp.11
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2020 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVpqbRJSUpw3TmW9H1R5MG9usGVURZO389ioxmAxPlY=;
        b=fNFYzj7VftcDf6txwaREOryMObVhf8wOguWZmnQqdJ5PSVRleWUfVfumiyqlECpm4a
         AYzms6SCUpEymxjxgqaQ0XhuX115QUdR8yZYYm315GCs5mau9Ms8arpNwzpSXiqbL5mY
         HIoubJp58d71RwRFyapV1RcNuDt7eA/a54oc22SmpRoVU6elTJRcciGrACqmirbvbOJ0
         3tOiGjCl4H9pvuOknMqA6U0z33/zA4NXRatuCs4d8dFjLCbYiTgJcBYHOYYYSkZS5BTI
         9mQdscMti5yfSp43AJs9RHjFm45lFHcomgOEe5FdR+ucBaSqt4CjQRwDTGSURH3Xobq0
         kxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVpqbRJSUpw3TmW9H1R5MG9usGVURZO389ioxmAxPlY=;
        b=aI+2jp1UfPXX3pDNJwJ6u9GoUr3ouwGRN2FV/Gs+JG41nDHxvLiFxK5Hksrh8Al4nF
         LaRmmCADzaYq9m5X8UnvJyybMu2osCqsQHPdMWsFfKOUTBT3M25MOVWLvob2seb8gFuz
         qR736VNPWr7ytjUQHq9np6FODYdu4qqklIJpS5y7HbehxveSNN/TJ8rTyHch9v7fnli1
         26uK+ZqKRSqm1gEDWEMdoFx4H8R1sjVJOGj1i0QRPJ5S6RyMC9gImHg2lDeNEHVoIqMl
         /f/bJZEVtyZiQA5Y4Z21E7ELQjtN/xCN1/UHo7pm4Bh4Xtb1aq1nTiXvEsguLjUeF6Gq
         Rb7A==
X-Gm-Message-State: AOAM532DL1OUznpqjT6h276FLoJOz3N74pzbHPPwEJuCVj3IgdpI/aac
        vWcDn5rO/Zr8f8NbUBuXSBburVmnCWpt4yoj8wc=
X-Google-Smtp-Source: ABdhPJzoel6ZkNL/PO0U1BBH+5gjw4IsZ5Qk5KinGlB9UhZGOtfstDXk61/i+RlkvLNOOnUHO40QGnOjUysqIEH1AJg=
X-Received: by 2002:aed:3728:: with SMTP id i37mr90282qtb.347.1596062609336;
 Wed, 29 Jul 2020 15:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200727213045.2117855-1-ian.kumlien@gmail.com> <20200729222758.GA1963264@bjorn-Precision-5520>
In-Reply-To: <20200729222758.GA1963264@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 30 Jul 2020 00:43:18 +0200
Message-ID: <CAA85sZv0WTQAVyxr7LRKn-CDFgg5nTQTNzcn4bycLgNu+yO5cw@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 30, 2020 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jul 27, 2020 at 11:30:45PM +0200, Ian Kumlien wrote:
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
> > This change fixes a regression introduced by:
> > 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
>
> Hi Ian,
>
> Sorry about the regression, and thank you very much for doing the
> hard work of debugging and fixing it!
>
> My guess is that 66ff14e59e8a isn't itself buggy, but it allowed ASPM
> to be enabled on a longer path, and we weren't computing the maximum
> latency correctly, so ASPM on that longer path exceeded the amount we
> could tolerate.  If that's the case, 66ff14e59e8a probably just
> exposed an existing problem that could occur in other topologies even
> without 66ff14e59e8a.

I agree, this is why I didn't do fixes:. but it does fix a regression
- and it's hard to say
exactly what - I'd like it to go in to stable when accepted...

But we can rewrite it anyway you see fit :)

> I'd like to work through this latency code with concrete examples.
> Can you collect the "sudo lspci -vv" output and attach it to an entry
> at https://bugzilla.kernel.org?  If it's convenient, it would be
> really nice to compare it with similar output from before this patch.

I can cut from the mails i had in the conversation with Alexander Duyck

I submitted it against PCI, you can find it here:
https://bugzilla.kernel.org/show_bug.cgi?id=208741

Still filling in the data

> Bjorn
>
> > Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index b17e5ffd31b1..bd53fba7f382 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> >
> >  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  {
> > -     u32 latency, l1_switch_latency = 0;
> > +     u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
> >       struct aspm_latency *acceptable;
> >       struct pcie_link_state *link;
> >
> > @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >                * substate latencies (and hence do not do any check).
> >                */
> >               latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> > +             l1_max_latency = max_t(u32, latency, l1_max_latency);
> >               if ((link->aspm_capable & ASPM_STATE_L1) &&
> > -                 (latency + l1_switch_latency > acceptable->l1))
> > +                 (l1_max_latency + l1_switch_latency > acceptable->l1))
> >                       link->aspm_capable &= ~ASPM_STATE_L1;
> >               l1_switch_latency += 1000;
> >
> > --
> > 2.27.0
> >
