Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343861EB0E9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgFAVZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgFAVZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 17:25:22 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80095206E2;
        Mon,  1 Jun 2020 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591046721;
        bh=8Qt9e+XiD+FUR7h1k2mvt1mhtQNAprWB2mByevBZk2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Tfnv5ezJEYhLG3oubFQtNlNFDM77YpLtWpiK17A5c0idmWA0mdy6adF/ky3z8yezb
         8VvAj0fYHRPVM1uO6EGqVvCNwlE4uemfr8zUQf+2srN1kYRkSwQUWbVu/rvP/xJHQy
         MOgFpUic5ewR3UBpiwKZLLng4DXpV+RPrUWYTQLM=
Date:   Mon, 1 Jun 2020 16:25:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200601212519.GA758937@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 01:57:42PM -0700, Ashok Raj wrote:
> All Intel platforms guarantee that all root complex implementations
> must send transactions up to IOMMU for address translations. Hence for
> RCiEP devices that are Vendor ID Intel, can claim exception for lack of
> ACS support.
> 
> 
> 3.16 Root-Complex Peer to Peer Considerations
> When DMA remapping is enabled, peer-to-peer requests through the
> Root-Complex must be handled
> as follows:
> • The input address in the request is translated (through first-level,
>   second-level or nested translation) to a host physical address (HPA).
>   The address decoding for peer addresses must be done only on the
>   translated HPA. Hardware implementations are free to further limit
>   peer-to-peer accesses to specific host physical address regions
>   (or to completely disallow peer-forwarding of translated requests).
> • Since address translation changes the contents (address field) of
>   the PCI Express Transaction Layer Packet (TLP), for PCI Express
>   peer-to-peer requests with ECRC, the Root-Complex hardware must use
>   the new ECRC (re-computed with the translated address) if it
>   decides to forward the TLP as a peer request.
> • Root-ports, and multi-function root-complex integrated endpoints, may
>   support additional peerto-peer control features by supporting PCI Express
>   Access Control Services (ACS) capability. Refer to ACS capability in
>   PCI Express specifications for details.
> 
> Since Linux didn't give special treatment to allow this exception, certain
> RCiEP MFD devices are getting grouped in a single iommu group. This
> doesn't permit a single device to be assigned to a guest for instance.
> 
> In one vendor system: Device 14.x were grouped in a single IOMMU group.
> 
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> 
> After the patch:
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> 
> 14.0 and 14.2 are integrated devices, but legacy end points.
> Whereas 14.3 was a PCIe compliant RCiEP.
> 
> 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> 
> This permits assigning this device to a guest VM.
> 
> Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> Cc: Mark Scott <mscott@forcepoint.com>,
> Cc: Romil Sharma <rsharma@forcepoint.com>
> Cc: Ashok Raj <ashok.raj@intel.com>

Tentatively applied to pci/virtualization for v5.8, thanks!

The spec says this handling must apply "when DMA remapping is
enabled".  The patch does not check whether DMA remapping is enabled.

Is there any case where DMA remapping is *not* enabled, and we rely on
this patch to tell us whether the device is isolated?  It sounds like
it may give the wrong answer in such a case?

Can you confirm that I don't need to worry about this?  

> ---
> v2: Moved functionality from iommu to pci quirks - Alex Williamson
> 
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c9a2409c50..63373ca0a3fe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4682,6 +4682,20 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>  }
>  
> +static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * RCiEP's are required to allow p2p only on translated addresses.
> +	 * Refer to Intel VT-d specification Section 3.16 Root-Complex Peer
> +	 * to Peer Considerations
> +	 */
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
> +		return -ENOTTY;
> +
> +	return pci_acs_ctrl_enabled(acs_flags,
> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
> +}
> +
>  static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	/*
> @@ -4764,6 +4778,7 @@ static const struct pci_dev_acs_enabled {
>  	/* I219 */
>  	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
> +	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
>  	/* QCOM QDF2xxx root ports */
>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> -- 
> 2.7.4
> 
