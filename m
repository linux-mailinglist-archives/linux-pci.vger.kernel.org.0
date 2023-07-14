Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152D475396A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjGNLUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNLUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:20:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568D2D63;
        Fri, 14 Jul 2023 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333630; x=1720869630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TWbTERSN9sck8s9p2NkrzXtIVeCq+h7as7v69ZZ4WlY=;
  b=RW6C2LF7fh3ymFSxDdfO6UxcSHLmN8XVDFy09q+wcNWFqf/yFrm8uzq4
   hRSAksRU0RASksHPPB2aoKx1hglHtQgOcoN1g932o6Xxqx86Qt+HRLegG
   BmEEKmVdBzC0jW5jfWQIsWGKnfBOCf8d1Z0Xd53Bt/ETPoxCZFregvsBe
   +Jk5eUmMn5Kz+kQgI/g9HN8T1ZnLafWRLtUzA6iBlM9gFa3/aAlzy/DzU
   NfCYakEYMCBrAasfwPPhkmpW+yDEeHpuOCyhwAwx7qoDoLtbtIflFBJfz
   CC+/eIeUWLCGnQDkLMR+5vGeryrKCS1v0Ykrr6CfMfT27DAsbb9G2BGR2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431622432"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="431622432"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896388420"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="896388420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2023 04:20:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKGqF-002dxf-0y;
        Fri, 14 Jul 2023 14:20:07 +0300
Date:   Fri, 14 Jul 2023 14:20:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v2 07/15] ALSA: hda/i915:  Use global PCI match macro
Message-ID: <ZLEvZ3Ss05A+x1ty@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-8-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714185615.370597-8-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 08:56:07PM +0200, Amadeusz Sławiński wrote:
> Instead of using local macro to match PCI device, use global one.

...

> @@ -2718,7 +2718,6 @@
>  #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
>  #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
>  #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
> -#define PCI_DEVICE_ID_INTEL_HDA_APL_T	0x1a98
>  #define PCI_DEVICE_ID_INTEL_HDA_CPT	0x1c20
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f

Looks like it should be a separate change.

-- 
With Best Regards,
Andy Shevchenko


