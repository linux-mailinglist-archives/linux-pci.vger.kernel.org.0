Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649DB274D77
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgIVXoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 19:44:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:9371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIVXoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 19:44:07 -0400
IronPort-SDR: zacx9vCvepX8c/Qp3UIQNTm0Ki6lB+r2ukYJ+KfkxYiWPOT/8lp1q+N+0qOTt9112NZvM8hNZa
 rfs3AeeMPX6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="140214880"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="140214880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 16:44:07 -0700
IronPort-SDR: 3vPIyamVPg+0BpPtKtRSoPSz9klirYJAZ1WffMml8Du0jj6/D4RBohrmbblGmjKJ2KQe6611sU
 JLayg4nKgq0A==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="486178382"
Received: from nfoneill-mobl.amr.corp.intel.com (HELO [10.254.96.26]) ([10.254.96.26])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 16:44:07 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
Date:   Tue, 22 Sep 2020 16:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922233333.GA2239404@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/22/20 4:33 PM, Bjorn Helgaas wrote:
> On Tue, Sep 22, 2020 at 02:44:51PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 9/22/20 11:52 AM, Bjorn Helgaas wrote:
>>> On Fri, Jul 24, 2020 at 12:07:55PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> Current pcie_do_recovery() implementation has following two issues:
>>>>
>>>
>>> I'm having trouble parsing this out, probably just lack of my
>>> understanding...
>>>
>>>> 1. Fatal (DPC) error recovery is currently broken for non-hotplug
>>>> capable devices. Current fatal error recovery implementation relies
>>>> on PCIe hotplug (pciehp) handler for detaching and re-enumerating
>>>> the affected devices/drivers. pciehp handler listens for DLLSC state
>>>> changes and handles device/driver detachment on DLLSC_LINK_DOWN event
>>>> and re-enumeration on DLLSC_LINK_UP event. So when dealing with
>>>> non-hotplug capable devices, recovery code does not restore the state
>>>> of the affected devices correctly.
>>>
>>> Apparently in the hotplug case, something *does* restore the state of
>>> affected devices?
>>
>> Yes, in hotplug case, DLLSC state change handler takes over detachment
>> /cleanup and re-attachment of affected devices/drivers.
> 
> Where does the restore happen here?  I.e., what function does this?

DLLSC link down event will remove affected devices/drivers. And link up event
will re-create all devices.

on DLLSC link down event
->pciehp_ist()
   ->pciehp_handle_presence_or_link_change()
     ->pciehp_disable_slot()
       ->__pciehp_disable_slot()
         ->remove_board()
           ->pciehp_unconfigure_device()

on DLLSC link up event
->pciehp_ist()
   ->pciehp_handle_presence_or_link_change()
     ->pciehp_enable_slot()
       ->__pciehp_enable_slot()
         ->board_added()
           ->pciehp_configure_device()

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
