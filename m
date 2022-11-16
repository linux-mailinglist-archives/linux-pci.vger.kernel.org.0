Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E362C9A1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKPUKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKPUKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C146314B;
        Wed, 16 Nov 2022 12:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8BD61F7E;
        Wed, 16 Nov 2022 20:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61803C433D6;
        Wed, 16 Nov 2022 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629413;
        bh=WyIRbhkov3S53GoGHspADdJx6JBTh0gwM3r9YQo7aoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AALtFw3qTqrwnXfBdZ8sJgymnC1ZAeT7DfbUukgZyWAeu1+4BKEutdV/u8sr64/0/
         H5SFSR+ZAgjnSnPIyIDJ9xBMfc4VWhlqYsowtn/jsVcd/CKHE4wkN4/yL7XbBDZO96
         mXNDZl1cLsDeupRiVj99lOkBUvbqztAYxFi6orIcFVX8LtdqeFjHEjDON9VatlMeGx
         k6CUVkPpwvwoH55yehVPREEQxjrmMI4NdODniCKpJZOh0lX7zYBCCg6nzrwOKLtXVH
         OvlqjdW38ya6B8VkWJuIw+fXTotGXm3LoEoPLB8JQTcQK6VGcnWYx6Y+9iLxlRNlJO
         QWiW608QJPrkw==
Date:   Wed, 16 Nov 2022 14:10:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 10/33] PCI/MSI: Split __pci_write_msi_msg()
Message-ID: <20221116201011.GA1133404@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135205.836259395@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:27PM +0100, Thomas Gleixner wrote:
> The upcoming per device MSI domains will create different domains for MSI
> and MSI-X. Split the write message function into MSI and MSI-X helpers so
> they can be used by those new domain functions seperately.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |  104 +++++++++++++++++++++++++-------------------------
>  1 file changed, 54 insertions(+), 50 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -180,6 +180,58 @@ void __pci_read_msi_msg(struct msi_desc
>  	}
>  }
>  
> +static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
> +				     struct msi_msg *msg)
> +{
> +	int pos = dev->msi_cap;
> +	u16 msgctl;
> +
> +	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> +	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
> +	msgctl |= desc->pci.msi_attrib.multiple << 4;
> +	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
> +
> +	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
> +	if (desc->pci.msi_attrib.is_64) {
> +		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,  msg->address_hi);
> +		pci_write_config_word(dev, pos + PCI_MSI_DATA_64, msg->data);
> +	} else {
> +		pci_write_config_word(dev, pos + PCI_MSI_DATA_32, msg->data);
> +	}
> +	/* Ensure that the writes are visible in the device */
> +	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> +}
> +
> +static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	void __iomem *base = pci_msix_desc_addr(desc);
> +	u32 ctrl = desc->pci.msix_ctrl;
> +	bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +
> +	if (desc->pci.msi_attrib.is_virtual)
> +		return;
> +	/*
> +	 * The specification mandates that the entry is masked
> +	 * when the message is modified:
> +	 *
> +	 * "If software changes the Address or Data value of an
> +	 * entry while the entry is unmasked, the result is
> +	 * undefined."
> +	 */
> +	if (unmasked)
> +		pci_msix_write_vector_ctrl(desc, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +
> +	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
> +	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
> +	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> +
> +	if (unmasked)
> +		pci_msix_write_vector_ctrl(desc, ctrl);
> +
> +	/* Ensure that the writes are visible in the device */
> +	readl(base + PCI_MSIX_ENTRY_DATA);
> +}
> +
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>  	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
> @@ -187,63 +239,15 @@ void __pci_write_msi_msg(struct msi_desc
>  	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
>  		/* Don't touch the hardware now */
>  	} else if (entry->pci.msi_attrib.is_msix) {
> -		void __iomem *base = pci_msix_desc_addr(entry);
> -		u32 ctrl = entry->pci.msix_ctrl;
> -		bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
> -
> -		if (entry->pci.msi_attrib.is_virtual)
> -			goto skip;
> -
> -		/*
> -		 * The specification mandates that the entry is masked
> -		 * when the message is modified:
> -		 *
> -		 * "If software changes the Address or Data value of an
> -		 * entry while the entry is unmasked, the result is
> -		 * undefined."
> -		 */
> -		if (unmasked)
> -			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
> -
> -		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
> -		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
> -		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> -
> -		if (unmasked)
> -			pci_msix_write_vector_ctrl(entry, ctrl);
> -
> -		/* Ensure that the writes are visible in the device */
> -		readl(base + PCI_MSIX_ENTRY_DATA);
> +		pci_write_msg_msix(entry, msg);
>  	} else {
> -		int pos = dev->msi_cap;
> -		u16 msgctl;
> -
> -		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> -		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
> -		msgctl |= entry->pci.msi_attrib.multiple << 4;
> -		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
> -
> -		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
> -				       msg->address_lo);
> -		if (entry->pci.msi_attrib.is_64) {
> -			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
> -					       msg->address_hi);
> -			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
> -					      msg->data);
> -		} else {
> -			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
> -					      msg->data);
> -		}
> -		/* Ensure that the writes are visible in the device */
> -		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> +		pci_write_msg_msi(dev, entry, msg);
>  	}
>  
> -skip:
>  	entry->msg = *msg;
>  
>  	if (entry->write_msi_msg)
>  		entry->write_msi_msg(entry, entry->write_msi_msg_data);
> -
>  }
>  
>  void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
> 
