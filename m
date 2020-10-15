Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39E28EB61
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 05:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJODEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 23:04:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:11510 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgJODEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 23:04:21 -0400
IronPort-SDR: Y7c3yFEJJkGd5mTmPwDvnN3bx/YcJEO4xrvXuOVmWMAwDp49WDuVDMHUVp2WZQ51FlGpiKA26v
 LN3CvAGyJsiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162780266"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="162780266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:04:20 -0700
IronPort-SDR: U4Kvq3YPtgyHV1+ezff4hfjksuKRU5TyuOHxHCCa6vqQc+6QbBwuM4RFrsKbhJ0imJH2k/IF9D
 sPZoNEYZu7Dw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="314365473"
Received: from shaunabu-mobl1.amr.corp.intel.com (HELO [10.254.101.5]) ([10.254.101.5])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:04:19 -0700
Subject: Re: [PATCH v6 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
 <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com>
 <CAKF3qh1fiqqRGvUB2Jxm8tM6Q06GntquGxzmcKe1vapONSPREA@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b84ae5fd-d1db-9378-7e2e-937b660d2e9a@linux.intel.com>
Date:   Wed, 14 Oct 2020 20:04:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh1fiqqRGvUB2Jxm8tM6Q06GntquGxzmcKe1vapONSPREA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/14/20 6:58 PM, Ethan Zhao wrote:
> On Thu, Oct 15, 2020 at 1:06 AM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 10/14/20 8:07 AM, Ethan Zhao wrote:
>>> On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
>>>>
>>>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
>>>> merged fatal and non-fatal error recovery paths, and also made
>>>> recovery code depend on hotplug handler for "remove affected
>>>> device + rescan" support. But this change also complicated the
>>>> error recovery path and which in turn led to the following
>>>> issues.
>>>>
>>>> 1. We depend on hotplug handler for removing the affected
>>>> devices/drivers on DLLSC LINK down event (on DPC event
>>>> trigger) and DPC handler for handling the error recovery. Since
>>>> both handlers operate on same set of affected devices, it leads
>>>> to race condition, which in turn leads to  NULL pointer
>>>> exceptions or error recovery failures.You can find more details
>>>> about this issue in following link.
>>>>
>>>> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
>>>>
>>>> 2. For non-hotplug capable devices fatal (DPC) error recovery
>>>> is currently broken. Current fatal error recovery implementation
>>>> relies on PCIe hotplug (pciehp) handler for detaching and
>>>> re-enumerating the affected devices/drivers. So when dealing with
>>>> non-hotplug capable devices, recovery code does not restore the state
>>>> of the affected devices correctly. You can find more details about
>>>> this issue in the following links.
>>>>
>>>> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
>>>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>>>> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>>
>>>> In order to fix the above two issues, we should stop relying on hotplug
>>>     Yes, it doesn't rely on hotplug handler to remove and rescan the device,
>>> but it couldn't prevent hotplug drivers from doing another replicated
>>> removal/rescanning.
>>> it doesn't make sense to leave another useless removal/rescanning there.
>>> Maybe that's why these two paths were merged to one and made it rely on
>>> hotplug.
>> No, as per PCIe spec, hotplug and DPC has no functional dependency. Hence
>> depending on it to handle some of its recovery function is in-correct and
>> would lead to issues in non-hotplug capable platforms (which is true
>> currently).
>>>

>   pci_lock_rescan_remove() is global lock for PCIe, the mal-functional
>   device's port holds this lock, it prevents the whole system from doing
>   hot-plug operation.
It does not prevent the hotplug operation, but it might delay it. Since both
DPC and hotplug operates on same set of devices, it must be synchronized.
>   Though pciehp is not so hot/scalable and performance critical, but there
>   is per cpu thread to handle hot-plug operation. synchronize all threads
>   make them walk backwards for scalability.
DPC events does not happen in high frequency. So I don't think we should
worry about the performance here. Even hotplug handler will hold this lock
when adding/removing the devices. So adding/removing devices is a serialized
operation.
> 

>>
>>>> --
>>>> 2.17.1
>>>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
