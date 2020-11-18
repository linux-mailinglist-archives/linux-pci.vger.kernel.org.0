Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3860B2B761D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgKRGDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 01:03:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:59290 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRGDk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 01:03:40 -0500
IronPort-SDR: wrPH4rYZFTqqCeQ4lhnSvMwMiiA1y2OIPrSE0/NW1ZWqqXYpBrVBdM9Ieu3vmEnNZ9+qct/2sH
 0p9wqkpoNT+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171167656"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171167656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:03:39 -0800
IronPort-SDR: vXgZCNKGSdpsUbNcc68T9WSnB3X2WenrhmDZJliQG5THVE6lDfuz40r1JbyvrGcPRot9B569Mb
 mh3osZJodrZA==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544357270"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:03:39 -0800
Subject: Re: [PATCH v11 15/16] PCI/PME: Add pcie_walk_rcec() to RCEC PME
 handling
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-16-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <daef675b-a5b3-0973-e0a7-f4d0ed6dd7c8@linux.intel.com>
Date:   Tue, 17 Nov 2020 22:03:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-16-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> Root Complex Event Collectors (RCEC) appear as peers of Root Ports and also
> have the PME capability. As with AER, there is a need to be able to walk
> the RCiEPs associated with their RCEC for purposes of acting upon them with
> callbacks.
> 
> Add RCEC support through the use of pcie_walk_rcec() to the current PME
> service driver and attach the PME service driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-14-seanvk.dev@oregontracks.org
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/pme.c          | 15 +++++++++++----
>   drivers/pci/pcie/portdrv_core.c |  9 +++------
>   2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 6a32970bb731..87799166c96a 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
>   static void pcie_pme_mark_devices(struct pci_dev *port)
>   {
>   	pcie_pme_can_wakeup(port, NULL);
> -	if (port->subordinate)
> +
> +	if (pci_pcie_type(port) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
> +	else if (port->subordinate)
>   		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
>   }
>   
> @@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev *port)
>    */
>   static int pcie_pme_probe(struct pcie_device *srv)
>   {
> -	struct pci_dev *port;
> +	struct pci_dev *port = srv->port;
>   	struct pcie_pme_service_data *data;
>   	int ret;
>   
> +	/* Limit to Root Ports or Root Complex Event Collectors */
> +	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> +	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
may be you can save the value pci_pcie_type(port)?
> +		return -ENODEV;
> +
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> @@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
>   	data->srv = srv;
>   	set_service_data(srv, data);
>   
> -	port = srv->port;
>   	pcie_pme_interrupt_enable(port, false);
>   	pcie_clear_root_pme_status(port);
>   
> @@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
>   
>   static struct pcie_port_service_driver pcie_pme_driver = {
>   	.name		= "pcie_pme",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,
>   	.service	= PCIE_PORT_SERVICE_PME,
>   
>   	.probe		= pcie_pme_probe,
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..e1fed6649c41 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -233,12 +233,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	}
>   #endif
>   
> -	/*
> -	 * Root ports are capable of generating PME too.  Root Complex
> -	 * Event Collectors can also generate PMEs, but we don't handle
> -	 * those yet.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	/* Root Ports and Root Complex Event Collectors may generate PMEs */
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>   	    (pcie_ports_native || host->native_pme)) {
>   		services |= PCIE_PORT_SERVICE_PME;
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
