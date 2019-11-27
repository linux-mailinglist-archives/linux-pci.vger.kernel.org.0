Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003AD10A753
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 01:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0AGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 19:06:34 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38237 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfK0AGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 19:06:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id 14so23473926qtf.5;
        Tue, 26 Nov 2019 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=blwEJPZM1LwoJmXCJ81tx6CXl1QZ/gbiETqqfH17hCE=;
        b=uurMhc0/9WIyPsqom/omTyoBP/D+SyOe0YMA03g/1lxa4J4NRkRf7PANnJVhR5z6gk
         DRikQAVe8r7HG34tyE5Ce5O52mQ2KLkW4YcxjiHxn8PPjgog8HbY1qhgeGWJ01aAjODw
         hnGa8Du/9aeAJ4hNzf5zV0JmijVSLoGUiM7/8YQBL3gTbhnbGSyXCsfwNv9fFA+EsgwG
         d+gFzcBNADtFPAShkPUYLqKBUqaBHnfGMSG9Pgti3aEdK5RVpK9twHSyN4vfFGHTKwUQ
         FVeoG2xfj/FgPEIzRNUmuEeyTfUhW30seeBj3ucTtFeinhCi/0fEXJOhSZGaD/vBC4YH
         LZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blwEJPZM1LwoJmXCJ81tx6CXl1QZ/gbiETqqfH17hCE=;
        b=q7IxXyOEM+6lH+8uoP21Z9amAFTy16Qb2TOde5H2m38sgGhXfaTQEh5xl2w9a8Qlus
         9FZYFNfxb2Nfda1cZbXiDUFaGwJpjQuF2aQMO5S0lCTHUVVgnrGv7mboBiK7HJVwHCFN
         KjAeXNk00Srpl4IL7R9W3OvMdHQDj+E3pir1zilxkp6jrRuuBIMUhxwzu9RdbH1vjeE1
         JpJqwx0R6TMuXjVFpVjynUCumJ8Hr9tWy0u5RWvBg0/N1KwfGH2PI766KemIPNpOo6Hu
         00kSSufiVAzMc2NJ4MbGuthTvhfJQoiIwkoYAub9VSD+vThAdKtdDNGjAhs5D93qxS8Y
         ODYA==
X-Gm-Message-State: APjAAAVh6by97F/6saf8v5vfMqwpK59EQ0R2sA/N0ZJydZTYeVVHsTCb
        KmGSfj+cBnpszWFRAtgnRYEB/srppONKF0IvzdU=
X-Google-Smtp-Source: APXvYqxgIipg9JByOeSSia3UhSZgM/tRExQKLm3kt05xRhVsXoPTq99OO+g/bZv7VFfGXZfOpxxQ2QINgukymGWm1Yo=
X-Received: by 2002:ac8:b87:: with SMTP id h7mr25371582qti.253.1574813192455;
 Tue, 26 Nov 2019 16:06:32 -0800 (PST)
MIME-Version: 1.0
References: <a7ac93e3-9a1f-2cd5-bf0b-30b562bd707d@gmail.com> <20191126233735.GA215993@google.com>
In-Reply-To: <20191126233735.GA215993@google.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Tue, 26 Nov 2019 18:06:19 -0600
Message-ID: <CAL5oW01E=fE6=Z75THsBGd4XA67im5ivdzczAwmgCO1CaPzVng@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 26, 2019 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 25, 2019 at 03:03:23PM -0600, Stuart Hayes wrote:
> >
> > On 11/12/19 3:59 PM, Stuart Hayes wrote:
> > > The pciehp interrupt handler pciehp_isr() will read the slot status
> > > register and then write back to it to clear just the bits that caused the
> > > interrupt. If a different interrupt event bit gets set between the read and
> > > the write, pciehp_isr() will exit without having cleared all of the
> > > interrupt event bits, so we will never get another hotplug interrupt from
> > > that device.
> > >
> > > That is expected behavior according to the PCI Express spec (v.5.0, section
> > > 6.7.3.4, "Software Notification of Hot-Plug Events").
> > >
> > > Because the "presence detect changed" and "data link layer state changed"
> > > event bits are both getting set at nearly the same time when a device is
> > > added or removed, this is more likely to happen than it might seem. The
> > > issue can be reproduced rather easily by connecting and disconnecting an
> > > NVMe device on at least one system model.
> > >
> > > This patch fixes the issue by modifying pciehp_isr() to loop back and
> > > re-read the slot status register immediately after writing to it, until
> > > it sees that all of the event status bits have been cleared.
> > >
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> >
> > Bjorn,
> >
> > Do you have any comments or issues with this patch set?  Anything I can do?
>
> Were you planning to address Lukas' comments?
>
> https://lore.kernel.org/r/20191114025022.wz3gchr7w67fjtzn@wunner.de

Yes, I submitted a V2 for this patch (https://lkml.org/lkml/2019/11/20/1147).

But--I'm very sorry, I didn't mean to ask if you had any comments on
this patch--I meant to ask about an earlier patch set, and
accidentally replied to the wrong thread.

I meant to ask you about this patch set:
https://lore.kernel.org/lkml/20191025190047.38130-1-stuart.w.hayes@gmail.com/

Thank you!  --Stuart
