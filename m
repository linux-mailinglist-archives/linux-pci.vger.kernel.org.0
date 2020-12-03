Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243E2CE18B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 23:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgLCW0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 17:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgLCW03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 17:26:29 -0500
Date:   Thu, 3 Dec 2020 16:25:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607034348;
        bh=yVGI5M3I+UaUj1E+WUU3WDgydAUggfjpWAyIFD8U8a0=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=gnJTeSyyvIGQsuiX/SRqFPYlTpyAxvF61lG4Fzo2zV21oYkSGG88LokJnP0Oqmsei
         4DH0S3EA46iatrqA4Fq8J1MJZ1O43gmkPW5I94429Vi1hWRpyg/5EMeW05Qi7qTCWA
         ENlVjSewzZzGnVvUA6Vcnp0AGqiVvQsvY8XDMh9+WFrjlSScThiNx0iDGPf3DMzR5b
         5GSWPT6kNlbkLt8x4/TkcsUxC6m8GrpHM4DZVE2LCAMUnH1zUgaox5QXtANsxUD5I3
         X/1/0JVVDYAhpIkdE6NI3Yp1hhr8VtH4ZFyZKOKOdNibnAcr6kmZrNFDlq70zGXP0K
         Rsfk+DDONtQXg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v12 05/15] PCI/ERR: Simplify by using
 pci_upstream_bridge()
Message-ID: <20201203222546.GA1600426@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA95A917-CCFA-4A21-9146-0626716CAF65@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 06:45:00PM +0000, Kelley, Sean V wrote:
> Just confirming that when switched from dev->bus->self to
> pci_upstream_bridge() we’re okay with the NULL case:
> 
> > On Nov 20, 2020, at 4:10 PM, Sean V Kelley <sean.v.kelley@intel.com> wrote:
> > 
> > Use pci_upstream_bridge() in place of dev->bus->self.  No functional change
> > intended.
> > 
> > [bhelgaas: split to separate patch]
> > Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> > drivers/pci/pcie/err.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index db149c6ce4fb..05f61da5ed9d 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -159,7 +159,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > 	 */
> > 	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > 	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > -		dev = dev->bus->self;
> > +		dev = pci_upstream_bridge(dev);
> 
> The only case where pci_upstream_bridge(dev) could be NULL is if
> dev->bus is the root bus and we are being selective based on the
> type.

Yes, pci_upstream_bridge(dev) returns NULL if dev is on a root bus.
I think bus->self is NULL for root buses anyway, so I think this patch
is OK at least at this point in the series.

> Even later in this series when we actually add in RC_EC/RC_END we
> maintain the conditional checks:
> 
> https://lore.kernel.org/linux-pci/20201121001036.8560-11-sean.v.kelley@intel.com/
> 
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> 
> @@ -174,10 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> 
>  
>  	/*
>  	 * Error recovery runs on all subordinates of the bridge.  If the
> -	 * bridge detected the error, it is cleared at the end.
> +	 * bridge detected the error, it is cleared at the end.  For RCiEPs
> +	 * we should reset just the RCiEP itself.
> 
>  	 */
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_DOWNSTREAM)
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_RC_EC ||
> +	    type == PCI_EXP_TYPE_RC_END)
>  		bridge = dev;
>  	else
>  		bridge = pci_upstream_bridge(dev);
> 
> I believe we are okay here.

Well, I think we're at least no worse than today.  Today we keep
"bridge == dev" for Root Ports and Downstream Ports, and use
"bridge = dev->bus->self" for everything else.

After this series we keep "bridge == dev" for RCEC and RCiEPs in
addition.

I'm not sure about PCI_EXP_TYPE_PCI_BRIDGE, which is a PCIe-to-PCI
bridge.  According to the ancient "PCI Express to PCI/PCI-X Bridge
Specification" r1.0 of July 14, 2003, sec 5.23, these bridges can have
an AER Capability (with different format that I don't see mentioned
elsewhere).

But this AER Capability doesn't have the Root registers, so I assume
it would have to be below a Root Port in order to actually signal the
errors, which would mean it could not be on a root bus.

So I don't really *love* the fact that we use pci_upstream_bridge()
and rely on these assumptions that the result will not be NULL, but I
guess it's OK for now.

> > 	bus = dev->subordinate;
> > 
> > 	pci_dbg(dev, "broadcast error_detected message\n");
> > -- 
> > 2.29.2
> > 
> > 
> 
