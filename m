Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C143E783
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 19:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhJ1Rty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 13:49:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Rtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 13:49:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5DA71063;
        Thu, 28 Oct 2021 10:47:24 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23FA93F5A1;
        Thu, 28 Oct 2021 10:47:24 -0700 (PDT)
Date:   Thu, 28 Oct 2021 18:47:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028174710.GA4484@lpieralisi>
References: <20211027141246.GA27543@lpieralisi>
 <20211027142307.lrrix5yfvroxl747@pali>
 <20211028110835.GA1846@lpieralisi>
 <20211028111302.gfd73ifoyudttpee@pali>
 <20211028113030.GA2026@lpieralisi>
 <20211028113724.gm6zhqt7qcyxtgkq@pali>
 <87r1c59nqf.wl-maz@kernel.org>
 <20211028175150.7faa6481@thinkpad>
 <20211028182514.65a94c8e@thinkpad>
 <87o8799j9c.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8799j9c.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 28, 2021 at 06:00:47PM +0100, Marc Zyngier wrote:
> On Thu, 28 Oct 2021 17:25:14 +0100,
> Marek Behún <kabel@kernel.org> wrote:
> > 
> > On Thu, 28 Oct 2021 17:51:50 +0200
> > Marek Behún <kabel@kernel.org> wrote:
> > 
> > > Marc, we have ~70 patches ready for the aardvark controller driver.
> > > 
> > > It is patch 53 [1] that converts the old irq_find_mapping() +
> > > generic_handle_irq() API to the new API, so it isn't that Pali did
> > > not address your comments, it is that, due to convenience, he addressed
> > > them in a later patch.
> > > 
> > > The last time Pali sent a larger number of paches (in a previous
> > > version, which was 42 patches [1]), it was requested that we split the
> > > series into smaller sets, so that it is easier to merge.
> > > 
> > > Since then some more changes accumulated, resulting in the current ~70
> > > patches, which I have been sending in smaller batches.
> > > 
> > > I could rebase the entire thing so that the patch changing the usage of
> > > the old irq_find_mapping() + generic_handle_irq() API is first. But
> > > that would require rebasing and testing all the patches one by one,
> > > since the patches in-between touch everything almost everything else.
> > > 
> > > If it is really that problematic to review the changes while they use
> > > the old API, please let me know and I will rebase it. But if you could
> > > find it in yourself to review the patches with old API usage, it would
> > > really save a lot of time and the result will be the same, to your
> > > satisfaction.
> > 
> > Lorenzo, Marc, Bjorn,
> > 
> > I have one more question.
> > 
> > Pali prepared the ~70 patches so that fixes come first, and
> > new features / changes to new API later.
> > 
> > He did it in this way so that the patches could be then conventiently
> > backported to stable versions - were we to first change the API usage
> > to the new API, and then fix the ~20 IRQ related things, we would
> > afterwards have to backport the fixes by rewriting them one by one.
> > 
> > Is this really how we should do this? Should we ignore stable while
> > developing for master, regardless of how much other work would need to
> > be spent by backporting to master, even if it could be much simpler by
> > applying the patches in master in another order?
> 
> I already replied to that in August. Upstream is the primary
> development target. If you want to backport patches, do them and make
> the changes required so that they are correct for whatever kernel you
> target. Stable doesn't matter to upstream at all.

+1

Please don't write patch series with stable backports in mind, don't.

Let's focus on mailine with one series at a time, I understand it is
hard but that's the only way we can work and I can keep track of what
you are doing, if we keep splitting patch series I can't track reviews
and then we end up in this situation. I asked if you received Marc's
feedback exactly because I can't track the original discussion and if I
merged the series (the MSI bits) I would have ignored what Marc
requested you to do and that's not OK.

So, given the timing, I will try to merge patches [1-3] and [11-14]
if I can rebase the series cleanly; maybe I can include patch 9 if
it does not depend on previous patches.

Thanks,
Lorenzo
