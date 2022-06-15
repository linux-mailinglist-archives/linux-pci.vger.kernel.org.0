Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919E554CC5B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbiFOPO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347987AbiFOPOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 11:14:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BF3BFA0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jun 2022 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655306062; x=1686842062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lweGIS25LYqsMLFtghZJHNm5ITBCaxEIo1fo9eJhCq8=;
  b=Fp+G18ZT6d6Ze5yN6Sfw7fMWz2cnLrEkup6leAelB4jUHMIq9NPJ5lx+
   GWlQlDe1m6L25Sy9Co2X0ao9k3tbPfa1h3RzlAcIK5UrLZoUcdHgAsJTN
   6zgVM9hyk0QjzgGtERqxCRuZbtu7eJVKo8KrHS7dMAmr4JPxjoNfDL9K7
   EO/PsAMLBhhCiyxhr3FS+fu8ethbpou6lzJw9twVyC05SKvAmirq17K9g
   mQkhKWCJI/iRT1hELgS+58ZyvM0i2NY93ak02Fu1S5X2eGgeb+Z4vsVSM
   6zfvHkPaKuJZPeAdotJeO6uFmxkMDdNGe4JZMXpq3UZYoWk5tFfnJ1fDG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279710142"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279710142"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:14:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641049647"
Received: from dbohning-mobl.amr.corp.intel.com (HELO [10.212.140.214]) ([10.212.140.214])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:14:21 -0700
Message-ID: <65242da6-9917-4307-90fe-4bb4d35c2f1c@linux.intel.com>
Date:   Wed, 15 Jun 2022 08:14:19 -0700
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
 <e38acd32-48f0-8872-8637-856ac0033ce2@linux.intel.com>
 <0754f511-fba7-7ee4-22ac-8457ba71c889@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <0754f511-fba7-7ee4-22ac-8457ba71c889@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/14/22 1:35 PM, Andrey Grodzovsky wrote:
> 
> 
> On 2022-06-14 14:22, Sathyanarayanan Kuppuswamy wrote:
>> Hi,
>>
>> On 6/14/22 11:07 AM, Andrey Grodzovsky wrote:
>>> Just a gentle ping, also - I updated the ticket https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215590&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=wEEU3f5%2BrCSZZEnn0e0FTiWRbILd1ZlyYccg3k2CfQQ%3D&amp;reserved=0
>>>
>>> with the workaround we did if this could help you to advise us
>>> what would be a generic solution for this ?
>>>
>>> Andrey
>> Can you explain your WA? It seems to be unrelated to deadlock issue
>> discussed in this thread. Are they related?
> 
> So from start - originally we have an extension PCI board which is hot plug-able into our system board. On top of this extension board we have
> AMD dGPU card. Originally we observed hang on resume from sleep (S3) in
> AER enabled system because of race between AER and pciehp on S3 resume and so this
> was resolved by the patch https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/T/
> 

There is patch to disable AER in suspend/resume path (from Kai-Heng Feng). Did
you check with this patch?

> Now after this we are facing a second issue where after resume and after
> AER driver recovery completed for pcieport the system won't detect a new
> hotplug of the extention board into the system board. Anatoli looked

What about the hotplug events during this sequence? Did you get the
LINK DOWN/UP or Presence change events?

> into it and found the workaround that I attached that made it work by
> resetting secondary bus and updating link speed on the upstream bridge
> after AER recovery complete (post S3 resume).  But this is just a


> workaround and not a generic solution so we would like to get an advise for a generic fix for this problem.
> 
> To reiterate the full scenario is like this
> 
> 1) Boot system
> 
> 2) Extension board is first time hotplugged and dGPU is added to PCI topology
> 
> 3) System suspend S3
> 
> 4)  WE have costum BIOS which 'shuts off' the extension board during sleep so on resume the system discovers that the extension board (and dGPU) are gone and hot removes it from PCI topology. Together with this hot remove AER errors are generated and handled.
> 
> 5)We again try to hot plug though a script we have but the system won't
> detect the new hot plug of the extension board.
> 
> 5*) The given workaround patch fixes issue in bullet 5) and hot plug
> is detected and system recognizes the extension board and add it and dGPU to PCI topology.
> 
> Andrey
> 
>>
>>>
>>> On 2022-06-10 17:25, Andrey Grodzovsky wrote:
>>>>
>>>>
>>>> On 2022-02-10 09:39, Andrey Grodzovsky wrote:
>>>>> Thanks a lot for quick response, we will give this a try.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-02-10 01:23, Lukas Wunner wrote:
>>>>>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>>>>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>>>>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>>>>>> we do is putting the system to sleep, disconnecting the eGPU
>>>>>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>>>>>> removing power to external PCIe cage and waking the
>>>>>>> system up.
>>>>>>>
>>>>>>> I attached the log. Please advise if you have any idea how
>>>>>>> to work around it ? Since the kernel is old, does anyone
>>>>>>> have an idea if this issue is known and already solved in later kernels ?
>>>>>>> We cannot try with latest since our kernel is custom for that platform.
>>>>>>
>>>>>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>>>>>
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0mLcR5MtJ52ZPoGPZ63WqK%2BFPNCQ8tOpizKU%2BUmkuFY%3D&amp;reserved=0
>>>>>>
>>>>>> The fix hasn't been applied yet.  I think I need to rework the patch,
>>>>>> just haven't found the time.
>>>>
>>>> Hey Lucas - just checking again if you had a chance to push this change
>>>> through ? It's essential to us in one of our costumer projects so we
>>>> wonder if have any estimate when will it be up-streamed and if we can
>>>> help with this. We would also need backporting this back to 5.11 and 5.4
>>>> kernels after it's upstreamed.
>>>>
>>>> Another point I want to mention is that this patch has a negative
>>>> side effect on plug back times - it causes a regression point for the delay to light-up display at resume time related to back-ported AER
>>>>
>>>> Anatoli is working on resolving this and so maybe he can add his
>>>> comment here and maybe you can help him with proper resolution for this.
>>>>
>>>> Andrey
>>>>
>>>>>>
>>>>>> Since the trigger in your case are AER-handled errors during a
>>>>>> system sleep transition, you may also want to consider the
>>>>>> following 2-patch series by Kai-Heng Feng which is currently
>>>>>> under discussion:
>>>>>>
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C2bef39c2088748464bf408da4e32caca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637908277297716792%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F94hA3KKA9VUqisUhSaPCPIbi9IS43%2FOGManjoOh1AQ%3D&amp;reserved=0
>>>>>>
>>>>>> That series disables AER during a system sleep transition and
>>>>>> should thus prevent the flood of AER-handled errors you're seeing.
>>>>>> Once AER is disabled, the reset-induced deadlocks should go away as well.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Lukas
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
