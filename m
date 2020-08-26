Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F026253499
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHZQQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 12:16:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:62689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHZQQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Aug 2020 12:16:14 -0400
IronPort-SDR: VdSLH9iIIXmMDUV7APn4CBKhRcL9w9bXoJPZooklM3zZtQpdQFX7TeOQFPOR6SqGkA2rEzuLI5
 k1N1qfbYePAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135874281"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135874281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:16:14 -0700
IronPort-SDR: OIYvC+XQ9djlCtX2sCZbdyEnMHzvhh87wxEjs2vhS/h1aHOXy5VTnF62nvEyJazh3CpsNftCTM
 Td4Dk+5T129g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="444102622"
Received: from yliang6-mobl1.ccr.corp.intel.com (HELO [10.254.84.68]) ([10.254.84.68])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2020 09:16:13 -0700
Subject: Re: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rjw@rjwysocki.net,
        ashok.raj@intel.com, tony.luck@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
 <20200804194052.193272-3-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <fe1e4832-a634-66d8-96dc-4ad980dabd1a@linux.intel.com>
Date:   Wed, 26 Aug 2020 09:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804194052.193272-3-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/4/20 12:40 PM, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors may
> optionally be sent to a corresponding Root Complex Event Collector (RCEC).
> Each RCiEP must be associated with no more than one RCEC. Interface errors
> are reported to the OS by RCECs.
> 
> For an RCEC (technically not a Bridge), error messages "received" from
> associated RCiEPs must be enabled for "transmission" in order to cause a
> System Error via the Root Control register or (when the Advanced Error
> Reporting Capability is present) reporting via the Root Error Command
> register and logging in the Root Error Status register and Error Source
> Identification register.
> 
> Given the commonality with Root Ports and the need to also support AER
> and PME services for RCECs, extend the Root Port driver to support RCEC
> devices through the addition of the RCEC Class ID to the driver
> structure.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
>   drivers/pci/pcie/portdrv_core.c | 8 ++++----
>   drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..5d4a400094fc 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -234,11 +234,11 @@ static int get_port_device_capability(struct pci_dev *dev)
>   #endif
>   
>   	/*
> -	 * Root ports are capable of generating PME too.  Root Complex
> -	 * Event Collectors can also generate PMEs, but we don't handle
> -	 * those yet.
> +	 * Root ports and Root Complex Event Collectors are capable
> +	 * of generating PME too.
>   	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>   	    (pcie_ports_native || host->native_pme)) {
>   		services |= PCIE_PORT_SERVICE_PME;
What about AER service? Don't you need to enable it for RCEC?
>   
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3a3ce40ae1ab..4d880679b9b1 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>   	if (!pci_is_pcie(dev) ||
>   	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>   	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>   		return -ENODEV;
>   
>   	status = pcie_port_device_register(dev);
> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
>   	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>   	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>   	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> +	/* handle any Root Complex Event Collector */
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>   	{ },
>   };
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
