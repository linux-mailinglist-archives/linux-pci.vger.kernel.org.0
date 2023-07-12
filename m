Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283D750805
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGLMUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGLMUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 08:20:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0826A7;
        Wed, 12 Jul 2023 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689164412; x=1720700412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aHYcX/RpGX8NgxBuDMZyXS2bZgmbpwPq0YBcwOhVdKI=;
  b=l41VQkqIFAMZ2oOYilNjxoui0QN2ESHzvxiCiOEhQh39VS0wH34U5Fw0
   f+8O5fJiYE/L3cboBYjJSA9CP1s/4r0Cv9ckZ7EDJxt59y1F53pUMXur8
   r7oAFkekR8aSXSF0LYYGfGP4ObyfRLVIqc8oUjSjifCd9qni6GIbN+Jd8
   LRkbyLBcdhomyItutaXzvH4+W8ZvuM6QruhMRoiUk9zYF0rBMFNwlt+oE
   8txB/HJt+AKVD1zaRcEsD4yYoadGTOH4SyzwPbt8q484JFPQM75lG0HXp
   oqxL7csNKBYs+wjQ3DKBKV9EVJknp7/sRwJkMp07npyfq6G1XeSnhGNjg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431007174"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="431007174"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 05:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052168447"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="1052168447"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 05:19:50 -0700
Message-ID: <958f3638-f68a-ebec-29cc-816f823b017f@linux.intel.com>
Date:   Wed, 12 Jul 2023 14:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/13] ASoC: Intel: sst: Convert to PCI device IDs defines
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
 <ZK1oKYW0rro4FnNO@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1oKYW0rro4FnNO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/2023 4:33 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:26PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header.
> 
> ...
> 
>>   	switch (sst->dev_id) {
>> -	case SST_MRFLD_PCI_ID:
>> +	case PCI_DEVICE_ID_INTEL_ADSP_TNG:
>>   	case SST_BYT_ACPI_ID:
>>   	case SST_CHV_ACPI_ID:
> 
> I think this needs a bit more, i.e. replacing the rest with respective PCI IDs.
> 
> All three will be defined with SST prefix, which makes sense to me.
> 
> ACPI here is a bit misleading, but correct. The ACPI specification assumes that
> respective part of the ID space covers 100% of PCI ID space.
> 
> I have briefly checked the code and it seems that ID is used externally only
> for PCI case, so we may simply use the lower 16 bits of the ACPI _HID for the
> context.
> 

Do I understand correctly that I should just do:
#define PCI_DEVICE_ID_INTEL_SST_BYT	0x0F28
#define PCI_DEVICE_ID_INTEL_SST_CHV	0x22A8
and use those IDs instead?

> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index a0d29510d2bc..b1f59604d825 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -222,7 +222,7 @@ static void sst_init_locks(struct intel_sst_drv *ctx)
>   }
>   
>   int sst_alloc_drv_context(struct intel_sst_drv **ctx,
> -		struct device *dev, unsigned int dev_id)
> +		struct device *dev, unsigned short dev_id)
>   {
>   	*ctx = devm_kzalloc(dev, sizeof(struct intel_sst_drv), GFP_KERNEL);
>   	if (!(*ctx))
> diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
> index 4d37d39fd8f4..c04f033e1d5f 100644
> --- a/sound/soc/intel/atom/sst/sst.h
> +++ b/sound/soc/intel/atom/sst/sst.h
> @@ -358,7 +358,7 @@ struct sst_fw_save {
>   struct intel_sst_drv {
>   	int			sst_state;
>   	int			irq_num;
> -	unsigned int		dev_id;
> +	unsigned short		dev_id;
>   	void __iomem		*ddr;
>   	void __iomem		*shim;
>   	void __iomem		*mailbox;
> @@ -523,7 +523,7 @@ int sst_register(struct device *);
>   int sst_unregister(struct device *);
>   
>   int sst_alloc_drv_context(struct intel_sst_drv **ctx,
> -		struct device *dev, unsigned int dev_id);
> +		struct device *dev, unsigned short dev_id);
>   int sst_context_init(struct intel_sst_drv *ctx);
>   void sst_context_cleanup(struct intel_sst_drv *ctx);
>   void sst_configure_runtime_pm(struct intel_sst_drv *ctx);
> 
> ...
> 
>>   /* driver names */
>>   #define SST_DRV_NAME "intel_sst_driver"
> 
>> -#define SST_MRFLD_PCI_ID 0x119A
>>   #define SST_BYT_ACPI_ID	0x80860F28
>>   #define SST_CHV_ACPI_ID	0x808622A8
> 
> And kill all three!
> 

