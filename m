Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522E3D99B4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhG1XqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 19:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232727AbhG1XqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 19:46:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B92604DB;
        Wed, 28 Jul 2021 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627515975;
        bh=bbS0zRKkb2SnZmwdiC86cRo8A0cn3GR5tuq6JQWneXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RERO4YLbB2avjAzTFUdBSaSP8auP0FSEbC00wPvguQcCsHYbXyxNzATQWDYCh6DTB
         cwfm5/nex/cCpBlaInw90nwZ1I81syAlnNLyRrrVV9qAogMdEHGHW1ynrOq1b2Ua/F
         NUPVOle4uBxz9BhITuGo8+wRH5524FMtfAD90TSjl1hAxJy+EFV1oxuaGgvcTcup3m
         IFZRlhir3ppv8MoMadYuVztPjiZ5rYp6cqsbmxIbALflxOsSsSGkOzHg3b2p6ug8Q5
         XhnNKzn+UfUNjd3D4ecQlK4pBKir4lleNo2NVBv7qHZ5uvKyzn4MLi/SE1Nn4m5g1D
         6c7CY/oUlxM4A==
Date:   Wed, 28 Jul 2021 18:46:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/5] PCI/VPD: Don't check Large Resource types for
 validity
Message-ID: <20210728234613.GA871409@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b0fd08b-4603-d7af-b936-95a3e451ee0c@suse.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 16, 2021 at 08:03:45AM +0200, Hannes Reinecke wrote:
> On 7/15/21 11:59 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > VPD consists of a series of Small and Large Resources.  Computing the size
> > of VPD requires only the length of each, which is specified in the generic
> > tag of each resource.  We only expect to see ID_STRING, RO_DATA, and
> > RW_DATA in VPD, but it's not a problem if it contains other resource types.
> > 
> > Drop the validity checking of Large Resource items.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/vpd.c | 37 ++++++++++++++-----------------------
> >   1 file changed, 14 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index 9c2744d79b53..d7a4a9f05bd6 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -82,31 +82,22 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
> >   		if (header[0] & PCI_VPD_LRDT) {
> >   			/* Large Resource Data Type Tag */
> >   			tag = pci_vpd_lrdt_tag(header);
> > -			/* Only read length from known tag items */
> > -			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
> > -			    (tag == PCI_VPD_LTIN_RO_DATA) ||
> > -			    (tag == PCI_VPD_LTIN_RW_DATA)) {
> > -				if (pci_read_vpd(dev, off+1, 2,
> > -						 &header[1]) != 2) {
> > -					pci_warn(dev, "failed VPD read at offset %zu",
> > -						 off + 1);
> > -					return 0;
> > -				}
> > -				size = pci_vpd_lrdt_size(header);
> > -
> > -				/*
> > -				 * Missing EEPROM may read as 0xff.
> > -				 * Length of 0xffff (65535) cannot be valid
> > -				 * because VPD can't be that large.
> > -				 */
> > -				if (size > PCI_VPD_MAX_SIZE)
> > -					goto error;
> > -				off += PCI_VPD_LRDT_TAG_SIZE + size;
> > -			} else {
> > -				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
> > -					 tag, off);
> > +			if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
> > +				pci_warn(dev, "failed VPD read at offset %zu",
> > +					 off + 1);
> >   				return 0;
> >   			}
> > +			size = pci_vpd_lrdt_size(header);
> > +
> > +			/*
> > +			 * Missing EEPROM may read as 0xff.  Length of
> > +			 * 0xffff (65535) cannot be valid because VPD can't
> > +			 * be that large.
> > +			 */
> > +			if (size > PCI_VPD_MAX_SIZE)
> > +				goto error;
> > +
> > +			off += PCI_VPD_LRDT_TAG_SIZE + size;
> >   		} else {
> >   			/* Short Resource Data Type Tag */
> >   			tag = pci_vpd_srdt_tag(header);
> > 
> I'm not entirely happy with this; we really have to rely on well-formed VPD
> tags for the protocol to work correctly, and that's why I took the cautious
> approach. But with the check for missing EEPROM I hope we've covered the
> most common causes for invalid tags. Let's see how it goes.

True.  The tags need to be well-formed in the sense of having
intelligible lengths so we can identify the beginning and end of each
resource.  But we don't actually depend on the resource name
(ID_STRING, etc) or the content.

> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
