Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15204577F2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 21:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKSUwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 15:52:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:54517 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhKSUwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 15:52:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="234729121"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="234729121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:49:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="455919443"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.165]) ([10.78.16.165])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:49:04 -0800
Message-ID: <a8b5f6d3-ff52-1bf6-994e-2aa0421c011a@linux.intel.com>
Date:   Fri, 19 Nov 2021 13:48:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Content-Language: en-US
To:     lorenzo.pieralisi@arm.com, Bjorn Helgaas <helgaas@kernel.org>
References: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
Cc:     jonathan.derrick@linux.dev, linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/16/2021 3:11 PM, Nirmal Patel wrote:
> During VT-d pass-through, the VMD driver occasionally fails to
> enumerate underlying NVMe devices when repetitive reboots are
> performed in the guest OS. The issue can be resolved by resetting
> VMD root ports for proper enumeration and triggering secondary bus
> reset which will also propagate reset through downstream bridges.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> ---
> ---
> v4->v5: Fixing small nitpick fix.
> v3->v4: Using pci_reset_bus function for secondary bus reset instead of
>         manually triggering secondary bus reset, addressing review
>         comments of v3.
> v2->v3: Combining two functions into one, Remove redundant definations
>         and Formatting fixes
>
>  drivers/pci/controller/vmd.c | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..a905fce6232f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -498,6 +498,40 @@ static inline void vmd_acpi_begin(void) { }
>  static inline void vmd_acpi_end(void) { }
>  #endif /* CONFIG_ACPI */
>  
> +static void vmd_domain_reset(struct vmd_dev *vmd)
> +{
> +	u16 bus, max_buses = resource_size(&vmd->resources[0]);
> +	u8 dev, functions, fn, hdr_type;
> +	char __iomem *base;
> +
> +	for (bus = 0; bus < max_buses; bus++) {
> +		for (dev = 0; dev < 32; dev++) {
> +			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, 0), 0);
> +
> +			hdr_type = readb(base + PCI_HEADER_TYPE) &
> +					 PCI_HEADER_TYPE_MASK;
> +
> +			functions = (hdr_type & 0x80) ? 8 : 1;
> +			for (fn = 0; fn < functions; fn++) {
> +				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, fn), 0);
> +
> +				hdr_type = readb(base + PCI_HEADER_TYPE) &
> +						PCI_HEADER_TYPE_MASK;
> +
> +				if (hdr_type != PCI_HEADER_TYPE_BRIDGE ||
> +				    (readw(base + PCI_CLASS_DEVICE) !=
> +				     PCI_CLASS_BRIDGE_PCI))
> +					continue;
> +
> +				memset_io(base + PCI_IO_BASE, 0,
> +					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +			}
> +		}
> +	}
> +}
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -801,6 +835,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> +	vmd_domain_reset(vmd);
> +	list_for_each_entry(child, &vmd->bus->children, node)
> +		pci_reset_bus(child->self);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*

Hi

Gentle ping. Please let me know if you are okay with these changes (with Jon's Reviewed-by). Thanks.

-nirmal

