Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDFE3D99AB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhG1Xmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 19:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhG1Xmt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 19:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D348A61039;
        Wed, 28 Jul 2021 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627515767;
        bh=5v/dtdMsfS4+iw/3NHJSpTvoghPXApVRUb3IyCvWP1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jz5nvf1H6v/BOPf7LFFtiAUMu28v0MwpvRxRYC+G7Q/LM/P9o6D9l1sx8nGPOv896
         wrYVW7K8X+ih0p7F73XeQ41za13M36tW1tkkLTen2xJ/nwHpWu0VxUmgC9Lx7yrZdI
         HFMX0kHeSfhui3ONJ9kbgqQmaqxZou6M9yTDeskT+7bJqemZ/k0wf+FOkIf1PiCHMy
         dSMdCGnYO6sgzImPMtZe4sQqCxGn845C0BlnzIvTQy8k4MDieZmKpx09rfpIOkT6gO
         b1f8xkGrPh4pthOKVs1BLqu6zQfkplWhl1rrTmdEtSVZMYU+OSGQ37+zHAZyvoUP2A
         oads0L618XBmw==
Date:   Wed, 28 Jul 2021 18:42:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/5] PCI/VPD: Consolidate missing EEPROM checks
Message-ID: <20210728234245.GA868725@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77979cb8-776b-3bd3-3552-593ea6ebad92@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 16, 2021 at 12:16:55AM +0200, Heiner Kallweit wrote:
> On 15.07.2021 23:59, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > A missing VPD EEPROM typically reads as either all 0xff or all zeroes.
> > Both cases lead to invalid VPD resource items.  A 0xff tag would be a Large
> > Resource with length 0xffff (65535).  That's invalid because VPD can only
> > be 32768 bytes, limited by the size of the address register in the VPD
> > Capability.
> > 
> > A VPD that reads as all zeroes is also invalid because a 0x00 tag is a
> > Small Resource with length 0, which would result in an item of length 1.
> > This isn't explicitly illegal in PCIe r5.0, sec 6.28, but the format is
> > derived from PNP ISA, which *does* say "a small resource data type may be
> > 2-8 bytes in size" (Plug and Play ISA v1.0a, sec 6.2.2.
> > 
> > Check for these invalid tags and return VPD size of zero if we find them.
> > If they occur at the beginning of VPD, assume it's the result of a missing
> > EEPROM.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/vpd.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index 9b54dd95e42c..9c2744d79b53 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -77,11 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
> >  
> >  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
> >  		unsigned char tag;
> > -
> > -		if (!header[0] && !off) {
> > -			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
> > -			return 0;
> > -		}
> > +		size_t size;
> >  
> >  		if (header[0] & PCI_VPD_LRDT) {
> >  			/* Large Resource Data Type Tag */
> > @@ -96,8 +92,16 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
> >  						 off + 1);
> >  					return 0;
> >  				}
> > -				off += PCI_VPD_LRDT_TAG_SIZE +
> > -					pci_vpd_lrdt_size(header);
> > +				size = pci_vpd_lrdt_size(header);
> > +
> > +				/*
> > +				 * Missing EEPROM may read as 0xff.
> > +				 * Length of 0xffff (65535) cannot be valid
> > +				 * because VPD can't be that large.
> > +				 */
> 
> I'm not fully convinced. Instead of checking for a "no VPD EPROM" read (00/ff)
> directly, we now do it indirectly based on the internal tag structure.
> We have pci_vpd_lrdt_size() et al to encapsulate the internal structure.
> IMO the code is harder to understand now.

I don't quite follow.  Previously we checked for 0x00 data
("if (!header[0] && !off)"), but we didn't check directly for 0xff.

If we read 0xff, we took the PCI_VPD_LRDT case, but it wouldn't match
ID_STRING, RO_DATA, or RW_DATA, so we'd fall out and check again
against ID_STRING, RO_DATA, and RW_DATA, and take the "invalid
%s VPD tag" error path because it doesn't match any.

This results in failure for any large resource except ID_STRING,
RO_DATA, and RW_DATA, regardless of the size.

My proposed code catches a different set of invalid things.
"size > PCI_VPD_MAX_SIZE" will catch any large resource headers with
length 0x8001 through 0xffff.

Possibly it should actually check for "off + size > PCI_VPD_MAX_SIZE"
so e.g., it would catch a 0x20 byte resource starting at 0x7ff0.

> > +				if (size > PCI_VPD_MAX_SIZE)
> > +					goto error;
> > +				off += PCI_VPD_LRDT_TAG_SIZE + size;
> >  			} else {
> >  				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
> >  					 tag, off);
> > @@ -105,14 +109,28 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
> >  			}
> >  		} else {
> >  			/* Short Resource Data Type Tag */
> > -			off += PCI_VPD_SRDT_TAG_SIZE +
> > -				pci_vpd_srdt_size(header);
> >  			tag = pci_vpd_srdt_tag(header);
> > +			size = pci_vpd_srdt_size(header);
> > +
> > +			/*
> > +			 * Missing EEPROM may read as 0x00.  A small item
> > +			 * must be at least 2 bytes.
> > +			 */
> > +			if (size == 0)
> > +				goto error;
> > +
> > +			off += PCI_VPD_SRDT_TAG_SIZE + size;
> >  			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
> >  				return off;
> >  		}
> >  	}
> >  	return 0;
> > +
> > +error:
> > +	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
> > +		 header[0], off, off == 0 ?
> > +		 "; assume missing optional EEPROM" : "");
> > +	return 0;
> >  }
> >  
> >  /*
> > 
> 
