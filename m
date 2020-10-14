Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C076C28E509
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgJNRGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 13:06:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:51458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730842AbgJNRGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 13:06:50 -0400
IronPort-SDR: 58JBSqOFQDiswojLyNAzuu5cFPqtYXJf5kfg7Cj922GiyGn8ppFtO8Imk6O7U7hH6aVm38HyyN
 YXIp34xHPdVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="153090536"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="153090536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 10:06:28 -0700
IronPort-SDR: sVGy5hGJPWa0UJvX2bRUPL7E2QwtY9LXVTF7Unl8qJxsjG/kfAy8csU8BzVVbfTbfU+p5C7peM
 MrXdOQYTcSnw==
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="345736029"
Received: from mmussend-mobl1.amr.corp.intel.com (HELO [10.252.132.111]) ([10.252.132.111])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 10:06:27 -0700
Subject: Re: [PATCH v6 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Ethan Zhao <xerces.zhao@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com>
Date:   Wed, 14 Oct 2020 10:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/14/20 8:07 AM, Ethan Zhao wrote:
> On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
>>
>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
>> merged fatal and non-fatal error recovery paths, and also made
>> recovery code depend on hotplug handler for "remove affected
>> device + rescan" support. But this change also complicated the
>> error recovery path and which in turn led to the following
>> issues.
>>
>> 1. We depend on hotplug handler for removing the affected
>> devices/drivers on DLLSC LINK down event (on DPC event
>> trigger) and DPC handler for handling the error recovery. Since
>> both handlers operate on same set of affected devices, it leads
>> to race condition, which in turn leads to  NULL pointer
>> exceptions or error recovery failures.You can find more details
>> about this issue in following link.
>>
>> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
>>
>> 2. For non-hotplug capable devices fatal (DPC) error recovery
>> is currently broken. Current fatal error recovery implementation
>> relies on PCIe hotplug (pciehp) handler for detaching and
>> re-enumerating the affected devices/drivers. So when dealing with
>> non-hotplug capable devices, recovery code does not restore the state
>> of the affected devices correctly. You can find more details about
>> this issue in the following links.
>>
>> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>
>> In order to fix the above two issues, we should stop relying on hotplug
>    Yes, it doesn't rely on hotplug handler to remove and rescan the device,
> but it couldn't prevent hotplug drivers from doing another replicated
> removal/rescanning.
> it doesn't make sense to leave another useless removal/rescanning there.
> Maybe that's why these two paths were merged to one and made it rely on
> hotplug.
No, as per PCIe spec, hotplug and DPC has no functional dependency. Hence
depending on it to handle some of its recovery function is in-correct and
would lead to issues in non-hotplug capable platforms (which is true
currently).
> 

>> +       else
>> +               udev = dev->bus->self;
>> +
>> +       parent = udev->subordinate;
>> +       pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
>> +
>> +        pci_lock_rescan_remove();
>     Though here you have lock, but hotplug will do another
> 'pci_stop_and_remove_bus_device()'
>     without merging it with the hotplug driver, you have no way to
> remove the replicated actions in
>    hotplug handler.
No, the core operation (remove/add device) is syncronzied and done in
only one thread. Please check the following flow. Even in hotplug
handler, before removing the device, it attempts to hold pci_lock_rescan_remove()
lock. So holding the same lock in DPC handler will syncronize the DPC/hotplug
handlers. Also if one of the thread (DPC or hotplug) removes/adds the affected devices,
other thread will not repeat the same action (since the device is already removed/added).

->pciehp_ist()
   ->pciehp_handle_presence_or_link_change()
     ->pciehp_disable_slot()
       ->__pciehp_disable_slot()
         ->remove_board()
           ->pciehp_unconfigure_device()
             ->pci_lock_rescan_remove()
> 
> 
>    Thanks,
>    Ethan
>> +        pci_dev_get(dev);
>> +        list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>> +                                        bus_list) {
>> +               pci_stop_and_remove_bus_device(pdev);
>> +       }
>> +
>> +       result = reset_link(udev);
>> +
>> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> +               /*
>> +                * If the error is reported by a bridge, we think this error
>> +                * is related to the downstream link of the bridge, so we
>> +                * do error recovery on all subordinates of the bridge instead
>> +                * of the bridge and clear the error status of the bridge.
>> +                */
>> +               pci_aer_clear_fatal_status(dev);
>> +               if (pcie_aer_is_native(dev))
>> +                       pcie_clear_device_status(dev);
>> +       }
>> +
>> +       if (result == PCI_ERS_RESULT_RECOVERED) {
>> +               if (pcie_wait_for_link(udev, true))
>     And another  pci_rescan_bus() like in the hotplug handler.
As I have mentioned before, holding the same lock should make them synchronized
and not repeat the underlying functionality of pci_rescan_bus() in both threads
at the same time.
>> +                       pci_rescan_bus(udev->bus);
>> +               pci_info(dev, "Device recovery from fatal error successful\n");
>> +        } else {
>> +               pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>> +               pci_info(dev, "Device recovery from fatal error failed\n");

>> --
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
