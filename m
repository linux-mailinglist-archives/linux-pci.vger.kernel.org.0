Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C827662E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 04:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIXCEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 22:04:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:52288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXCEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 22:04:40 -0400
IronPort-SDR: SBloBsLui30GihXNSzR1dKJ9Wl7StnB+HpAQJMAfNcwzSlgMYCrlYTDB82U3By/P3D6bPzZBHb
 Kg3tsdQJ9BQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225204563"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="225204563"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 19:04:39 -0700
IronPort-SDR: hz/RI71VQEz5S+0FXXacOm2hX8rmBeP1olv5jScvAu/g9sdK3wmEXYWmavhPCcjL5cd+rFH1b6
 MjWukxp3Rl3Q==
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="382878614"
Received: from jdelagui-mobl.amr.corp.intel.com (HELO [10.255.231.15]) ([10.255.231.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 19:04:39 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
 <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
Date:   Wed, 23 Sep 2020 19:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/20 6:15 PM, Sinan Kaya wrote:
> On 9/22/2020 7:44 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> here does the restore happen here?  I.e., what function does this?
>>
>> DLLSC link down event will remove affected devices/drivers. And link up
>> event
>> will re-create all devices.
>>
>> on DLLSC link down event
>> ->pciehp_ist()
>>    ->pciehp_handle_presence_or_link_change()
>>      ->pciehp_disable_slot()
>>        ->__pciehp_disable_slot()
>>          ->remove_board()
>>            ->pciehp_unconfigure_device()
>>
>> on DLLSC link up event
>> ->pciehp_ist()
>>    ->pciehp_handle_presence_or_link_change()
>>      ->pciehp_enable_slot()
>>        ->__pciehp_enable_slot()
>>          ->board_added()
>>            ->pciehp_configure_device()
> 
> AFAIK, DLLSC is a requirement not optional. Why is this not supported by
> non-hotplug ports?
Its required for hotplug capable ports. Please check PCIe spec v5.0 sec 6.7.3.3.

The Data Link Layer State Changed event provides an indication that the state of
the Data Link Layer Link Active bit in the Link Status Register has changed.
Support for Data Link Layer State Changed events and software notification of these
events are required for hot-plug capable Downstream Ports.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
