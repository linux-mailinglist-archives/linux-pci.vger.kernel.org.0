Return-Path: <linux-pci+bounces-35196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF0B3D37C
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E45217DB7D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733325E47D;
	Sun, 31 Aug 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFcxsneJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08D25A2C3;
	Sun, 31 Aug 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756645141; cv=none; b=QCMLpefSFjBGDhqbnd/djO3wKP3cec+afpDuNOI7BR1q/IhZwWSVO7UGBuftjCKfGRlfDn4bu4eEKTsaGEs1VMpQ+Ur2Xw+Ne1twPb8UP0/4si0DhD8CTuWydDUeYa6YMqt+lqEr/iO9bFdpt9w7uDSkJ3hk/VE/SPp1Q8BXQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756645141; c=relaxed/simple;
	bh=Caa7DDTCiNusl0o9A3cEtcEjFF2MrzAytBi6d98j3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exLYW43X/+UAJgn5Jg/Kj4oVYo2RkADkmKlHj8E+rCakaMDE2HSrdDLWRcPrk2SRG4ELVXhT9lw6NtJzFyivqSBX3p+mqjJNP5E4h2Rbinj98OgzT+MCIeA+4/svEitvbHfDaqx5jj6X+o4RwA6DK3Ewk/DKLoXchxkbrACIGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFcxsneJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164B9C4CEED;
	Sun, 31 Aug 2025 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756645141;
	bh=Caa7DDTCiNusl0o9A3cEtcEjFF2MrzAytBi6d98j3S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFcxsneJ2yc/qJGF/QR+zEjVXwzzXAsYLsyttgdyBB2K3VtezkJA8DU88nl0nJ1SA
	 7zg03mWozxd3aEzXMYl0GGm8YzYE+s/G+dWWBUAgVPidHQ1Tjd+nNB+daYqsJKblzx
	 0ZCxd63+ipK0AtOF3aPUWEbJKAZ66GHhMlg78uQQj0a98FVWGjHZDAYb1ululBFWBI
	 2Uxt+/Sg/4eYjV8TNc9m6+xFnTpa+mBplkOm3MS8GnbM1VXgHsbzVkXfStBBFqmnRn
	 dmqVzM0jwzTjA8Sp6VlRdvsE7e6U14fEk/gbDNxwvwVYXFynJgdZR3fg8GWQS0tQ2a
	 2sia7IJVIc6jw==
Date: Sun, 31 Aug 2025 18:28:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org, 
	bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com, 
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <2fo64esrc5v5vj46iff2ptgcthaeahwicuzug46popwqrryfsi@yt62sqsnv4e3>
References: <20250825203542.3502368-1-david.e.box@linux.intel.com>
 <20250828204345.GA958461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828204345.GA958461@bhelgaas>

On Thu, Aug 28, 2025 at 03:43:45PM GMT, Bjorn Helgaas wrote:
> On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> > defaults. Devices in such domains may therefore run without the intended
> > power management.
> > 
> > Add a host-bridge mechanism that lets controller drivers supply their own
> > defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> > set via pci_host_set_default_pcie_link_state(). During link initialization,
> > if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> > BIOS.
> > 
> > This enables drivers like VMD to align link power management with platform
> > expectations and avoids embedding controller-specific quirks in ASPM core
> > logic.
> 
> I think this kind of sidesteps the real issue.  Drivers for host
> controllers or PCI devices should tell us about *broken* things, but
> not about things advertised by the hardware and available for use.
> 
> The only documented policy controls I'm aware of for ASPM are:
> 
>   - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
>     control on this platform")
> 
>   - _OSC negotiation for control of the PCIe Capability (OS is only
>     allowed to write PCI_EXP_LNKCTL if platform has granted control to
>     the OS)
> 
> I think what we *should* be doing is enabling ASPM when it's
> advertised, subject to those platform policy controls and user choices
> like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.
> 
> So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
> without drivers doing anything at all.  Maybe we have to carve out
> exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
> on x86 systems before 2026 can't enable more ASPM than BIOS did," or
> whatever.  Is there any baby step we can make in that direction?
> 

I'm not sure about the ACPI world, but for devicetree platforms, BIOS or the
bootloader won't configure ASPM for the devices (mostly). So the baby step would
be to set PCIE_LINK_STATE_ALL for all devicetree platforms :)

We did similar thing for enabling D3Hot for bridges earlier:
a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")

- Mani

-- 
மணிவண்ணன் சதாசிவம்

