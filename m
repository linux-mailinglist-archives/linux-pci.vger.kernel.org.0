Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C41279224
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgIYUdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 16:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIYUZb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 16:25:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD3623A05;
        Fri, 25 Sep 2020 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601063956;
        bh=+CwG8PMkVFhMLUU31Blay8HXYnthfew4j3ndlVqdqV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OWhggZDhSYl0qMYW0YAQIddY39OAOqqLqFyDjAQ/ZX9r5LIP4fixN2DVMJ7QOyqxo
         BbiWoEJ+dbsG7/ajKgMTnQ+fievEx2WK/XQIsAfvzgiyKkMH+0vUFn/ToNY+k1ImkW
         ksSTroXu6gpfpxq8RExqFYGVpFMen7YdW8qgv6Ww=
Date:   Fri, 25 Sep 2020 14:59:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v6 02/10] PCI/RCEC: Bind RCEC devices to the Root Port
 driver
Message-ID: <20200925195913.GA2455203@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922213859.108826-3-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 02:38:51PM -0700, Sean V Kelley wrote:
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
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 8 ++++----
>  drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..99769c636775 100644
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
> +	 * of generating PME.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&

It seems like this change belongs in patch 09/10, where we change
pme.c so it claims both Root Ports and RCECs.  Does this hunk
accomplish anything before 09/10?

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
> -- 
> 2.28.0
> 
