Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391C694BD5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBMP4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 10:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBMP4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 10:56:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D80617161;
        Mon, 13 Feb 2023 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676303787; x=1707839787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vxeAsNf+mv/ERsbiwUZurdbzKLA8ndvUmODsrDY8naE=;
  b=YlBIUXZodiv9/lfqvfwMYOb9c1rQjd6zQ5RR4giuP0DoKc9uZh3lS0hL
   b5FcfrgzHTB6395Q58qGG8JoMiEpW5xigEp1Fpwl1yuBwFYGzSs79sWj1
   dVU/3u5gPtjOJOGnDYGlG+I+L5eCcPTCo44DsPRao4cHh74tR1cTQ/UAH
   aEXUIDcXXN/1owwyN4E1YPTeAlT+RGeclIH01AqDieqbkG/DQw40qFtT0
   5nP8MSiiFbboKLovn1KFBC9+dUdI2caILwjBB6nlLatzvl3I4vEAMJTj3
   nSt3KlZ5BQMGpOoXdpGi+wmn9/lGBbolVPkhh9jae3yTx7Np3AH7Cgcya
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="318940889"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318940889"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:56:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618684301"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618684301"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.99.85]) ([10.212.99.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:56:25 -0800
Message-ID: <c2e244bd-a94b-8de2-e43c-7ff8a756cbc7@intel.com>
Date:   Mon, 13 Feb 2023 08:56:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com, bhelgaas@google.com,
        Jonathan.Cameron@Huawei.com
References: <20230211001144.GA2716712@bhelgaas>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230211001144.GA2716712@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/10/23 5:11 PM, Bjorn Helgaas wrote:
> On Fri, Feb 10, 2023 at 04:46:15PM -0700, Dave Jiang wrote:
>> On 2/10/23 3:52 PM, Bjorn Helgaas wrote:
>>> On Fri, Feb 10, 2023 at 10:04:03AM -0700, Dave Jiang wrote:
>>>> By default the CXL RAS mask registers bits are defaulted to 1's and
>>>> suppress all error reporting. If the kernel has negotiated ownership
>>>> of error handling for CXL then unmask the mask registers by writing 0s.
>>>>
>>>> PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
>>>> allows exposure of system enabled PCI error flags for the driver to decide
>>>> which error bits to toggle. Bjorn suggested that the error enabling should
>>>> be controlled from the system policy rather than a driver level choice[1].
>>>>
>>>> CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
>>>> unmasking.
>>>>
>>>> [1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af
>>>
>>>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>> +	void __iomem *addr;
>>>> +	u32 orig_val, val, mask;
>>>> +
>>>> +	if (!cxlds->regs.ras)
>>>> +		return -ENODEV;
>>>> +
>>>> +	/* BIOS has CXL error control */
>>>> +	if (!host_bridge->native_cxl_error)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {
>>>
>>> 1) I don't really want to expose PCI_EXP_AER_FLAGS in linux/pci.h.
>>> It's basically a convenience part of the AER implementation.
>>>
>>> 2) I think your intent here is to configure the CXL RAS masking based
>>> on what PCIe error reporting is enabled, but doing it by looking at
>>> PCI_EXP_AER_FLAGS doesn't seem right.  This expression is a
>>> compile-time constant that is always true, but we can't rely on
>>> devices always being configured that way.
>>>
>>> We call pci_aer_init() for every device during enumeration, but we
>>> only write PCI_EXP_AER_FLAGS if pci_aer_available() and if
>>> pcie_aer_is_native().  And there are a bunch of drivers that call
>>> pci_disable_pcie_error_reporting(), which *clears* those flags.  I'm
>>> not sure those drivers *should* be doing that, but they do today.
>>>
>>> I'm not sure why this needs to be conditional at all, but if it does,
>>> maybe you want to read PCI_EXP_DEVCTL and base it on that?
>>
>> Ok I'll read the PCI_EXP_DEVCTL. Looking to only unmask the relevant RAS
>> reporting if respective PCIe bits are enabled.
> 
> That sounds OK to me, but leaves the question of those drivers that
> call pci_disable_pcie_error_reporting() because CXL won't know about
> that.  But maybe that's not a problem, I dunno.

Currently the CXL subsystem covers the type-3 devices so I don't think 
it'll be an issue. type-2 may be an issue but it doesn't go through the 
current driver. Maybe we'll figure out how to deal with that when those 
show device drivers show up.


> 
>>> I see you're just adding a check of return value here, but I'm not
>>> sure you need to call pci_enable_pcie_error_reporting() in the first
>>> place.  Isn't the call in the pci_aer_init() path enough?
>>
>> I guess I'm confused by the kernel documentation:
>> "
>> pci_enable_pcie_error_reporting enables the device to send error
>> messages to root port when an error is detected. Note that devices
>> don't enable the error reporting by default, so device drivers need
>> call this function to enable it.
>> "
>>
>> Seems to indicate that driver should always call this if it wants AER
>> reporting?
> 
> Oh, thanks for pointing that out!  I'll update that doc to match the
> current code, which *does* enable reporting by default:

Ah ok. I shall remove the calling of pci_enable_pcie_error_reporting.

> 
> commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> Author: Stefan Roese <sr@denx.de>
> Date:   Tue Jan 25 08:18:20 2022 +0100
> 
>      PCI/AER: Enable error reporting when AER is native
> 
>      If we have native control of AER, set the following error reporting enable
>      bits:
> 
>        - Correctable Error Reporting Enable
>        - Non-Fatal Error Reporting Enable
>        - Fatal Error Reporting Enable
>        - Unsupported Request Reporting Enable
> 
>      Note that these bits are all in the Device Control register and are not
>      AER-specific.
> 
>      This affects all devices with an AER capability, including hot-added
>      devices.
> 
>      Please note that this change is quite invasive, as error reporting now will
>      be enabled for all available PCIe Endpoints, which was previously not the
>      case.
> 
>      When "pci=noaer" is selected, error reporting stays disabled of course.
