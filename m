Return-Path: <linux-pci+bounces-3236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFDB84E246
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 14:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E68C1C2663B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAE763E8;
	Thu,  8 Feb 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+hhCHh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25011762D3;
	Thu,  8 Feb 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400195; cv=none; b=i3pleLpWYzwMgcl0SfBri688De12hWJbvv4uRk7DcjvZghj+bpJspz7TUHEYkc9tX/SeHiOTzHG1i0tchLWQCqnvgY+cK5Zm7czfkxOGBv1rcnos87jSc7tak0oZbk0nm7mW80yAySkyxdfZr2RjXX53jew+DgD2ohMiGmAHnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400195; c=relaxed/simple;
	bh=NGuRSsB7vUfQqrg7eTKVhId/7xzcLwfkDUNBI99Ae1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP/PBtAU/+TqvVpah7zkwYpCmsq/RFoI++jKqKR+12ghzju7M38N3RLVqeWPePKzT/PiPj0Bsz9lYfuT+gIwLVhF5nRyJ32ivnUS1Vh4pNcB/cCS5KwQuRUuzxH7E4oWsqABXuBCeSZcD1d0tjQ9UqFjN5wOReQhpmlCklxF6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+hhCHh7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707400193; x=1738936193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGuRSsB7vUfQqrg7eTKVhId/7xzcLwfkDUNBI99Ae1E=;
  b=F+hhCHh7HE/7smRAF/MIWibmqtHZfaBA5khP0o8k4Y2yqlKbcA+6k+ld
   nLP3IbLvZZFRGLgpSKnCddWPOizosfoD6h6W4NISHoyd10qbYy1C5qLNC
   8/H/AUt0BtyDaVOv8OYAxzR4xrLeNeI4Fs1DcTfWzK7iEoF/9+FJ1JRkU
   LzGrQcUoKZ+WjR/WjrztaFfmS4z1aw83nRVcEQD3qzf3tPTA5c2Ky+I9+
   Azbf8oZ+fLEYvLb61t7YnKJmoYBGRnlp1+rzQKEaxjFu1qru0hc+Kx/VM
   xjKsmWrUIT1FX3amqlP60+cD6EzmPWvZbQ3PuLDw5CP2sUXRyL6+OIX2D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1106449"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1106449"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2023060"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:49:50 -0800
Date: Thu, 8 Feb 2024 14:49:47 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZcTb+32aciVfGKxH@linux.intel.com>
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas>
 <ZbtmB2GXPIwW1fLl@linux.intel.com>
 <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com>
 <ZcE0wWb6/CGFTKi/@linux.intel.com>
 <CAJZ5v0hLXS1EJZgUPn_i6Sp1RNJ2tH1oJ6AKvAQAM4Um_bwHPA@mail.gmail.com>
 <ZcJSQFF6XCgPjwx/@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJSQFF6XCgPjwx/@linux.intel.com>

On Tue, Feb 06, 2024 at 04:37:36PM +0100, Stanislaw Gruszka wrote:
> > > > If this is a real possibility (I mean, device in a low-power state and
> > > > in an error state at the same time), it would be better to call
> > > > __pm_runtime_disable(dev, false) instead of pm_runtime_get_sync(), as
> > > > that would prevent runtime PM from changing the device state.
> > >
> > > __pm_runtime_disable(dev, false) does not work as reliable in my
> > > test as pm_runtime_get_sync(), the
> > >
> > > igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > >
> > > message disappears, but sill have:
> > >
> > > igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> > > pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> > > pcieport 0000:00:1c.2: AER: subordinate device reset failed
> > > pcieport 0000:00:1c.2: AER: device recovery fail
> > 
> > But what exactly do you do?
> > 
> > (1) __pm_runtime_disable(dev, false)
> > (2) Check power state
> >      (a) If D0 (and device runtime-active), proceed
> >      (b) If > D0, remove power (if possible) and put into D0
> > 
> > or something else?
> 
> I just did point (1), did not check power state (2).
> I tested below patch with replaced:
> 
>   pm_runtime_get_sync -> __pm_runtime_disable(false)
>   pm_runtime_put -> pm_runtime_enable()
> 
> I could try to test with (1)+(2), but now sure how do do step (2b),
> by:
> 
> pci_set_power_state(D3cold)
> pci_set_power_state(D0)

The problematic case is indeed when after __pm_runtime_disable(), device
is in D3hot state. In such case we need to do the same operations as
pci_pm_runtime_resume() does, otherwise AER code is not able to work.
I think, just doing pm_runtime_get_sync() is better.

While I'm able to reproduce D3hot & error state using aer_inject
on the same smae device, more practical case is recovery running on all
devices connected to a port (else case in pcie_do_recovery 
type == PCIE_EXP_TYPE* check). On such case some devices can be suspend,
and from AER code comments I conclude they have to be reset.

> +static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
> +{
> +	pm_runtime_put(&pdev->dev);
> +	return 0;
> +}
> +
<snip>
> +
> +	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

This can happen after driver is unbind from device. I had concern about
that, but after drivers/base/ code examination, seems to be fine do
do pm_runtime_put() after unbind.

Regards
Stanislaw

