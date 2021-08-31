Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD843FCD94
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhHaTMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 15:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239523AbhHaTMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 15:12:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96CC61041;
        Tue, 31 Aug 2021 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437090;
        bh=yXGLJ89LVA1WEyeIl9eFXtaUf9sdbM507DJLnsBxFq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hsFDVutCDHnJWyHitS49dVOYeWNSALX/ADFkzbsoy4UBxBetnvlGlLYX4XjIU1ka8
         Xlxz1XCyLOEilhCgiv3C8P5GI2NSZXWl7Ij5wYcT6I1goeveVQwIoUegAbUVag/RLb
         d8LHnEx7lnQLWFNaI+09ZlWvrw+x4oVDBWLxOpquewGmLNwujiFiL4SucunoD4qeeK
         HaKgXbZH+w5OhsG4Ke7e5BXg17mtiNOzwxhvry2+DGLNrzOlxs8ZM/LYPS/ChWmkKj
         xhfeUywDmhpSanqs8ptCKPaXkfdzQ4z77xVuUOVJRHt2r9I9q5tX57ggHLP229nC/o
         kcz9mlPBfjSXQ==
Date:   Tue, 31 Aug 2021 14:11:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210831191128.GA124802@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Myron]

On Thu, May 13, 2021 at 03:03:14AM +0530, Stuart Hayes wrote:
> The pcieport driver can fail to attach to a downstream port that doesn't
> support bandwidth notification.  This can happen when, in
> pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
> set up a bandwidth notification IRQ for a device that doesn't support it.
> 
> This patch changes get_port_device_capability() to look at the link
> bandwidth notification capability bit in the link capabilities register of
> the port, instead of assuming that all downstream ports have that
> capability.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Sorry, I totally dropped the ball on this.  I added a stable tag and
put this on pci/portdrv and plan to try to squeeze it into v5.15.

> ---
> 
> changes from v1:
> 	- corrected spelling errors in commit message
> 	- added Lukas' reviewed-by:
> 
> ---
>  drivers/pci/pcie/portdrv_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed6649c41..3ee63968deaa 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		u32 linkcap;
> +
> +		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +			services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	}
>  
>  	return services;
>  }
> -- 
> 2.27.0
> 
