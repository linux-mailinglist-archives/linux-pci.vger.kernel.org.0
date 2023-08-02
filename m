Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631E76D36C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjHBQK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHBQKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 12:10:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D21BE4
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690992654; x=1722528654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aRvPKihYU01ClMmJrv3NjPtCS5U5U3Y4gLPnfM64+LI=;
  b=Ent/yhh672gRR4N/e0KSSRA0AaaQuNHj+4a5y6H5opQdw7sX9z/R53v+
   PLLcvO1SAnbMZ/JlA2bn+6OdOct7kfxnLo+1W8pC9VulCMdMEDFHIMZTP
   ifnHWswOS/0tCZRHEA11EOyng/9fiR4y5jtkwcKsqx9YkPRZ2t+l9DICU
   rTeZ5bdvE9aXJIAggeBpGy9LFoPerY1gJp7G4n0sIGB+OIHbG1OYiHrQB
   gYfo3o2jRA0jQthS6IltVMBdAwba4izMHmnKDicgZOXh77Picw5G/7ogy
   m0Ba3YO4UWziTOszbnGEXzkVXTEc2YhN/spFBMjUy6zlVAEpX8J9pnx1P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359663601"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="359663601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706226139"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="706226139"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO [10.212.125.114]) ([10.212.125.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:07:36 -0700
Message-ID: <206f5a15-29f0-ec7c-1b85-50ace8ae7c2f@linux.intel.com>
Date:   Wed, 2 Aug 2023 11:07:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] PCI: add ArrowLake-S PCI ID for Intel HDAudio
 subsystem.
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230802150105.24604-2-pierre-louis.bossart@linux.intel.com>
 <20230802155226.GA59821@bhelgaas> <87fs51cu86.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87fs51cu86.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/23 10:57, Takashi Iwai wrote:
> On Wed, 02 Aug 2023 17:52:26 +0200,
> Bjorn Helgaas wrote:
>>
>> On Wed, Aug 02, 2023 at 10:01:01AM -0500, Pierre-Louis Bossart wrote:
>>> Add part ID to common include file
>>
>> Please drop period at end of subject and add one at the end of the
>> commit log.
>>
>> Also mention the drivers that will use this new #define; looks like
>> hda_intel.c and ...
>>
>> Well, actually, I only see that one use, which means we probably
>> shouldn't add this #define to pci_ids.h, per the comment at the top of
>> the file.  If there's only one use, use the hex ID in the driver (or
>> add a #define in the driver itself).
> 
> Judging from the previous patterns, the same ID could be required for
> ASoC SOF driver, too, which isn't included in this patch set.  In
> that case, it's worth to put to pci_ids.h.
> (OTOH, it can be done at a later stage, too.)

I am not following. we just agreed a couple of weeks ago to record ALL
Intel/HDaudio PCI IDs in the same pci_ids.h include file.

ArrowLake-S is the first addition to first file after the work done by
Cezary/Amadeusz. Yes it's required to be added since it'll be used in
other parts later on. But even if there was ONE use of this PCI ID, why
would we not add it for consistency to the global pci_ids.h file?
Takashi's hda_intel.c file would look really bad if we have a mix of
single-use PCIs and shared ones...

Oh and heads-up that I have a change for LunarLake that will require
Mark to pull the branch from Takashi :-)
