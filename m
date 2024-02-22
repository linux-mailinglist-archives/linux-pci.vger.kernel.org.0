Return-Path: <linux-pci+bounces-3883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4732A860204
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D7A1C26638
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D014B839;
	Thu, 22 Feb 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L81UA4vx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8314B804;
	Thu, 22 Feb 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628076; cv=none; b=MsBUsDlz6lt80jUX8xnrQCE4nzYHxme6EflXhymiTPBGaYPqjWQCm6MGC2fwGfRBwbEFle1dBfGgRs3iP9ELAPRHMjlUgmywc0KS3DGBQ/Ae9liIISWUhR9VZMiXrOiydExtr6qEOh8V1CZ668gv6x5NaGcjFafbsTiLsGN/3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628076; c=relaxed/simple;
	bh=LfVuxzNR1LBGUV7iHeKbVsq8x9JIOjThYHKFHeLuabI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tu6ubJyz1hBiXgpbInlf0Cy9CuQjnaBeQiWecvyiDy1ENgbfIHqCo234Q7C5DgBy+Ck5BW6SpHZVc1dfVGAZrYLbzZRc7d+bTkDOAQWpAiccuFnjGyoySll8iMCFksLGI81IFPRLSX2mZjCkpZ770SFw2BLfZ8/aouiMCj8oNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L81UA4vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009DFC433F1;
	Thu, 22 Feb 2024 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708628076;
	bh=LfVuxzNR1LBGUV7iHeKbVsq8x9JIOjThYHKFHeLuabI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L81UA4vx+9tMHTTCDSI+v6mv1DZafhCwigjQ03b9vqWIbBxh885eItd/hWOo/8RHs
	 9Zm3bZRZuj1eOGdurXu18x9hk494/JAeUdnt4UKVtyE6VrrQJ/bj3lLC4dsZBIgEdy
	 2/0RVrS9HSO0l6EvFaJtB8EAdN+66hEJR5Fp6gOvdajJyk319+DkIVzc2qokVNK7wH
	 nL/2WpGZSG6Q4mY4tayyTroIyuX30mKmVy0DAxRoyg/PZci/wDjbhU/HDnL4bNQSk9
	 sAJMBDmwrsmU9rYVNjhAYjuuNn2lg7O+f0Q+9/bScmKbnziowZ5ncM1o9QyXrp5GB/
	 F9wWQl8uzQSmg==
Date: Thu, 22 Feb 2024 12:54:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com, macro@orcam.me.uk,
	ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com, hkallweit1@gmail.com,
	johan+linaro@kernel.org, xueshuai@linux.alibaba.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Message-ID: <20240222185434.GA24540@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f0d77b-8ea4-4443-8077-6139bc905952@linux.intel.com>

On Thu, Feb 22, 2024 at 10:20:06AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/22/24 9:44 AM, Vidya Sagar wrote:
> > Many PCIe device drivers save the configuration state of their respective
> > devices during probe and restore the same when their 'slot_reset' hook
> > is called through PCIe Error Recovery Handler.
> >
> > If the system has a change in ASPM policy after the driver's probe is
> > called and before error event occurred, 'slot_reset' hook restores the
> > PCIe configuration state to what it was at the time of probe but not to
> > what it was just before the occurrence of the error event.
> > This effectively leads to a mismatch in the ASPM configuration between
> > the device and its upstream parent device.
> >
> > Update the saved configuration state of the device with the latest info
> > whenever there is a change w.r.t ASPM policy.
> >
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > V4:
> > * Rebased on top of pci/aspm branch
> >
> > V3:
> > * Addressed sathyanarayanan.kuppuswamy's review comments
> >
> > V2:
> > * Rebased on top of the tree code
> > * Addressed Bjorn's review comments
> >
> >  drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
> >  3 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfc5b84dc9c9..3db606ba9344 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
> >  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
> >  	pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
> >  
> > -	pci_save_aspm_state(dev);
> > +	pci_save_aspm_l1ss_state(dev);
> >  	pci_save_ltr_state(dev);
> >  
> >  	return 0;
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index b217e74966eb..9fe78eb8b07d 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
> >  bool pci_bridge_d3_possible(struct pci_dev *dev);
> >  void pci_bridge_d3_update(struct pci_dev *dev);
> >  void pci_aspm_get_l1ss(struct pci_dev *pdev);
> > -void pci_save_aspm_state(struct pci_dev *pdev);
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
> 
> is this rename a review request? It is not clear from the commit log
> why you are doing it?

David's changes already on pci/aspm added pci_save_aspm_state(), but
it actually only saves L1SS data, and Vidya needs to save the non-L1SS
data also.

I think I'm going to rework David's changes a little bit so this is
named pci_save_aspm_l1ss_state() from the beginning so we won't need
the rename here.

Bjorn

