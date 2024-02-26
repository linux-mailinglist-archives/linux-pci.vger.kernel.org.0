Return-Path: <linux-pci+bounces-4018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E516867A0A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA641C2B9E0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB012BF3B;
	Mon, 26 Feb 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRY2JMo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704D12BF26;
	Mon, 26 Feb 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960687; cv=none; b=u5RwZYaCTM1aL2zgMs2hKi4a93Jmdbj/w9Iydeu7o1ICXOn8YXH23GrdgFp4Hz9aa7TBEd4+5JmKhDIl90BpWS9hZAveT+IgN2128meovH44vgn3Q2FEMes73CBcMGtHCuzTmhj7WnJwPancMkenqiwd4pBTU7q+zOsepkvluFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960687; c=relaxed/simple;
	bh=5sVKV4wkvq1eGCuONcZKC2B80eRfgAbNH78OsTHsM+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dU1Z+xFkkyxfbU13TToT0eVa2i8lRBKoUtvOYzXcPxPDwhfcMLa/E7/nul5mjfwYCxcEWZa6xZkeuzw6ZvzQycNhVFY3cFa7hzrfseidEmW1eYSidFJyNPSLsifPH6Sl08lIGW8FlMK6+ANBRRol6b7sD0401fL3uxmXEbovf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRY2JMo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE44C43390;
	Mon, 26 Feb 2024 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708960687;
	bh=5sVKV4wkvq1eGCuONcZKC2B80eRfgAbNH78OsTHsM+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fRY2JMo4qfNiJsuDSmCv1Xqji49KsYLvcrbU9dBMWugRAEaKLPrt3G2fAivRpO/CL
	 bZ6UTV0OudWVu5uYwSDRF1i+QaBlqZJXf1IniWw1XiFBZihcmFlfNhNW5A3rR/+zjo
	 J665+ru3DIwxBVTYfx7U1aLTiXsdLasNYzaUZRio2Roswn784CGebrqm7y6N8sjb1B
	 mx0CcuNcgKxoiTaeI/unc/PL3aCASf+zgX0QBY6COHXLXkZxnrkAbzxwZdR0g39jh8
	 KrBWvVUiBQ6S5wBP1h4gA+oI66B/6y5w/PCIUQNUSgRGe+J5lPcGklxG9U5mklktKt
	 4RIXy3QcXJeKA==
Date: Mon, 26 Feb 2024 09:18:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/DPC: Request DPC only if also requesting AER
Message-ID: <20240226151805.GA200026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81b1e5b-81fa-4df0-926d-1d75323cf47b@linux.intel.com>

On Sun, Feb 25, 2024 at 11:46:07AM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > When booting with "pci=noaer", we don't request control of AER, but we
> > previously *did* request control of DPC, as in the dmesg log attached at
> > the bugzilla below:
> >
> >   Command line: ... pci=noaer
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
> >
> > That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
> > says:
> >
> >   If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
> >   must also set bit 7 of the Support field (indicating support for Error
> >   Disconnect Recover notifications) and bits 3 and 4 of the Control field
> >   (requesting control of PCI Express Advanced Error Reporting and the PCI
> >   Express Capability Structure).
> 
> IIUC, this dependency is discussed in sec 4.5.2.4. "Dependencies
> Between _OSC Control Bits".
> 
> Because handling of Downstream Port Containment has a dependency on
> Advanced Error Reporting, the operating system is required to
> request control over Advanced Error Reporting (bit 3 of the Control
> field) while requesting control over Downstream Port Containment
> Configuration (bit 7 of the Control field). If the operating system
> attempts to claim control of Downstream Port Containment
> Configuration without also claiming control over Advanced Error
> Reporting, firmware is required to refuse control of the feature
> being illegally claimed and mask the corresponding bit.  Firmware is
> required to maintain ownership of Advanced Error Reporting if it
> retains ownership of Downstream Port Containment Configuration.  If
> the operating system sets bit 7 of the Control field, it must set
> bit 7 of the Support field, indicating support for the Error
> Disconnect Recover event.

So I guess you're suggesting that there are two defects here?

  1) Linux requested DPC control without requesting AER control.

  2) Platform granted DPC control when it shouldn't have.

I do agree with that, but obviously we can only fix 1) in Linux.

> > Request DPC control only if we have also requested AER control.
> >
> > Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218491#c12
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: <stable@vger.kernel.org>	# v5.7+
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Matthew W Carlis <mattc@purestorage.com>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > ---
> Code wise it looks fine to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >  drivers/acpi/pci_root.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 58b89b8d950e..efc292b6214e 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -518,17 +518,19 @@ static u32 calculate_control(void)
> >  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> >  		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> >  
> > -	if (pci_aer_available())
> > +	if (pci_aer_available()) {
> >  		control |= OSC_PCI_EXPRESS_AER_CONTROL;
> >  
> > -	/*
> > -	 * Per the Downstream Port Containment Related Enhancements ECN to
> > -	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> > -	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> > -	 * and EDR.
> > -	 */
> > -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> > -		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> > +		/*
> > +		 * Per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, the
> > +		 * OS can request DPC control only if it has advertised
> > +		 * OSC_PCI_EDR_SUPPORT and requested both
> > +		 * OSC_PCI_EXPRESS_CAPABILITY_CONTROL and
> > +		 * OSC_PCI_EXPRESS_AER_CONTROL.
> > +		 */
> > +		if (IS_ENABLED(CONFIG_PCIE_DPC))
> > +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> > +	}
> >  
> >  	return control;
> >  }
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

