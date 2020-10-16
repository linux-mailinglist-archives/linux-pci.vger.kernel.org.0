Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C18290A7D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbgJPRTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 13:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390321AbgJPRTe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 13:19:34 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D71520704;
        Fri, 16 Oct 2020 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602868773;
        bh=9kLpyiAYynL4fs7VkW+MjrLNVjELYDZXp4v/TfTQB2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GymZvpishaFRuNxpLri5eyNg1vnMIzZZtcMQGadqRjYDKQs+DBJ1aLYaseEKL1gQO
         hNqmhOskfTjxrfMXWgm33lr9Wd7HotwEJp7g/xSjHEo0FGlxB9IshW0iVLHwophT1o
         38xb4xJ++9sNO0L7GtvbDFXyimmnRV6TxCV8Auw8=
Date:   Fri, 16 Oct 2020 12:19:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v9 09/15] PCI/ERR: Add pci_walk_bridge() to
 pcie_do_recovery()
Message-ID: <20201016171931.GA85196@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016001113.2301761-10-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 05:11:07PM -0700, Sean V Kelley wrote:
> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> Consolidate subordinate bus checks with pci_walk_bus() into
> pci_walk_bridge() for walking below potentially AER affected bridges.
> 
> [bhelgaas: fix kerneldoc]
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-7-seanvk.dev@oregontracks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/err.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 931e75f2549d..8b53aecdb43d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -146,13 +146,30 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +/**
> + * pci_walk_bridge - walk bridges potentially AER affected
> + * @bridge:	bridge which may be a Port
> + * @cb:		callback to be called for each device found
> + * @userdata:	arbitrary pointer to be passed to callback
> + *
> + * If the device provided is a bridge, walk the subordinate bus, including
> + * any bridged devices on buses under this bus.  Call the provided callback
> + * on each device found.
> + */
> +static void pci_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (bridge->subordinate)

Remind me why we add this bridge->subordinate test?  I see that we're
going to need it later, but I think we should add the test in the same
patch that adds the case where "bridge->subordinate == NULL" becomes
possible.

Or else a note in this commit log about what's happening.

AFAICT, this test is literally the only possible functional change in
this patch, so the commit log should mention it.

> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_channel_state_t state,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>  {
>  	int type = pci_pcie_type(dev);
>  	struct pci_dev *bridge;
> -	struct pci_bus *bus;
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  
>  	/*
> @@ -165,23 +182,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
> -	bus = bridge->subordinate;
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> -		pci_walk_bus(bus, report_frozen_detected, &status);
> +		pci_walk_bridge(bridge, report_frozen_detected, &status);
>  		status = reset_subordinates(bridge);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(bridge, "subordinate device reset failed\n");
>  			goto failed;
>  		}
>  	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
> +		pci_walk_bridge(bridge, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(bridge, "broadcast mmio_enabled message\n");
> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> +		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -192,14 +208,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		 */
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(bridge, "broadcast slot_reset message\n");
> -		pci_walk_bus(bus, report_slot_reset, &status);
> +		pci_walk_bridge(bridge, report_slot_reset, &status);
>  	}
>  
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
>  	pci_dbg(bridge, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_bridge(bridge, report_resume, &status);
>  
>  	if (pcie_aer_is_native(bridge))
>  		pcie_clear_device_status(bridge);
> -- 
> 2.28.0
> 
