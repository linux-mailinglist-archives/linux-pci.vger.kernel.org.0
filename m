Return-Path: <linux-pci+bounces-5300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B732488F35E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AC41C27095
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D014D291;
	Wed, 27 Mar 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzKQFztx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B8136E1C;
	Wed, 27 Mar 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583864; cv=none; b=omI4vnIRxWjHmKOl1g+zB8MZGOHb4gy5AHLQJ9i9y7zRg4iq6paXEX6KcW7QBwZGup+7dQI+JaX2mFjsAwfqKol45JA6ID8K+al01jVxZaOQAH8qt9ADlpYOF41SyAAbWC0nJpRZvIzfgUtlyHVd0FbDDa0EboZM/ZvkljNLjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583864; c=relaxed/simple;
	bh=2rho0S5AnRWhqTPiiYVVwdBxLagXYptAcGcS1Ptq9GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skd01TQip4RxtN+KDqfUgF7bfEMKPV0uvodG2Lw3KRuXiyBspurxHRBaqaXz+0iJqLYHkA3wh4hJBeZutsYNl1um69nnMA8mPBCRFDtBQEwlz9OoQslDkRkGbenaWiupTnyg88xp5es0mtAoRuy/yoRRsgT9ZEKzEY9l4MvLxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzKQFztx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711583863; x=1743119863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2rho0S5AnRWhqTPiiYVVwdBxLagXYptAcGcS1Ptq9GA=;
  b=FzKQFztxcu6YkFavSup2NNgmW44PA9OmnL2u87k2jwO88V3evzgpf8dk
   D31PxGb8X+7gBswfXOU7g3HvoJHoOiIBaxKWavOXr6mha0o7cWiwiFEKS
   dG0W/W6bRo39CaWYSkNzmzpe5S6kHAMSVvaV7V0WzfGqImlqMQAWP67GT
   SHxIEI4iLPtjbp8nDTc+YSUQjZqrjErLJ4V58DPK5TH9eRq0ky/BE9+2/
   5+GrQv1UVB2C6qUnu/BEkcaUoSqMNaQrVSPewwVRVHISioTlPK/uF3TI+
   ylnkSMDlmPrIet6JNQlS4BggjiZvnbCr1LxfF/O8DeRlgw4AwVu53KytH
   w==;
X-CSE-ConnectionGUID: AI8c9Uc1SdmCIXD/p39gPg==
X-CSE-MsgGUID: hVnPgtemTvmpgwrTyxKD4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17446879"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17446879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16472961"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:57:41 -0700
Message-ID: <201384aa-a7a3-415a-9159-a615e8b3cc53@intel.com>
Date: Wed, 27 Mar 2024 16:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de
References: <20240327212629.GA1533990@bhelgaas>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240327212629.GA1533990@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/24 2:26 PM, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2024 at 04:58:01PM -0700, Dave Jiang wrote:
>> Per CXL spec r3.1 8.1.5.2, secondary bus reset is masked unless the
>> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
>> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
>> the CXL Port Control Extensions register by returning -ENOTTY.
> 
> s/secondary bus reset/Secondary Bus Reset (SBR)/
> to show that this is defined by PCIe spec and introduce the
> initialism.

ok will fix
> 
>> With the current behavior, the bus_reset would appear to have executed
>> successfully, however the operation is actually masked if the "Unmask
>> SBR" bit is set with the default value. The intention is to inform the
>> user that SBR for the CXL device is masked and will not go through.
> 
> The default value of Unmask SBR isn't really relevant here.

Changing to:
    When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
    appear to have executed successfully. However the operation is actually
    masked. The intention is to inform the user that SBR for the CXL device
    is masked and will not go through.

> 
>> The expectation is that if a user overrides the "Unmask SBR" via a
>> user tool such as setpci then they can trigger a bus reset successfully.
> 
> ... if a user *sets* Unmask SBR ...
> to be more specific about what value is required.
> 

    If a user overrides the "Unmask SBR" via a user tool such as setpci and
    sets the value to 1, then the bus reset will execute successfully.


>> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Rename is_cxl_device() to pci_is_cxl(). (Lukas)
>> - Inverse xmas tree var declaration for is_cxl_port_sbr_masked(). (Lukas)
>> - Return -ENOTTY on error of reset method. (Lukas)
>> - Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
>> - Additional explanation in commit log on behavior. (Lukas)
>> ---
>>  drivers/cxl/cxlpci.h          |  2 --
>>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/pci_regs.h |  7 ++++++
>>  3 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 93992a1c8eec..55be4dccbed0 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -13,10 +13,8 @@
>>   * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>>   */
>>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>> -#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
>>  
>>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>>  #define   CXL_DVSEC_CAP_OFFSET		0xA
>>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e5f243dd4288..259e5d6538bb 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>>  }
>>  
>> +static bool pci_is_cxl(struct pci_dev *dev)
>> +{
>> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
>> +					 CXL_DVSEC_PCIE_DEVICE);
>> +}
>> +
>> +static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
> 
> s/is_cxl_port_sbr_masked/cxl_sbr_masked/ or similar

