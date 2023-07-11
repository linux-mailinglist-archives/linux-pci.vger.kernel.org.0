Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389474F15E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjGKON0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjGKONY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:13:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF710B0;
        Tue, 11 Jul 2023 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084803; x=1720620803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RiocU3lLiq+39RFXSqs6p/cZudPc+izr4AUqqHXXmmI=;
  b=ATDNh99c7/c2vBocNEiTyoQLo84BisJGmoDql8ZOISv88S5/5Shqcsb5
   vpiE3EIyprLZTKtCn/hI5TrxnYeapvGk5tB8ZcnZQLtPPCSNv17hkKeJG
   gjXadmjrJ9AuBmA35wcOM7GjgctXKd7Jy4fDhxHYRLpX0bd4OvI3ue5gS
   adg6IXMXqZZclTnWk6jBaPFfy7ZZGbqsPe/BW3/mIaooZDhfChU2ix3o3
   4kO6ovmf5Zhd9fj8LRcTR1kcPX+sao9ZAyJilaR/E2rLgFMWkxxcjK55R
   0+azcvYFZ4eqXcoGSRy7Gvh8+JupcMnjGFsGmcxYcqT3JmZLcIRISzXdL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395414831"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="395414831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834716022"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834716022"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:13:19 -0700
Message-ID: <1840b0c5-81aa-488c-1fbe-ac6681e3df35@linux.intel.com>
Date:   Tue, 11 Jul 2023 16:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/13] ASoC: Intel: avs: Convert to PCI device IDs defines
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
 <20230711125726.3509391-11-amadeuszx.slawinski@linux.intel.com>
 <ZK1iiMgmjpCA02x+@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1iiMgmjpCA02x+@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/2023 4:09 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:23PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY() macro,
>> so device ID can be provided in short form.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/soc/intel/avs/board_selection.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
>> index 60f8fb0bff95..b32e02940e30 100644
>> --- a/sound/soc/intel/avs/board_selection.c
>> +++ b/sound/soc/intel/avs/board_selection.c
>> @@ -263,14 +263,14 @@ struct avs_acpi_boards {
>>   };
>>   
>>   #define AVS_MACH_ENTRY(_id, _mach) \
>> -	{ .id = (_id), .machs = (_mach), }
>> +	{ .id = PCI_DEVICE_ID_INTEL_##_id, .machs = (_mach), }
>>   
>>   /* supported I2S boards per platform */
>>   static const struct avs_acpi_boards i2s_boards[] = {
>> -	AVS_MACH_ENTRY(0x9d70, avs_skl_i2s_machines), /* SKL */
>> -	AVS_MACH_ENTRY(0x9d71, avs_kbl_i2s_machines), /* KBL */
>> -	AVS_MACH_ENTRY(0x5a98, avs_apl_i2s_machines), /* APL */
>> -	AVS_MACH_ENTRY(0x3198, avs_gml_i2s_machines), /* GML */
>> +	AVS_MACH_ENTRY(HDA_SKL_LP, avs_skl_i2s_machines),
>> +	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
>> +	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
>> +	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),
> 
> Maybe sort them by name?

They are sorted by generation.

