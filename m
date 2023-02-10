Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9E692B9B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 00:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBJXqu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 18:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBJXqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 18:46:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577BF125AC;
        Fri, 10 Feb 2023 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676072801; x=1707608801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7FpgIac8FzbCShLFwaqYK1OwqN3FNoWhI2Ig6hNiFsE=;
  b=kXORbJvgZXtkerQePY2YwWM1r0MjUcQme1Mlehm9id/n/dw63bG2cBha
   Y9aKBtlimJUdNfXVtRWIXykBDuso9h2uYp4ixx1ATQ6iONHxnJIMxL9dk
   dFFtTJwaWsRkcJ3Ko2ro2OwaM+nkJ28pqjsOIhPoVvfV+QAWnKWPxBKXy
   +gsnmaYg/5cyN9yOLk03Wct7zt8l6/DUHhkTNFZjO/We7pKTW+gyz+Daf
   LeEc6zG4CVMd/4PM69cv+ux5YIumhu/2O70R1tcbjgXHMSY4bb6wMo6yn
   zoT+50qb+dr2C6QDeI5D4jUBqRHHjls7wuim363IIn7gTLYerOUNFeefS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="318576355"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="318576355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:46:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700633859"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700633859"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.190.133]) ([10.213.190.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:46:16 -0800
Message-ID: <c5a3eb31-ebeb-2a8c-e504-4ea52e720844@intel.com>
Date:   Fri, 10 Feb 2023 16:46:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com, bhelgaas@google.com,
        Jonathan.Cameron@Huawei.com
References: <20230210225223.GA2706583@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230210225223.GA2706583@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/10/23 3:52 PM, Bjorn Helgaas wrote:
> On Fri, Feb 10, 2023 at 10:04:03AM -0700, Dave Jiang wrote:
>> By default the CXL RAS mask registers bits are defaulted to 1's and
>> suppress all error reporting. If the kernel has negotiated ownership
>> of error handling for CXL then unmask the mask registers by writing 0s.
>>
>> PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
>> allows exposure of system enabled PCI error flags for the driver to decide
>> which error bits to toggle. Bjorn suggested that the error enabling should
>> be controlled from the system policy rather than a driver level choice[1].
>>
>> CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
>> unmasking.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af
> 
>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>> +{
>> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +	void __iomem *addr;
>> +	u32 orig_val, val, mask;
>> +
>> +	if (!cxlds->regs.ras)
>> +		return -ENODEV;
>> +
>> +	/* BIOS has CXL error control */
>> +	if (!host_bridge->native_cxl_error)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {
> 
> 1) I don't really want to expose PCI_EXP_AER_FLAGS in linux/pci.h.
> It's basically a convenience part of the AER implementation.
> 
> 2) I think your intent here is to configure the CXL RAS masking based
> on what PCIe error reporting is enabled, but doing it by looking at
> PCI_EXP_AER_FLAGS doesn't seem right.  This expression is a
> compile-time constant that is always true, but we can't rely on
> devices always being configured that way.
> 
> We call pci_aer_init() for every device during enumeration, but we
> only write PCI_EXP_AER_FLAGS if pci_aer_available() and if
> pcie_aer_is_native().  And there are a bunch of drivers that call
> pci_disable_pcie_error_reporting(), which *clears* those flags.  I'm
> not sure those drivers *should* be doing that, but they do today.
> 
> I'm not sure why this needs to be conditional at all, but if it does,
> maybe you want to read PCI_EXP_DEVCTL and base it on that?

Ok I'll read the PCI_EXP_DEVCTL. Looking to only unmask the relevant RAS 
reporting if respective PCIe bits are enabled.

> 
>> +		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
>> +		orig_val = readl(addr);
>> +
>> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> 
> Weird name ("_MASK_MASK"), but I assume there's a good reason ;)

Yes. It's the mask of the error mask register. Is that too much of a 
mouthful? I can take out the second mask.

> 
>> +		if (!cxl_pci_flit_256(pdev))
>> +			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
>> +		val = orig_val & ~mask;
>> +		writel(val, addr);
>> +		dev_dbg(&pdev->dev,
>> +			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
>> +			orig_val, val);
>> +	}
> 
>>   	if (cxlds->regs.ras) {
>> -		pci_enable_pcie_error_reporting(pdev);
>> -		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>> -		if (rc)
>> -			return rc;
>> +		rc = pci_enable_pcie_error_reporting(pdev);
> 
> I see you're just adding a check of return value here, but I'm not
> sure you need to call pci_enable_pcie_error_reporting() in the first
> place.  Isn't the call in the pci_aer_init() path enough?

I guess I'm confused by the kernel documentation:
"
pci_enable_pcie_error_reporting enables the device to send error
messages to root port when an error is detected. Note that devices
don't enable the error reporting by default, so device drivers need
call this function to enable it.
"

Seems to indicate that driver should always call this if it wants AER 
reporting?

> 
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -693,6 +693,7 @@
>>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
>> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
> 
> Please spell out the hex constant.  This is to match the style of the
> surrounding code, and it also gives a hint about the size of the
> register.

Ok will fix
> 
> Bjorn
