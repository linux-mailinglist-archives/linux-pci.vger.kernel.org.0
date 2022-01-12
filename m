Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8288048BB9D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 01:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiALAGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 19:06:03 -0500
Received: from mx.socionext.com ([202.248.49.38]:6014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233810AbiALAF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jan 2022 19:05:59 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Jan 2022 09:05:58 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 859602059054;
        Wed, 12 Jan 2022 09:05:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 12 Jan 2022 09:05:58 +0900
Received: from [10.212.180.44] (unknown [10.212.180.44])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 56BA9B62A1;
        Wed, 12 Jan 2022 09:05:56 +0900 (JST)
Subject: Re: [patch] genirq/msi: Populate sysfs entry only once
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
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
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de> <87leznqx2a.ffs@tglx>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com>
Date:   Wed, 12 Jan 2022 09:05:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87leznqx2a.ffs@tglx>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Is this fix the same as below?
https://marc.info/?l=linux-kernel&m=164061119923119&w=2

On 2022/01/11 3:12, Thomas Gleixner wrote:
> The MSI entries for multi-MSI are populated en bloc for the MSI
> descriptor,
> but the current code invokes the population inside the per interrupt loop
> which triggers a warning in the sysfs code and causes the interrupt
> allocation to fail.
> 
> Move it outside of the loop so it works correctly for single and
> multi-MSI.
> 
> Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/irq/msi.c |   11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -887,12 +887,11 @@ int __msi_domain_alloc_irqs(struct irq_d
>   			ret = msi_init_virq(domain, virq + i, vflags);
>   			if (ret)
>   				return ret;
> -
> -			if (info->flags & MSI_FLAG_DEV_SYSFS) {
> -				ret = msi_sysfs_populate_desc(dev, desc);
> -				if (ret)
> -					return ret;
> -			}
> +		}
> +		if (info->flags & MSI_FLAG_DEV_SYSFS) {
> +			ret = msi_sysfs_populate_desc(dev, desc);
> +			if (ret)
> +				return ret;
>   		}
>   		allocated++;
>   	}
> 

---
Best Regards
Kunihiko Hayashi
