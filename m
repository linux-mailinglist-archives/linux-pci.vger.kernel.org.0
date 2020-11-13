Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203E92B1649
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKMHVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 02:21:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:28234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKMHVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 02:21:06 -0500
IronPort-SDR: w02Uf+WBKzmOeOm1Q0rEteUk2bu1wX3mq8OO3dRepPfmDnw2V2gsKk+Sk9xoi599di8hBucqsF
 2VTT7ZkkWeLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234597292"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="234597292"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:21:01 -0800
IronPort-SDR: EONXJF7YvBQvv6j5Nm8hLVoWEA4SJGRtIy3wvSNf/su8bmK+TZUrddVSFriM57SurvPJggLmbO
 nBpzcdy8a2xQ==
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="542568340"
Received: from zhangn1-mobl2.ccr.corp.intel.com (HELO [10.254.209.85]) ([10.254.209.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:20:57 -0800
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
Message-ID: <f507c2cf-f628-3b79-6c36-8ad8a10bb69c@linux.intel.com>
Date:   Fri, 13 Nov 2020 15:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 2020/11/13 3:15, Thomas Gleixner wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
> 
> Cure that by inheriting the irq domain from the physical function
> device.
> 
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.
> 
> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>   	dmar_iommu_notify_scope_dev(info);
>   }
>   
> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
> +{
> +	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
> +}
> +
>   static int dmar_pci_bus_notifier(struct notifier_block *nb,
>   				 unsigned long action, void *data)
>   {
> @@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct
>   	/* Only care about add/remove events for physical functions.
>   	 * For VFs we actually do the lookup based on the corresponding
>   	 * PF in device_to_iommu() anyway. */
> -	if (pdev->is_virtfn)
> +	if (pdev->is_virtfn) {
> +		/*
> +		 * Note: This is a horrible hack and needs to be cleaned
> +		 * up by assigning the domain to the bus, but that's too
> +		 * big of a change for post rc3.
> +		 *
> +		 * Ensure that the VF device inherits the irq domain of the
> +		 * PF device:
> +		 */
> +		if (action == BUS_NOTIFY_ADD_DEVICE)
> +			vf_inherit_msi_domain(pdev);
>   		return NOTIFY_DONE;
> +	}
> +
>   	if (action != BUS_NOTIFY_ADD_DEVICE &&
>   	    action != BUS_NOTIFY_REMOVED_DEVICE)
>   		return NOTIFY_DONE;

We also encountered this problem in internal testing. This patch can
solve the problem.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
