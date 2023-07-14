Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C707753B48
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGNMqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGNMqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:46:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D8CE;
        Fri, 14 Jul 2023 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689338805; x=1720874805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wgu458RtWJFWnO7skXaA0azj0Qi3toRihxTlRUl23kM=;
  b=jXF3l/6x2hRZR6daRJje4f+eunNdmaEeQyenyVcC1rvegvjgkLAo/HKp
   n5hXh16nmyPdU0BvVfKv+v/2mM5cCIqaCM5C5bvh7+AEmK073t2O/gsMy
   mCOmZiJyfEo8VKfBPHWliOU3xoQivgdsfidSPKOW0L67c/7Je2//VnH8O
   tvOov8oC+2UJ7STGWnpyYBhxMiZKBPo1rRRrZiPasDRmO5fopAqfp4bcH
   AAHF3qpWLwxLNlHf9jg9ZhNLQ7SpgFeb0JhhSzPsqq0idLwV12ddCPvMv
   dCgyxlsdqzWiVXQvs9pX/wFS/1tz9W/VQsq3qDG7XeY0JO3x4YXqu7kJo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431638399"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="431638399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716326313"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="716326313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 05:46:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKIBo-002f6O-2G;
        Fri, 14 Jul 2023 15:46:28 +0300
Date:   Fri, 14 Jul 2023 15:46:28 +0300
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
Subject: Re: [PATCH v3 03/15] ASoC: SOF: Remove unused Broxton PCI ID
Message-ID: <ZLFDpIfWG5YiWZvO@smile.fi.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
 <20230714202457.423866-4-amadeuszx.slawinski@linux.intel.com>
 <ZLFBBzmJXgXeWZ0y@smile.fi.intel.com>
 <a23f2c59-34a7-f5d0-f2a2-44364fc1e37c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a23f2c59-34a7-f5d0-f2a2-44364fc1e37c@linux.intel.com>
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

On Fri, Jul 14, 2023 at 02:44:06PM +0200, Amadeusz Sławiński wrote:
> On 7/14/2023 2:35 PM, Andy Shevchenko wrote:
> > On Fri, Jul 14, 2023 at 10:24:45PM +0200, Amadeusz Sławiński wrote:

...

> > >   sound/hda/intel-dsp-config.c  | 7 -------
> > >   sound/soc/sof/intel/pci-apl.c | 2 --
> > 
> > I dunno how SOF and HDA are related to each other, but in the next patch you
> > also do something about HDA, either group all of them, or split HDA, or split
> > on per file basis. I'm not familiar with the relationship between them up to
> > you which way you choose.
> > 
> 
> Well SOF is a DSP driver, so that's why I split it from HDA -
> intel-dsp-config.c file is used to perform checks to know if it should load
> DSP driver (and which one), hence the "weird" split.

Ah, okay that explains!

-- 
With Best Regards,
Andy Shevchenko


