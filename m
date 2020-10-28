Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0129DF33
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgJ2A7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 20:59:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:16196 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgJ1WR3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:29 -0400
IronPort-SDR: rdRA8M3bw7vFFH0a0PPCvONQSS/tI7Hu3uQIYjIlW9MsONDqMebVodfb7sIT+n+syxla+bsQ/M
 yGWVWtVRd3IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156072242"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="156072242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:14:11 -0700
IronPort-SDR: 4YVU2uW+/l5QXaisbX2aM9ahPxQ6TtDiYZso8e6kxGgGUplah6Dy87BbJ8sy/cRhYrV2nm3ItO
 vZH5r+w+PlgA==
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="536311450"
Received: from rramir3-mobl.amr.corp.intel.com (HELO [10.254.71.48]) ([10.254.71.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:14:11 -0700
Subject: Re: [PATCH v11 1/5] PCI: Conditionally initialize host bridge
 native_* members
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh1j1GAOxK8QAwAgPpn3wxtvZgp8QJQ2zjcv5B=jEVG_eg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <aed26290-632e-fe65-327c-95a68538c58b@linux.intel.com>
Date:   Wed, 28 Oct 2020 10:14:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh1j1GAOxK8QAwAgPpn3wxtvZgp8QJQ2zjcv5B=jEVG_eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/27/20 11:09 PM, Ethan Zhao wrote:
> On Tue, Oct 27, 2020 at 10:00 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
>> struct pci_host_bridge PCIe specific native_* members to "1" is
>> incorrect. So protect the PCIe specific member initialization
>> with CONFIG_PCIEPORTBUS.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/probe.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4289030b0fff..756fa60ca708 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>           * may implement its own AER handling and use _OSC to prevent the
>>           * OS from interfering.
>>           */
>> +#ifdef CONFIG_PCIEPORTBUS
>>          bridge->native_aer = 1;
>>          bridge->native_pcie_hotplug = 1;
>> -       bridge->native_shpc_hotplug = 1;
>>          bridge->native_pme = 1;
>> -       bridge->native_ltr = 1;
>>          bridge->native_dpc = 1;
>> +#endif
>    If CONFIG_PCIEPORTBUS wasn't defined, leave them to "unknown" value ?
By default all of them are 0.
> 
>> +       bridge->native_ltr = 1;
>> +       bridge->native_shpc_hotplug = 1;
>>
>>          device_initialize(&bridge->dev);
>>   }
>> --
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
