Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B51927902D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 20:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgIYSRD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 14:17:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:30408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgIYSRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 14:17:02 -0400
IronPort-SDR: D1LUz2e5iEgtd9MY1eYb289kmfTTgVgfWosmIZ3jWTRHvIE4KvLA/ULg88EybpWsqMA8NlfwKJ
 bc4S2q3/3vgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="246385757"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="246385757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 11:17:01 -0700
IronPort-SDR: iPxBmzfK6F2DyPoIigBaHYym+cq9qAstU4U4Ztm+Hg0lx4gQzgo25OcEIbiNGvvSxI/W+93Dgb
 4XolPQcd0Awg==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455947520"
Received: from kritigup-mobl.amr.corp.intel.com (HELO [10.255.231.88]) ([10.255.231.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 11:16:59 -0700
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
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
 <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com>
Date:   Fri, 25 Sep 2020 11:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/25/20 10:47 AM, Sinan Kaya wrote:
> On 9/25/2020 1:11 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> Why? Isn't DPC slot reset enough?
>> It will do the reset at hardware level. But driver state is not
>> cleaned up. So doing bus reset will restore both driver and
>> hardware states.
> 
> I really don't like this. If hotplug driver is restoring the state
> and DPC driver is not; let's fix the DPC driver rather than causing
> two resets and hope for the best.
> 
> One approach is to share the restore code between hotplug driver and
> DPC driver.
> 
> If this is a too involved change, DPC driver should restore state
> when hotplug is not supported.
Yes. we can add a condition for hotplug capability check.
> 
> DPC driver should be self-sufficient by itself.
> 
>> Also for non-fatal errors, if reset is requested then we still need
>> some kind of bus reset call here
> 
> DPC should handle both fatal and non-fatal cases
Currently DPC is only triggered for FATAL errors.
  and cause a bus reset
> in hardware already before triggering an interrupt.
Error recovery is not triggered only DPC driver. AER also uses the
same error recovery code. If DPC is not supported, then we still need
reset logic.
> 
> I disagree that you need an additional reset on top of DPC reset.
> Isn't one reset enough?
> 
> What will the second reset provide that first reset won't provide?
> 
> I see that you are trying to do the second reset only because second
> reset restores state.
> 
> That looks like a short-term fix only to explode on the next iteration.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
