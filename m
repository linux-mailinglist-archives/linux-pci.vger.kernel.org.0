Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2898A393A0F
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 02:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhE1AGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 20:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhE1AGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 20:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEE7C611C9;
        Fri, 28 May 2021 00:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622160291;
        bh=TZsH9RQGe/a33Z6yw5NLchRnLE8vX8Hg1n2GCyvagA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TBgKHkOazsQ7QfqPxCNEY/o1LC5pYCERsQkE4+sVBu48iv25laBloAwoh/3B2croO
         bzJdzYOac5hXjuMDUBjdHPzarEOWAlOVaCAx7yVn+zcTRfM+pIo7hI2oZR/gHQUsYm
         AOVcphI2SNg2ScWuXwaIduuPtAAS6fXXFQDvJzT5vURu3JJBP9FqZSgToAG6WlPYeZ
         mzlxca3QCnC+CThfW+13c21NyCPdkFsZwLJChm0k5HJx4R3z+Z6YH6HUuNHx2NxjAB
         2U8IgyE3suSzdB+4ECYMDAtEfFuC9osMudp6aajmORNL5AZ/ukOeHqhAfS7S685yRU
         uKaH7XQa2LBDQ==
Date:   Thu, 27 May 2021 19:04:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] PCI: Check value of resource alignment before using
 __ffs
Message-ID: <20210528000448.GA1448205@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526090612.a6i66ugimoxvyomg@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 02:36:12PM +0530, Amey Narkhede wrote:
> On 21/05/25 05:01PM, Bjorn Helgaas wrote:
> > On Thu, Apr 22, 2021 at 04:25:38PM +0530, Amey Narkhede wrote:
> > > Return value of __ffs is undefined if no set bit exists in
> > > its argument. This indicates that the associated BAR has
> > > invalid alignment.
> > >
> > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > ---
> > >  drivers/pci/setup-bus.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 2ce636937c6e..ce5380bdd2fd 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> > >  			 * resources.
> > >  			 */
> > >  			align = pci_resource_alignment(dev, r);
> > > -			order = __ffs(align) - 20;
> > > -			if (order < 0)
> > > -				order = 0;
> > > -			if (order >= ARRAY_SIZE(aligns)) {
> > > +			if (align) {
> > > +				order = __ffs(align) - 20;
> > > +				order = (order < 0) ? 0 : order;
> > > +			}
> > > +			if (!align || order >= ARRAY_SIZE(aligns)) {
> > >  				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
> > >  					 i, r, (unsigned long long) align);
> > >  				r->flags = 0;
> >
> > I know this is solving a theoretical problem.  Is it also solving a
> > *real* problem?
> >
> > I dislike the way it complicates the code and the usage of "align" and
> > "order".  I know that when "!align", we don't evaluate the
> > "order >= ARRAY_SIZE()" (which would involve an uninitialized value),
> > but it just seems ugly, and I'm not sure how much we benefit.
> >
> > And the "disabling BAR" part is gross.  I know you're not changing
> > that part, but it's just wrong.  Setting r->flags = 0 certainly does
> > not disable the BAR.  It might make Linux ignore it, but that doesn't
> > mean the hardware ignores it.  When we turn on PCI_COMMAND_MEMORY, the
> > BAR is enabled along with all the other memory BARs.
> >
> > Bjorn
> 
> Thanks for the detailed explanation. Is there any way to properly
> disable the BAR?

Unfortunately there is no way to disable an individual BAR.
PCI_COMMAND_MEMORY applied to *all* memory BARs, and the same for
PCI_COMMAND_IO.

> On the side note do you think this problem is
> worth solving? I came across this during code inspection.
> I mean if practically there aren't chances of
> this bug occuring I'm okay with dropping this patch.

I guess I would just drop it.  Yes, it's a potential problem, but I
couldn't figure out a solution that really seemed clean.

Bjorn
