Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110345504E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhKQWW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhKQWW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 17:22:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B95261B51;
        Wed, 17 Nov 2021 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637187597;
        bh=WDOpFX4ILHdxhaCqTmNeTvnW8uAAY2H0GvXbP/PjOP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EYPvQQA0fa5BxLXrxbOmwQdTjyzv74LT3vXWYJa3ClPeKHfsylRVA46nvOk5Q2SeI
         8PmAvN5YNX/xSdjxREu7MZKUvdxv4pVGexVRPI29wwJ8mDwK5ll5BweY3PuHSzeVb/
         H5nUGPr5/+JrJnL1g+MrgTAig77/8fwjUuuFa2O2KnazBypO2MLuR5ymeKf8RHwZZ5
         qFByz7uFmb2neVI5K0+j6WCwnR5FHHx63j4r7j5Mesewv9ZyQYA3uq+bsx4a4C9nBU
         B/T7DJ/cpMiMZtOhuLYlgIL49oy8EH4DaFudot0peI+bIS2fY9omFS9AoTx680lPsl
         uQPUco0H2EwtA==
Date:   Wed, 17 Nov 2021 16:19:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2] PCI/VPD: Add simple sanity check to pci_vpd_size()
Message-ID: <20211117221955.GA1780304@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3d20c2f-f1be-507e-5ddc-df3241aef1c0@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 10:31:51PM +0100, Heiner Kallweit wrote:
> On 13.10.2021 20:37, Heiner Kallweit wrote:
> > We have a problem with a device where each VPD read returns 0x33 [0].
> > This results in a valid VPD structure (except the tag id) and
> > therefore pci_vpd_size() scans the full VPD address range.
> > On an affected system this took ca. 80s.
> > 
> > That's not acceptable, on the other hand we may not want to re-add
> > the old tag checks. In addition these tag check still wouldn't be able
> > to avoid the described scenario 100%.
> > Instead let's add a simple sanity check on the number of found tags.
> > A VPD image conforming to the PCI spec [1] can have max. 4 tags:
> > id string, ro section, rw section, end tag.
> > 
> > [0] https://lore.kernel.org/lkml/20210915223218.GA1542966@bjorn-Precision-5520/
> > [1] PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags
> > 
> > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/pci/vpd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a4fc4d069..921470611 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -56,6 +56,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
> >  {
> >  	size_t off = 0, size;
> >  	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
> > +	int num_tags = 0;
> >  
> >  	while (pci_read_vpd_any(dev, off, 1, header) == 1) {
> >  		size = 0;
> > @@ -63,6 +64,10 @@ static size_t pci_vpd_size(struct pci_dev *dev)
> >  		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
> >  			goto error;
> >  
> > +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
> > +		if (++num_tags > 4)
> > +			goto error;
> > +
> >  		if (header[0] & PCI_VPD_LRDT) {
> >  			/* Large Resource Data Type Tag */
> >  			if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) != 2) {
> > 
> 
> Can this one be picked up for next?

I'm hesitating because we (or maybe just "I" :)) worked so hard to
avoid interpreting the VPD data, and now we're back to that.

There's nothing of value in this particular device's VPD.  Is there
any reason we shouldn't just use quirk_blacklist_vpd() for it?

Bjorn
