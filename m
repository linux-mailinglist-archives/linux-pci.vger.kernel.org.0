Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB52CB4C1C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfIQKlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 06:41:12 -0400
Received: from foss.arm.com ([217.140.110.172]:54260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfIQKlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 06:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2D91000;
        Tue, 17 Sep 2019 03:41:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A67C3F59C;
        Tue, 17 Sep 2019 03:41:10 -0700 (PDT)
Date:   Tue, 17 Sep 2019 11:41:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Message-ID: <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
 <20190916135435.5017-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916135435.5017-3-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 07:54:35AM -0600, Jon Derrick wrote:
> The shadow offset scratchpad was moved to 0x2000-0x2010. Update the
> location to get the correct shadow offset.

Hi Jon,

what does "was moved" mean ? Would this code still work on previous HW ?

We must make sure that the address move is managed seamlessly by the
kernel.

For the time being I have to drop this fix and it is extremely
tight to get it in v5.4, I can't send stable changes that we may
have to revert.

Thanks,
Lorenzo

> Cc: stable@vger.kernel.org # v5.2+
> Fixes: 6788958e ("PCI: vmd: Assign membar addresses from shadow registers")
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 2e4da3f51d6b..a35d3f3996d7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -31,6 +31,9 @@
>  #define PCI_REG_VMLOCK		0x70
>  #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
>  
> +#define MB2_SHADOW_OFFSET	0x2000
> +#define MB2_SHADOW_SIZE		16
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -578,7 +581,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		u32 vmlock;
>  		int ret;
>  
> -		membar2_offset = 0x2018;
> +		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
>  		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
>  		if (ret || vmlock == ~0)
>  			return -ENODEV;
> @@ -590,9 +593,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			if (!membar2)
>  				return -ENOMEM;
>  			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
> -						readq(membar2 + 0x2008);
> +					readq(membar2 + MB2_SHADOW_OFFSET);
>  			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
> -						readq(membar2 + 0x2010);
> +					readq(membar2 + MB2_SHADOW_OFFSET + 8);
>  			pci_iounmap(vmd->dev, membar2);
>  		}
>  	}
> -- 
> 2.20.1
> 
