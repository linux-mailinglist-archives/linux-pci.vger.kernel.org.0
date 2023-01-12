Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A43666AA3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 06:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjALFGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 00:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjALFGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 00:06:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE1415719;
        Wed, 11 Jan 2023 21:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673499976; x=1705035976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VDEi9SBFPHh0vp/V8tBDLP636oGPQipAnV/XqRFHXcQ=;
  b=WFoDZlAkis5wsC6SVU+NZDxcaErkn40BSpwkWfpen3jViYmwXRVhE64d
   z+4/5QgEbN3ymV8XZlYW1b0ZeYhjr15t2DqbTrZzF0CoitsDqByKciSJF
   +BJbPsKGwBWoyx9VTF8HstDyr1LvH7K7qgVJxL1EtrZLcItTXAimGZnpV
   z9FE0DBOU0zVXYP2beeVZfs6x66lcqbGiJV6Q3NPFWeMTlmAEj2wyqevN
   /EcpG7cQLDXlrC5nmGp6d6htdZO1wysfBq8lToMKUmvFOn4+LfnOAaE0+
   JEoP0O39jLpHk/sAseEvczjTf8nBm6sC38UjXj1mF4XDmrZN8aYrQNppr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409850150"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="409850150"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 21:06:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="651000806"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="651000806"
Received: from mabir-mobl.amr.corp.intel.com (HELO [10.209.115.16]) ([10.209.115.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 21:06:15 -0800
Message-ID: <0406e96b-56fc-d9bd-6ef8-88157ce64e1f@linux.intel.com>
Date:   Wed, 11 Jan 2023 21:06:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        treding@nvidia.com, jonathanh@nvidia.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vsethi@nvidia.com,
        linuxppc-dev@lists.ozlabs.org, sagar.tv@gmail.com
References: <20230111231033.GA1714672@bhelgaas>
 <880c4d3c-86d2-082c-bb58-8212adc67ff3@linux.intel.com>
 <4ddef2c9-44b6-4a08-dbeb-428cd0864c55@nvidia.com>
 <de13b6bd-813f-d0bb-3a92-ea1ad3db5d54@linux.intel.com>
 <4a764544-189f-65e0-7d77-84995299721d@nvidia.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <4a764544-189f-65e0-7d77-84995299721d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/11/23 8:59 PM, Vidya Sagar wrote:
> 
> 
> On 1/12/2023 9:18 AM, Sathyanarayanan Kuppuswamy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/11/23 7:33 PM, Vidya Sagar wrote:
>>> I think we still need bios option. For example, consider a system where BIOS needs to keep ECRC enabled for integrity reasons but if kernel doesn't want it for perf reasons, then, kernel can always use 'ecrc=off' option.
>>
>> I agree that "on" and "off" option makes sense. Since the kernel defaults ecrc setting to "bios", why again allow it as a command line option?
> 
> Agree. "on" and "off" are fine but "default" is redundant. Do you want me to push a change to remove that as part of this patch itself? I think
> it is more like a cleanup and should go separately.

IMO, the "bios" option cleanup and command line update from Bjorn can be in one patch, and your change could be a separate patch. But it is
up to you and Bjorn.

> 
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
