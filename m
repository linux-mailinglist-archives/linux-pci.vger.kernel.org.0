Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84A27669C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 04:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIXCvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 22:51:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:60567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgIXCvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 22:51:06 -0400
IronPort-SDR: VzzOMvbIgAYDyCWlR6gTxBz3sJZA5jmRhVoBsxsUM2kYvVW4FSLrUKoaxZkLDW9ebzn2v7RCjW
 3lsfvyn7bBAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="141085824"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="141085824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 19:51:06 -0700
IronPort-SDR: MY0WoXmH2RYuPS1fhnWOvwlsOolPlf3vcJzS0Cba7JRDXC+Q5P0iZOonb+CkBkMVvm6Oy8YNTi
 YpMFYuLYH8CQ==
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="382888683"
Received: from jdelagui-mobl.amr.corp.intel.com (HELO [10.255.231.15]) ([10.255.231.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 19:51:05 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
 <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
 <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
Date:   Wed, 23 Sep 2020 19:51:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/20 7:16 PM, Sinan Kaya wrote:
> On 9/23/2020 10:04 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> AFAIK, DLLSC is a requirement not optional. Why is this not supported by
>>> non-hotplug ports?
>> Its required for hotplug capable ports. Please check PCIe spec v5.0 sec
>> 6.7.3.3.
>>
>> The Data Link Layer State Changed event provides an indication that the
>> state of
>> the Data Link Layer Link Active bit in the Link Status Register has
>> changed.
>> Support for Data Link Layer State Changed events and software
>> notification of these
>> events are required for hot-plug capable Downstream Ports.
> 
> I see. Can I assume that your system supports DPC?
> DPC is supposed to recover the link via dpc_reset_link().
Yes. But the affected device/drivers cleanup during error recovery
is handled by hotplug handler. So we are facing issue when dealing
with non hotplug capable ports.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
