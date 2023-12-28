Return-Path: <linux-pci+bounces-1521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE981FB57
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 22:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EB01C21E06
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E92101D9;
	Thu, 28 Dec 2023 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idDxD4Bv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1359107BA
	for <linux-pci@vger.kernel.org>; Thu, 28 Dec 2023 21:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB517C433C7;
	Thu, 28 Dec 2023 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703798622;
	bh=GatiE2VQ9hIH0S6FVmFIzHGLRh6yS9fcrFSkypS/sZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=idDxD4Bv2Ztg0lfaa1Lzk5ijIToZSfds7lHVEOL1R/Y7u0S/LAGBn7YjJKFFYhfFO
	 qiCO2Z4oxytpQuOP4mekpRTNOqe74HcSaZcN5fynmwYc70Ty7NrkL/pm9dxqc33+8w
	 AbcaunR92vA0Z1szMsufbLgD0B4ABR7Kufe58lU5RVqsU5q4s6W6UJdFQVKoEo5zbH
	 7RU8LucNVC0yr568N2w1JRNgfRiJgYAoTDgoctqD56/p9Y1nKpDoeZ3kwrcQvA7L4U
	 ajA6hkoNWKcQll0JFuIJzxVPOPf1KIFM+jIula1CV5SoM3tQv/K6GtYzslzEZJHuYA
	 yQgcEIFTFx/sw==
Date: Thu, 28 Dec 2023 15:23:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <20231228212340.GA1553749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223212235.34293-2-mattc@purestorage.com>

[+cc Keith, Lukas]

Hi Matthew, thanks for your work and the patch.

On Sat, Dec 23, 2023 at 02:22:35PM -0700, Matthew W Carlis wrote:
> This change ensures the kernel will use DPC on a supporting device if
> the kernel will also control AER on the Root Ports & RCECs.
> 
> The rules around controlling DPC/AER are somewhat clear in PCIe/ACPI
> specifications. It is recommended to always link control of both to the
> same entity, being the OS or system firmware. The kernel wants to be
> flexible by first having a default policy, but also by providing command
> line parameters to enable us all to do what we want even if it might
> violate the recommendations.
> 
> The following mentioned patch brought the kernels default behavior
> more in line with the specification around AER, but changed its behavior
> around DPC on PCIe Downstream Switch Ports; preventing the kernel from
> controlling DPC on them unless using pcie_ports=dpc-native.
>     * "PCI/portdrv: Allow AER service only for Root Ports & RCECs"
> After this change the behavior around using DPC on PCIe switch ports
> and Root Ports should be as it was before.
> 
> Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
> ---
>  drivers/pci/pcie/portdrv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..8e023aa97672 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -257,12 +257,19 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  	/*
> +	 * _OSC AER Control is required by the OS & requires OS to control AER,
> +	 * but _OSC DPC Control isn't required by the OS to control DPC; however
> +	 * it does require the OS to control DPC. _OSC DPC Control also requres
> +	 * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
> +	 * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
> +	 * platform fw or OS always link control of DPC to AER.
> +	 *
>  	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>  	 * permission to use AER.
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    pci_aer_available() && (pcie_ports_dpc_native ||
> +	    (dev->aer_cap && host->native_aer)))
>  		services |= PCIE_PORT_SERVICE_DPC;

This is easier to read if we retain the original line breaks, i.e.,

  -     (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
  +     (pcie_ports_dpc_native || (dev->aer_cap && host->native_aer)))

Prior to d8d2b65a940b, we set PCIE_PORT_SERVICE_AER for a device
whenever it had an AER Capability.  If it had a DPC Capability, we
also set PCIE_PORT_SERVICE_DPC so DPC would work on it.

After d8d2b65a940b, we only set PCIE_PORT_SERVICE_AER for Root Ports
and RCECs because the AER driver only binds to those devices.  We no
longer set PCIE_PORT_SERVICE_DPC for Switch Downstream Ports because
they don't have PCIE_PORT_SERVICE_AER set.

The result is that you need "pcie_ports=dpc-native" to make DPC work
on those devices when you didn't need it before d8d2b65a940b.

That's a regression that we need to fix:
#regzbot introduced: d8d2b65a940b ("PCI/portdrv: Allow AER service only for Root Ports & RCECs")

_OSC directly supports negotiation of DPC ownership, and I think we
should pay attention to what it tell us.  We already request DPC
control and set native_dpc accordingly, but we don't use it here;
currently we only look at it in the unrelated pciehp_ist() path.

Can you try the patch below and see if it resolves the problem?

I don't think we need to complicate this by trying to enforce the
AER/DPC dependencies in the OS.  The firmware spec already requires
platforms to either retain ownership of both AER and DPC, or grant
ownership of both to the OS.

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..423dadd6727e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -262,7 +262,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (pcie_ports_dpc_native || host->native_dpc))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||

