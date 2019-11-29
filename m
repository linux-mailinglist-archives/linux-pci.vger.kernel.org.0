Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975C910D8AE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK2Qud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 11:50:33 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35114 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfK2Qud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 11:50:33 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iajTD-0007PZ-KQ; Fri, 29 Nov 2019 09:50:16 -0700
To:     James Sewart <jamessewart@arista.com>, linux-pci@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
Date:   Fri, 29 Nov 2019 09:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com, dima@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, hch@infradead.org, linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-29 5:49 a.m., James Sewart wrote:
> pci_add_dma_alias can now be used to create a dma alias for a range of
> devfns.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c    | 23 ++++++++++++++++++-----
>  drivers/pci/quirks.c | 14 +++++++-------
>  include/linux/pci.h  |  2 +-
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..9b0e3481fe17 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> - * @devfn: alias slot and function
> + * @devfn_from: alias slot and function
> + * @nr_devfns: Number of subsequent devfns to alias
>   *
>   * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>   * which is used to program permissible bus-devfn source addresses for DMA
> @@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>  {
> +	int devfn_to;
> +
> +	if (nr_devfns > U8_MAX+1)
> +		nr_devfns = U8_MAX+1;

Why +1? That doesn't seem right to me....

> +	devfn_to = devfn_from + nr_devfns - 1;
> +
>  	if (!dev->dma_alias_mask)
>  		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
> @@ -5882,9 +5889,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  		return;
>  	}
>  
> -	set_bit(devfn, dev->dma_alias_mask);
> -	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> -		 PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
> +
> +	if (nr_devfns == 1)
> +		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from));
> +	else if(nr_devfns > 1)
> +		pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from),
> +				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
>  }
>  
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..0f3f5afc73fd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 0)
> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0), 1);
>  }
>  
>  /*
> @@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 1)
> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1), 1);
>  }
>  
>  /*
> @@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
>  
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
>  	if (id)
> -		pci_add_dma_alias(dev, id->driver_data);
> +		pci_add_dma_alias(dev, id->driver_data, 1);
>  }
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
> @@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>   */
>  static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
>  {
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
> @@ -5273,7 +5273,7 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  			pci_dbg(pdev,
>  				"Aliasing Partition %d Proxy ID %02x.%d\n",
>  				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
> -			pci_add_dma_alias(pdev, devfn);
> +			pci_add_dma_alias(pdev, devfn, 1);
>  		}
>  	}
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a6cf19eac2d..84a8d4c2b24e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2323,7 +2323,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  }
>  #endif
>  
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			   int (*fn)(struct pci_dev *pdev,
> 
