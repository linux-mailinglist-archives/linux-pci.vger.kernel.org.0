Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07D81E5099
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE0Vki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 17:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0Vkh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 17:40:37 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 460DF2075A;
        Wed, 27 May 2020 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590615636;
        bh=pFdpyoxwe3uUHiar6GLuq2xYndiOyAmdHSmOWg7qQIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tZJ6jU5gC05AY1YgkaqnSIY12ckLauqVN4vziuwcmrHxKvKojNWaXUmpESd68y0h9
         C4YtSkGUFN1alSHqSHv+woIWRJBeg4Xpfeu+1se3idd1DrmnJEP7BfyRDsQYl9Voj0
         Ti+t+J+r+GCWap56RUNCKjMjszf3ZN5F27AoESVs=
Date:   Wed, 27 May 2020 16:40:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] PCI/PTM: Fix PTM switch capability evaluation
Message-ID: <20200527214034.GA266668@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276AA9D6ED3B737DD6C9F70DAB40@DM5PR12MB1276.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 02:46:32PM +0000, Gustavo Pimentel wrote:
> On Thu, May 21, 2020 at 21:50:13, Bjorn Helgaas <helgaas@kernel.org> 
> wrote:
> 
> > On Thu, May 21, 2020 at 03:37:30PM +0200, Gustavo Pimentel wrote:
> > > In order to enable PTM feature in a PCIe Endpoint, it is required to
> > > enable this feature as well in all devices capable (if present) in the
> > > datapath between the Root complex and the referred Endpoint e.g. PCIe
> > > switches.
> > > 
> > > RC <--> Switch (USP) <-> Switch (DSP) <-> EP
> > > 
> > > According to PCIe specification Rev5 (6.22.3.2) and (7.9.16), in order
> > > to enable this feature on a PTM capable switch, it's required to write a
> > > enable bit in the switch upstream port (USP) control register, which after
> > > that must respond to all PTM request messages received at any of its
> > > downstream ports (DSP).
> > > 
> > > The previous implementation verifies if the PCIe switch has the PTM
> > > feature enabled on both streams ports (USP and DSP). Since the DSP
> > > doesn't support PTM capability, the previous implementation doesn't
> > > allow the PTM feature to be enabled in the Endpoint, the current patch
> > > fixes this.
> > > 
> > > Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints")
> > > Signed-off-by: Aditya Paluri <venkata.adityapaluri@synopsys.com>
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: Joao Pinto <jpinto@synopsys.com>
> > 
> > The existing code is definitely broken.  I would prefer to fix this on
> > the enumeration side, as opposed to walking the tree at enable-time.
> > Can you try the alternate patch below?
> 
> Ok, we have tested your patch and it's working.

Thanks!  I applied this to pci/enumeration for v5.8.

> > > ---
> > >  drivers/pci/pcie/ptm.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > > index 9361f3a..cd85d44 100644
> > > --- a/drivers/pci/pcie/ptm.c
> > > +++ b/drivers/pci/pcie/ptm.c
> > > @@ -111,6 +111,14 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> > >  	 */
> > >  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> > >  		ups = pci_upstream_bridge(dev);
> > > +		/*
> > > +		 * Per PCIe r5.0, sec 7.9.16, the PTM capability is not
> > > +		 * permitted in Switch Downstream Ports
> > > +		 */
> > > +		if (ups && ups->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
> > > +		    pci_pcie_type(ups) == PCI_EXP_TYPE_DOWNSTREAM)
> > > +			ups = pci_upstream_bridge(ups);
> > > +
> > >  		if (!ups || !ups->ptm_enabled)
> > >  			return -EINVAL;
> > >  
> > 
> > commit b9e92258d486 ("PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Port")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Thu May 21 15:40:07 2020 -0500
> > 
> >     PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Port
> >     
> >     Except for Endpoints, we enable PTM at enumeration-time.  Previously we did
> >     not account for the fact that Switch Downstream Ports may not have a PTM
> >     capability; their PTM behavior is controlled by the Upstream Port (PCIe
> >     r5.0, sec 7.9.16).  Since Downstream Ports don't have a PTM capability, we
> >     did not mark them as "ptm_enabled", which meant that pci_enable_ptm() on an
> >     Endpoint failed because there was no PTM path to it.
> >     
> >     Mark Downstream Ports as "ptm_enabled" if their Upstream Port has PTM
> >     enabled.
> >     
> >     Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints")
> >     Reported-by: Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 9361f3aa26ab..0c42573a66d8 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -39,10 +39,6 @@ void pci_ptm_init(struct pci_dev *dev)
> >  	if (!pci_is_pcie(dev))
> >  		return;
> >  
> > -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > -	if (!pos)
> > -		return;
> > -
> >  	/*
> >  	 * Enable PTM only on interior devices (root ports, switch ports,
> >  	 * etc.) on the assumption that it causes no link traffic until an
> > @@ -52,6 +48,23 @@ void pci_ptm_init(struct pci_dev *dev)
> >  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
> >  		return;
> >  
> > +	/*
> > +	 * Switch Downstream Ports may not have a PTM capability; their PTM
> > +	 * behavior is controlled by the Upstream Port (PCIe r5.0, sec
> > +	 * 7.9.16).
> > +	 */
> > +	ups = pci_upstream_bridge(dev);
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM &&
> > +	    ups && ups->ptm_enabled) {
> > +		dev->ptm_granularity = ups->ptm_granularity;
> > +		dev->ptm_enabled = 1;
> > +		return;
> > +	}
> > +
> > +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > +	if (!pos)
> > +		return;
> > +
> >  	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> >  	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
> >  
> > @@ -61,7 +74,6 @@ void pci_ptm_init(struct pci_dev *dev)
> >  	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
> >  	 * furthest upstream Time Source as the PTM Root.
> >  	 */
> > -	ups = pci_upstream_bridge(dev);
> >  	if (ups && ups->ptm_enabled) {
> >  		ctrl = PCI_PTM_CTRL_ENABLE;
> >  		if (ups->ptm_granularity == 0)
> 
> 
