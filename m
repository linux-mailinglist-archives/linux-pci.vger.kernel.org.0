Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236E42B2CD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 04:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJMCqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 22:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhJMCqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 22:46:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CAF460F38;
        Wed, 13 Oct 2021 02:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634093037;
        bh=uWF2h7wVwbhN8R7YBCXFrfY9XfSneeNPhl9j7cDE2Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D+wndaYugsj0a/KFWj6jNfG705tzZ2S8OvWtV5jg0htFcEJYGSnVD709jkZ+01kdn
         CRQ07wIquGb02knjyBWRm6YpN2oLCOXlOJH0+V1Yth06b1vllZvSgdhLCoIlBC9TfR
         CVi1kPJMPu13cBZceSWDQdmJOVegGM2J/dQqkBU4kdOKsd+2zTRmszOuTZdvfKNsLp
         bGFWyLvvrjlSBY1RmNOfqpopNq400+lz6Oe+FXcmyYEaZ4mugnq5l+wap0Q7ruO2kt
         xtV1K/iXdHVR+1T1QeZ4KykNenNwP6Nle3g5pdKVX9FHTvRobBXc9rQvC3Dk3DxV1s
         xKfNOhbxPqO6g==
Date:   Tue, 12 Oct 2021 21:43:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211013024355.GA1865721@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWS1QtNJh7vPCftH@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali]

On Mon, Oct 11, 2021 at 05:05:54PM -0500, Rob Herring wrote:
> On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Use SET_PCI_ERROR_RESPONSE() to set the error response and
> > RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> > read.
> > 
> > These definitions make error checks consistent and easier to find.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/access.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 46935695cfb9..e1954bbbd137 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> >  
> >  	addr = bus->ops->map_bus(bus, devfn, where);
> >  	if (!addr) {
> > -		*val = ~0;
> > +		SET_PCI_ERROR_RESPONSE(val);
> 
> This to me doesn't look like kernel style. I'd rather see a define 
> replace just '~0', but I defer to Bjorn.
> 
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> Neither does this using custom error codes rather than standard Linux 
> errno. I point this out as I that's were I'd start with the config 
> accessors. Though there are lots of occurrences so we'd need a way to do 
> this in manageable steps.

I would love to see PCIBIOS_* confined to arch/x86 and everywhere else
using standard Linux error codes.  That's probably a lot of work, but
Naveen has a lot of energy :)

> Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value 
> and delete the drivers all doing this? Then we have 2 copies (in source) 
> rather than the many this series modifies. Though I'm not sure if there 
> are other cases of calling pci_bus.ops.read() which expect to get ~0.

That does seem like a really good idea.

Bjorn
