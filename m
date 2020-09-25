Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EE278F66
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgIYRMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 13:12:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:29630 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgIYRMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 13:12:43 -0400
IronPort-SDR: M23hTGy65RZdhh55Q0K0UNn+UqaHW7SVZn9AyBmEMi/vJdoULHjhyod61dH1VX54lCxpGY7G5f
 KF0QpkjrKgaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158988191"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="158988191"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 10:11:36 -0700
IronPort-SDR: N9qUM2kQQYcBmlx5yh5/8dXOuUXX/0lOMEfPuYTgIhfYvd/oMAPoRnfdMgFJYGswNSBacdsZDR
 R/FsilD2KtWQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455925879"
Received: from snouri-mobl1.amr.corp.intel.com (HELO [10.255.231.80]) ([10.255.231.80])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 10:11:35 -0700
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
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
 <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
 <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
Date:   Fri, 25 Sep 2020 10:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/25/20 9:55 AM, Sinan Kaya wrote:
> On 9/25/2020 1:11 AM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 9/24/20 1:52 PM, Sinan Kaya wrote:
>>> On 9/24/2020 12:06 AM, Kuppuswamy, Sathyanarayanan wrote:
> 
>>>
>>> So, this is a matter of moving the save/restore logic from the hotplug
>>> driver into common code so that DPC slot reset takes advantage of it?
>> We are not moving it out of hotplug path. But fixing it in this code path.
>> With this fix, we will not depend on hotplug driver to restore the state.
> 
> Any possibility of unification?
If we do that, it might need rework of hotplug driver. It will be a big
change. IMO, its better not to touch that bee hive.
> 
> 
> [snip]
>>>
>>>> To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
>>>> successful reset_link() operation. This will ensure ->slot_reset() be
>>>> called after reset_link() operation for fatal errors.
>>>
>>> You lost me here. Why do we want to do secondary bus reset on top of
>>> DPC reset?
>> For non-hotplug capable slots, when reset (PCI_ERS_RESULT_NEED_RESET) is
>> requested, we want to reset it before calling ->slot_reset() callback.
> 
> Why? Isn't DPC slot reset enough?
It will do the reset at hardware level. But driver state is not
cleaned up. So doing bus reset will restore both driver and
hardware states.
Also for non-fatal errors, if reset is requested then we still need
some kind of bus reset call here.
> What will bus reset do that DPC slot reset won't do?
> 
> I can understand calling bus reset if DPC is not supported.
> I don't understand the requirement to do double reset.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
