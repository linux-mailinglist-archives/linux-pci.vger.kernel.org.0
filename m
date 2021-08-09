Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37F3E4318
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHIJrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 05:47:55 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:45819 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhHIJrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 05:47:55 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2F86F2800B3D2;
        Mon,  9 Aug 2021 11:47:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1733A260B31; Mon,  9 Aug 2021 11:47:31 +0200 (CEST)
Date:   Mon, 9 Aug 2021 11:47:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
Message-ID: <20210809094731.GA16595@wunner.de>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809042414.107430-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Mika]

On Mon, Aug 09, 2021 at 12:24:12PM +0800, Kai-Heng Feng wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873

The last comment on this bugzilla says "BIOS will fix this."
and the status is RESOLVED WILL_NOT_FIX.

Why is the patch still necessary?


> Some platforms cannot detect ethernet hotplug once its upstream port is
> runtime suspended because PME isn't enabled in _OSC.

If PME is not handled natively, why does the NIC runtime suspend?
Shouldn't this be fixed in the NIC driver by keeping the device
runtime active if PME cannot be used?


> Disallow port runtime suspend when any child device requires wakeup, so
> pci_pme_list_scan() can still read the PME status from the devices
> behind the port.

pci_pme_list_scan() is for broken devices which fail to signal PME.
Is this NIC really among them or does PME fail merely because it's not
granted to OSPM?


> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -59,14 +59,30 @@ static int pcie_port_runtime_suspend(struct device *dev)
>  	return pcie_port_device_runtime_suspend(dev);
>  }
>  
> +static int pcie_port_wakeup_check(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev)
> +		return 0;
> +
> +	return pdev->wakeup_prepared;
> +}
> +
>  static int pcie_port_runtime_idle(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pcie_port_find_device(pdev, PCIE_PORT_SERVICE_PME) &&
> +	    device_for_each_child(dev, NULL, pcie_port_wakeup_check))
> +		return -EBUSY;
> +
>  	/*
>  	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
>  	 * should be good to go to D3.  Everything else, including moving
>  	 * the port to D3, is handled by the PCI core.
>  	 */
> -	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> +	return pdev->bridge_d3 ? 0 : -EBUSY;

If an additional check is necessary for this issue, it should be
integrated into pci_dev_check_d3cold() instead of pcie_port_runtime_idle().

Thanks,

Lukas
