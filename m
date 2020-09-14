Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4146A26951C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgINSm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 14:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgINSmv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 14:42:51 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F861208B3;
        Mon, 14 Sep 2020 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108965;
        bh=J2Eu+UEixaWbeDTKFivypSdsvj6018V7BMKdixtixBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8NrKEtx0lHPz0T77i+HSGZqYr3Yc1r+gWPMFtaRqrVjDxBaEI+wOK2NmAKfzA5++
         iHkxa29JB2hgwpTubTT6I1uSqPAylLadceldzUOV1afPS12GfKnfUBlmA+5owQJ72z
         xv3mPDTg5Fci6FZdA4KJoyQ5ewBD92i+FcIlTcj4=
Date:   Tue, 15 Sep 2020 03:42:38 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Offset Client VMD MSI/X vectors
Message-ID: <20200914184238.GA10507@redsun51.ssa.fujisawa.hgst.com>
References: <20200914173255.5481-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914173255.5481-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 01:32:55PM -0400, Jon Derrick wrote:
> Client VMD platforms have a software-triggered MSI/X vector 0 that will
> not forward hardware-remapped MSI/X vectors from the sub-device domain.
> This causes an issue with VMD platforms that use AHCI behind VMD and
> have a single MSI/X vector mapping to vector 0. Add an MSI/X vector
> offset for these platforms.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f69ef8c89f72..f8195bad79d1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -53,6 +53,12 @@ enum vmd_features {
>  	 * vendor-specific capability space
>  	 */
>  	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
> +
> +	/*
> +	 * Device may use MSI/X vector 0 for software triggering and will not
> +	 * be used for MSI/X remapping
> +	 */
> +	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
>  };
>  
>  /*
> @@ -104,6 +110,7 @@ struct vmd_dev {
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
>  	u8			busn_start;
> +	u8			first_vec;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -199,25 +206,26 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
>   */
>  static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
>  {
> -	int i, best = 1;
>  	unsigned long flags;
> +	int i, best;
>  
>  	if (vmd->msix_count == 1)

This condition needs account for the vector offset, right?

  	if (vmd->msix_count == 1 + vmd->first_vec))

> -		return &vmd->irqs[0];
> +		return &vmd->irqs[vmd->first_vec];
