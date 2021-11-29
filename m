Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25665462587
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhK2Wku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhK2WkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:40:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505DC203960
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:18:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso16409885pji.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64mdYM4TFDap+15tFzg//A188pEwlRg5eeO/kY3qwEo=;
        b=0WPhk10QRX8aw8s2z/Us1MoEvLG4aJilJSHe+aSI/b3WKuAb/MpnhsicHbQZAPN8cF
         Onb1LBIkTmQ/EqCrp/r+jN9h1eTJlanGOts6PgEFrBfhnk21laCF1ydzSX3kuCJVNShm
         vWt114+3H0TaJxSdXwW0PbbvQ3yMHR7MUJI4LW/e63bg1vtc7bMb6DkC4FgJZkuLTK7O
         OaC4NPru6mKTHPoNkm32OAe7ONDNsk6JBzBZZiYef/St/oedklmXv3TEoZgJES1lXi0z
         oaZlA8MGJPBANuu4Gekp9jO5ydCDRgB0/2VscxREiQo0BMEyL7fvCJ3ffKVdz9z+MRJU
         QOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64mdYM4TFDap+15tFzg//A188pEwlRg5eeO/kY3qwEo=;
        b=uuVvrw3RkzNj+zYLenNEirkwL9OpxobL0G55iZdOFyLwamRsZ7ATTM6qfyOseAWIgb
         Q+JSzYwDquhP6ycIyQ2lcFHwzNs1tHr0UMls7gt1yN9nbxwOIzNWhCt7DUEj+jM00R59
         ruSLiz8Vih0pifla9sBuUOB1qchRVZajrmmDpZzBBJhFae9WbtJqFxPDkENShuXlA+1x
         w6CDXR7n0ZbNRWMxDptV7sIPf1mweCjhxtq4Z05Bs+MwSPMS8aKgxRwU/ikoryjHfWmK
         vI7RYDYm8pOb5fgGMqdHTUL1tS7o3KF1vQNV7x8Lc97MYLRVr4zBvPNoY2AyGINU67YD
         KxDQ==
X-Gm-Message-State: AOAM532HzCSFxGC4Wu7Ya3JVhVOvBAlf6DqcPnu0Q7VjqGENXIzuK64G
        3QPQS7D+PgN/bx4diWtyAnRsKem+oH+/3HH8qKhO4A==
X-Google-Smtp-Source: ABdhPJzpto0h5jTWmvea6qu030oHXXa3VLAJxIbmE+Ii6u+BCn7xekcL27lUJYBwFlPt1ClYPlZm+iACqKJGvTnPjkc=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr21907pjb.220.1638213521627;
 Mon, 29 Nov 2021 11:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-6-ben.widawsky@intel.com> <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
 <20211129183330.svptvcystceazgwc@intel.com> <CAPcyv4hPP8KYXD-6mrpHRpLYLqSQb22Lie2_m1Nc=Y5NqqfJgQ@mail.gmail.com>
 <20211129191146.vhiwkf5jsegil4aa@intel.com>
In-Reply-To: <20211129191146.vhiwkf5jsegil4aa@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 11:18:36 -0800
Message-ID: <CAPcyv4gboiSXq1zCtmnP7oWzjaoMG=RL5sgmhFtXuxsTTPf3fA@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 11:11 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-29 11:02:41, Dan Williams wrote:
> > On Mon, Nov 29, 2021 at 10:33 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-11-24 13:55:03, Dan Williams wrote:
> > > > On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > The expectation is that the mailbox interface ready bit is the first
> > > > > step in access through the mailbox interface. Therefore, waiting for the
> > > > > doorbell busy bit to be clear would imply that the mailbox interface is
> > > > > ready. The original driver implementation used the doorbell timeout for
> > > > > the Mailbox Interface Ready bit to piggyback off of, since the latter
> > > > > doesn't have a defined timeout (introduced in 8adaf747c9f0 ("cxl/mem:
> > > > > Find device capabilities"), a timeout has since been defined with an ECN
> > > > > to the 2.0 spec). With the current driver waiting for mailbox interface
> > > > > ready as a part of probe() it's no longer necessary to use the
> > > > > piggyback.
> > > > >
> > > > > With the piggybacking no longer necessary it doesn't make sense to check
> > > > > doorbell status when acquiring the mailbox. It will be checked during
> > > > > the normal mailbox exchange protocol.
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > ---
> > > > > This patch did not exist in RFCv2
> > > > > ---
> > > > >  drivers/cxl/pci.c | 25 ++++++-------------------
> > > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index 2cef9fec8599..869b4fc18e27 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -221,27 +221,14 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> > > > >
> > > > >         /*
> > > > >          * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > > > > -        * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > > > > +        * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
> > > > >          * bit is to allow firmware running on the device to notify the driver
> > > > > -        * that it's ready to receive commands. It is unclear if the bit needs
> > > > > -        * to be read for each transaction mailbox, ie. the firmware can switch
> > > > > -        * it on and off as needed. Second, there is no defined timeout for
> > > > > -        * mailbox ready, like there is for the doorbell interface.
> > > > > -        *
> > > > > -        * Assumptions:
> > > > > -        * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > > > > -        *    it for every command.
> > > > > -        *
> > > > > -        * 2. If the doorbell is clear, the firmware should have first set the
> > > > > -        *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > > > > -        *    to be ready is sufficient.
> > > > > +        * that it's ready to receive commands. The spec does not clearly define
> > > > > +        * under what conditions the bit may get set or cleared. As of the 2.0
> > > > > +        * base specification there was no defined timeout for mailbox ready,
> > > > > +        * like there is for the doorbell interface. This was fixed with an ECN,
> > > > > +        * but it's possible early devices implemented this before the ECN.
> > > >
> > > > Can we just drop comment block altogether? Outside of
> > > > cxl_pci_setup_mailbox() the only time the mailbox status should be
> > > > checked is after a doorbell timeout after submitting a command.
> > > >
> > >
> > > Yes, I think it's fine to drop it.
> > >
> > > > >          */
> > > > > -       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > > > > -       if (rc) {
> > > > > -               dev_warn(dev, "Mailbox interface not ready\n");
> > > > > -               goto out;
> > > > > -       }
> > > > > -
> > > > >         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > > >         if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > > > >                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> > > >
> > > > This error message is obsolete since nothing is pre-checking the
> > > > mailbox anymore, and per above I see no problem waiting to check the
> > > > status until after the mailbox has failed to respond after a timeout.
> > >
> > > The message is wrong, but I think the logic is still valuable. How about:
> > > "mbox: reported interface ready, but mbox not ready"
> >
> > You mean check this every time even though the spec says the driver
> > only needs to check it once per-reset?
>
> Unfortunately it does not say that. "... it shall remain set until the next
> reset or the device encounters an error that prevents any mailbox
> communication."
>
> Once we have real error checking in place, this could go away, though I see no
> harm in leaving it.

Right, there's no harm in the check, it just seems overly paranoid to
me if it was already checked once. Until a doorbell timeout happens
it's an extra MMIO cycle that can saved for a "what happened?" check
after a timeout.
