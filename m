Return-Path: <linux-pci+bounces-4354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D192E86ECA3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 00:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF801C21DB7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 23:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555E5EE7A;
	Fri,  1 Mar 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct7mAuHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A35916A;
	Fri,  1 Mar 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334367; cv=none; b=iR2AsbR+aAhTRJlw1BDcRcCBQGbAP8g6FMbxoRb4tfno0ecbrpKpiPGiiqCY78lVeG8VfspY84Sqc0fUMSPcwxHOUOTJaECiQ/JeKMBY1EAJX6KnrEbZ/UCiXSj+ihwJ/zCQMQL5MQ2/NgxEgZQx0AtEqSb4DFe81guoKsVImQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334367; c=relaxed/simple;
	bh=rKuOkTbxIaJ7x3JYEDBqBkcVG0yonSQhx1eYOaWzU84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z6dGaxZiLeMOvSh6hL7sN1xFcQnYhUI0Dr0zslnzNxQc0PnqjSjbYmJbasWLwudOn/uixniL4srcCz/mNHiNCpu7jmo747Hniz8pFQee2qTLBac+g9tV6YKMmS5nzc5yXwA7HrGOLfDjq64bn6ndi163oXISanZERfw7zkEwync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct7mAuHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F6C433C7;
	Fri,  1 Mar 2024 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334366;
	bh=rKuOkTbxIaJ7x3JYEDBqBkcVG0yonSQhx1eYOaWzU84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ct7mAuHN/gO0UJqnRxXYiGbHvIMLwL2elf9hDKrI/f2F4rVp3P+D93s72WDrEKIVA
	 pH05pek4dTERDqYHll0UwZ2U4Duvuq3ETcGk9IRT7hB4kBWTuwrp/Y9xAmcjc9by95
	 FvXsF7YlblTr8W5Tz6drpvximdNJIZKwZUm8LzKEQKcwlJfhZBQvHZ9iH09uyfQI7/
	 s3cYoARcRmNH+yN50aqEh9JtB+M6mXd+ZB5r779Eqy1FldeK2XdVy4h/GKWySeoX59
	 Ss593U5B7m4iw9LKOcmAgbtfongQI77HPN7s9e7ii5AzJpy08pWhVN+h5zA61qn/rd
	 FegUt4gOa08Yw==
Date: Fri, 1 Mar 2024 17:06:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/3] PCI/DPC: Remove CONFIG_PCIE_EDR
Message-ID: <20240301230604.GA368825@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35cafc72-89d2-48d3-ab73-0af4ed2bcac1@linux.intel.com>

On Sun, Feb 25, 2024 at 12:05:12PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Previous Kconfig allowed the possibility of enabling CONFIG_PCIE_DPC
> > without CONFIG_PCIE_EDR.  The PCI Firmware Spec, r3.3, sec 4.5.1,
> > table 4-5, says an ACPI OS that requests control of DPC must also
> > advertise support for EDR.
> >
> > Remove CONFIG_PCIE_EDR and enable the EDR code with CONFIG_PCIE_DPC so that
> > enabling DPC also enables EDR for ACPI systems.  Since EDR is an ACPI
> > feature, build edr.o only when CONFIG_ACPI is enabled.  Stubs cover the
> > case when DPC is enabled without ACPI.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/acpi/pci_root.c   |  2 +-
> >  drivers/pci/pcie/Kconfig  | 14 ++++----------
> >  drivers/pci/pcie/Makefile |  5 ++++-
> >  drivers/pci/pcie/dpc.c    | 10 ----------
> >  include/linux/pci-acpi.h  |  4 ++--
> >  5 files changed, 11 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index efc292b6214e..bcaf3d3a5e05 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -448,7 +448,7 @@ static u32 calculate_support(void)
> >  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> >  	if (pci_msi_enabled())
> >  		support |= OSC_PCI_MSI_SUPPORT;
> > -	if (IS_ENABLED(CONFIG_PCIE_EDR))
> > +	if (IS_ENABLED(CONFIG_PCIE_DPC))	/* DPC => EDR support */
> >  		support |= OSC_PCI_EDR_SUPPORT;
> 
> Since EDR internally touches AER registers, I still think we should
> make sure OS enables AER support before advertising the EDR support.

I guess you're suggesting that we should make it look like this?

  if (host_bridge->native_aer && IS_ENABLED(CONFIG_PCIE_DPC))

That doesn't seem right to me because the implementation note in PCI
Firmware r3.3, sec 4.6.12, shows the EDR flow when firmware maintains
control of AER and DPC, i.e., "host_bridge->native_aer" would be
false.

> >  	return support;
> > diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> > index 8999fcebde6a..21e98289fbe9 100644
> > --- a/drivers/pci/pcie/Kconfig
> > +++ b/drivers/pci/pcie/Kconfig
> > @@ -137,6 +137,10 @@ config PCIE_DPC
> >  	  have this capability or you do not want to use this feature,
> >  	  it is safe to answer N.
> >  
> > +	  On ACPI systems, this includes Error Disconnect Recover support,
> > +	  the hybrid model that uses both firmware and OS to implement DPC,
> > +	  as specified in the PCI Firmware Specification r3.3.
> 
> Nit: Include some section reference?

I basically copied this from the PCIE_EDR help and updated the
revision number.  But I don't think the firmware spec is a very good
reference because EDR is defined by ACPI.  There's very little text in
the ACPI spec about EDR, but the firmware spec does assume you know
what *is* there.  And the ACPI spec is available to anybody, unlike
the PCI firmware spec.

+         On ACPI systems, this includes Error Disconnect Recover support,
+         the hybrid model that uses both firmware and OS to implement DPC,
+         as specified in ACPI r6.5, sec 5.6.6.

> >  config PCIE_PTM
> >  	bool "PCI Express Precision Time Measurement support"
> >  	help
> > @@ -145,13 +149,3 @@ config PCIE_PTM
> >  
> >  	  This is only useful if you have devices that support PTM, but it
> >  	  is safe to enable even if you don't.
> > -
> > -config PCIE_EDR
> > -	bool "PCI Express Error Disconnect Recover support"
> > -	depends on PCIE_DPC && ACPI
> > -	help
> > -	  This option adds Error Disconnect Recover support as specified
> > -	  in the Downstream Port Containment Related Enhancements ECN to
> > -	  the PCI Firmware Specification r3.2.  Enable this if you want to
> > -	  support hybrid DPC model which uses both firmware and OS to
> > -	  implement DPC.

