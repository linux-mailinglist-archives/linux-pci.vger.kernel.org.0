Return-Path: <linux-pci+bounces-29679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68770AD8B4F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525E16190C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834C275AFB;
	Fri, 13 Jun 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw8bXodJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F702275AEC;
	Fri, 13 Jun 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815560; cv=none; b=AaBspT4OT+WcXLCWpN59k0YQsAVnt08p5VBxcxCL1FSWXVnQi/gxF2fNOwUn4cXn80Q7/3+65DJR66WLlPlphf2cbje7ONdLX0xNYNWHedyDnlw1/PKKf5tQl9YlDU2dYQWh/aanxYGyj/KeZKIvGAJWxmGs1nS2JIjCppBtREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815560; c=relaxed/simple;
	bh=9Ib3i1mlFKicVwKiPGf5NRYHamJ2n8eOcsjuXffXj54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzXMnCe1ZM8YDq4HAgWinI/Y1Zg7FAmI5xxVU4AFPCoENXqvSBUD/kRa5CsfqdWjxdxUeV4IZokteMxcweGAnkRyPFh2yHvwl2jXI9ksJxNpHJ+nGOPLIgxKrt1C/r8Ie7R+H6xdNWC1qvPd8YpT4s/xySwIJL032GqQI8LJQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw8bXodJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3680CC4CEE3;
	Fri, 13 Jun 2025 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749815560;
	bh=9Ib3i1mlFKicVwKiPGf5NRYHamJ2n8eOcsjuXffXj54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aw8bXodJydbeLxjxs9CS/1ymdxGC+nk/uG6P0DwTJYpW42Pg/5BHWY+BJi5zY2cph
	 LKHTsRogZ8cDXCb/AGkccXPdupEBA3Ah84vP4n+51iTDbEwRj00qU77a4uUHOCw+dQ
	 lnvzOuTJRixDvWsz/46CN4nXvGvstFtySvo/iVuwszfFmwpXdTX4FmiqNhqbUvvFLZ
	 J2BSZ+yTPCkuHm6UqmrUuIOEuWfSgydKa9JUjRMSu3uRcbiIIJPnDNrIhn7wfg9b43
	 n3qU/sG/nuANHXA8sduV69dpVBZTlX5yi68+CoSdIcI3cTPulotnddlGKqRm5Nx7Gf
	 LDrFtJaEuhFtQ==
Date: Fri, 13 Jun 2025 13:52:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
Message-ID: <aEwRAZgLJUECbGz6@ryzen>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com>
 <co2q55j4mk2ux7af4sj6snnfomditwizg5jevg6oilo3luby5z@6beqtbn3l432>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <co2q55j4mk2ux7af4sj6snnfomditwizg5jevg6oilo3luby5z@6beqtbn3l432>

On Fri, Jun 13, 2025 at 12:08:31PM +0530, Manivannan Sadhasivam wrote:
> On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
> > Current PCIe initialization logic may leave root ports operating with
> > non-optimal Maximum Payload Size (MPS) settings. While downstream device
> > configuration is handled during bus enumeration, root port MPS values
> > inherited from firmware or hardware defaults might not utilize the full
> > capabilities supported by the controller hardware. This can result is
> > uboptimal data transfer efficiency across the PCIe hierarchy.
> > 
> > During host controller probing phase, when PCIe bus tuning is enabled,
> > the implementation now configures root port MPS settings to their
> > hardware-supported maximum values. By iterating through bridge devices
> > under the root bus and identifying PCIe root ports, each port's MPS is
> > set to 128 << pcie_mpss to match the device's maximum supported payload
> > size.
> 
> I don't think the above statement is accurate. This patch is not iterating
> through the bridges and you cannot identify root ports using that. What this
> patch does is, it checks whether the device is root port or not and if it is,
> then it sets the MPS to MPSS (hw maximum) if PCIE_BUS_TUNE_OFF is not set.

Correct.
Later, when the bus is walked, if any downstream device does not support
the MPS value currently configured in the root port, pci_configure_mps()
will reduce the MPS in the root port to the max supported by the downstream
device.

So even we start off by setting MPS in the root port to the max supported
by the root port, it might get reduced later on.


> 
> > The Max Read Request Size (MRRS) is subsequently adjusted through
> > existing companion logic to maintain compatibility with PCIe
> > specifications.
> > 
> > Explicit initialization at host probing stage ensures consistent PCIe
> > topology configuration before downstream devices perform their own MPS
> > negotiations. This proactive approach addresses platform-specific
> > requirements where controller drivers depend on properly initialized
> > root port settings, while maintaining backward compatibility through
> > PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> > utilized without altering existing device negotiation behaviors.
> > 
> > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > ---
> >  drivers/pci/probe.c | 72 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 41 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 364fa2a514f8..1f67c03d170a 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2149,6 +2149,37 @@ int pci_setup_device(struct pci_dev *dev)
> >  	return 0;
> >  }
> >  
> > +static void pcie_write_mps(struct pci_dev *dev, int mps)
> > +{
> > +	int rc;
> > +
> > +	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
> > +		mps = 128 << dev->pcie_mpss;
> > +
> > +		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > +		    dev->bus->self)
> > +
> > +			/*
> > +			 * For "Performance", the assumption is made that
> > +			 * downstream communication will never be larger than
> > +			 * the MRRS.  So, the MPS only needs to be configured
> > +			 * for the upstream communication.  This being the case,
> > +			 * walk from the top down and set the MPS of the child
> > +			 * to that of the parent bus.
> > +			 *
> > +			 * Configure the device MPS with the smaller of the
> > +			 * device MPSS or the bridge MPS (which is assumed to be
> > +			 * properly configured at this point to the largest
> > +			 * allowable MPS based on its parent bus).
> > +			 */
> > +			mps = min(mps, pcie_get_mps(dev->bus->self));
> > +	}
> > +
> > +	rc = pcie_set_mps(dev, mps);
> > +	if (rc)
> > +		pci_err(dev, "Failed attempting to set the MPS\n");
> > +}
> > +
> >  static void pci_configure_mps(struct pci_dev *dev)
> >  {
> >  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> > @@ -2178,6 +2209,16 @@ static void pci_configure_mps(struct pci_dev *dev)
> >  		return;
> >  	}
> >  
> > +	/*
> > +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
> > +	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
> > +	 * strategy, and the MPSS of the devices below the root port, the MPS
> > +	 * of the root port might get overridden later.
> > +	 */
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> > +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> > +		pcie_write_mps(dev, 128 << dev->pcie_mpss);
> 
> I believe you can just use "pcie_set_mps(dev, 128 << dev->pcie_mpss)" directly
> and avoid moving pcie_write_mps() around.

+1


Kind regards,
Niklas

