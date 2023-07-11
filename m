Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620E874F161
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjGKONX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGKONW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:13:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8D10E7;
        Tue, 11 Jul 2023 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689084795; x=1720620795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=s9hiWJGhbB7fHM+elndbClDFNGnHDKG9q2O/XYVM/wE=;
  b=i9/HC9BfxqPtKnH+SzP6WpGNr+LU2XoNjoqB2vpi1SQayer63kKiZiyX
   B74rnhMmunMo6Q1X+FMt2rusOH7gxlZwzDPGDg/iHvJspl7kpsYvHp+FK
   ZhozxXykkz2EV64E5cqzWjGyfFM15NhJUfr9jGoPZDjLGwPs9Xv4ksf+S
   jsm/WpkgrAsOf0A8u/JihZYLJbuMu6WNU/V2U8y3uISVWMwuTmxqKMeZb
   KFpkKHpxj7X4aDSR/qgHbSaIS4olhkty7ZTgNilDlRm1+GGk34ow+Dv7d
   u4ZR1aybVnZxOrrFsrqrP2bno6JhkwETq5gB5vh+nbXMOPqTPZe92D85A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344225910"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344225910"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1051800428"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="1051800428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 07:12:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJE6j-001s0S-37;
        Tue, 11 Jul 2023 17:12:49 +0300
Date:   Tue, 11 Jul 2023 17:12:49 +0300
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
Subject: Re: [PATCH 07/13] ALSA: intel-dsp-config: Convert to PCI device IDs
 defines
Message-ID: <ZK1jYdMxO4vUFmhw@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-8-amadeuszx.slawinski@linux.intel.com>
 <ZK1gaER7n4JUjIeW@smile.fi.intel.com>
 <86dbdeeb-cc2b-59f7-eabb-6282799a3d32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86dbdeeb-cc2b-59f7-eabb-6282799a3d32@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 04:09:42PM +0200, Amadeusz Sławiński wrote:
> On 7/11/2023 4:00 PM, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 02:57:20PM +0200, Amadeusz Sławiński wrote:

...

> > > -		.device = 0x119a,
> > > +		.device = PCI_DEVICE_ID_INTEL_ADSP_TNG,
> > 
> > Yeah, somebody familiar with Intel history of SST/HDA/wtf should really
> > tell why HDA code is using this ID. Does it mean that SST implies HDA
> > always? Only for this (or this family of) platform?
> > 
> > It might affect the ID naming, but otherwise it's orthogonal to the series.
> > 
> 
> There were few early devices where DSP was separate unit:
> Haswell, Broadwell - where we use ACPI to load (SND_SOC_INTEL_CATPT) audio
> driver, Tangier/Merrifield - where ACPI or PCI is used to load
> (SND_SST_ATOM_HIFI2_PLATFORM_PCI) audio driver.
> All further generations are HDA devices with integrated DSP. This causes all
> the weirdness ;)

Maybe we should stick with SST in the name? At least that's how Tangier TRM
titles it.

-- 
With Best Regards,
Andy Shevchenko


