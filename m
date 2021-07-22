Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F553D2C1A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 20:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGVSGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:06:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:45745 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGVSGd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:06:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="233540775"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="233540775"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:47:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="470760303"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.166.173]) ([10.213.166.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:47:07 -0700
Subject: Re: [PATCH v2 2/2] PCI: vmd: Issue vmd domain window reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
References: <20210720224236.GA136601@bjorn-Precision-5520>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <46f1b33c-ba82-a0df-cb66-01df04be52cb@linux.intel.com>
Date:   Thu, 22 Jul 2021 11:47:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720224236.GA136601@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/2021 3:42 PM, Bjorn Helgaas wrote:
> On Tue, Jul 20, 2021 at 01:50:09PM -0700, Nirmal Patel wrote:
>> In order to properly re-initialize the VMD domain during repetitive driver
>> attachment or reboot tests, ensure that the VMD root ports are re-initialized
>> to a blank state that can be re-enumerated appropriately by the PCI core.
>> This is performed by re-initializing all of the bridge windows to ensure
>> that PCI core enumeration does not detect potentially invalid bridge windows
>> and misinterpret them as firmware-assigned windows, when they simply may be
>> invalid bridge window information from a previous boot.
> Rewrap commit log to fit in 75 columns.  No problem about v2 vs v1.
I will take care of it.
>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 6e1c60048774..e52bdb95218e 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -651,6 +651,39 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>>  	return 0;
>>  }
>>  
>> +
> Remove spurious blank line here.
Sure.
>
>> +static void vmd_domain_reset_windows(struct vmd_dev *vmd)
>> +{
>> +	u8 hdr_type;
>> +	char __iomem *addr;
>> +	int dev_seq;
>> +	u8 functions;
>> +	u8 fn_seq;
>> +	int max_devs = resource_size(&vmd->resources[0]) * 32;
>> +
>> +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
>> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_VENDOR_ID;
>> +		if (readw(addr) != PCI_VENDOR_ID_INTEL)
>> +			continue;
>> +
>> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_HEADER_TYPE;
>> +		hdr_type = readb(addr) & PCI_HEADER_TYPE_MASK;
>> +		if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
>> +			continue;
>> +
>> +		functions = !!(hdr_type & 0x80) ? 8 : 1;
>> +		for (fn_seq = 0; fn_seq < functions; fn_seq++)
>> +		{
> Put "{" on previous line.
>
> Looks quite parallel to vmd_domain_sbr(), except that here we iterate
> through functions as well.  Why does vmd_domain_sbr() not need to
> iterate through functions?
I am not sure if there is VMD hardware with non zero functions.
>
>> +			addr = VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_VENDOR_ID;
>> +			if (readw(addr) != PCI_VENDOR_ID_INTEL)
>> +				continue;
>> +
>> +			memset_io((VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_IO_BASE),
>> +			 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> Make the lines above fit in 80 columns.
Sure.
>
>> +		}
>> +	}
>> +}
>> +
>>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  {
>>  	struct pci_sysdata *sd = &vmd->sysdata;
>> @@ -741,6 +774,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  		.parent = res,
>>  	};
>>  
>> +	vmd_domain_reset_windows(vmd);
>> +
>>  	sd->vmd_dev = vmd->dev;
>>  	sd->domain = vmd_find_free_domain();
>>  	if (sd->domain < 0)
>> -- 
>> 2.27.0
>>

