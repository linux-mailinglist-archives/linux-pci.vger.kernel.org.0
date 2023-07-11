Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B574F042
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGKNgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGKNgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:36:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45529E6F;
        Tue, 11 Jul 2023 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689082574; x=1720618574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=524GPqhKA4PY07IMonLbtpmWvOSiTrizz3nlKdExsX0=;
  b=TwazSGNX+DBB9RtpsqM1J1VVDkXNiRBD6nAffTi3bs5XV35q1hs+zcQ4
   gjoUuZMkAkAXLQHwEt9Jt6OV2pbrxYfS7ABwZz9lr18psmaFd3+Y4vxZm
   rILOSps7eLd0pq7t8cBAQ5s1FP/7zQnffNynLBSyYWxAotxq4Ufbxjg7g
   2uQ8XlrZ7vZeSZcb0/ZN45W5+K+guQPek8LV7W5q7Wq5s35nqC+vc0XTf
   84a4ssafuELOG8tUx7K+IbOJ65MSS8D00vKsiXK5Xw2hPrxHFrE3zeoho
   Y6lAbcVPFrP49SHpBQmiRi7YWmREJx1x616XEeAiZuZ9/mNUOWL7VVU8I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="364656338"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="364656338"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724436510"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="724436510"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2023 06:36:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJDXF-001rTm-0r;
        Tue, 11 Jul 2023 16:36:09 +0300
Date:   Tue, 11 Jul 2023 16:36:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/13] ALSA: hda: Add controller matching macros
Message-ID: <ZK1ayXcoTfIrr18V@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-4-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-4-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:16PM +0200, Amadeusz Sławiński wrote:
> Some HDA controllers require additional handling, so there are macros to
> match them, however those are spread across multiple files. Add them all
> in one place, so they can be reused.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One nit-pick below.

> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  include/sound/hdaudio.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index 2ffdf58bd6d4..aacacca456d5 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/iopoll.h>
> +#include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/timecounter.h>
>  #include <sound/core.h>
> @@ -704,4 +705,30 @@ static inline unsigned int snd_array_index(struct snd_array *array, void *ptr)
>  	for ((idx) = 0, (ptr) = (array)->list; (idx) < (array)->used; \
>  	     (ptr) = snd_array_elem(array, ++(idx)))
>  
> +/*
> + * Device matching
> + */
> +
> +#define HDA_CONTROLLER_IS_HSW(pci) (pci_match_id((struct pci_device_id []){ \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_0) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_2) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_HSW_3) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_BDW) }, \
> +			{ } \
> +		}, pci))
> +
> +#define HDA_CONTROLLER_IS_APL(pci) (pci_match_id((struct pci_device_id []){ \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_APL) }, \
> +			{ } \
> +		}, pci))
> +
> +#define HDA_CONTROLLER_IN_GPU(pci) (HDA_CONTROLLER_IS_HSW(pci) || \
> +		pci_match_id((struct pci_device_id []){ \

I think if you start with pci_match_id() and move HDA_CONTROLLER_IS_HSW() at
the end it will make this macro aligned with the rest, so easier to get them
all at once.

> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG1) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_0) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_1) }, \
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HDA_DG2_2) }, \
> +			{ } \
> +		}, pci))

-- 
With Best Regards,
Andy Shevchenko


