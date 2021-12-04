Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF8468200
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 03:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384053AbhLDCiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 21:38:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:42835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235609AbhLDCiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Dec 2021 21:38:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237312074"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237312074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 18:34:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="501403727"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.5.226]) ([10.212.5.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 18:34:57 -0800
Message-ID: <119cd071-9cca-d2a7-4198-50c351b729b0@linux.intel.com>
Date:   Fri, 3 Dec 2021 19:34:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20211203181807.GA3009059@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20211203181807.GA3009059@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/3/2021 11:18 AM, Bjorn Helgaas wrote:
> [+cc Lorenzo]
>
> On Tue, Nov 16, 2021 at 03:11:36PM -0700, Nirmal Patel wrote:
>> During VT-d pass-through, the VMD driver occasionally fails to
>> enumerate underlying NVMe devices when repetitive reboots are
>> performed in the guest OS. The issue can be resolved by resetting
>> VMD root ports for proper enumeration and triggering secondary bus
>> reset which will also propagate reset through downstream bridges.
> Hmm.  Does not say what the root cause is, just that it can be "fixed"
> by a reset, but OK.
>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
>> ---
>> ---
>> v4->v5: Fixing small nitpick fix.
>> v3->v4: Using pci_reset_bus function for secondary bus reset instead of
>>         manually triggering secondary bus reset, addressing review
>>         comments of v3.
>> v2->v3: Combining two functions into one, Remove redundant definations
>>         and Formatting fixes
>>
>>  drivers/pci/controller/vmd.c | 37 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index a5987e52700e..a905fce6232f 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -498,6 +498,40 @@ static inline void vmd_acpi_begin(void) { }
>>  static inline void vmd_acpi_end(void) { }
>>  #endif /* CONFIG_ACPI */
>>  
>> +static void vmd_domain_reset(struct vmd_dev *vmd)
>> +{
>> +	u16 bus, max_buses = resource_size(&vmd->resources[0]);
>> +	u8 dev, functions, fn, hdr_type;
>> +	char __iomem *base;
> I don't understand what's going on here.
>
>> +	for (bus = 0; bus < max_buses; bus++) {
>> +		for (dev = 0; dev < 32; dev++) {
>> +			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
>> +						PCI_DEVFN(dev, 0), 0);
>> +
>> +			hdr_type = readb(base + PCI_HEADER_TYPE) &
>> +					 PCI_HEADER_TYPE_MASK;
>> +			functions = (hdr_type & 0x80) ? 8 : 1;
> This look like an open-coded version of pci_hdr_type() for every
> possible device on every possible bus below the VMD, regardless of
> whether that device actually exists.  So most of these reads will
> result in Unsupported Request errors and 0xff data returns, which you
> interpret as a multi-function device.
>
>> +			for (fn = 0; fn < functions; fn++) {
>> +				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
>> +						PCI_DEVFN(dev, fn), 0);
>> +
>> +				hdr_type = readb(base + PCI_HEADER_TYPE) &
>> +						PCI_HEADER_TYPE_MASK;
> So you open-code pci_hdr_type() again, for lots of functions that
> don't exist.
>
>> +				if (hdr_type != PCI_HEADER_TYPE_BRIDGE ||
>> +				    (readw(base + PCI_CLASS_DEVICE) !=
>> +				     PCI_CLASS_BRIDGE_PCI))
>> +					continue;
> This at least will skip the rest for functions that don't exist, since
> hdr_type will be 0x7f (not 0x01, PCI_HEADER_TYPE_BRIDGE).
>
>> +
>> +				memset_io(base + PCI_IO_BASE, 0,
>> +					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> And here you clear the base & limit registers of the IO and MEM
> windows of each bridge, again with basically a hand-written special
> case of pci_write_config_*().
>
> This looks like you're trying to disable the windows.  AFAICT, the
> spec doesn't say what happens to the window base/limit registers after
> reset, but it does say that reset clears the I/O Space Enable and
> Memory Space Enable in the Command Register.  For bridges, that will
> disable the windows.
>
> Writing zero to both base & limit does not disable the windows; it
> just sets them to [io 0x0000-0x0fff], [mem 0x00000000-0x000fffff],
> etc.
>
> So I'm not really convinced that this function is necessary at all,
> given that you do a secondary bus reset on every VMD root port right
> afterwards.

I am trying to clean up bridge devices under each vmd domain and then run
secondary bus reset. Is propagation of hot reset on downstream ports via
secondary bus reset enough between multiple reboot? I am testing if it
solves our issue. I will let you know the results. Please let me know if you
have more suggestions.

Thanks.

>
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>  static void vmd_attach_resources(struct vmd_dev *vmd)
>>  {
>>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
>> @@ -801,6 +835,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  	vmd_acpi_begin();
>>  
>>  	pci_scan_child_bus(vmd->bus);
>> +	vmd_domain_reset(vmd);
>> +	list_for_each_entry(child, &vmd->bus->children, node)
>> +		pci_reset_bus(child->self);
>>  	pci_assign_unassigned_bus_resources(vmd->bus);
>>  
>>  	/*
>> -- 
>> 2.27.0
>>

