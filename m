Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5A3C88D8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhGNQqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 12:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235859AbhGNQqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 12:46:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B67613C0;
        Wed, 14 Jul 2021 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626280990;
        bh=/yUb8YhcoUWFnRWjqTEBMvUi/4Ai1rusVFWVlDh/YHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XiAYjhIwsqlcbpM4svjvKLdJCGtKU7MGIlnjDQ3yq2diUXpcEm/LP+izlMcOLt6E4
         UAq37FM6iDZOML1OAhsucPDRFipWlA89Ch8loY5+fA7tEKXXwWOy097ihtK5sGGfNS
         EsnsnlxVYZJk3aDjCUh0TKo/OdCuNvOHv60xAhgP6VNDQeXUKDyvl1pGj6QVDomXhB
         RFnWB/Z/Kw+xoYmKac3lLkcyLjFiQprw3sP382HienMVvfvai2Y07FUOukfT9wUQjo
         YDmi7pwShpLQLuB/DGzFux368YeX2C9zKdeTyjadB0FE2ZnNADKijRLoFY+5qR6xHB
         +Yvahprb1YJdg==
Date:   Wed, 14 Jul 2021 11:43:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI: Clean up VPD constants and functions in pci.h
Message-ID: <20210714164308.GA1853971@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f81466-96a8-4895-aafe-c7317c852db7@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 10:55:26PM +0200, Heiner Kallweit wrote:
> Move some constants that are used by vpd.c only from include/linux/pci.h
> to drivers/pci/vpd.c. In addition remove some unused VPD inline functions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c   |  7 +++++++
>  include/linux/pci.h | 43 -------------------------------------------
>  2 files changed, 7 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index ecdce170f..ff537371c 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -13,6 +13,13 @@
>  
>  /* VPD access through PCI 2.2+ VPD capability */
>  
> +/* Small Resource Data Type */
> +#define PCI_VPD_SRDT_TAG_SIZE	1
> +#define PCI_VPD_SRDT_END	(0x0f << 3) /* end tag */
> +
> +/* Large Resource Data Type */
> +#define PCI_VPD_LRDT_TIN_MASK	0x7f
> +
>  struct pci_vpd_ops {
>  	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59..c21558821 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2240,17 +2240,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask);
>  #define PCI_VPD_LRDT_RO_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RO_DATA)
>  #define PCI_VPD_LRDT_RW_DATA		PCI_VPD_LRDT_ID(PCI_VPD_LTIN_RW_DATA)
>  
> -/* Small Resource Data Type Tag Item Names */
> -#define PCI_VPD_STIN_END		0x0f	/* End */
> -
> -#define PCI_VPD_SRDT_END		(PCI_VPD_STIN_END << 3)
> -
> -#define PCI_VPD_SRDT_TIN_MASK		0x78
> -#define PCI_VPD_SRDT_LEN_MASK		0x07
> -#define PCI_VPD_LRDT_TIN_MASK		0x7f
> -
>  #define PCI_VPD_LRDT_TAG_SIZE		3
> -#define PCI_VPD_SRDT_TAG_SIZE		1
>  
>  #define PCI_VPD_INFO_FLD_HDR_SIZE	3
>  
> @@ -2271,39 +2261,6 @@ static inline u16 pci_vpd_lrdt_size(const u8 *lrdt)
>  	return (u16)lrdt[1] + ((u16)lrdt[2] << 8);
>  }
>  
> -/**
> - * pci_vpd_lrdt_tag - Extracts the Large Resource Data Type Tag Item
> - * @lrdt: Pointer to the beginning of the Large Resource Data Type tag
> - *
> - * Returns the extracted Large Resource Data Type Tag item.
> - */
> -static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
> -{
> -	return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
> -}
> -
> -/**
> - * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
> - * @srdt: Pointer to the beginning of the Small Resource Data Type tag
> - *
> - * Returns the extracted Small Resource Data Type length.
> - */
> -static inline u8 pci_vpd_srdt_size(const u8 *srdt)
> -{
> -	return (*srdt) & PCI_VPD_SRDT_LEN_MASK;
> -}
> -
> -/**
> - * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
> - * @srdt: Pointer to the beginning of the Small Resource Data Type tag
> - *
> - * Returns the extracted Small Resource Data Type Tag Item.
> - */
> -static inline u8 pci_vpd_srdt_tag(const u8 *srdt)
> -{
> -	return ((*srdt) & PCI_VPD_SRDT_TIN_MASK) >> 3;
> -}

I think the last uses of these were removed by the previous patch.
Can you remove these definitions in the same patch that removed the
last use?  Then we don't have the unused things dangling between
patches.

>  /**
>   * pci_vpd_info_field_size - Extracts the information field length
>   * @info_field: Pointer to the beginning of an information field header
> -- 
> 2.31.1
> 
> 
