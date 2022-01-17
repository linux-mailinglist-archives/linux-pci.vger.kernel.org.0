Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD304904B3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiAQJVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 04:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiAQJVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 04:21:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC749C061574
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 01:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03E64B80E65
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 09:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500DDC36AE7;
        Mon, 17 Jan 2022 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642411302;
        bh=0w8WQ5GF2Svqv+sG9cQc6zr4N6/xOftE3VTqEnBLcEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMjqxvhOvOz6h9qzt76PAispWKvsmMJHOLKNqdB2OjokFyHGqNCmEuYFOSMRywTJc
         xNyjGGGL3Be+DfI+JVF+H9UqbM0I8dU5qRoucicjURT9TTgHaHmWmYaQ0r7JtYT+d6
         /Afli0kKyR8In0x6AS0jLN55JsaybMw8bpM8SX2vjgTSagfKqNeKycX875Rr0+MFgf
         Llu8LM69NPVsfKF21fpokVo67j3+jvKtjESIhoYP8Ul1z+pt+AmruSlllbKtHZWojD
         NBqI0ceL3BowuqiYjR93d27OtBQsoH7oUw1eJ7C4K445kIe/jzGcnGadl3UJ8PvNbg
         yjGioAhUoA/gQ==
Received: by pali.im (Postfix)
        id 63FAB871; Mon, 17 Jan 2022 10:21:39 +0100 (CET)
Date:   Mon, 17 Jan 2022 10:21:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Don't disable AER reporting in
 get_port_device_capability()
Message-ID: <20220117092139.kjjpnkxisb43euet@pali>
References: <20220117080348.2757180-1-sr@denx.de>
 <20220117080348.2757180-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117080348.2757180-2-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 17 January 2022 09:03:47 Stefan Roese wrote:
> Testing has shown, that AER reporting is currently disabled in the
> DevCtl registers of all non Root Port PCIe devices on systems using
> pcie_ports_native || host->native_aer. Practically disabling AER
> completely in such systems. This is due to the fact that with commit
> 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port
> initialization"), a call to pci_disable_pcie_error_reporting() was
> added *after* the PCIe AER setup was completed for the PCIe device
> tree.
> 
> Here a longer analysis about the currect status of AER enaling /
> disabling upon bootup provided by Bjorn:
> 
>   pcie_portdrv_probe
>     pcie_port_device_register
>       get_port_device_capability
>         pci_disable_pcie_error_reporting
>           clear CERE NFERE FERE URRE               # <-- disable for RP USP DSP
>       pcie_device_init
>         device_register                            # new AER service device
>           aer_probe
>             aer_enable_rootport                    # RP only
>               set_downstream_devices_error_reporting
>                 set_device_error_reporting         # self (RP)
>                   if (RP || USP || DSP)
>                     pci_enable_pcie_error_reporting
>                       set CERE NFERE FERE URRE     # <-- enable for RP
>                 pci_walk_bus
>                   set_device_error_reporting
>                     if (RP || USP || DSP)
>                       pci_enable_pcie_error_reporting
>                         set CERE NFERE FERE URRE   # <-- enable for USP DSP
> 
> In a typical Root Port -> Endpoint hierarchy, the above:
>   - Disables Error Reporting for the Root Port,
>   - Enables Error Reporting for the Root Port,
>   - Does NOT enable Error Reporting for the Endpoint because it is not
>     a Root Port or Switch Port.
> 
> In a deeper Root Port -> Upstream Switch Port -> Downstream Switch
> Port -> Endpoint hierarchy:
>   - Disables Error Reporting for the Root Port,
>   - Enables Error Reporting for the Root Port,
>   - Enables Error Reporting for both Switch Ports,
>   - Does NOT enable Error Reporting for the Endpoint because it is not
>     a Root Port or Switch Port,
>   - Disables Error Reporting for the Switch Ports when
>     pcie_portdrv_probe() claims them.  AER does not re-enable it
>     because these are not Root Ports.
> 
> This patch now removes this call to pci_disable_pcie_error_reporting()
> from get_port_device_capability(), leaving the already enabled AER
> configuration intact. With this change, AER is enabled in the Root Port
> and the PCIe switch upstream and downstream ports. Only the PCIe
> Endpoints don't have AER enabled yet. A follow-up patch will take
> care of this Endpoint enabling.
> 
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
> - Enhance commit message as suggested by Bjorn
> 
>  drivers/pci/pcie/portdrv_core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index f81c7be4d7d8..27b990cedb4c 100644
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
