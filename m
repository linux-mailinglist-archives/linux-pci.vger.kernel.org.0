Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6092F7507EE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 14:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGLMQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjGLMQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 08:16:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF51BFA;
        Wed, 12 Jul 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689164183; x=1720700183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+tlum6euBaSBSYRCVrhu1uXmmTQNXoNiIGldL0XknoY=;
  b=iU+m2wSSJO193dl2juVgi/UO744S25s9OY2fH6Z75GkYyuOJcYM/mglW
   2FpFOhefrxt99+xiSCGJiSi4M/KCq3ui1oSr7jnVJoORvyzqKrsQyuQjw
   Ca95AXHqce+/3JQVLGbZrJAVj1gyhNzY9xXNXDctuH7nGIUC/gEPSemN+
   QUyuwSMvfS6kx87Qtrwl/gxt0ZtX+G1XpXl4S5CXb7mEkJYYbx6OPK0Ca
   dR4KjNpzhJkNifB7JjwEWggpR71YG33MBy1+hC4Md1ocvz4RdOuLCPvnF
   pfe0c6GsaUgaOGMyqjSISnr4kOiLM6tIao233+qMcgnWo4IEnXyn7iLUn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428610619"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="428610619"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 05:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811551375"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="811551375"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 05:16:19 -0700
Message-ID: <ec6a8f88-ae94-21a5-ec01-013c68fd8feb@linux.intel.com>
Date:   Wed, 12 Jul 2023 14:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/13] ASoC: SOF: Intel: Convert to PCI device IDs defines
Content-Language: en-US
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
 <20230711125726.3509391-13-amadeuszx.slawinski@linux.intel.com>
 <ZK1kPXm+FieJ+vya@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1kPXm+FieJ+vya@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/2023 4:16 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:25PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header and while at it change to using
>> PCI_DEVICE_DATA() macro, to simplify declarations.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Oh, additional remark below.
> 
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/soc/sof/intel/pci-apl.c |  9 +++----
>>   sound/soc/sof/intel/pci-cnl.c | 15 ++++--------
>>   sound/soc/sof/intel/pci-icl.c | 12 ++++------
>>   sound/soc/sof/intel/pci-mtl.c |  3 +--
>>   sound/soc/sof/intel/pci-skl.c |  6 ++---
>>   sound/soc/sof/intel/pci-tgl.c | 45 ++++++++++++-----------------------
>>   sound/soc/sof/intel/pci-tng.c |  3 +--
>>   7 files changed, 31 insertions(+), 62 deletions(-)
>>
>> diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
>> index 69cad5a6bc72..083659ddfe6b 100644
>> --- a/sound/soc/sof/intel/pci-apl.c
>> +++ b/sound/soc/sof/intel/pci-apl.c
>> @@ -85,12 +85,9 @@ static const struct sof_dev_desc glk_desc = {
>>   
>>   /* PCI IDs */
>>   static const struct pci_device_id sof_pci_ids[] = {
>> -	{ PCI_DEVICE(0x8086, 0x5a98), /* BXT-P (ApolloLake) */
>> -		.driver_data = (unsigned long)&bxt_desc},
>> -	{ PCI_DEVICE(0x8086, 0x1a98),/* BXT-T */
>> -		.driver_data = (unsigned long)&bxt_desc},
>> -	{ PCI_DEVICE(0x8086, 0x3198), /* GeminiLake */
>> -		.driver_data = (unsigned long)&glk_desc},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL_T, &bxt_desc) },
> 
> Have we ever had APL-T? What is that? I remember that we have had two or
> three BXTs inside, and then products become for Broxton and Apollo Lake
> SoC codenames. I never have heard about -T...
> 

I've talked a bit with Cezary and it seems that 0x1a98 is BXT-M (not -T) 
and it's an RVP, BXT-M B0 to be specific. From what we know no BXT is 
available on market. Perhaps we can just remove it?


