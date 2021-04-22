Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9D367EE0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhDVKmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 06:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235796AbhDVKmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Apr 2021 06:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 142C9613C3;
        Thu, 22 Apr 2021 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619088116;
        bh=rRnAUyXUsOA2UHDC3FlcHxQvTIIy0TFugmG8qXly9t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=co/OBM8tdr0JaX+0TOI+9wDV7cdJOgD2c7bGkaR/q2huFJ4NAdbpkGZabxfRyi2/W
         Gc5c1dKzyyv5F7UYkgwErVW4/Mr3dbsZRmPkyfWvopDqGImRJXXLFCec5n0aDa8zK+
         BDa6V1juvpRJoz2yTtDhyscWgwyC0aYufXkG/Q48m7zEnRYOG/UN+gufK1OQY2A1Ml
         Cwhp4zycfJtyQEsEs4nJJKNrBZt25OUXLUkZrDOndEh4dQWi149alIQzIzdmcGjMxI
         n8oWq/MjQ1Tgnxrfd2LHkt6mt2KceshnAx/R8vzthn0ofMn2SSBQs6xehR2Nj602yJ
         h7fqsc8Bad1+g==
Date:   Thu, 22 Apr 2021 13:41:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check value of resource alignment before using __ffs
Message-ID: <YIFS720CvbjYTbLQ@unreal>
References: <20210421184747.62391-1-ameynarkhede03@gmail.com>
 <YIEa/5E45SzKzvuf@unreal>
 <20210422094323.i4foiagx3hmzxpj4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422094323.i4foiagx3hmzxpj4@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 22, 2021 at 03:13:23PM +0530, Amey Narkhede wrote:
> On 21/04/22 09:43AM, Leon Romanovsky wrote:
> > On Thu, Apr 22, 2021 at 12:17:47AM +0530, Amey Narkhede wrote:
> > > Return value of __ffs is undefined if no set bit exists in
> > > its argument. This indicates that the associated BAR has
> > > invalid alignment.
> > >
> > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > ---
> > >  drivers/pci/setup-bus.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 2ce636937c6e..44e8449418ae 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1044,6 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> > >  			 * resources.
> > >  			 */
> > >  			align = pci_resource_alignment(dev, r);
> > > +			if (!align) {
> > > +				pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > > +					 i, r);
> > > +				continue;
> > > +			}
> >
> > I see that you copied it from pdev_sort_resources(), but it is
> > incorrect change, see how negative order is handled and later
> > ARRAY_SIZE() check.
> >
> > Thanks
> >
> Is it guaranteed that it will return value which will result
> in negative value or >= ARRAY_SIZE? Comment on __ffs says value
> is undefined for 0 that means it could be anything or am I missing
> something?

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2ce636937c6e..ce5380bdd2fd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
                         * resources.
                         */
                        align = pci_resource_alignment(dev, r);
-                       order = __ffs(align) - 20;
-                       if (order < 0)
-                               order = 0;
-                       if (order >= ARRAY_SIZE(aligns)) {
+                       if (align) {
+                               order = __ffs(align) - 20;
+                               order = (order < 0) ? 0 : order;
+                       }
+                       if (!align || order >= ARRAY_SIZE(aligns)) {
                                pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
                                         i, r, (unsigned long long) align);
                                r->flags = 0;


> 
> Thanks,
> Amey
