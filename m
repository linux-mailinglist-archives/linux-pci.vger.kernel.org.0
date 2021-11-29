Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F2462685
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhK2Wxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhK2Wwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:52:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB1C0980D7
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:02:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m24so12938128pls.10
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOvMGCPHR+bCBQguwSCbuxniLM0sag3xU3SsHwqrdg4=;
        b=N68cAYSBDIGDlWi/64zcrzBifIAtRkQNGt72lRIxeWtG2erUK8AjB/ftm4r6Mhn8Lu
         L7gym1G3jr39j7q7W4FUuLEGZaCI9MoczcqhwDSep+kf5ZG4mPLehP2pkfPp9uh050ft
         bkF0weEv1xVnFle6/pz0eCtClGkdCwptU1N3l9rF47QjVjIaOhKkkq20oc8dwC7O8+c/
         5M/Ae3OF5Kd7+7WrAlmBJ3ZFibAVQ8gyeTGt618G3WkSgIZFf5Th9ZnkzHq1ZIRmbuLa
         eeCdzXFqsClsjqqWISjC1+KlwYbkUuho9L0neEJCT9gkeM6yQrYmAIOw6S5trIXVVFCO
         SWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOvMGCPHR+bCBQguwSCbuxniLM0sag3xU3SsHwqrdg4=;
        b=RcA4JUUmo9HSo2CGN7Gg96+uATG9rqljqd609h69de5B3irGSShpBK34A97ki8D2/o
         smamOYw7xmYHGT1DV8VR0oaEeLYMTO9yhOug+oiBJ4YPqINUKIR91b/IKrYwtD//vb4a
         NdX+8rxZYT4jye4QbMH9+b9v8owk9SF2mLaEGcRl8qHH3ct1QTjm3td4Ro7plp34dTc3
         gKY81Dtm6xClJ+n2INVw0kFuLBZ63T0MaDgyAe7J6HLLoPGMYYSO2A7TD2awVaqqO3UR
         YfinudnodMyBmBpVd26tKMC/3bWQGE6LmTFi0GCPxJz/k0hc+wnuLs2t9ZdKlypKPJBz
         LVmg==
X-Gm-Message-State: AOAM532PPQ2CuuK8dpOYc9M7W2LAVkPAEuOieYbTSfd/4liNWDYtY3Bl
        Z4jdVf9B9V+BBgkliMaCcXUDV2nHpY2J1j0TAwhppA==
X-Google-Smtp-Source: ABdhPJxMZLTlaoPl2Z2Z3Ym5oXuvClf+b/G3COl6lJKxHdKArb6vJmHKd+O/+8w9BFmS9u1tJzXe7b4szXov9MPFNWE=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr219183pjb.93.1638212566580;
 Mon, 29 Nov 2021 11:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com> <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
 <20211129183330.svptvcystceazgwc@intel.com>
In-Reply-To: <20211129183330.svptvcystceazgwc@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 11:02:41 -0800
Message-ID: <CAPcyv4hPP8KYXD-6mrpHRpLYLqSQb22Lie2_m1Nc=Y5NqqfJgQ@mail.gmail.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 10:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-24 13:55:03, Dan Williams wrote:
> > On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > The expectation is that the mailbox interface ready bit is the first
> > > step in access through the mailbox interface. Therefore, waiting for the
> > > doorbell busy bit to be clear would imply that the mailbox interface is
> > > ready. The original driver implementation used the doorbell timeout for
> > > the Mailbox Interface Ready bit to piggyback off of, since the latter
> > > doesn't have a defined timeout (introduced in 8adaf747c9f0 ("cxl/mem:
> > > Find device capabilities"), a timeout has since been defined with an ECN
> > > to the 2.0 spec). With the current driver waiting for mailbox interface
> > > ready as a part of probe() it's no longer necessary to use the
> > > piggyback.
> > >
> > > With the piggybacking no longer necessary it doesn't make sense to check
> > > doorbell status when acquiring the mailbox. It will be checked during
> > > the normal mailbox exchange protocol.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > > This patch did not exist in RFCv2
> > > ---
> > >  drivers/cxl/pci.c | 25 ++++++-------------------
> > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 2cef9fec8599..869b4fc18e27 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -221,27 +221,14 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> > >
> > >         /*
> > >          * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > > -        * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > > +        * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
> > >          * bit is to allow firmware running on the device to notify the driver
> > > -        * that it's ready to receive commands. It is unclear if the bit needs
> > > -        * to be read for each transaction mailbox, ie. the firmware can switch
> > > -        * it on and off as needed. Second, there is no defined timeout for
> > > -        * mailbox ready, like there is for the doorbell interface.
> > > -        *
> > > -        * Assumptions:
> > > -        * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > > -        *    it for every command.
> > > -        *
> > > -        * 2. If the doorbell is clear, the firmware should have first set the
> > > -        *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > > -        *    to be ready is sufficient.
> > > +        * that it's ready to receive commands. The spec does not clearly define
> > > +        * under what conditions the bit may get set or cleared. As of the 2.0
> > > +        * base specification there was no defined timeout for mailbox ready,
> > > +        * like there is for the doorbell interface. This was fixed with an ECN,
> > > +        * but it's possible early devices implemented this before the ECN.
> >
> > Can we just drop comment block altogether? Outside of
> > cxl_pci_setup_mailbox() the only time the mailbox status should be
> > checked is after a doorbell timeout after submitting a command.
> >
>
> Yes, I think it's fine to drop it.
>
> > >          */
> > > -       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > > -       if (rc) {
> > > -               dev_warn(dev, "Mailbox interface not ready\n");
> > > -               goto out;
> > > -       }
> > > -
> > >         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > >         if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > >                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> >
> > This error message is obsolete since nothing is pre-checking the
> > mailbox anymore, and per above I see no problem waiting to check the
> > status until after the mailbox has failed to respond after a timeout.
>
> The message is wrong, but I think the logic is still valuable. How about:
> "mbox: reported interface ready, but mbox not ready"

You mean check this every time even though the spec says the driver
only needs to check it once per-reset?
