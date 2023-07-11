Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1907274F143
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjGKOKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKOKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:10:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E5B0;
        Tue, 11 Jul 2023 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084629; x=1720620629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZJckkFcdQ46lGeHOGwt24YBZGL/HoGzzm/IkMebPc/U=;
  b=LmMYCvt+gKDQ4YFhxx49di8PIcHELd6WJR7ZwQlYDLIs73fXONX9g4os
   cqrhfIu8OjSwUb867j5pM2dP1MEBbYZ0i2eWfQoC82/X2Uck2AlnY8O5s
   j3wtz/UaxiL3vCMpd7eMa5g3tUj1h+bfzMB+mAYcm4Xx1GdcKeHCC2hLU
   QaNok+OlgrFQ7ahn9LysC+WnLd8FPwA9+r435d51icWAHiMB6dmAkua3I
   AjWqeea4kyjvvnBLbwxMAbS9MhPCmpDlGMyj7RKsxOGf+UahKRVY1h8v3
   5qNFqklUjiv/uebO7shK71/Gobk3Zf4W8zBtmGKVWdGadQYnkpU9hBRAZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367206850"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367206850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811209493"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="811209493"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:09:46 -0700
Message-ID: <86dbdeeb-cc2b-59f7-eabb-6282799a3d32@linux.intel.com>
Date:   Tue, 11 Jul 2023 16:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/13] ALSA: intel-dsp-config: Convert to PCI device IDs
 defines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-8-amadeuszx.slawinski@linux.intel.com>
 <ZK1gaER7n4JUjIeW@smile.fi.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1gaER7n4JUjIeW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/11/2023 4:00 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:20PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header. Also simplify comments for
>> Alder Lake and Raptor Lake platforms, as new IDs make it clear what
>> revision is in use.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # for Intel Tangier ID
> 
> One remark below.
> 
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/hda/intel-dsp-config.c | 119 ++++++++++++++++-------------------
>>   1 file changed, 55 insertions(+), 64 deletions(-)
>>
>> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
>> index 317bdf6dcbef..2a71fa5ffec1 100644
>> --- a/sound/hda/intel-dsp-config.c
>> +++ b/sound/hda/intel-dsp-config.c
>> @@ -50,14 +50,14 @@ static const struct config_entry config_table[] = {
>>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
>>   	{
>>   		.flags = FLAG_SOF,
>> -		.device = 0x119a,
>> +		.device = PCI_DEVICE_ID_INTEL_ADSP_TNG,
> 
> Yeah, somebody familiar with Intel history of SST/HDA/wtf should really
> tell why HDA code is using this ID. Does it mean that SST implies HDA
> always? Only for this (or this family of) platform?
> 
> It might affect the ID naming, but otherwise it's orthogonal to the series.
> 

There were few early devices where DSP was separate unit:
Haswell, Broadwell - where we use ACPI to load (SND_SOC_INTEL_CATPT) 
audio driver, Tangier/Merrifield - where ACPI or PCI is used to load 
(SND_SST_ATOM_HIFI2_PLATFORM_PCI) audio driver.
All further generations are HDA devices with integrated DSP. This causes 
all the weirdness ;)

