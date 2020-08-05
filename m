Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1D23CF73
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHETUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 15:20:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbgHERrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 13:47:31 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4B69D483CC3B2D2041B1;
        Wed,  5 Aug 2020 18:47:01 +0100 (IST)
Received: from localhost (10.52.120.30) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 5 Aug 2020
 18:47:00 +0100
Date:   Wed, 5 Aug 2020 18:45:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
Message-ID: <20200805184535.00005711@Huawei.com>
In-Reply-To: <20200804194052.193272-3-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
        <20200804194052.193272-3-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.30]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Aug 2020 12:40:45 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

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
One trivial thing inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/pci/pcie/portdrv_core.c | 8 ++++----
>  drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..5d4a400094fc 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -234,11 +234,11 @@ static int get_port_device_capability(struct pci_dev *dev)
>  #endif
>  
>  	/*
> -	 * Root ports are capable of generating PME too.  Root Complex
> -	 * Event Collectors can also generate PMEs, but we don't handle
> -	 * those yet.
> +	 * Root ports and Root Complex Event Collectors are capable
> +	 * of generating PME too.

I'm not sure what the 'too' refers to.   I'd just drop it and avoid
any possible confusion!

>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    (pcie_ports_native || host->native_pme)) {
>  		services |= PCIE_PORT_SERVICE_PME;
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3a3ce40ae1ab..4d880679b9b1 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	if (!pci_is_pcie(dev) ||
>  	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
>  	status = pcie_port_device_register(dev);
> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
> +	/* handle any Root Complex Event Collector */
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>  	{ },
>  };
>  


