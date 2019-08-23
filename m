Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FBF9B70D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 21:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391603AbfHWT3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 15:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391604AbfHWT3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 15:29:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C880F21874;
        Fri, 23 Aug 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566588562;
        bh=uIK4gKr6LBqWcnb2353Sxa3YV4CobVhslIIjwr3IInY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X599OQxOO+nrYPeYotid93GGbP3k2bq7c7WrUd2ZmIe5Vg4vdw7aZUxBr+vMLehmw
         JJk9MQUwo2BckT04EGL40gX/Pfd67dhXfy46H34ENlXtsZls4eu3nVnLu1N8mBYQWC
         NOMfO7t3dKM+CHmhGzxF40Nx2QbGnoQU0BdHYZuE=
Date:   Fri, 23 Aug 2019 14:29:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/3] PCI: Add PCI_ERROR_RESPONSE definition
Message-ID: <20190823192920.GA127465@google.com>
References: <20190822200551.129039-1-helgaas@kernel.org>
 <20190822200551.129039-2-helgaas@kernel.org>
 <20190823104415.GC14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823104415.GC14582@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 23, 2019 at 11:44:15AM +0100, Andrew Murray wrote:
> On Thu, Aug 22, 2019 at 03:05:49PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > An MMIO read from a PCI device that doesn't exist or doesn't respond causes
> > a PCI error.  There's no real data to return to satisfy the CPU read, so
> > most hardware fabricates ~0 data.
> > 
> > Add a PCI_ERROR_RESPONSE definition for that and use it where appropriate
> > to make these checks consistent and easier to find.
> > 
> > Note that successful reads *also* may return ~0 data, so additional
> > information (e.g., knowledge that ~0 is not a valid register value) is
> > needed to reliably identify errors.

> > -	 * generally synthesize ~0 data to complete the read (except when
> > -	 * CRS SV is enabled and the read was for the Vendor ID; in that
> > -	 * case it synthesizes 0x0001 data).
> > +	 * generally synthesize ~0 data (PCI_ERROR_RESPONSE) to complete
> > +	 * the read (except when CRS SV is enabled and the read was for the
> > +	 * Vendor ID; in that case it synthesizes 0x0001 data).
> 
> There are some other areas in drivers/pci where comments also refer to ~0
> and similar:
> 
> $ git grep -i ffffffff drivers/pci/ | grep \*
> drivers/pci/access.c:            * have been written as 0xFFFFFFFF if hardware error happens
> drivers/pci/controller/dwc/pci-keystone.c: * bus error instead of returning 0xffffffff. This handler always returns 0
> drivers/pci/controller/pci-xgene.c:      * ready") instead of 0xFFFFFFFF ("device does not exist").  This
> drivers/pci/controller/pcie-iproc.c:     * eventually return the wrong data (0xffffffff).
> drivers/pci/pci.c: * FFFFFFFFs on the command line.)
> 
> I've removed anything in the above list that doesn't look like a good candidate
> for PCI_ERROR_RESPONSE.
> 
> Perhaps there is some value for replacing "~0" with "~0 (PCI_ERROR_RESPONSE)"
> in the comments too?

Good idea, I'll take a look at those.

> >  		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
> >  		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
> > -		    PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
> > +		    PCIBIOS_SUCCESSFUL || (status == (u32) PCI_ERROR_RESPONSE))
> 
> The casts are necessary but slightly annoying. Have you considered something
> like:
> 
> #define SET_PCI_ERROR_RESPONSE(val)	(val = ((typeof(val))(~0ULL)))
> #define RESPONSE_IS_PCI_ERROR(val)	(val == ((typeof(val))(~0ULL)))

I hadn't thought of that, but I really like the idea.  Thanks, I think
I'll try that out!

> >  			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
> >  
> >  		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9e700d9f9f28..d64fd3788061 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -123,6 +123,13 @@ enum pci_interrupt_pin {
> >  /* The number of legacy PCI INTx interrupts */
> >  #define PCI_NUM_INTX	4
> >  
> > +/*
> > + * Reading from a device that doesn't respond typically returns ~0.  A
> > + * successful read from a device may also return ~0, so you need additional
> > + * information to reliably identify errors.
> > + */
> > +#define PCI_ERROR_RESPONSE		(~0ULL)
> > +
> >  /*
> >   * pci_power_t values must match the bits in the Capabilities PME_Support
> >   * and Control/Status PowerState fields in the Power Management capability.
> > -- 
> > 2.23.0.187.g17f5b7556c-goog
> > 
