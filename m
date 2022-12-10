Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1A648BF2
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLJAxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 19:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJAxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 19:53:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F09764E;
        Fri,  9 Dec 2022 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670633616; x=1702169616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TnfD0mZeAmpMteacT6BU2lU8PJ8wEOvUACMJDMCbvLU=;
  b=Nw1ViKztQzGLZwlBg+YKIZwWaQeK3D8s07fimCl4UJqaKcxCdCz3MfIt
   4DAAXX23lyx6/hyRdK7prInqXIlhqJpF2j26Ocz7Mu8MTC82SEuNTn2FQ
   U7hpgDzaMURZt9EGu25D6UFX7l1nYeFt7zlObJWc75bEjH/MNAddBkJfD
   pvsHC6BQcYAii1sLMN2qwIX5cwSl3/iROuyG+IuJ3Sw4k5EzpsBWoWBCb
   5hxN3s8s9NCV+vUHVF5TsE88zpb/WgQS1CNJkeIxa3hLRTueoCwZKOMg4
   1vlupKUVdqwbmonDX8Zc7vLqb/lwAb7yc+1sKSajSfvkXVig9gmx52RAf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403833308"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403833308"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:53:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="597895810"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="597895810"
Received: from rrode-mobl1.amr.corp.intel.com (HELO [10.251.24.37]) ([10.251.24.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:53:35 -0800
Message-ID: <240a1988-4d4a-87dd-8d4f-f9e198660175@linux.intel.com>
Date:   Fri, 9 Dec 2022 16:53:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221210002922.1749403-1-helgaas@kernel.org>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/9/22 4:29 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously portdrv allowed the AER service for any device with an AER
> capability (assuming Linux had control of AER) even though the AER service
> driver only attaches to Root Port and RCECs.
> 
> Because get_port_device_capability() included AER for non-RP, non-RCEC
> devices, we tried to initialize the AER IRQ even though these devices
> don't generate AER interrupts.
> 
> Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
> GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
> failed, and portdrv failed to claim the switch port at all.  The GPU itself
> could be suspended, but the switch could not be put in a low-power state
> because it had no driver.
> 
> Don't allow the AER service on non-Root Port, non-Root Complex Event
> Collector devices.  This means we won't enable Bus Mastering if the device
> doesn't require MSI, the AER service will not appear in sysfs, and the AER
> service driver will not bind to the device.
> 
> Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
> Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> This is a v3 based on Mika's patch at
> https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
> 
> I wouldn't normally kibbitz like this, but I'm hoping to squeeze this into
> the v6.2 merge window.
> 
> Changes from v2:
> 
>   * Test the device type in get_port_device_capability() instead of
>     pcie_init_service_irqs().  The benefits are to keep the device type
>     checking together (this is similar to the PME test), avoid enabling Bus
>     Mastering unnecessarily, avoid exposing the portdrv AER service in
>     sysfs, and preventing the AER service driver from binding to devices it
>     doesn't need to.
> 
>  drivers/pci/pcie/portdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a6c4225505d5..8b16e96ec15c 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +	    dev->aer_cap && pci_aer_available() &&
>  	    (pcie_ports_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
