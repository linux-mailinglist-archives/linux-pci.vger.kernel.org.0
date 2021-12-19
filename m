Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A27479FF0
	for <lists+linux-pci@lfdr.de>; Sun, 19 Dec 2021 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhLSItT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Dec 2021 03:49:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:55569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhLSItT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Dec 2021 03:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639903759; x=1671439759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9DtOtcOa1nNCgYvBj5NsZNl2k2Q+7Los0wZBqYsoAi4=;
  b=Uu7EOrCvEBVZJPYKaoGeTYPvMQ8gbYCwxYMe033EZ+PozpqtJ3NqgMzI
   72b7umwwnbHCt8SW6rWd1KPCjSSi5GiBPNCbrb2nSbn6TDVR5n3fxA3Go
   fbIyx11iTbbcde9weV+ehUYLN9bVM0BLXmiK1v+PuAvN5lrIpmt3wDYfZ
   0rIT0kcTsEK6yYPfPfriqPD22/hLv/wvw/dXTpmG2TmOX//a9QlLP8X2D
   cp1bw3XGmIn4m5UjPthZYNnVdRIDGH+3WFPkyDsp3NPaE95Mk4czt5fGN
   ISzizvFPX+5sZe1Dcz20ToZxn4MGXaNfvI49yTRE1F31nMYoSmKuuKgfJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="220006360"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="220006360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 00:49:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="683896274"
Received: from prgreen-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.252.135.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 00:49:14 -0800
Date:   Sun, 19 Dec 2021 00:49:21 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        intel-gfx@lists.freedesktop.org, x86@kernel.org,
        linux-pci@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH V3] drm/i915/adl-n: Enable ADL-N platform
Message-ID: <20211219084921.lgd47srpzepspdpv@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211210051802.4063958-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87r1ab1huq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87r1ab1huq.fsf@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 17, 2021 at 03:27:57PM +0200, Jani Nikula wrote:
>On Fri, 10 Dec 2021, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
>> Adding PCI device ids and enabling ADL-N platform.
>> ADL-N from i915 point of view is subplatform of ADL-P.
>>
>> BSpec: 68397
>>
>> Changes since V2:
>> 	- Added version log history
>> Changes since V1:
>> 	- replace IS_ALDERLAKE_N with IS_ADLP_N - Jani Nikula
>>
>> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
>
>Cc: x86 maintainers & lists
>
>Ack for merging the arch/x86/kernel/early-quirks.c PCI ID update via
>drm-intel?
>
>I note not all such changes in git log have your acks recorded, though
>most do. Do you want us to be more careful about Cc'ing you for acks on
>PCI ID changes every time going forward?

That's what Borislav asked in
https://lore.kernel.org/all/20200520093025.GD1457@zn.tnic/

Lucas De Marchi

