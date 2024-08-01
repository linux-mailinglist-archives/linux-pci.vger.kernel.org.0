Return-Path: <linux-pci+bounces-11120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EAF945136
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FD9283B80
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF71B8EB6;
	Thu,  1 Aug 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe+u7jtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65D1B4C5D;
	Thu,  1 Aug 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531602; cv=none; b=PHugBsWE81zPiLaAXbDqVA+L67Ug9/iWnDMfMNhim6hxvbHf6V391E17S9rU5MgjerkDVlMEJf91bSSmR1ARL64XHKRpQXTDUON9bJgBDrs0iPC3p9lDFfyCTaemTY8tKPUAAzXQgFc+h7VU7Rvgw2XkeYGezv5TeRvbU1IT9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531602; c=relaxed/simple;
	bh=A/7RObg8Tzl1vD90LuvoQOcriMT+2Jss1+r/SM4KW0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tGIzfrj0CXPCYcQNTyf5dDB5rHoFpy7OiZ0cDZSl1jrEkYXScFPZ9JWsU9q6CAoHdG6aripeZCI5L/98+V6Wv24ZROgeyziE9+vwiZ9KZp1YUSAjDGDESLrB/DjIXsaDyJ/3+8+Nuxuzv80oXbQjXnMv8P9MHB30+1AFCjEKuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe+u7jtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53023C32786;
	Thu,  1 Aug 2024 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722531601;
	bh=A/7RObg8Tzl1vD90LuvoQOcriMT+2Jss1+r/SM4KW0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xe+u7jtrOH5CGdYNy2kTw9DpuDLkwzzEi5EoDbbYjhQAmwGUvgkhctGYRLFQq3n1a
	 CKml7FNT0Z1wEvu1CbY49ZfYjvC6ruVi79mfuhk9pobGvJJtyFNqpOZbnptU/hVHbF
	 YSqBHCKqs6P9O2cBEGAX0nbJd9M/1nJSSAADfSMJpQf//WZiPyftLXWipsyK5BFcq6
	 68uxzeyZYYjn6+tnhkC7j2owaEh7uQ8lynHBq5dCIIVB9cG12OI0OMwkE3d8lRpkdG
	 N9pEIAw9PaUIB73n0jPrtI0tJgmyxh+tVymu3sT50X9f0qElnLelskrA3bk7yySKF2
	 c16XipuV6gfYg==
Date: Thu, 1 Aug 2024 11:59:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: s390: Handle ARI on bus without associated struct
 pci_dev
Message-ID: <20240801165959.GA83976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06e8e396d64d7202f9a8aae91e0c556b344cc5b.camel@linux.ibm.com>

On Tue, Jul 30, 2024 at 09:59:13PM +0200, Niklas Schnelle wrote:
> On Tue, 2024-07-30 at 21:36 +0200, Niklas Schnelle wrote:
> > On s390 PCI busses are virtualized and the downstream ports are
> > invisible to the OS and struct pci_bus::self is NULL. This associated
> > struct pci_dev is however relied upon in pci_ari_enabled() to check
> > whether ARI is enabled for the bus. ARI is therefor always detected as
> > disabled.
> > 
> > At the same time firmware on s390 always enables and relies upon ARI
> > thus causing a mismatch. Moreover with per-PCI function pass-through
> > there may exist busses with no function with devfn 0. For example
> > a SR-IOV capable device with two PFs may have separate function
> > dependency link chains for each of the PFs and their child VFs. In this
> > case the OS may only see the second PF and its child VFs on a bus
> > without a devfn 0 function. A situation which is also not supported by
> > the common pci_configure_ari() code.
> > 
> > Dispite simply being a mismatch this causes problems as some PCI devices
> > present a different SR-IOV topology depending on PCI_SRIOV_CTRL_ARI.
> > 
> > A similar mismatch may occur with SR-IOV when virtfn_add_bus() creates new
> > busses with no associated struct pci_dev. Here too pci_ari_enabled()
> > on these busses would return false even if ARI is actually used.
> > 
> > Prevent both mismatches by moving the ari_enabled flag from struct
> > pci_dev to struct pci_bus making it independent from struct pci_bus::
> > self. Let the bus inherit the ari_enabled state from its parent bus when
> > there is no bridge device such that busses added by virtfn_add_bus()
> > match their parent. For s390 set ari_enabled when the device supports
> > ARI in the awareness that all PCIe ports on s390 systems are ARI
> > capable.
> > 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci_bus.c | 12 ++++++++++++
> >  drivers/pci/pci.c       |  4 ++--
> >  drivers/pci/probe.c     |  1 +
> >  include/linux/pci.h     |  4 ++--
> >  4 files changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> > index daa5d7450c7d..021319438dad 100644
> > --- a/arch/s390/pci/pci_bus.c
> > +++ b/arch/s390/pci/pci_bus.c
> > @@ -278,6 +278,18 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
> >  {
> >  	struct zpci_dev *zdev = to_zpci(pdev);
> >  
> > +	/*
> > +	 * On s390 PCI busses are virtualized and the bridge
> > +	 * devices are invisible to the OS. Furthermore busses
> > +	 * may exist without a devfn 0 function. Thus the normal
> > +	 * ARI detection does not work. At the same time fw/hw
> > +	 * has always enabled ARI when possible. Reflect the actual
> > +	 * state by setting ari_enabled whenever a device on the bus
> > +	 * supports it.
> > +	 */
> > +	if (pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ARI))
> > +		zdev->zbus->bus->ari_enabled = 1;
> > +
> 
> @Bjorn unstead of adding the above code to s390 specific code an
> alternative I considered would be to modify pci_configure_ari() like
> below. I tested this as well but wasn't sure if it is too much churn
> especially the handling of the dev->devfn != 0 case. Then again it
> might be nice to have this in common code.
> 
> @@ -3523,12 +3524,18 @@ void pci_configure_ari(struct pci_dev *dev)
>         u32 cap;
>         struct pci_dev *bridge;
> 
> -       if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> +       if (pcie_ari_disabled || !pci_is_pcie(dev))
> +               return;
> +
> +       if (dev->devfn && !hypervisor_isolated_pci_functions())
>                 return;
> 
>         bridge = dev->bus->self;
> -       if (!bridge)
> +       if (!bridge) {
> +               if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI))
> +                       dev->bus->ari_enabled = 1;

In the generic case here, how do we know whether the invisible bridge
leading here has ARI enabled?  If that's known to always be the case
for s390, I understand that, but I don't understand the other cases
(jailhouse, passthrough, etc).

>                 return;
> +       }
> 
>         pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
>         if (!(cap & PCI_EXP_DEVCAP2_ARI))
> 

