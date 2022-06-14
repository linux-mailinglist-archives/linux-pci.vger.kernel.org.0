Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196E54B87A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiFNSWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiFNSWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 14:22:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A7CFB
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655230941; x=1686766941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0oVECWuPtJS+2NEW65wvjhppjtPyitlmkFO8YPSJ7e0=;
  b=XWMo07pJNHha5D7+ZYuhfk9In2Nk7pimvmHU7izwNqNBux0Ln30obGSo
   lmkcaXOUViD2/vRAzQP/lyLf8TiTGGxh6ERXYqE07FfYWwVF/KrOqJN6u
   Ewiz8ZNZKBQe3ZY/BNqC3v2NTeP2OEcf2l0nbuQt1WXtkLjtI4aptX6VS
   DtMy/TFKeyRz3o+QxBKKsb+KoZU06s9DZLr6BIqaScqIYqrJLlfwfVoJ8
   SVPNjy8kxQdDCORBrzo0TRlUZVinxtfRyOIxzaTIVaMLUxWNpIZ4h8tqV
   kLjXkVcD3jfDX8mKmWGGoLq45SoLcxEzQ3/CP4e3GXHWkBelofrb/cjUO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279740838"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279740838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 11:22:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612362775"
Received: from chakrab1-mobl.amr.corp.intel.com (HELO [10.209.55.84]) ([10.209.55.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 11:22:07 -0700
Message-ID: <e38acd32-48f0-8872-8637-856ac0033ce2@linux.intel.com>
Date:   Tue, 14 Jun 2022 11:22:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
 <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
 <830edffd-edb9-e07a-a87d-21a6f52577e3@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <830edffd-edb9-e07a-a87d-21a6f52577e3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/14/22 11:07 AM, Andrey Grodzovsky wrote:
> Just a gentle ping, also - I updated the ticket https://bugzilla.kernel.org/show_bug.cgi?id=215590
> 
> with the workaround we did if this could help you to advise us
> what would be a generic solution for this ?
> 
> Andrey
Can you explain your WA? It seems to be unrelated to deadlock issue
discussed in this thread. Are they related?

> 
> On 2022-06-10 17:25, Andrey Grodzovsky wrote:
>>
>>
>> On 2022-02-10 09:39, Andrey Grodzovsky wrote:
>>> Thanks a lot for quick response, we will give this a try.
>>>
>>> Andrey
>>>
>>> On 2022-02-10 01:23, Lukas Wunner wrote:
>>>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>>>> we do is putting the system to sleep, disconnecting the eGPU
>>>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>>>> removing power to external PCIe cage and waking the
>>>>> system up.
>>>>>
>>>>> I attached the log. Please advise if you have any idea how
>>>>> to work around it ? Since the kernel is old, does anyone
>>>>> have an idea if this issue is known and already solved in later kernels ?
>>>>> We cannot try with latest since our kernel is custom for that platform.
>>>>
>>>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=hrRVL77%2FNRvojfG2WDamDLO5dsqn3Cv6XxNbP0eGum0%3D&amp;reserved=0
>>>>
>>>> The fix hasn't been applied yet.  I think I need to rework the patch,
>>>> just haven't found the time.
>>
>> Hey Lucas - just checking again if you had a chance to push this change
>> through ? It's essential to us in one of our costumer projects so we
>> wonder if have any estimate when will it be up-streamed and if we can
>> help with this. We would also need backporting this back to 5.11 and 5.4
>> kernels after it's upstreamed.
>>
>> Another point I want to mention is that this patch has a negative
>> side effect on plug back times - it causes a regression point for the delay to light-up display at resume time related to back-ported AER
>>
>> Anatoli is working on resolving this and so maybe he can add his
>> comment here and maybe you can help him with proper resolution for this.
>>
>> Andrey
>>
>>>>
>>>> Since the trigger in your case are AER-handled errors during a
>>>> system sleep transition, you may also want to consider the
>>>> following 2-patch series by Kai-Heng Feng which is currently
>>>> under discussion:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=tnLUa6J%2FLqFrlm4CfZ9l26io0bOQ7ip30d26ax05st4%3D&amp;reserved=0
>>>>
>>>> That series disables AER during a system sleep transition and
>>>> should thus prevent the flood of AER-handled errors you're seeing.
>>>> Once AER is disabled, the reset-induced deadlocks should go away as well.
>>>>
>>>> Thanks,
>>>>
>>>> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
