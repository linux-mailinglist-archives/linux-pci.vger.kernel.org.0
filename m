Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D623A83B0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFOPLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 11:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhFOPLw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 11:11:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD5D361607;
        Tue, 15 Jun 2021 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623769788;
        bh=xZ2c9FIXhMbs/nAc5HgGETR1BJI49Ytt9JNbgvnEq8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pFxQ1DygVFWH6WhCEX1XkUcl+Um8krpg8kri6TPmzs528TAujGfdcjpnjcg2KXZG5
         m8fismt/jkHNtUTH4mo9gOv3T2gUTN9YPc5tbRKnC2fXpIeVe505oO1u1CQKUhoDlI
         q1xmmN3Qxf13g8YVhK1iSRuklfGGvn4Roa6BiVsVfJh5dQ2JhIbsU1RUr8ACquizSj
         rEpd1EhiBo5l+Y/67fU3/tP/OC4smDsGEQj3pK3kbNmHqX+yuEXyPdP4+v8a82rD6J
         Sdr1IszhSvhHjgJfc5vg5FQzVYLogNsbJDqIvov7ic7OT6ZjVRCOrKGdnu9xRc5G0U
         giQEYxgp0utVQ==
Date:   Tue, 15 Jun 2021 10:09:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH kernel v2] powerpc/powernv: Reserve a hole which appears
 after enabling IOV
Message-ID: <20210615150946.GA2881072@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927065231.20382-1-aik@ozlabs.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2017 at 04:52:31PM +1000, Alexey Kardashevskiy wrote:
> In order to make generic IOV code work, the physical function IOV BAR
> should start from offset of the first VF. Since M64 segments share
> PE number space across PHB, and some PEs may be in use at the time
> when IOV is enabled, the existing code shifts the IOV BAR to the index
> of the first PE/VF. This creates a hole in IOMEM space which can be
> potentially taken by some other device.
> 
> This reserves a temporary hole on a parent and releases it when IOV is
> disabled; the temporary resources are stored in pci_dn to avoid
> kmalloc/free.
> 
> Cc: linux-pci@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I assume this goes to powerpc next branch but before this I'd like to
> get Bjorn's opinion as he continously commented on this bit.
> 
> This is the diff in /proc/iomem:
> 
> @@ -11,6 +11,7 @@
>          200800000000-200bffffffff : 0000:04:00.0
>  210000000000-21fdffffffff : /pciex@3fffe40100000
>    210000000000-21fdfff0ffff : PCI Bus 0001:01
> +    210000000000-210009ffffff : pnv_iov_reserved
>      21000a000000-2101ffffffff : 0001:01:00.0
>        21000a000000-21000bffffff : 0001:01:00.2
>          21000a000000-21000bffffff : mlx5_core
> 
> ---
> Changes:
> v2:
> * changed order - now devm_release_resource() is called before
> pci_update_resource(). Strangely the opposite did not produce a warning
> but still
> ---
>  arch/powerpc/include/asm/pci-bridge.h     |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c | 24 +++++++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 0b8aa1fe2d5f..62ed83db04ae 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -218,6 +218,7 @@ struct pci_dn {
>  #endif
>  	struct list_head child_list;
>  	struct list_head list;
> +	struct resource holes[PCI_SRIOV_NUM_BARS];
>  };
>  
>  /* Get the pointer to a device_node's pci_dn */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 57f9e55f4352..d66a758b8efb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1002,9 +1002,12 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  	}
>  
>  	/*
> -	 * After doing so, there would be a "hole" in the /proc/iomem when
> -	 * offset is a positive value. It looks like the device return some
> -	 * mmio back to the system, which actually no one could use it.
> +	 * Since M64 BAR shares segments among all possible 256 PEs,
> +	 * we have to shift the beginning of PF IOV BAR to make it start from
> +	 * the segment which belongs to the PE number assigned to the first VF.
> +	 * This creates a "hole" in the /proc/iomem which could be used for
> +	 * allocating other resources so we reserve this area below and
> +	 * release when IOV is released.
>  	 */
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -1018,7 +1021,22 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (%sabling %d VFs shifted by %d)\n",
>  			 i, &res2, res, (offset > 0) ? "En" : "Dis",
>  			 num_vfs, offset);
> +
> +		if (offset < 0) {
> +			devm_release_resource(&dev->dev, &pdn->holes[i]);
> +			memset(&pdn->holes[i], 0, sizeof(pdn->holes[i]));
> +		}
> +
>  		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
> +
> +		if (offset > 0) {
> +			pdn->holes[i].start = res2.start;
> +			pdn->holes[i].end = res2.start + size * offset - 1;
> +			pdn->holes[i].flags = IORESOURCE_BUS;
> +			pdn->holes[i].name = "pnv_iov_reserved";
> +			devm_request_resource(&dev->dev, res->parent,
> +					&pdn->holes[i]);

Does this actually work as you intended?  It looks wrong to set
"pdn->holes[i].flags = IORESOURCE_BUS" and then use res->parent,
an IORESOURCE_MEM resource, as the root.

I didn't figure out what actually happens.  Maybe nothing, since I
don't see anything in the

  devm_request_resource
    request_resource_conflict
      __request_resource

path that actually *looks* at "flags".  But it doesn't look right.

> +		}
>  	}
>  	return 0;
>  }
> -- 
> 2.11.0
> 
