Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FC48F0DD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 21:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiANUTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 15:19:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45518 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiANUTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 15:19:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9654AB82A28
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 20:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229ACC36AE5;
        Fri, 14 Jan 2022 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642191577;
        bh=x+WgLRk4SMV2nI2+xa6bew44FqW62hnnN2DNIkxHMBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oFO5pvoEa5tlNJxDMXf0AJA9cvcqYzmjWr5F0z0WCXVAURAMj3FpzfErLdwdMFsj7
         1gWPQuWlBHJFAs2rPa3zfVVsheyFLrBJrUuo1XAGFoKe+royx32xx9ydXb1/UuU2RG
         p+p7o6U2Aagq+Z/IlUXt2+/kuupCLZp3BWI6c9E675WVNX0vt0T0iQIi8URAdnAYhG
         SAlM/C5NZTwsl1+7IHVAthtQZMrtBTqDabCNk9CzDWLarTRauwSKP/WCrlUspN/rtZ
         WgJEg/Ya8RF7tuCC766C47YPz/tt1hCcuUQ20x948CbWIqPoLpVi7+hypTsWuHnta8
         5AmsU7q7bFN+g==
Date:   Fri, 14 Jan 2022 14:19:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Don't disable AER reporting in
 get_port_device_capability()
Message-ID: <20220114201935.GA572866@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113113604.1652425-1-sr@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 13, 2022 at 12:36:04PM +0100, Stefan Roese wrote:
> Testing has shown, that AER reporting is currently disabled in the
> DevCtl registers of all non Root Port PCIe devices on systems using
> pcie_ports_native || host->native_aer. Practically disabling AER
> completely in such systems. 

I want to be a little pedantic here because the error landscape is
complicated, and I think it will help if we correspond closely to the
spec language.

Device Control controls Error Reporting (whether the device sends
ERR_* messages), and IIUC this is relevant even without AER (I'm
looking at PCIe r6.0, sec 6.2.5, which refers to CERE, NERE, FERE
outside the AER box).

Can you update this with analysis of the code as opposed to what we
observe in testing?  Hopefully the analysis corresponds to the
observations :)  Here's my take; probably too much for a commit log,
but maybe it can be distilled:

  pcie_portdrv_probe
    pcie_port_device_register
      get_port_device_capability
        pci_disable_pcie_error_reporting
          clear CERE NFERE FERE URRE               # <-- disable for RP USP DSP
      pcie_device_init
        device_register                            # new AER service device
          aer_probe
            aer_enable_rootport                    # RP only
              set_downstream_devices_error_reporting
                set_device_error_reporting         # self (RP)
                  if (RP || USP || DSP)
                    pci_enable_pcie_error_reporting
                      set CERE NFERE FERE URRE     # <-- enable for RP
                pci_walk_bus
                  set_device_error_reporting
                    if (RP || USP || DSP)
                      pci_enable_pcie_error_reporting
                        set CERE NFERE FERE URRE   # <-- enable for USP DSP

In a typical Root Port -> Endpoint hierarchy, the above:

  - Disables Error Reporting for the Root Port,

  - Enables Error Reporting for the Root Port,

  - Does NOT enable Error Reporting for the Endpoint because it is not
    a Root Port or Switch Port.

In a deeper Root Port -> Upstream Switch Port -> Downstream Switch
Port -> Endpoint hierarchy:

  - Disables Error Reporting for the Root Port,

  - Enables Error Reporting for the Root Port,

  - Enables Error Reporting for both Switch Ports,

  - Does NOT enable Error Reporting for the Endpoint because it is not
    a Root Port or Switch Port,

  - Disables Error Reporting for the Switch Ports when
    pcie_portdrv_probe() claims them.  AER does not re-enable it
    because these are not Root Ports.

I think the bottom line is that the current code leaves reporting
enabled on Root Ports and disabled everywhere else.  It's enabled
temporarily on Switch Ports, but disabled again when
pcie_portdrv_probe() claims them.

The core doesn't do anything with Endpoints, but a few drivers enable
reporting themselves.  This probably only works when their devices are
directly connected to a Root Port.

> This is due to the fact that with commit 2bd50dd800b5 ("PCI: PCIe:
> Disable PCIe port services during port initialization"), a call to
> pci_disable_pcie_error_reporting() was added *after* the PCIe AER
> setup was completed for the PCIe device tree.

IIUC, 2bd50dd800b5 is really only an issue for Switch Ports, because
it makes portdrv disable reporting for them, but AER doesn't re-enable
it.

> This patch now removes this call to pci_disable_pcie_error_reporting()
> from get_port_device_capability(), leaving the already enabled AER
> configuration intact. With this change, I'm able to fully use the
> Kernel AER infrastructure on a ZynqMP system which has a PCIe switch
> connected to the host CPU PCIe Root Port.

This patch doesn't affect the Endpoint, and I assume you also need to
enable reporting there?

> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 4dab74ff4368..48f5e67709f7 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -244,15 +244,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  
>  #ifdef CONFIG_PCIEAER
>  	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	    (pcie_ports_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_AER;
> -
> -		/*
> -		 * Disable AER on this port in case it's been enabled by the
> -		 * BIOS (the AER service driver will enable it when necessary).
> -		 */
> -		pci_disable_pcie_error_reporting(dev);
> -	}
>  #endif
>  
>  	/* Root Ports and Root Complex Event Collectors may generate PMEs */
> -- 
> 2.34.1
> 
