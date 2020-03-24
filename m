Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B785191DBE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 00:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCXXtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 19:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgCXXtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:47 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688B020771;
        Tue, 24 Mar 2020 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093786;
        bh=vpN9VZ3/XqMMlM29y3ksAh6NJ5OS375WskdTFbdbfKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=03TcxpuWLlgAm5WWVV0XMINrlghzoU7/EZbpHYbBn90HrEVzboRSYClTlJ6sEOnmv
         qcE5pEzfkJbrbE9fUuQtMrY/057+dB0eFB7VE3gwOXs5tVrISU1ei3nyvy5mrv3wgV
         uvDHrPY85jawP5GSNelPoo5GQlCYzBXe5E3kMcyc=
Date:   Tue, 24 Mar 2020 18:49:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug
 case
Message-ID: <20200324234944.GA73526@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 05:26:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If hotplug is supported, during DPC event, hotplug
> driver would remove the affected devices and detach
> the drivers on DLLSC link down event and will
> re-enumerate it once the DPC recovery is handled
> and link comes back online (on DLLSC LINK up event).
> Hence we don't depend on .mmio_enabled or .slot_reset
> callbacks in error recovery handler to restore the
> device.
> 
> But if hotplug is not supported/enabled, then we need
> to let the error recovery handler attempt
> the recovery of the devices using slot reset.
> 
> So if hotplug is not supported, then instead of
> returning PCI_ERS_RESULT_RECOVERED, return
> PCI_ERS_RESULT_NEED_RESET.
> 
> Also modify the way error recovery handler processes
> the recovery value.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 8 ++++++++
>  drivers/pci/pcie/err.c | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e06f42f58d3d..0e356ed0d73f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
>  
>  #include "portdrv.h"
>  #include "../pci.h"
> @@ -144,6 +145,13 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	if (!pcie_wait_for_link(pdev, true))
>  		return PCI_ERS_RESULT_DISCONNECT;
>  
> +	/*
> +	 * If hotplug is not supported/enabled then let the device
> +	 * recover using slot reset.
> +	 */
> +	if (!hotplug_is_native(pdev))
> +		return PCI_ERS_RESULT_NEED_RESET;

I don't understand why hotplug is relevant here.  This path
(dpc_reset_link()) is only used for downstream ports that support DPC.
DPC has already disabled the link, which resets everything below the
port, regardless of whether the port supports hotplug.

I do see that PCI_ERS_RESULT_NEED_RESET seems to promise a lot more
than it actually *does*.  The doc (pci-error-recovery.rst) says
.error_detected() can return PCI_ERS_RESULT_NEED_RESET to *request* a
slot reset.  But if that happens, pcie_do_recovery() doesn't do a
reset at all.  It calls the driver's .slot_reset() method, which tells
the driver "we've reset your device; please re-initialize the
hardware."

I guess this abuses PCI_ERS_RESULT_NEED_RESET by taking advantage of
that implementation deficiency in pcie_do_recovery(): we know the
downstream devices have already been reset via DPC, and returning
PCI_ERS_RESULT_NEED_RESET means we'll call .slot_reset() to tell the
driver about that reset.

I can see how this achieves the desired result, but if/when we fix
pcie_do_recovery() to actually *do* the reset promised by
PCI_ERS_RESULT_NEED_RESET, we will be doing *two* resets: the first
via DPC and a second via whatever slot reset mechanism
pcie_do_recovery() would use.

So I guess the real issue (as you allude to in the commit log) is that
we rely on hotplug to unbind/rebind the driver, and without hotplug we
need to at least tell the driver the device was reset.

I'll try to expand the comment here so it reminds me what's going on
when we have to look at this again :)  Let me know if I'm on the right
track.

>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 1ac57e9e1e71..6e52591a4722 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -178,7 +178,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> -	if (status != PCI_ERS_RESULT_RECOVERED) {
> +	if ((status != PCI_ERS_RESULT_RECOVERED) &&
> +	    (status != PCI_ERS_RESULT_NEED_RESET)) {
>  		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
>  			pci_name(dev));
>  		return PCI_ERS_RESULT_DISCONNECT;
> @@ -206,7 +207,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
>  		status = reset_link(dev, service);
> -		if (status != PCI_ERS_RESULT_RECOVERED)
> +		if (status == PCI_ERS_RESULT_DISCONNECT)
>  			goto failed;
>  	} else {
>  		pci_walk_bus(bus, report_normal_detected, &status);
> -- 
> 2.17.1
> 
