Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6385B3D2BFF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGVR6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 13:58:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:65239 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhGVR6n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 13:58:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191989104"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="191989104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:39:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="470757802"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.166.173]) ([10.213.166.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:39:17 -0700
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
References: <20210720223318.GA135757@bjorn-Precision-5520>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <2b3fc9ac-7b6e-82cd-4b0a-67b4aeadd527@linux.intel.com>
Date:   Thu, 22 Jul 2021 11:39:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720223318.GA135757@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/2021 3:33 PM, Bjorn Helgaas wrote:
> On Tue, Jul 20, 2021 at 01:50:08PM -0700, Nirmal Patel wrote:
>> During VT-d passthrough repetitive reboot tests, it was determined that the VMD
>> domain needed to be reset in order to allow downstream devices to reinitialize
>> properly. This is done using a secondary bus reset at each of the VMD root
>> ports and any bridges in the domain.
> I don't understand the "any bridges in the domain" part.  Clearly you
> only reset Intel bridges, and only those on a single "bus".  So can
> there be both VMD root ports and another kind of bridge on the same
> bus?
>
> Rewrap this to fit in 75 columns or so, so it doesn't overflow 80
> column lines when git log indents it by 4.

You are right on resetting only Intel bridges. I think I can reword the message
like "This is done using setting secondary bus reset bit of each of the VMD
root port and will propagate reset through downstream bridges."

>
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
> Already defined in include/uapi/linux/pci_regs.h.

I will make the changes.

>
>> +#define PCI_CLASS_BRIDGE_PCI 0x0604
> Already defined in include/linux/pci_ids.h.  What am I missing?  Seems
> like you should see duplicate definition warnings.

I will make the changes.

>
>> +#define DEVICE_SPACE (8 * 4096)
>> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
>> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))
> Add blank line here.
Sure.
>
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
> Fix comment indentation.
>
> s/many/may/
>
> I don't really understand the comment anyway.  Is the point that
> subdevice config space may not be physically contiguous?  Certainly
> VMD_DEVICE_BASE() computes virtual addresses that are linear.

I will remove this confusing comment for the sack of simplicity.

>
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
> It's a shame we can't do this with pci_reset_secondary_bus().  Makes
> me wonder if there's an opportunity for special pci_ops.
>
>> +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
>> +		readw(base + PCI_BRIDGE_CONTROL);
>> +
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

