Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89546C640
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbhLGVLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 16:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhLGVLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 16:11:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F162C061746;
        Tue,  7 Dec 2021 13:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBF8CCE1E01;
        Tue,  7 Dec 2021 21:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8250C341C1;
        Tue,  7 Dec 2021 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911285;
        bh=Un8pVb1ViG+hHJBV0K32UXMvYIETtBkFtRlli7CA0QM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aCbzd0NEb2pQzyZ0dxCVmc3D7+wht440q0E0LtCH9EBL6AmXweh77FA6vFVv+lovw
         QxUM8o9yuv91Owv+YX0uqXzLPMe9Xmgrdwsq/Q0XtDXLOgeHXtR/qWyue29zAHe+qn
         ZNo6fhJJvBTogag2oEBDmFwEwkYMA/6cjrRB9/RvEo/WrLVjhaCtSMKZ3lJBI/ML0e
         H2WKoiCX7z7ZcvhMozBDewcD4TrkbQVYFGuZQ6IhOk/J97KO7Fn9gfBhXnI6eBTMOi
         jxz2bdl5MIQY5mZHQt4K9hdDQz+EBL7RNknLIwfMhihldvflaMJpn9QmDetpivNk4I
         5elH8aZ6ytVgA==
Date:   Tue, 7 Dec 2021 15:08:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 19/31] PCI: hv: Rework MSI handling
Message-ID: <20211207210803.GA78366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210748.629363944@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:33PM +0100, Thomas Gleixner wrote:
> Replace the about to vanish iterators and make use of the filtering. Take
> the descriptor lock around the iterators.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3445,18 +3445,23 @@ static int hv_pci_suspend(struct hv_devi
>  
>  static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
>  {
> -	struct msi_desc *entry;
>  	struct irq_data *irq_data;
> +	struct msi_desc *entry;
> +	int ret = 0;
>  
> -	for_each_pci_msi_entry(entry, pdev) {
> +	msi_lock_descs(&pdev->dev);
> +	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_data = irq_get_irq_data(entry->irq);
> -		if (WARN_ON_ONCE(!irq_data))
> -			return -EINVAL;
> +		if (WARN_ON_ONCE(!irq_data)) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
>  		hv_compose_msi_msg(irq_data, &entry->msg);
>  	}
> +	msi_unlock_descs(&pdev->dev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /*
> 
