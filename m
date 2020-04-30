Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B91C08B8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD3VE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 17:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgD3VE6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 17:04:58 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234D42070B;
        Thu, 30 Apr 2020 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588280697;
        bh=F2VDeECTHEpLFs3NQpoFi0et0wGDa9oGfGjHPF/ysxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DbAnsdztOboqHPWhruNxS7vQ+0X98KgUPkfF+4AxiQGywOeXDYN6X9TNeoxn2cVWz
         tTerHqE+LTfEAoxdVG++tWgwfLood3/eINorSOroMaGRRS+j8ZpB5NdgKiBOejyCsG
         YqsQhbquRrlVuFtERrhCBRDUthlSD9gOotYhxYyE=
Date:   Thu, 30 Apr 2020 16:04:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jonathan.derrick@intel.com, mr.nuke.me@gmail.com,
        rjw@rjwysocki.net, Keith Busch <kbusch@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200430210455.GA64122@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3535fbc69604425b1e8f008348950ab@AUSX13MPC107.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith, Sinan, Tyler]

On Wed, Apr 29, 2020 at 03:24:41PM +0000, Austin.Bolen@dell.com wrote:
> On 4/28/2020 3:37 PM, Bjorn Helgaas wrote:
> > [+to Mario, Austin, Rafael; Dell folks, I suspect this commit will
> > break Dell servers but I'd like your opinion]
> >
> > <snip>
> Thanks Bjorn, for the heads up. I checked with our server BIOS team and
> they say that only checking _OSC for AER should work on our servers.  We
> always configure_OSC and the HEST FIRMWARE_FIRST flag to retain firmware
> control of AER so either could be checked.
> 
> > I *really* want the patch because the current mix of using both _OSC
> > and FIRMWARE_FIRST to determine AER capability ownership is a mess and
> > getting worse, but I'm more and more doubtful.
> >
> > My contention is that if firmware doesn't want the OS to use the AER
> > capability it should simply decline to grant control via _OSC.
>
> I agree per spec that _OSC should be used and this was confirmed by the
> ACPI working group. Alex had submitted a patch for us [2] to switch to
> using _OSC to determine AER ownership following the decision in the ACPI
> working group.
> 
> [2] https://lkml.org/lkml/2018/11/16/202

Wow, egg on my face :(  How embarrassing.  Alex posted the *identical*
patch 18 months ago.  There was a lot of discussion the first time,
but I certainly should have applied this the second time around when
that had been resolved.

Anyway, I did apply it now on pci/error for v5.8, and I added links to
Alex's posting as well as his sign-off, since he actually did all the
work earlier.

I apologize for missing this.

This still leaves patch [2/2] from Alex and the second half of Sathy's
patch.  They're similar but not identical, so I'll try to sort that
out next.

> > But things like 0584396157ad ("PCI: PCIe AER: honor ACPI HEST FIRMWARE
> > FIRST mode") [1] suggest that some machines grant AER control to the
> > OS via _OSC, but still expect the OS to leave AER alone for certain
> > devices.
>
> AFAIK, no Dell server, including the 11G servers mentioned in that
> patch, have granted control of AER via _OSC and set HEST FIRMWARE_FIRST
> for some devices. I don't think this model is even support by the
> ACPI/PCIe standards.  Yes, you can set the bits that way, but there is
> no text I've found that says how the OS/firmware should behave in that
> scenario. In order to be interoperable, I think someone would need to
> standardized how the OS/firmware would could co-ordinate in such a model.
> >
> > I think the FIRMWARE_FIRST language in the ACPI spec is really too
> > vague to tell the OS not to use the AER Capability, but it seems like
> > that's what commits like [1] rely on.
> >
> > The current _OSC definition (PCI Firmware r3.2) applies only to
> > PNP0A03/PNP0A08 devices, but it's conceivable that it could be
> > extended to other devices if we need per-device AER Capability
> > ownership.
> >
> > [1] https://git.kernel.org/linus/0584396157ad
> >
> >> commit 8f8e42e7c2dd ("PCI/AER: Use only _OSC to determine AER ownership")
> >> Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Date:   Mon Apr 27 18:25:13 2020 -0500
> >>
> >>     PCI/AER: Use only _OSC to determine AER ownership
> >>     
> >>     Per the PCI Firmware spec, r3.2, sec 4.5.1, the OS can request control of
> >>     AER via bit 3 of the _OSC Control Field.  In the returned value of the
> >>     Control Field:
> >>     
> >>       The firmware sets [bit 3] to 1 to grant control over PCI Express Advanced
> >>       Error Reporting.  ...  after control is transferred to the operating
> >>       system, firmware must not modify the Advanced Error Reporting Capability.
> >>       If control of this feature was requested and denied or was not requested,
> >>       firmware returns this bit set to 0.
> >>     
> >>     Previously the pci_root driver looked at the HEST FIRMWARE_FIRST bit to
> >>     determine whether to request ownership of the AER Capability.  This was
> >>     based on ACPI spec v6.3, sec 18.3.2.4, and similar sections, which say
> >>     things like:
> >>     
> >>       Bit [0] - FIRMWARE_FIRST: If set, indicates that system firmware will
> >>                 handle errors from this source first.
> >>     
> >>       Bit [1] - GLOBAL: If set, indicates that the settings contained in this
> >>                 structure apply globally to all PCI Express Devices.
> >>     
> >>     These ACPI references don't say anything about ownership of the AER
> >>     Capability.
> >>     
> >>     Remove use of the FIRMWARE_FIRST bit and rely only on the _OSC bit to
> >>     determine whether we have control of the AER Capability.
> >>     
> >>     Link: https://lore.kernel.org/r/67af2931705bed9a588b5a39d369cb70b9942190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com
> >>     [bhelgaas: commit log, split patches]
> >>     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index ac8ad6cb82aa..9e235c1a75ff 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -483,13 +483,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> >>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> >>  		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> >>  
> >> -	if (pci_aer_available()) {
> >> -		if (aer_acpi_firmware_first())
> >> -			dev_info(&device->dev,
> >> -				 "PCIe AER handled by firmware\n");
> >> -		else
> >> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
> >> -	}
> >> +	if (pci_aer_available())
> >> +		control |= OSC_PCI_EXPRESS_AER_CONTROL;
> >>  
> >>  	/*
> >>  	 * Per the Downstream Port Containment Related Enhancements ECN to
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index f4274d301235..efc26773cc6d 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -318,30 +318,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
> >>  		aer_set_firmware_first(dev);
> >>  	return dev->__aer_firmware_first;
> >>  }
> >> -
> >> -static bool aer_firmware_first;
> >> -
> >> -/**
> >> - * aer_acpi_firmware_first - Check if APEI should control AER.
> >> - */
> >> -bool aer_acpi_firmware_first(void)
> >> -{
> >> -	static bool parsed = false;
> >> -	struct aer_hest_parse_info info = {
> >> -		.pci_dev	= NULL,	/* Check all PCIe devices */
> >> -		.firmware_first	= 0,
> >> -	};
> >> -
> >> -	if (pcie_ports_native)
> >> -		return false;
> >> -
> >> -	if (!parsed) {
> >> -		apei_hest_parse(aer_hest_parse, &info);
> >> -		aer_firmware_first = info.firmware_first;
> >> -		parsed = true;
> >> -	}
> >> -	return aer_firmware_first;
> >> -}
> >>  #endif
> >>  
> >>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
> >> @@ -1523,7 +1499,7 @@ static struct pcie_port_service_driver aerdriver = {
> >>   */
> >>  int __init pcie_aer_init(void)
> >>  {
> >> -	if (!pci_aer_available() || aer_acpi_firmware_first())
> >> +	if (!pci_aer_available())
> >>  		return -ENXIO;
> >>  	return pcie_port_service_register(&aerdriver);
> >>  }
> >> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> >> index 2d155bfb8fbf..11c98875538a 100644
> >> --- a/include/linux/pci-acpi.h
> >> +++ b/include/linux/pci-acpi.h
> >> @@ -125,10 +125,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> >>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> >>  #endif	/* CONFIG_ACPI */
> >>  
> >> -#ifdef CONFIG_ACPI_APEI
> >> -extern bool aer_acpi_firmware_first(void);
> >> -#else
> >> -static inline bool aer_acpi_firmware_first(void) { return false; }
> >> -#endif
> >> -
> >>  #endif	/* _PCI_ACPI_H_ */
> 
> 
