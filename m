Return-Path: <linux-pci+bounces-36341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A143EB7EB3C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD751C02CAE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F42F7AA3;
	Wed, 17 Sep 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnz3pZO2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF62F39D7;
	Wed, 17 Sep 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104875; cv=none; b=aE/+/Oek/qr8sqVkvi9yiSq7zEVHlmd2lgpauZ8yNcl05GnZ4MHYW8jJ4lHIhhkCdJq0e0eVxHPCc6NC2va/FayByl6VtaPuOyOp69UwXD8Q6hly8TtSt3qkyceV+L1jypD8nHfEsYARubye22dhi058hRWFnuOjELpq8ytLAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104875; c=relaxed/simple;
	bh=9EIowYvEPZOqg+KYd0lf5vl3N9XVhtAKVJH7AC+KA5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6nsbmGSL+XknFh2EcFTS8dify1nZydgseK6FMqvRr3AMb7bK4QSP/1yVEoMOnrUADqS0OUb5svUBY0MRGnwyU2pW8z+A8EW/rh1Mrzct/DGGIeyqAIEfAh3hudQN99x71rDV1X5KNIUckwJgrtpZcwSkITus2y22JM1UEnY188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnz3pZO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB82BC4CEF0;
	Wed, 17 Sep 2025 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104874;
	bh=9EIowYvEPZOqg+KYd0lf5vl3N9XVhtAKVJH7AC+KA5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mnz3pZO2LNyBtk9R4cClLiheWHz4cq6ok9vEM/tCuO6cscaqpT/AsxDF5zr/L9cSk
	 2aOl//VZAqW+Bo9UjsWrbdftYsHImwwL6IXsiTQHofRd/wHsfiMh3vvYqiJUIhdctl
	 jyOHMo53h5SSdEIkIGCQxJ5d+MA0LcUm+OyR3rqJ4EAOsN1wlhMXP8nU0ICF0j27i5
	 +nOH/i3CFmM7YzoPY/OnfTPPn+X/NV+EuyocoRRQpdfmN59X1sGZn7lv6AxQ1JvUuB
	 /kyCCMXcQ8WUJzPoBDXzfDmumnUrWK1SW4F46ajIfjm/rrc0+l0qF3AtiiqpfPAj+r
	 qDXrv7JO3z7aw==
Date: Wed, 17 Sep 2025 15:57:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
Message-ID: <5fifyei5gt2ypvk3hzj4lyc476thcou3g7u7x2lnup2eerazlx@66cbcjzvo5dg>
References: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
 <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
 <ccf1b22b-8b6d-4aae-ac27-e84943b7ffd0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf1b22b-8b6d-4aae-ac27-e84943b7ffd0@oss.qualcomm.com>

On Tue, Sep 16, 2025 at 06:28:58PM GMT, Konrad Dybcio wrote:
> On 9/16/25 6:12 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> > the BIOS (through LNKCTL) during device initialization. This was done
> > conservatively to avoid issues with the buggy devices that advertise
> > ASPM capabilities, but behave erratically if the ASPM states are enabled.
> > So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> > states that were known to work for the devices.
> > 
> > But this turned out to be a problem for devicetree platforms, especially
> > the ARM based devicetree platforms powering Embedded and *some* Compute
> > devices as they tend to run without any standard BIOS. So the ASPM states
> > on these platforms were left disabled during boot and the PCI subsystem
> > never bothered to enable them, unless the user has forcefully enabled the
> > ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> > themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> > 
> > This caused runtime power issues on those platforms. So a couple of
> > approaches were tried to mitigate this BIOS dependency without user
> > intervention by enabling the ASPM states in the PCI controller drivers
> > after device enumeration, and overriding the ASPM/Clock PM states
> > by the PCI controller drivers through an API before enumeration.
> > 
> > But it has been concluded that none of these mitigations should really be
> > required and the PCI subsystem should enable the ASPM states advertised by
> > the devices without relying on BIOS or the PCI controller drivers. If any
> > device is found to be misbehaving after enabling ASPM states that they
> > advertised, then those devices should be quirked to disable the problematic
> > ASPM/Clock PM states.
> > 
> > In an effort to do so, start by overriding the ASPM and Clock PM states set
> > by the BIOS for devicetree platforms first. Separate helper functions are
> > introduced to set the default ASPM and Clock PM states and they will
> > override the BIOS set states by enabling all of them if CONFIG_OF is
> > enabled. To aid debugging, print the overridden ASPM and Clock PM states.
> > 
> > In the future, these helpers could be extended to allow other platforms
> > like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> > 
> > Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> > +	if (IS_ENABLED(CONFIG_OF) && !enabled) {
> 
> JFYI CONFIG_OF=y && CONFIG_ACPI=y is valid, at least on arm64

Ouch! I didn't know this, thanks for pointing it out.

> Maybe something like of_have_populated_dt()?
> 

Yep, this looks like the correct API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

