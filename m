Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12823D2C11
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhGVSDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:03:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:2646 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGVSDa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:03:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="208603651"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="208603651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:44:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="470759505"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.166.173]) ([10.213.166.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:44:04 -0700
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
 <20210720205009.111806-2-nirmal.patel@linux.intel.com>
 <20210721085026.aue5snnynlqw6r46@pali>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <052f4ccc-c4ac-3c50-54f5-e915cfc45057@linux.intel.com>
Date:   Thu, 22 Jul 2021 11:44:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721085026.aue5snnynlqw6r46@pali>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/21/2021 1:50 AM, Pali Rohár wrote:
> On Tuesday 20 July 2021 13:50:08 Nirmal Patel wrote:
>> During VT-d passthrough repetitive reboot tests, it was determined that the VMD
>> domain needed to be reset in order to allow downstream devices to reinitialize
>> properly. This is done using a secondary bus reset at each of the VMD root
>> ports and any bridges in the domain.
>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 46 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index e3fcdfec58b3..6e1c60048774 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/srcu.h>
>>  #include <linux/rculist.h>
>>  #include <linux/rcupdate.h>
>> +#include <linux/delay.h>
>>  
>>  #include <asm/irqdomain.h>
>>  #include <asm/device.h>
>> @@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
>>  	.write		= vmd_pci_write,
>>  };
>>  
>> +#define PCI_HEADER_TYPE_MASK 0x7f
>> +#define PCI_CLASS_BRIDGE_PCI 0x0604
>> +#define DEVICE_SPACE (8 * 4096)
>> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
>> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))
>> +static void vmd_domain_sbr(struct vmd_dev *vmd)
>> +{
>> +	char __iomem *base;
>> +	u16 ctl;
>> +	int dev_seq;
>> +	int max_devs = resource_size(&vmd->resources[0]) * 32;
>> +
>> +	/*
>> +	* Subdevice config space may or many not be mapped linearly using 4k config
>> +	* space.
>> +	*/
>> +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
>> +		base = VMD_DEVICE_BASE(vmd, dev_seq);
>> +		if (readw(base + PCI_VENDOR_ID) != PCI_VENDOR_ID_INTEL)
>> +			continue;
>> +
>> +		if ((readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK) !=
>> +		    PCI_HEADER_TYPE_BRIDGE)
>> +			continue;
>> +
>> +		if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
>> +			continue;
>> +
>> +		/* pci_reset_secondary_bus() */
>> +		ctl = readw(base + PCI_BRIDGE_CONTROL);
>> +		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
>> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
>> +		readw(base + PCI_BRIDGE_CONTROL);
>> +		msleep(2);
>> +
>> +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
>> +		readw(base + PCI_BRIDGE_CONTROL);
> Hello!
>
> You cannot unconditionally call secondary bus reset for arbitrary PCIe
> Bridge. Calling it breaks more PCIe devices behind bridge and
> pci_reset_secondary_bus() already handles it and skip reset if reset is
> causing issues.
>
> I would suggest to use pci_reset_secondary_bus() and extend it
> so you can call it also from your driver.
Secondary bus reset is only performed on Intel VMD root ports prior to the
VMD domain PCI enumerations.
>
>> +	}
>> +	ssleep(1);
>> +}
>> +
>>  static void vmd_attach_resources(struct vmd_dev *vmd)
>>  {
>>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
>> @@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  	if (vmd->irq_domain)
>>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>>  
>> +	vmd_domain_sbr(vmd);
>> +
>>  	pci_scan_child_bus(vmd->bus);
>>  	pci_assign_unassigned_bus_resources(vmd->bus);
>>  
>> -- 
>> 2.27.0
>>

