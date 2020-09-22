Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428D8274A64
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIVUu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:50:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:47828 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVUu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:50:26 -0400
IronPort-SDR: vkN4FTGi46Wt/qVpSex2jgeYhAYZBfDe78TQskNIQynd8H7HZpqn7YPACE96mo0vRoGkhv6/+u
 ckYCPYwQB3Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222298640"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="222298640"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:50:24 -0700
IronPort-SDR: Y36xdET4I6OzK/EPHTM1IqQ0YZpypLWOJz02xf18v5kwcvX1Rli6WDBMMcZgWm3e5+M03H+nXq
 SR6idQoRvTTw==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="291423769"
Received: from fkhoshne-mobl1.amr.corp.intel.com (HELO [10.255.230.168]) ([10.255.230.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:50:24 -0700
Subject: Re: [PATCH v9 1/5] PCI: Conditionally initialize host bridge native_*
 members
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200922203950.GA2227863@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <56d9af56-223a-c141-bc05-9499fbd5ff0a@linux.intel.com>
Date:   Tue, 22 Sep 2020 13:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922203950.GA2227863@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/22/20 1:39 PM, Bjorn Helgaas wrote:
> I got 1/5, 3/5, and 5/5 (and no cover letter).  Is there a 2/5 and a
> 4/5?  Not sure if I should wait for more, or review these three as-is?
I sent all 5 together with cover letter. Do you want me to send it again ?
> 
> On Fri, Sep 18, 2020 at 12:58:30PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
>> index 03d37128a24f..0da0fc034413 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>   	 * may implement its own AER handling and use _OSC to prevent the
>>   	 * OS from interfering.
>>   	 */
>> +#ifdef CONFIG_PCIEPORTBUS
>>   	bridge->native_aer = 1;
>>   	bridge->native_pcie_hotplug = 1;
>> -	bridge->native_shpc_hotplug = 1;
>>   	bridge->native_pme = 1;
>> -	bridge->native_ltr = 1;
>>   	bridge->native_dpc = 1;
>> +#endif
>> +	bridge->native_ltr = 1;
>> +	bridge->native_shpc_hotplug = 1;
>>   
>>   	device_initialize(&bridge->dev);
>>   }
>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
