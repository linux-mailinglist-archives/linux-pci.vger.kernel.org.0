Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A899A753B38
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjGNMlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjGNMlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:41:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582D269F;
        Fri, 14 Jul 2023 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689338462; x=1720874462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kOKU0Oxxh2EfZONWCEwEiRbt3oUTbJJvsq5FBiKlLUE=;
  b=WLc2MOSX2pjMOz1yMPVBQxpF/nz5R2ILh4I1QBVarpiIghIbEosKECOB
   WaVj3Nc5cZ4/fuBJKLRHMDAyhaSCRI8fu6mJGRIa+cYZXlSjs5JOGqxJJ
   AfWL8ArWKI7QRsAPxzVNb8fXtPZIa6gz7mW3thVFFHwyA86z8EZorr9Ck
   a2xe7iQwxpd1loC1iAvciZ1eEsoAwvStN30V192/U5EvfnpNpffnNE7OP
   yY6hq1BIc/zM+qfuywAI4y18xWuxW5PiyQXuOJJ3KbahVPvMivWxl+EtP
   Bw+Dd9zx3F1n2yP8soGS65xy31UjoyzUNa7zDqGYiaWgh8pYB6llgIZcA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368103722"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="368103722"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812421841"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="812421841"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 05:40:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKI6S-002f1l-2H;
        Fri, 14 Jul 2023 15:40:56 +0300
Date:   Fri, 14 Jul 2023 15:40:56 +0300
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
Subject: Re: [PATCH v3 15/15] ASoC: Intel: sst: Convert to PCI device IDs
 defines
Message-ID: <ZLFCWKqiaJZhx6ci@smile.fi.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
 <20230714202457.423866-16-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714202457.423866-16-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 10:24:57PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header. BSW replaces CHV, as 0x22a8
> was added in PCI header as BSW ID for consistency, as they are same
> (similar) platforms. The ACPI IDs are used only internally and lower
> 16 bits uniquely define the device as vendor ID for Intel is 8086 for
> all of them. Use PCI_DEVICE_DATA() to match PCI device to be consistent
> with other Intel audio drivers.

One nit-pick below, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	unsigned int		dev_id;
> +	unsigned short		dev_id;

Thinking more about this change I would probably add a comment on top of
sst_alloc_drv_context() call in sst_acpi.c to tell that in this case the
driver handles PCI IDs in ACPI and we are using only device ID part.
(If real ACPI ID appears, the kstrtouint() returns error, so we are fine
 with the change)

So, summarize above and add a comment.

-- 
With Best Regards,
Andy Shevchenko


