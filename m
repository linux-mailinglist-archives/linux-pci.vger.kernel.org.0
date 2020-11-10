Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5785A2AE117
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJUyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 15:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJUyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 15:54:40 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAD620665;
        Tue, 10 Nov 2020 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605041678;
        bh=8kpsa4r/BRs2QEoPXMPzzCIoySjMMv+Iw5TZ2VJvq8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rb03Dp+6ZQpwg1CccJpHyrVMck3Wx80wpqcWNyV7umMj+4AUCZCRiI51xSgf1alvl
         Q5jBGoF5pi6Kw9UFyKNZrIgLl564ysrMdtmW+tOn9lRhUazHzfSQWJfshG+8ZLZwuB
         FDkf8+YksaW4koqhTVqa1r8kAEXO0o27Rt6N8Qyk=
Date:   Tue, 10 Nov 2020 14:54:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a potential uninitentional integer overflow
 issue
Message-ID: <20201110205436.GA692055@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106080419.GC29398@kadam>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 11:04:19AM +0300, Dan Carpenter wrote:
> On Thu, Nov 05, 2020 at 04:24:30PM -0600, Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2020 at 03:33:45PM +0300, Dan Carpenter wrote:
> > > On Wed, Oct 07, 2020 at 12:46:15PM +0100, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > The shift of 1 by align_order is evaluated using 32 bit arithmetic
> > > > and the result is assigned to a resource_size_t type variable that
> > > > is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
> > > > before widening issue by using the BIT_ULL macro to perform the
> > > > shift.
> > > > 
> > > > Addresses-Coverity: ("Uninitentional integer overflow")
> > 
> > s/Uninitentional/Unintentional/
> > Also in subject (please also capitalize subject)
> > 
> > Doesn't Coverity also assign an ID number for this specific issue?
> > Can you include that as well, e.g.,
> > 
> >   Addresses-Coverity-ID: 1226899 ("Unintentional integer overflow")
> > 
> > > > Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > ---
> > > >  drivers/pci/pci.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 6d4d5a2f923d..1a5844d7af35 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -6209,7 +6209,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> > > >  			if (align_order == -1)
> > > >  				align = PAGE_SIZE;
> > > >  			else
> > > > -				align = 1 << align_order;
> > > > +				align = BIT_ULL(align_order);
> > > 
> > > "align_order" comes from sscanf() so Smatch thinks it's not trusted.
> > > Anything above 63 is undefined behavior.  There should be a bounds check
> > > on this but I don't know what the valid values of "align" are.
> > 
> > The spec doesn't explicitly say what the size limit for 64-bit BARs
> > is, but it does say 32-bit BARs can support up to 2GB (2^31).  So I
> > infer that 2^63 would be the limit for 64-bit BARs.
> > 
> > What about something like the following?  To me, BIT_ULL doesn't seem
> > like an advantage over "1ULL << ", but maybe there's a reason to use
> > it.
> 
> The advantage of BIT_ULL() is that checkpatch and I think Coccinelle
> will suggest using it.  It's only recently where a few people have
> complained (actually you're probably the second person) that BIT() is
> sort of a weird thing to use for size variables.

If that's the only reason, I definitely prefer "1ULL << align_order".

BIT_ULL is just a pointless abstraction in this case.
