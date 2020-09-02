Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFA25B548
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIBU1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 16:27:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:38349 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBU1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 16:27:37 -0400
IronPort-SDR: jjF4nDjs1i0MMa1aR31mrUUsGVuJvAULJP3DV6ooR2Wn33JdS1M+4JRkN3xM+fUdH9hvff+v4H
 vl9/4uUZGQQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154877449"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="154877449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 02 Sep 2020 13:27:36 -0700
IronPort-SDR: GtBaKznKuR1LXoE174x3vfConIS+Tpxs9ge1e1K5AjFcCBVFmOeBnEg7ukNML0z3SYSPeknflT
 Fp5p/u90DafA==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="325925854"
Received: from acduong-mobl2.amr.corp.intel.com (HELO [10.254.87.179]) ([10.254.87.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 13:27:36 -0700
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     alexander.deucher@amd.com, nirmodas@amd.com, Dennis.Li@amd.com,
        christian.koenig@amd.com, luben.tuikov@amd.com, bhelgaas@google.com
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
 <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
 <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d4da4c2c-4fdb-08ee-c514-acfbcb67e16b@linux.intel.com>
Date:   Wed, 2 Sep 2020 13:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/2/20 12:54 PM, Andrey Grodzovsky wrote:
> Yes, works also.
> 
> Can you provide me a formal patch that i can commit into our local amd staging tree with my patch set ?
https://patchwork.kernel.org/patch/11684175/mbox/
> 
> Alex - is that how we want to do it, without this patch or reverting the original patch the feature 
> is broken.
> 
> Andrey
> 
> On 9/2/20 3:00 PM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 9/2/20 11:42 AM, Andrey Grodzovsky wrote:
>>> This reverts commit 6d2c89441571ea534d6240f7724f518936c44f8d.
>>>
>>> In the code bellow
>>>
>>>                  pci_walk_bus(bus, report_frozen_detected, &status);
>>> -               if (reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>>> +               status = reset_link(dev, service);
>>>
>>> status returned from report_frozen_detected is unconditionally masked
>>> by status returned from reset_link which is wrong.
>>>
>>> This breaks error recovery implementation for AMDGPU driver
>>> by masking PCI_ERS_RESULT_NEED_RESET returned from amdgpu_pci_error_detected
>>> and hence skiping slot reset callback which is necessary for proper
>>> ASIC recovery. Effectively no other callback besides resume callback will
>>> be called after link reset the way it is implemented now regardless of what
>>> value error_detected callback returns.
>>>
>>     }
>>
>> Instead of reverting this change, can you try following patch ?
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F56ad4901-725f-7b88-2117-b124b28b027f%40linux.intel.com%2FT%2F%23me8029c04f63c21f9d1cb3b1ba2aeffbca3a60df5&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C77325d6a2abc42d26ae608d84f726c51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346700170831846&amp;sdata=JPo8lOXfjxpq%2BnmlVrSi93aZxGjIlbuh0rkZmNKkzQM%3D&amp;reserved=0 
>>
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
