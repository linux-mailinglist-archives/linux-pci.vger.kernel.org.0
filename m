Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5C750D23
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGLPxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGLPxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 11:53:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A01BD4;
        Wed, 12 Jul 2023 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177221; x=1720713221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JyJLilC7lSpSEXwLkk2Nl0wlhmfEXlOLLuDZFu3Vyj4=;
  b=LlGe8hT6Be3025Jy/puWuho4C2+WxnOpoyTsEXyUl1j1H6zjuTnEyrsB
   vZXjGiRVbyLxM/Zt+ViRNWW7tKft/5kEBvBcmh+bpwCETgHf9Un4hE5Hq
   xG1an83yxIjbsWknLK5+hSyklAmJizy1qUyEQUBCjbsxp7awp+uKjmHCm
   wLjoeEoU055OrKSXfWxPkKGlsMvMjXl9yS+zeBE9Pm3qEgKtDwO56j462
   U7GHHf+h0J9+PDlG+v7l7737wS8xT46+pdldzM4iv7mwHNRjJU3N3ZmML
   VnyJGWHfk2hdhbeYrISoyArVnUGjvqHRkxBVlG348qab7aXZoUHr7+UY+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362391803"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="362391803"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895674100"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="895674100"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2023 08:53:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJc9o-002AZF-0w;
        Wed, 12 Jul 2023 18:53:36 +0300
Date:   Wed, 12 Jul 2023 18:53:36 +0300
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
Subject: Re: [PATCH 12/13] ASoC: SOF: Intel: Convert to PCI device IDs defines
Message-ID: <ZK7MgNH7KM7rHris@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-13-amadeuszx.slawinski@linux.intel.com>
 <ZK1kPXm+FieJ+vya@smile.fi.intel.com>
 <ec6a8f88-ae94-21a5-ec01-013c68fd8feb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec6a8f88-ae94-21a5-ec01-013c68fd8feb@linux.intel.com>
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

On Wed, Jul 12, 2023 at 02:16:17PM +0200, Amadeusz Sławiński wrote:
> On 7/11/2023 4:16 PM, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 02:57:25PM +0200, Amadeusz Sławiński wrote:

...

> > Oh, additional remark below.

> > > +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
> > > +	{ PCI_DEVICE_DATA(INTEL, HDA_APL_T, &bxt_desc) },
> > 
> > Have we ever had APL-T? What is that? I remember that we have had two or
> > three BXTs inside, and then products become for Broxton and Apollo Lake
> > SoC codenames. I never have heard about -T...
> 
> I've talked a bit with Cezary and it seems that 0x1a98 is BXT-M (not -T) and
> it's an RVP, BXT-M B0 to be specific. From what we know no BXT is available
> on market. Perhaps we can just remove it?

If you go this way, it should be in a separate patch and it seems it has
already pre-cooked commit message (as per previous paragraph) :-)

-- 
With Best Regards,
Andy Shevchenko