>
>BR,
>Jani.
>
>
>> ---
>>  arch/x86/kernel/early-quirks.c           | 1 +
>>  drivers/gpu/drm/i915/i915_drv.h          | 2 ++
>>  drivers/gpu/drm/i915/i915_pci.c          | 1 +
>>  drivers/gpu/drm/i915/intel_device_info.c | 7 +++++++
>>  drivers/gpu/drm/i915/intel_device_info.h | 3 +++
>>  include/drm/i915_pciids.h                | 6 ++++++
>>  6 files changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
>> index fd2d3ab38ebb..1ca3a56fdc2d 100644
>> --- a/arch/x86/kernel/early-quirks.c
>> +++ b/arch/x86/kernel/early-quirks.c
>> @@ -554,6 +554,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>>  	INTEL_RKL_IDS(&gen11_early_ops),
>>  	INTEL_ADLS_IDS(&gen11_early_ops),
>>  	INTEL_ADLP_IDS(&gen11_early_ops),
>> +	INTEL_ADLN_IDS(&gen11_early_ops),
>>  	INTEL_RPLS_IDS(&gen11_early_ops),
>>  };
>>
>> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
>> index a0f54a69b11d..b2ec85a3e40a 100644
>> --- a/drivers/gpu/drm/i915/i915_drv.h
>> +++ b/drivers/gpu/drm/i915/i915_drv.h
>> @@ -1283,6 +1283,8 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
>>  	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G11)
>>  #define IS_ADLS_RPLS(dev_priv) \
>>  	IS_SUBPLATFORM(dev_priv, INTEL_ALDERLAKE_S, INTEL_SUBPLATFORM_RPL_S)
>> +#define IS_ADLP_N(dev_priv) \
>> +	IS_SUBPLATFORM(dev_priv, INTEL_ALDERLAKE_P, INTEL_SUBPLATFORM_N)
>>  #define IS_HSW_EARLY_SDV(dev_priv) (IS_HASWELL(dev_priv) && \
>>  				    (INTEL_DEVID(dev_priv) & 0xFF00) == 0x0C00)
>>  #define IS_BDW_ULT(dev_priv) \
>> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
>> index 708a23415e9c..6a19e9da53cc 100644
>> --- a/drivers/gpu/drm/i915/i915_pci.c
>> +++ b/drivers/gpu/drm/i915/i915_pci.c
>> @@ -1132,6 +1132,7 @@ static const struct pci_device_id pciidlist[] = {
>>  	INTEL_RKL_IDS(&rkl_info),
>>  	INTEL_ADLS_IDS(&adl_s_info),
>>  	INTEL_ADLP_IDS(&adl_p_info),
>> +	INTEL_ADLN_IDS(&adl_p_info),
>>  	INTEL_DG1_IDS(&dg1_info),
>>  	INTEL_RPLS_IDS(&adl_s_info),
>>  	{0, 0, 0}
>> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
>> index a3446a2abcb2..54944d87cd3c 100644
>> --- a/drivers/gpu/drm/i915/intel_device_info.c
>> +++ b/drivers/gpu/drm/i915/intel_device_info.c
>> @@ -170,6 +170,10 @@ static const u16 subplatform_portf_ids[] = {
>>  	INTEL_ICL_PORT_F_IDS(0),
>>  };
>>
>> +static const u16 subplatform_n_ids[] = {
>> +	INTEL_ADLN_IDS(0),
>> +};
>> +
>>  static const u16 subplatform_rpls_ids[] = {
>>  	INTEL_RPLS_IDS(0),
>>  };
>> @@ -210,6 +214,9 @@ void intel_device_info_subplatform_init(struct drm_i915_private *i915)
>>  	} else if (find_devid(devid, subplatform_portf_ids,
>>  			      ARRAY_SIZE(subplatform_portf_ids))) {
>>  		mask = BIT(INTEL_SUBPLATFORM_PORTF);
>> +	} else if (find_devid(devid, subplatform_n_ids,
>> +				ARRAY_SIZE(subplatform_n_ids))) {
>> +		mask = BIT(INTEL_SUBPLATFORM_N);
>>  	} else if (find_devid(devid, subplatform_rpls_ids,
>>  			      ARRAY_SIZE(subplatform_rpls_ids))) {
>>  		mask = BIT(INTEL_SUBPLATFORM_RPL_S);
>> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
>> index 213ae2c07126..e341d90f28a2 100644
>> --- a/drivers/gpu/drm/i915/intel_device_info.h
>> +++ b/drivers/gpu/drm/i915/intel_device_info.h
>> @@ -113,6 +113,9 @@ enum intel_platform {
>>  /* ADL-S */
>>  #define INTEL_SUBPLATFORM_RPL_S	0
>>
>> +/* ADL-P */
>> +#define INTEL_SUBPLATFORM_N    0
>> +
>>  enum intel_ppgtt_type {
>>  	INTEL_PPGTT_NONE = I915_GEM_PPGTT_NONE,
>>  	INTEL_PPGTT_ALIASING = I915_GEM_PPGTT_ALIASING,
>> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
>> index baf3d1d3d566..533890dc9da1 100644
>> --- a/include/drm/i915_pciids.h
>> +++ b/include/drm/i915_pciids.h
>> @@ -666,6 +666,12 @@
>>  	INTEL_VGA_DEVICE(0x46C2, info), \
>>  	INTEL_VGA_DEVICE(0x46C3, info)
>>
>> +/* ADL-N */
>> +#define INTEL_ADLN_IDS(info) \
>> +	INTEL_VGA_DEVICE(0x46D0, info), \
>> +	INTEL_VGA_DEVICE(0x46D1, info), \
>> +	INTEL_VGA_DEVICE(0x46D2, info)
>> +
>>  /* RPL-S */
>>  #define INTEL_RPLS_IDS(info) \
>>  	INTEL_VGA_DEVICE(0xA780, info), \
>
>-- 
>Jani Nikula, Intel Open Source Graphics Center
