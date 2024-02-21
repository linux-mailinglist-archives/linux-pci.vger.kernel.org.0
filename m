Return-Path: <linux-pci+bounces-3844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13085ECDD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 00:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E0C1C21EC0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23256456;
	Wed, 21 Feb 2024 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enu4yqBB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D1A35;
	Wed, 21 Feb 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557928; cv=none; b=Y3oV3WjpQPKnmsmYsPqxLTI7KHTD5s31fY5epGOBSmqG4pZZUxhVnsGOmX1bp3QQoX8qwF9TbUl50x9W8BRQby9PM0hH+u9J6bM0ebEPE3tf7ac7YmN74ZfH24YyUolfCPmOFUP25g9EfJPxLvoXeQxe9LTgaM/7CNxy2DEbVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557928; c=relaxed/simple;
	bh=cm0rXHuYpdUHHEiy4MG/nHpcI2fGOqCABwVVztVbBUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D2WAWxpVXmcxP22dPL/aLsIyuaXwJARdbPoW+JxYktpv0wK3N4qHzqs5zdfJmeCtBOV5+JVktqPXYZ9cLRCFjs+6/TlWik0VoXL2y7F5LN5lkT5HpgvlEquujDkfBZ1ydP9EsYUm2qX5sTRXrQbr11LDvUvYQcqw9ugKkYYNZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enu4yqBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6CEC433C7;
	Wed, 21 Feb 2024 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557927;
	bh=cm0rXHuYpdUHHEiy4MG/nHpcI2fGOqCABwVVztVbBUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=enu4yqBBb/AYies9CfHBzeZEXCn6XnamsV5WkPgFOTTIcWY47IDWEmHA8bHBhcYew
	 AJpLO1EARhcu+Quv0pwf5hx78d5KRcIQD7N6x5wbqxxdFc7Nnn7l19gcU1M+JULo55
	 iv9mNLg4BvCXr+7DgAbh0nWL4BDkc8ciRNSbnMR0LfnS7t9DUEBuOCwMSb/LbMC8cv
	 ZTN1wWwCMQ/UXAeQ+6G44z2C4KiWKmwQLEoCVCxDULQ7fpDVed9ad6dQbGJrwtEJG+
	 aAqYIFKnHd2UytSpCUCINY1bmW5Sck71AX2iu3FeA8DxyD0ru7Jh8/8l4U6YOJpqh8
	 DdZhkeWuFIvSw==
Date: Wed, 21 Feb 2024 17:25:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH] PCI/DPC: Request DPC only if also requesting AER
Message-ID: <20240221232523.GA1533169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39ef1387-609c-45ca-9bfa-e01b72cacaaa@linux.intel.com>

On Tue, Feb 20, 2024 at 06:45:32PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/20/24 3:55 PM, Bjorn Helgaas wrote:
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
> >
> > Request DPC control only if we have also requested AER control.
> 
> Can you also add similar check in calculate_support call?
> 
>         if (pci_aer_available() && IS_ENABLED(CONFIG_PCIE_EDR))
>                 support |= OSC_PCI_EDR_SUPPORT;

That doesn't seem right to me.  The implementation note in sec 4.6.12
suggests that EDR Notifications may be used even when the firmware
maintains control of AER and DPC.  Maybe that note is wrong or
misleading, but as written, I interpret that as meaning that it may be
useful for the platform to know that the OS supports EDR even if it
AER control isn't requested or granted.

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
> >  drivers/acpi/pci_root.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 58b89b8d950e..1c16965427b3 100644
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
>
> I think you mean OSC_PCI_EXPRESS_DPC_CONTROL.

No, I just tried to rephrase the text for _OSC Control, bit 7 (quoted
in the commit log), so I think requesting control of bits 3 and 4 (AER
and PCIe Capability) is right.

> > +		 * OSC_PCI_EXPRESS_AER_CONTROL.
> > +		 */
> > +		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> > +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> 
> Since you are cleaning up this part, why not add a patch to remove
> CONFIG_PCIE_EDR?

Good idea, I'll do that, too.

Bjorn

