Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A39F391B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 21:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKGUCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 15:02:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:38138 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfKGUCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 15:02:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 12:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="scan'208";a="353896399"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 07 Nov 2019 12:02:12 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 7058C580108;
        Thu,  7 Nov 2019 12:02:12 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     Bjorn Helgaas <helgaas@kernel.org>, Olof Johansson <olof@lixom.net>
Cc:     Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191025202004.GA147688@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <1ade6a9f-9532-c400-9bb0-4e68ed5752ce@linux.intel.com>
Date:   Thu, 7 Nov 2019 11:59:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191025202004.GA147688@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/25/19 1:20 PM, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
>> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
>> the behavior was changed such that native (kernel) handling of DPC
>> got tied to whether the kernel also handled AER. While this is what
>> the standard recommends, there are BIOSes out there that lack the DPC
>> handling since it was never required in the past.
> Some systems do not grant OS control of AER via _OSC.  I guess the
> problem is that on those systems, the OS DPC driver used to work, but
> after eed85ff4c0da7, it does not.  Right?

I need some clarification on this issue. Do you mean in these systems,
firmware expects OS to handle DPC and AER, but it does not let OS know
about it via _OSC ?

>
> We should also update negotiate_os_control() to request control of DPC
> via _OSC.  Kuppuswamy's patch [1] does that but hasn't been merged
> yet.  That will conflict with this, but I can resolve that.
>
> I applied this as below (with the nits Keith noticed) to pci/aer for
> v5.5, thanks!
>
> [1] https://lore.kernel.org/r/b638cbd3e122b4c7a58b949d7224230d2c4b34d4.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com
>
> commit 35a0b2378c19
> Author: Olof Johansson <olof@lixom.net>
> Date:   Wed Oct 23 12:22:05 2019 -0700
>
>      PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control
>      
>      Prior to eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
>      Linux handled DPC events regardless of whether firmware had granted it
>      ownership of AER or DPC, e.g., via _OSC.
>      
>      PCIe r5.0, sec 6.2.10, recommends that the OS link control of DPC to
>      control of AER, so after eed85ff4c0da7, Linux handles DPC events only if it
>      has control of AER.
>      
>      On platforms that do not grant OS control of AER via _OSC, Linux DPC
>      handling worked before eed85ff4c0da7 but not after.
>      
>      To make Linux DPC handling work on those platforms the same way they did
>      before, add a "pcie_ports=dpc-native" kernel parameter that makes Linux
>      handle DPC events regardless of whether it has control of AER.
>      
>      [bhelgaas: commit log, move pcie_ports_dpc_native to drivers/pci/]
>      Link: https://lore.kernel.org/r/20191023192205.97024-1-olof@lixom.net
>      Signed-off-by: Olof Johansson <olof@lixom.net>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..806c89f79be8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3540,6 +3540,8 @@
>   			even if the platform doesn't give the OS permission to
>   			use them.  This may cause conflicts if the platform
>   			also tries to use these services.
> +		dpc-native	Use native PCIe service for DPC only.  May
> +				cause conflicts if firmware uses AER or DPC.
>   		compat	Disable native PCIe services (PME, AER, DPC, PCIe
>   			hotplug).
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index a32ec3487a8d..e06f42f58d3d 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -291,7 +291,7 @@ static int dpc_probe(struct pcie_device *dev)
>   	int status;
>   	u16 ctl, cap;
>   
> -	if (pcie_aer_get_firmware_first(pdev))
> +	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>   		return -ENOTSUPP;
>   
>   	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 944827a8c7d3..1e673619b101 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -25,6 +25,8 @@
>   
>   #define PCIE_PORT_DEVICE_MAXSERVICES   5
>   
> +extern bool pcie_ports_dpc_native;
> +
>   #ifdef CONFIG_PCIEAER
>   int pcie_aer_init(void);
>   #else
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 1b330129089f..5075cb9e850c 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -250,8 +250,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>   		pcie_pme_interrupt_enable(dev, false);
>   	}
>   
> +	/*
> +	 * With dpc-native, allow Linux to use DPC even if it doesn't have
> +	 * permission to use AER.
> +	 */
>   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
> +	    pci_aer_available() &&
> +	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>   		services |= PCIE_PORT_SERVICE_DPC;
>   
>   	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0a87091a0800..160d67c59310 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -29,12 +29,20 @@ bool pcie_ports_disabled;
>    */
>   bool pcie_ports_native;
>   
> +/*
> + * If the user specified "pcie_ports=dpc-native", use the Linux DPC PCIe
> + * service even if the platform hasn't given us permission.
> + */
> +bool pcie_ports_dpc_native;
> +
>   static int __init pcie_port_setup(char *str)
>   {
>   	if (!strncmp(str, "compat", 6))
>   		pcie_ports_disabled = true;
>   	else if (!strncmp(str, "native", 6))
>   		pcie_ports_native = true;
> +	else if (!strncmp(str, "dpc-native", 10))
> +		pcie_ports_dpc_native = true;
>   
>   	return 1;
>   }
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

