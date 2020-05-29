Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2301E7AAC
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2KdU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 06:33:20 -0400
Received: from foss.arm.com ([217.140.110.172]:34738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2KdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 06:33:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0531045;
        Fri, 29 May 2020 03:33:19 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71E03F52E;
        Fri, 29 May 2020 03:33:17 -0700 (PDT)
Date:   Fri, 29 May 2020 11:33:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Message-ID: <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528030240.16024-3-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 11:02:39PM -0400, Jon Derrick wrote:
> Versions of VMD with the Host Physical Address shadow register use this
> register to calculate the bus address offset needed to do guest
> passthrough of the domain. This register shadows the Host Physical
> Address registers including the resource type bits. After calculating
> the offset, the extra resource type bits lead to the VMD resources being
> over-provisioned at the front and under-provisioned at the back.
> 
> Example:
> pci 10000:80:02.0: reg 0x10: [mem 0xf801fffc-0xf803fffb 64bit]
> 
> Expected:
> pci 10000:80:02.0: reg 0x10: [mem 0xf8020000-0xf803ffff 64bit]
> 
> If other devices are mapped in the over-provisioned front, it could lead
> to resource conflict issues with VMD or those devices.
> 
> Fixes: a1a30170138c9 ("PCI: vmd: Fix shadow offsets to reflect spec changes")
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Hi Jon,

it looks like I can take this patch for v5.8 whereas patch 2 depends
on the QEMU changes acceptance and should probably wait.

Please let me know your thoughts asap and I will try to at least
squeeze this patch in.

Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index dac91d6..e386d4e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -445,9 +445,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			if (!membar2)
>  				return -ENOMEM;
>  			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
> -					readq(membar2 + MB2_SHADOW_OFFSET);
> +					(readq(membar2 + MB2_SHADOW_OFFSET) &
> +					 PCI_BASE_ADDRESS_MEM_MASK);
>  			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
> -					readq(membar2 + MB2_SHADOW_OFFSET + 8);
> +					(readq(membar2 + MB2_SHADOW_OFFSET + 8) &
> +					 PCI_BASE_ADDRESS_MEM_MASK);
>  			pci_iounmap(vmd->dev, membar2);
>  		}
>  	}
> -- 
> 1.8.3.1
> 
