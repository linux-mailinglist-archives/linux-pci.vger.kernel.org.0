Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A518E10A2F6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfKZRHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 12:07:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:52650 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbfKZRHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 12:07:03 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iZeIk-0004un-K7; Tue, 26 Nov 2019 10:06:59 -0700
To:     James Sewart <jamessewart@arista.com>, linux-pci@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
Date:   Tue, 26 Nov 2019 10:06:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com, dima@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2] PCI: Add DMA alias quirk for PLX PEX NTB
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-26 10:03 a.m., James Sewart wrote:
> The PLX PEX NTB forwards DMA transactions using Requester ID's that
> don't exist as PCI devices. The devfn for a transaction is used as an
> index into a lookup table storing the origin of a transaction on the
> other side of the bridge.
> 
> Add helper pci_add_dma_alias_range that can alias a range of devfns in 
> dma_alias_mask.
> 
> This patch aliases all possible devfn's to the NTB device so that any
> transaction coming in is governed by the mappings for the NTB.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>

Looks good to me, save a nit below; and you may want to split this into
two patches: one that introduces the new interface and one that uses it.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/pci.c    | 29 ++++++++++++++++++++++-------
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..f502af1b5d10 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5854,6 +5854,18 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +int _pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)
> +{
> +	if (!dev->dma_alias_mask)
> +		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> +	if (!dev->dma_alias_mask) {
> +		pci_warn(dev, "Unable to allocate DMA alias mask\n");
> +		return -ENOMEM;
> +	}
> +	bitmap_set(dev->dma_alias_mask, devfn_from, len);
> +	return 0;
> +}
> +
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> @@ -5875,18 +5887,21 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> -	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> -	if (!dev->dma_alias_mask) {
> -		pci_warn(dev, "Unable to allocate DMA alias mask\n");
> +	if (_pci_add_dma_alias_range(dev, devfn, 1) != 0)
>  		return;
> -	}
> -
> -	set_bit(devfn, dev->dma_alias_mask);
>  	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
>  		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
>  
> +void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)
> +{
> +	int devfn_to = devfn_from + len - 1;

Nit: there should be a blank line between the variable declarations and
the code in the functions.

> +	if (_pci_add_dma_alias_range(dev, devfn_from, len) != 0)
> +		return;
> +	pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
> +		 PCI_SLOT(devfn_from), PCI_FUNC(devfn_from), PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
> +}
> +
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  {
>  	return (dev1->dma_alias_mask &&
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..1ed230f739a4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5315,6 +5315,21 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>  
> +/*
> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
> + * are used to forward responses to the originator on the other side of the
> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
> + * turned on.
> + */
> +static void quirk_plx_ntb_dma_alias(struct pci_dev *pdev)
> +{
> +	pci_info(pdev, "Setting PLX NTB proxy ID aliases\n");
> +	/* PLX NTB may use all 256 devfns */
> +	pci_add_dma_alias_range(pdev, 0, 256);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_plx_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_plx_ntb_dma_alias);
> +
>  /*
>   * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
>   * not always reset the secondary Nvidia GPU between reboots if the system
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a6cf19eac2d..6765f3d0102b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2324,6 +2324,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  #endif
>  
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len);
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			   int (*fn)(struct pci_dev *pdev,
> 
