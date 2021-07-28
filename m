Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F043D9988
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhG1XhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 19:37:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:20729 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhG1XhQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 19:37:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212800162"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212800162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:37:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="581036047"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.43.33]) ([10.212.43.33])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:37:13 -0700
Subject: Re: [PATCH v3] PCI: vmd: Issue secondary bus reset and vmd domain
 window reset
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210728214639.7204-1-nirmal.patel@linux.intel.com>
 <6833bc78-b935-95bf-6cea-03e9f0ca5004@intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <c52ec6e3-9707-f245-3504-95ce8213a27f@linux.intel.com>
Date:   Wed, 28 Jul 2021 16:37:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6833bc78-b935-95bf-6cea-03e9f0ca5004@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/28/2021 4:21 PM, Derrick, Jonathan wrote:
> Hey Nirmal
>
> On 7/28/2021 3:46 PM, Nirmal Patel wrote:
>> In order to properly re-initialize the VMD domain during repetitive driver
>> attachment or reboot tests, ensure that the VMD root ports are
>> re-initialized to a blank state that can be re-enumerated appropriately
>> by the PCI core. This is performed by re-initializing all of the bridge
>> windows to ensure that PCI core enumeration does not detect potentially
>> invalid bridge windows and misinterpret them as firmware-assigned windows,
>> when they simply may be invalid bridge window information from a previous
>> boot.
>>
>> During VT-d passthrough repetitive reboot tests, it was determined that
>> the VMD domain needed to be reset in order to allow downstream devices
>> to reinitialize properly. This is done using setting secondary bus
>> reset bit of each of the VMD root port and will propagate reset through
>> downstream bridges.
> Can we better combine these two paragraphs?
I will try to create better summary.
>
>
>> v2->v3: Combining two functions into one, Remove redundant definations
>>         and Formatting fixes
> Below the dashes please
Ack
>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Not yet :)
Sorry about that. will fix it.
>
>> ---
>>  drivers/pci/controller/vmd.c | 63 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index e3fcdfec58b3..e2c0de700e61 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -15,6 +15,9 @@
>>  #include <linux/srcu.h>
>>  #include <linux/rculist.h>
>>  #include <linux/rcupdate.h>
>> +#include <linux/delay.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/pci_ids.h>
> Do you need to include pci_regs.h and pci_ids.h?
Works without including header files too.
>
>
>>  
>>  #include <asm/irqdomain.h>
>>  #include <asm/device.h>
>> @@ -447,6 +450,64 @@ static struct pci_ops vmd_ops = {
>>  	.write		= vmd_pci_write,
>>  };
>>  
>> +static void vmd_domain_reset(struct vmd_dev *vmd)
>> +{
>> +	char __iomem *base;
>> +	char __iomem *addr;
>> +	u16 ctl;
>> +	int dev_seq;
>> +	int max_devs = 32;
>> +	int max_buses = resource_size(&vmd->resources[0]);
>> +	int bus_seq;
>> +	u8 functions;
>> +	u8 fn_seq;
>> +	u8 hdr_type;
>> +
>> +	for(bus_seq = 0; bus_seq < max_buses; bus_seq++) {
>> +		for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
> No need for max_devs - just open-code '32'
Ack.
>
>
>> +			base = vmd->cfgbar
>> +					+ PCIE_ECAM_OFFSET(bus_seq,
>> +					   PCI_DEVFN(dev_seq, 0), PCI_VENDOR_ID);
> How about:
> 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus_seq,
> 				 PCI_DEVFN(dev_seq, 0), PCI_VENDOR_ID);
Ack.
>
>
>> +
>> +			if (readw(base) != PCI_VENDOR_ID_INTEL)
>> +				continue;
> Now that it's iterating all of the bridges in all of the buses, should
> it be limited to Intel devices?
Ack. I will remove it. It shouldn't have significant performance hit.
>
>
>> +
>> +			hdr_type = readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK;
>> +			if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
>> +				continue;
>> +
>> +			functions = !!(hdr_type & 0x80) ? 8 : 1;
>> +			for (fn_seq = 0; fn_seq < functions; fn_seq++)
>> +			{
>> +				addr = vmd->cfgbar
>> +						+ PCIE_ECAM_OFFSET(0x0,
>> +						   PCI_DEVFN(dev_seq, fn_seq), PCI_VENDOR_ID);
> Can you do the same as above here? Putting PCIE_ECAM_OFFSET on the same
> line as vmd->cfgbar? Also could you change bus from 0x0 to 0?
Yes.
>
>
>> +				if (readw(addr) != PCI_VENDOR_ID_INTEL)
>> +					continue;
> Is this necessary?
Ack.
>
>
>> +
>> +				memset_io((vmd->cfgbar +
>> +				 PCIE_ECAM_OFFSET(0x0,PCI_DEVFN(dev_seq, fn_seq),PCI_IO_BASE)),
> Needs a space after the commas, and please use 0 instead of 0x0.
Ack.
>
>
>> +				 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>> +			}
>> +
>> +			if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
>> +				continue;
>> +
>> +			/* pci_reset_secondary_bus() */
>> +			ctl = readw(base + PCI_BRIDGE_CONTROL);
>> +			ctl |= PCI_BRIDGE_CTL_BUS_RESET;
>> +			writew(ctl, base + PCI_BRIDGE_CONTROL);
>> +			readw(base + PCI_BRIDGE_CONTROL);
>> +			msleep(2);
>> +
>> +			ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>> +			writew(ctl, base + PCI_BRIDGE_CONTROL);
>> +			readw(base + PCI_BRIDGE_CONTROL);
>> +		}
>> +	}
>> +	ssleep(1);
>> +}
>> +
>>  static void vmd_attach_resources(struct vmd_dev *vmd)
>>  {
>>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
>> @@ -747,6 +808,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  	if (vmd->irq_domain)
>>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>>  
>> +	vmd_domain_reset(vmd);
>> +
> I'd remove this blank line
Ack.
>
>>  	pci_scan_child_bus(vmd->bus);
>>  	pci_assign_unassigned_bus_resources(vmd->bus);
>>  
>>