will update

> 
>> +{
>> +	int dvsec;
> 
> u16
> 

ok

>> +	u16 reg;
>> +	int rc;
>> +
>> +	/*
>> +	 * No DVSEC found, must not be CXL port.
>> +	 */
>> +	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_PORT);
>> +	if (!dvsec)
>> +		return false;
>> +
>> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CONTROL, &reg);
>> +	if (rc)
>> +		return true;
>> +
>> +	/*
>> +	 * CXL spec r3.1 8.1.5.2
>> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
>> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
>> +	 * Control gets set to 1.
>> +	 */
>> +	if (reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>  {
>> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>>  	int rc;
>>  
>> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
>> +	if (pci_is_cxl(dev) && bridge && is_cxl_port_sbr_masked(bridge)) {
> 
> This sounds like solely a property of the bridge, so why do we care
> what "dev" is?  I assume SBR is asserted in the standard PCIe way, and
> the only question is whether the bridge itself masks it.  Would this
> be enough?
> 
>   if (bridge && is_cxl_port_sbr_masked(bridge))

Yes that should work. I'll drop pci_is_cxl() and related bits

> 
>> +		if (probe)
>> +			return 0;
>> +
>> +		return -ENOTTY;
>> +	}
>> +
>>  	rc = pci_dev_reset_slot_function(dev, probe);
>>  	if (rc != -ENOTTY)
>>  		return rc;
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a39193213ff2..5f2c66987299 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1148,4 +1148,11 @@
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>>  
>> +/* Compute Express Link (CXL) */
>> +#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98
> 
> I see that you're just moving this #define from drivers/cxl/cxlpci.h,
> but I'm scratching my head a bit.  As used here, this is to match the
> DVSEC Vendor ID (PCIe r6.0, sec 7.9.6.2).
> 
> IIUC, this should be just a PCI SIG-defined "Vendor ID", e.g.,
> "PCI_VENDOR_ID_CXL", that doesn't need the "DVSEC" qualifier in the
> name, and would normally be defined in include/linux/pci_ids.h.
> 
> But I don't see CXL in pci_ids.h, and I don't see either "CXL" or the
> value "1e98" in the PCI SIG list at
> https://pcisig.com/membership/member-companies.
> 
I'll create a new patch and move to include/linux/pci_ids.h first for this define and change to PCI_VENDOR_ID_CXL. The value is defined in CXL spec r3.1 sec 8.1.1.

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e467df3..7dfbf6d96b3d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2607,6 +2607,8 @@
 
 #define PCI_VENDOR_ID_ALIBABA          0x1ded
 
+#define PCI_VENDOR_ID_CXL              0x1e98
+
 #define PCI_VENDOR_ID_TEHUTI           0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009      0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010      0x3010


>> +#define CXL_DVSEC_PCIE_DEVICE				0
> 
> I think this is the "DVSEC ID" (PCIe r6.0, sec 7.9.6.3), right?  And
> the "0" value comes from CXL r3.1, sec 8.1.3?

I'll leave this define alone for now since it's not needed anymore with dropping the CXL device check.
> 
> Sec 8.1.3 says "Software may use the presence of this DVSEC to
> differentiate between a CXL device and a PCIe device. As such, a
> standard PCIe device must not expose this DVSEC."
> 
> I think the "PCIE" in the name here may end up being confusing since
> the presence of this DVSEC means the device is a CXL device, *not* a
> standard PCIe device.
> 
>> +#define CXL_DVSEC_PCIE_PORT				3
> 
> And "3" comes from CXL r3.1, sec 8.1.5?
> 
> Same here; I'm not sure "PCIE" should be in the name, or maybe it
> should be at a different place, e.g., "PCI_DVSEC_CXL_PORT" or
> something, since this DVSEC controls CXL-specific things.
> 
> I kind of think a "PCI_DVSEC_" prefix might be appropriate since
> PCI is where the DVSEC concept is defined, and then the more specific
> details can follow

Will rename to PCI_DVSEC_CXL_PORT*

> 
>> +#define CXL_DVSEC_PORT_CONTROL				0x0c
>> +#define  CXL_DVSEC_PORT_CONTROL_UNMASK_SBR		0x00000001
> 
> s/CONTROL/CTL/ (or CTRL, though CTL is more common in this file)

ok

> 
> Bjorn
> 

