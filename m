Return-Path: <linux-pci+bounces-30935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4381AEBC6C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E40F170CB2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641F2E8E05;
	Fri, 27 Jun 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXr6Ef0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4B171C9;
	Fri, 27 Jun 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039497; cv=none; b=Fq272AjbPnM1HRVNB94YEWpboSRkXqo9pNh8HqZ1/bz2g5Ay2RVIcM6uXH+b+ooEyd7cJJfQHphM9lpuAbzI5oDeJN3qoVlSq+1LYcSdzQJpWseIFX45pXbumfxmrnNumECzi/cMNAyLqIlgW9LCLr9RHwPSh6KpiuNi9V7EvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039497; c=relaxed/simple;
	bh=dBajdsA/Qa7LcDIvcw0Z/OjuZVFOCfMxd181T0knkJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=juTybjNySEK72Xj8z/QY5EeUlrV/S+qmEqcEN/36ILPiIG+qjc+c19nNKxN2iWp/ONw943tqlXjJg2rQ/+eijHU1lia+nkst2Gz+FIoZXWEWSEvTaAgv7DcTEwGdCcBGKC3wBlVKOqvd/KdEvdCWLOLiv0t8EOvlA8uxCVpezBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXr6Ef0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7AC4CEE3;
	Fri, 27 Jun 2025 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039494;
	bh=dBajdsA/Qa7LcDIvcw0Z/OjuZVFOCfMxd181T0knkJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pXr6Ef0EoBPkb7OSCBb6uvRYd2ndTtPg6blj9ZW/5UbkhETOBkece8YO9NEo+FVhP
	 h3pPQDW+LsSQfM4lhv3NWX73Yv0d1eLm9A5lBVxbg7Tw3c96Uvqlg7BdEMLqpuJUUY
	 mJBtZYLO4mLCH93sLrZeEsI/W3whKfvavaASMNRAArVdNS4/5KfMd4RRoIXrQVNpvC
	 JyOo1Gl18U1TOfK/autsMTGmkfsgVuyegZN/QGfwg250sep15aNPU9EguWIHnJVtAO
	 FpFGKci0ruSM68jeVVZ16VJZAQUfe59YwMrRePs93we3I7RMwuW9jq+e6Yq7mTEaNV
	 EF1NlnJrJw0bQ==
Date: Fri, 27 Jun 2025 10:51:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>
Subject: Re: [RFC PATCH] PCI: Support Immediate Readiness on devices without
 PM capabilities
Message-ID: <20250627155133.GA1669946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF3HDIzpe3vnpBdj@google.com>

On Thu, Jun 26, 2025 at 03:17:48PM -0700, Sean Christopherson wrote:
> On Wed, Jun 25, 2025, Bjorn Helgaas wrote:
> > On Tue, Jun 24, 2025 at 10:16:37AM -0700, Sean Christopherson wrote:
> > > +void pci_pm_init(struct pci_dev *dev)
> > > +{
> > > +	u16 status;
> > > +
> > > +	device_enable_async_suspend(&dev->dev);
> > > +	dev->wakeup_prepared = false;
> > > +
> > > +	dev->pm_cap = 0;
> > > +	dev->pme_support = 0;
> > > +
> > > +	/*
> > > +	 * Note, support for the PCI PM spec is optional for legacy PCI devices
> > > +	 * and for VFs.  Continue on even if no PM capabilities are supported.
> > > +	 */
> > > +	__pci_pm_init(dev);
> > >  
> > >  	pci_read_config_word(dev, PCI_STATUS, &status);
> > >  	if (status & PCI_STATUS_IMM_READY)
> > >  		dev->imm_ready = 1;
> > 
> > I would rather just move this PCI_STATUS read to somewhere else.  I
> > don't think there's a great place to put it.  We could put it in
> > set_pcie_port_type(), which is sort of a grab bag of PCIe-related
> > things.
> > 
> > I don't know if it's necessarily even a PCIe-specific thing, but it
> > would be unexpected if somebody made a conventional PCI device that
> > set it, since the bit was reserved (and should be zero) in PCI r3.0
> > and defined in PCIe r4.0.
> > 
> > Maybe we should put it in pci_setup_device() close to where we call
> > pci_intx_mask_broken()?
> 
> Any reason not to throw it in pci_init_capabilities()?  That has the
> advantage of minimizing the travel distance, e.g. to avoid
> introducing a goof similar to what happened with 4d4c10f763d7 ("PCI:
> Explicitly put devices into D0 when initializing").

The only reason I suggested doing it earlier was to enable a potential
pci_find_capability() optimization.  But this could easily be moved
if/when that happens, so I think the patch below would be fine.

> E.g. something silly like this?  Or maybe pci_misc_init() or so?
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108..4a1ba5c017cd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3205,7 +3205,6 @@ void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>  void pci_pm_init(struct pci_dev *dev)
>  {
>         int pm;
> -       u16 status;
>         u16 pmc;
>  
>         device_enable_async_suspend(&dev->dev);
> @@ -3266,9 +3265,6 @@ void pci_pm_init(struct pci_dev *dev)
>                 pci_pme_active(dev, false);
>         }
>  
> -       pci_read_config_word(dev, PCI_STATUS, &status);
> -       if (status & PCI_STATUS_IMM_READY)
> -               dev->imm_ready = 1;
>  poweron:
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..d33b8af37247 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2595,6 +2595,15 @@ void pcie_report_downtraining(struct pci_dev *dev)
>         __pcie_print_link_status(dev, false);
>  }
>  
> +static void pci_imm_ready_init(struct pci_dev *dev)
> +{
> +       u16 status;
> +
> +       pci_read_config_word(dev, PCI_STATUS, &status);
> +       if (status & PCI_STATUS_IMM_READY)
> +               dev->imm_ready = 1;
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>         pci_ea_init(dev);               /* Enhanced Allocation */
> @@ -2604,6 +2613,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>         /* Buffers for saving PCIe and PCI-X capabilities */
>         pci_allocate_cap_save_buffers(dev);
>  
> +       pci_imm_ready_init(dev);        /* Immediate Ready */
>         pci_pm_init(dev);               /* Power Management */
>         pci_vpd_init(dev);              /* Vital Product Data */
>         pci_configure_ari(dev);         /* Alternative Routing-ID Forwarding */

