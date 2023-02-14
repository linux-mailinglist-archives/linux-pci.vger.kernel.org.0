Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5E6970A9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBNWWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 17:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNWWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 17:22:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71993AA6;
        Tue, 14 Feb 2023 14:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676413369; x=1707949369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0FUUQxURrA4LLaSGllUrJRqGQsLgzkyGBa3lM4ln+Hk=;
  b=XyVXx8hitMD/GUpNJjFYNkjyYqQK7SRym9/KcyCRgW1X/PCtgq8AyV0O
   Z8mrDQLES5zcnp52RXmKl3euhxfn8Y16Pq5MAfdnOwHilSDjrC6PsZKC0
   KDh67k4EI9Ob1+tWuQk8Abl9cnvkxT3ZEwhFOOMwyfi4VtnoBsPWisDBf
   6co5MK/k49p2cwifkZqWqpdng3hCKDbywnr5f4a0nHPd5D5B7H+iBkGFC
   RW01IEGjS61TIdZ3T/BFfWYnyRvqJBGmx8b3uFU1lL0VOnL5BoLhiNgAQ
   pZR6wWa86G8DWcBcTP0gYitrwfxgf6ijzYuEuVlaI/59Y2vvgi2o/4cky
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311651837"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="311651837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 14:22:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="843336629"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="843336629"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 14:22:42 -0800
Message-ID: <47b05595-141b-3e1a-6674-0c395088d988@intel.com>
Date:   Tue, 14 Feb 2023 15:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the
 CXL device
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
References: <20230208221559.GA2489627@bhelgaas>
 <158ba672-09f1-a202-4fb6-7168496b95c4@intel.com>
 <20230209151040.00006d93@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209151040.00006d93@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/23 8:10 AM, Jonathan Cameron wrote:
> On Wed, 8 Feb 2023 16:56:30 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 2/8/23 3:15 PM, Bjorn Helgaas wrote:
>>> On Tue, Feb 07, 2023 at 01:51:17PM -0700, Dave Jiang wrote:
>>>>
>>>>
>>>> On 2/6/23 3:39 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Feb 06, 2023 at 01:51:10PM -0700, Dave Jiang wrote:
>>>>>> The latency is calculated by dividing the FLIT size over the
>>>>>> bandwidth. Add support to retrieve the FLIT size for the CXL
>>>>>> device and calculate the latency of the downstream link.
>>>    
>>>>> I guess you only care about the latency of a single link, not the
>>>>> entire path?
>>>>
>>>> I am adding each of the link individually together in the next
>>>> patch. Are you suggesting a similar function like
>>>> pcie_bandwidth_available() but for latency for the entire path?
>>>
>>> Only a clarifying question.
>>>    
>>>>>> +static int cxl_get_flit_size(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +	if (cxl_pci_flit_256(pdev))
>>>>>> +		return 256;
>>>>>> +
>>>>>> +	return 66;
>>>>>
>>>>> I don't know about the 66-byte flit format, maybe this part is
>>>>> CXL-specific?
>>>>
>>>> 68-byte flit format. Looks like this is a typo from me.
>>>
>>> This part must be CXL-specific, since I don't think PCIe mentions
>>> 68-byte flits.
>>>    
>>>>>> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
>>>>>> + * mode, otherwise it's 68B flits mode.
>>>>>> + */
>>>>>> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +	u32 lnksta2;
>>>>>> +
>>>>>> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
>>>>>> +	return lnksta2 & BIT(10);
>>>>>
>>>>> Add a #define for the bit.
>>>>
>>>> ok will add.
>>>>   
>>>>>
>>>>> AFAICT, the PCIe spec defines this bit, and it only indicates the link
>>>>> is or will be operating in Flit Mode; it doesn't actually say anything
>>>>> about how large the flits are.  I suppose that's because PCIe only
>>>>> talks about 256B flits, not 66B ones?
>>>>
>>>> Looking at CXL v1.0 rev3.0 6.2.3 "256B Flit Mode", table 6-4, it shows that
>>>> when PCIe Flit Mode is set, then CXL is in 256B flits mode, otherwise, it is
>>>> 68B flits. So an assumption is made here regarding the flit side based on
>>>> the table.
>>>
>>> So reading PCI_EXP_LNKSTA2 and extracting the Flit Mode bit is
>>> PCIe-generic, but the interpretation of "PCIe Flit Mode not enabled
>>> means 68-byte flits" is CXL-specific?
>>>
>>> This sounds wrong, but I don't know quite how.  How would the PCI core
>>> manage links where Flit Mode being cleared really means Flit Mode is
>>> *enabled* but with a different size?  Seems like something could go
>>> wrong there.
>>
>> Looking at the PCIe base spec and the CXL spec, that seemed to be the
>> only way that implies the flit size for a CXL device as far as I can
>> tell. I've yet to find a good way to make that determination. Dan?
> 
> So a given CXL port has either trained up in:
> * normal PCI (in which case all the normal PCI stuff applies) and we'll
>    fail some of the other checks in the CXL driver never get hear here
>    - I 'think' the driver will load for the PCI device to enable things
>    like firmware upgrade, but we won't register the CXL Port devices
>    that ultimately call this stuff.
>    It's perfectly possible to have a driver that will cope with this
>    but it's pretty meaningless for a lot of cxl type 3 driver.
> * 68 byte flit (which was CXL precursor to PCI going flit based)
>    Can be queried via CXL DVSEC Flex Bus Port Status CXL r3.0 8.2.1.3.3
> * 256 byte flits (may or may not be compatible with PCIe ones as there
>    are some optional latency optimizations)
> 
> So if the 68 byte flit is enabled the 256 byte one should never be and
> CXL description is overriding the old PCIe
> 
> Hence I think we should have the additional check on the flex bus
> dvsec even though it should be consistent with your assumption above.

So I'm trying to understand the CXL DVSEC Port status "68B flit and VH 
Enabled bit". If this bit is set, it means we are in 68B flit mode and 
VH mode? Do we just ignore RCH/RCD calculations since it doesn't support 
hotplug? Does this bit get cleared for 256B flit mode? It's not clear to 
me.

> 
> Hmm. That does raise a question of how we take the latency optimized
> flits into account or indeed some of the other latency impacting things
> that may or may not be running - IDE in it's various modes for example.
> 
> For latency optimized we can query relevant bit in the flex bus port status.
> IDE info will be somewhere I guess though no idea if there is a way to
> know the latency impacts.

Should we deal with latency optimized flits and IDE in a later step?

> 
> Jonathan
> 
>>
>>
>>>
>>> Bjorn
> 
