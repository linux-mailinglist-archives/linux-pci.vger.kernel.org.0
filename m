Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228C01C0ACC
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgD3XCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 19:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgD3XCV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 19:02:21 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B46F20873;
        Thu, 30 Apr 2020 23:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588287740;
        bh=6TqcOEG/ADJ3kVYvKLo3/GmsrKDAE0exdbbfBR+Ms/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xiarNHnm0Ky6Hpfh7RRog9YTrqgGGmZbOrQAQuaZQv319Mlmcntqdop0aM5ecfEkC
         2xtEK9maudr3v7yt4y2rgQ4bxdAI4e6hvvJQ0lscOhuPwnN23zurS8Y2tEQatM0hpu
         x9ML47cf3Y3jhGJaeKQPa9oGu/C/BcrEC/gCEOH0=
Date:   Thu, 30 Apr 2020 18:02:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Austin Bolen <Austin.Bolen@dell.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200430230218.GA72958@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430224019.GA71117@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Austin, help us understand the FIRMWARE_FIRST bit! :)]

On Thu, Apr 30, 2020 at 05:40:22PM -0500, Bjorn Helgaas wrote:
> On Sun, Apr 26, 2020 at 11:30:06AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to
> > determine the PCIe AER Capability ownership between OS and
> > firmware. This support is added based on following spec
> > reference.
> > 
> > Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table
> > flags field BIT-0 and BIT-1 can be used to expose the
> > ownership of error source between firmware and OSPM.
> > 
> > Bit [0] - FIRMWARE_FIRST: If set, indicates that system
> >           firmware will handle errors from this source
> >           first.
> > Bit [1] – GLOBAL: If set, indicates that the settings
> >           contained in this structure apply globally to all
> >           PCI Express Bridges.
> > 
> > Although above spec reference states that setting
> > FIRMWARE_FIRST bit means firmware will handle the error source
> > first, it does not explicitly state anything about AER
> > ownership. So using HEST to determine AER ownership is
> > incorrect.
> > 
> > Also, as per following specification references, _OSC can be
> > used to negotiate the AER ownership between firmware and OS.
> > Details are,
> > 
> > Per ACPI spec r6.3, sec 6.2.11.3, table titled “Interpretation
> > of _OSC Control Field” and as per PCI firmware specification r3.2,
> > sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field
> > to request control over PCI Express AER. If the OS successfully
> > receives control of this feature, it must handle error reporting
> > through the AER Capability as described in the PCI Express Base
> > Specification.
> > 
> > Since above spec references clearly states _OSC can be used to
> > determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.
> 
> I pulled out the _OSC part of this to a separate patch.  What's left
> is below, and is essentially equivalent to Alex's patch:
> 
>   https://lore.kernel.org/r/20190326172343.28946-3-mr.nuke.me@gmail.com/
> 
> I like what this does, but what I don't like is the fact that we now
> have this thing called pcie_aer_get_firmware_first() that is not
> connected with the ACPI FIRMWARE_FIRST bit at all.

Austin, if we remove this, we'll have no PCIe-related code that looks
at the HEST FIRMWARE_FIRST bit at all.  Presumably it's there for some
reason, but I'm not sure what the reason is.

Alex's mail [1] has a nice table of _OSC AER/HEST FFS bits that looks
useful, but the only actionable thing I can see is that in the (1,1)
case, OSPM should do some initialization with masks/enables.

But I have no clue what that means or how to connect that with the
spec.  What are the masks/enables?  Is that something connected with
ERST?

[1] https://lore.kernel.org/r/20190326172343.28946-1-mr.nuke.me@gmail.com/

> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f4274d301235..85d73d28ec26 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -217,133 +217,19 @@ void pcie_ecrc_get_policy(char *str)
> >  }
> >  #endif	/* CONFIG_PCIE_ECRC */
> >  
> > -#ifdef CONFIG_ACPI_APEI
> > -static inline int hest_match_pci(struct acpi_hest_aer_common *p,
> > -				 struct pci_dev *pci)
> > -{
> > -	return   ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
> > -		 ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
> > -		 p->device                 == PCI_SLOT(pci->devfn) &&
> > -		 p->function               == PCI_FUNC(pci->devfn);
> > -}
> > -
> > -static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
> > -				struct pci_dev *dev)
> > -{
> > -	u16 hest_type = hest_hdr->type;
> > -	u8 pcie_type = pci_pcie_type(dev);
> > -
> > -	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
> > -		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
> > -	    (hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
> > -		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
> > -	    (hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
> > -		(dev->class >> 16) == PCI_BASE_CLASS_BRIDGE))
> > -		return true;
> > -	return false;
> > -}
> > -
> > -struct aer_hest_parse_info {
> > -	struct pci_dev *pci_dev;
> > -	int firmware_first;
> > -};
> > -
> > -static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
> > -{
> > -	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
> > -	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
> > -	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
> > -		return 1;
> > -	return 0;
> > -}
> > -
> > -static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
> > -{
> > -	struct aer_hest_parse_info *info = data;
> > -	struct acpi_hest_aer_common *p;
> > -	int ff;
> > -
> > -	if (!hest_source_is_pcie_aer(hest_hdr))
> > -		return 0;
> > -
> > -	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
> > -	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
> > -
> > -	/*
> > -	 * If no specific device is supplied, determine whether
> > -	 * FIRMWARE_FIRST is set for *any* PCIe device.
> > -	 */
> > -	if (!info->pci_dev) {
> > -		info->firmware_first |= ff;
> > -		return 0;
> > -	}
> > -
> > -	/* Otherwise, check the specific device */
> > -	if (p->flags & ACPI_HEST_GLOBAL) {
> > -		if (hest_match_type(hest_hdr, info->pci_dev))
> > -			info->firmware_first = ff;
> > -	} else
> > -		if (hest_match_pci(p, info->pci_dev))
> > -			info->firmware_first = ff;
> > -
> > -	return 0;
> > -}
> > -
> > -static void aer_set_firmware_first(struct pci_dev *pci_dev)
> > -{
> > -	int rc;
> > -	struct aer_hest_parse_info info = {
> > -		.pci_dev	= pci_dev,
> > -		.firmware_first	= 0,
> > -	};
> > -
> > -	rc = apei_hest_parse(aer_hest_parse, &info);
> > -
> > -	if (rc)
> > -		pci_dev->__aer_firmware_first = 0;
> > -	else
> > -		pci_dev->__aer_firmware_first = info.firmware_first;
> > -	pci_dev->__aer_firmware_first_valid = 1;
> > -}
> > -
> >  int pcie_aer_get_firmware_first(struct pci_dev *dev)
> >  {
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +
> >  	if (!pci_is_pcie(dev))
> >  		return 0;
> >  
> >  	if (pcie_ports_native)
> >  		return 0;
> >  
> > -	if (!dev->__aer_firmware_first_valid)
> > -		aer_set_firmware_first(dev);
> > -	return dev->__aer_firmware_first;
> > +	return !host->native_aer;
> >  }
> 
> > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > index 64b5e081cdb2..c05b49d740f4 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -147,16 +147,7 @@ static inline bool pcie_pme_no_msi(void) { return false; }
> >  static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
> >  #endif /* !CONFIG_PCIE_PME */
> >  
> > -#ifdef CONFIG_ACPI_APEI
> >  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
> > -#else
> > -static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
> > -{
> > -	if (pci_dev->__aer_firmware_first_valid)
> > -		return pci_dev->__aer_firmware_first;
> > -	return 0;
> > -}
> > -#endif
> >  
> >  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> >  #endif /* _PORTDRV_H_ */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 83ce1cdf5676..43f265830eca 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -420,8 +420,6 @@ struct pci_dev {
> >  	 * mappings to make sure they cannot access arbitrary memory.
> >  	 */
> >  	unsigned int	untrusted:1;
> > -	unsigned int	__aer_firmware_first_valid:1;
> > -	unsigned int	__aer_firmware_first:1;
> >  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
> >  	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
> >  	unsigned int	irq_managed:1;
> > -- 
> > 2.17.1
> > 
