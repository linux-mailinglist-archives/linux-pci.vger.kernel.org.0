Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276F57421FB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjF2IVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF2IUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 04:20:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5A1FFA;
        Thu, 29 Jun 2023 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688026736; x=1719562736;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nZeawW1oMN2HuGCf+TgAnAiNf1H7F95ZCg0NNjoviRI=;
  b=AcInyjof8vSX9VG0LJ0MS50C95n4MLOGfaJ1kDwB/ZvcJwsGmtiValQu
   khiQUoY+gZ6WGHhlhy+L+ZYnn81z236js3/fvJ/PM3+GawTVq8/D+m5HZ
   2xOU+fOCT2k1IEJG3bMyOZZi4vSBdVDQAFmY+qLIW109N/KP9x6jwwUcT
   mnHHInzsY1SFnhRziOtf/rnkDn5yFeV+LiVYKApFQXXQgSKCuBedo/CW5
   8rSUI/4lxPbc8j7rbMLWtb8cQKWXnqw3EyZfZGrYUEu5CTz8MawbU75tz
   3lu1FKYL9lcmvFuQ/1YxlXo8SU8HuO2R19Oa5m8gH2gEdDoJQTGJie4WP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351854300"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351854300"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891331178"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="891331178"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:18:53 -0700
Message-ID: <a7bf3aaa-581d-0625-5f18-6b9b062ea48d@linux.intel.com>
Date:   Thu, 29 Jun 2023 10:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [RFC PATCH 1/8] PCI: Add Intel Audio DSP devices to pci_ids.h
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-2-amadeuszx.slawinski@linux.intel.com>
 <ZJxHTHCq0T/y+dG0@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <ZJxHTHCq0T/y+dG0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/28/2023 4:44 PM, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 10:51:28PM +0200, Amadeusz Sławiński wrote:
>> Those IDs are mostly sprinkled between HDA, Skylake, SOF and avs drivers.
>> Almost every use contains additional comments to identify to which
>> platform those IDs refer to. Add those IDs to pci_ids.h header, so that
>> there is one place which defines those names.
> 
> ...
> 
>>   #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
>>   #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
>> +#define PCI_DEVICE_ID_INTEL_HDA_JSL_N	0x4dc8
>> +#define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
>> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
>> +#define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
> 
> Can it be kept sorted by a value?
> 
> Didn't check the full list, though.
> 

My mistake, I've tried to add them in order, but must have missed this 
one, will review whole list again.
