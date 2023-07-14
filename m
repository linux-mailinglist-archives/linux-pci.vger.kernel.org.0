Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA99753988
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjGNLch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjGNLce (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:32:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724853586;
        Fri, 14 Jul 2023 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334353; x=1720870353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vMiLtLLmLYbROtrWsVDVcXNKwbyBp9NtziuSigdu7S4=;
  b=jDSD6Vgdor66fKSfUUqXewXMEQKB3vGvHbz09LVumUzFzd2BeIJmOjhZ
   h3h0YYNNTOK+j8WsAl/YaNqRWthZg4av2Gi6+l9U2jFe9Vv+1vEO6kkZR
   GJIPFBDw3xaTzP1vlKpF7fJjkRXd93GLzn5BPTQ85dRhO7WQoIqxlmcZc
   7rL9lQ7nYqT7avrV2sVkKMEtm6PApfav2rUom3I5Lx2MrIsuSo2dy1HLw
   wd01i3F2J9k76DnPd8AMvEkLSYg8lUfmPp5d0xGt1De2Q2Rd+ElLspTkX
   2ayarqpYbQgQpthXa3N/uC1b4PD00ooUcjLzybawvseh6ena3noMKgfYU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362920112"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="362920112"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722372918"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722372918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 04:32:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKH2B-002e87-1W;
        Fri, 14 Jul 2023 14:32:27 +0300
Date:   Fri, 14 Jul 2023 14:32:27 +0300
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
Subject: Re: [PATCH v2 15/15] ASoC: Intel: sst: Convert to PCI device IDs
 defines
Message-ID: <ZLEyS7gZqbuXmkUL@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-16-amadeuszx.slawinski@linux.intel.com>
 <ZLEw9S8hmkcdk7K2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLEw9S8hmkcdk7K2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 02:26:45PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 14, 2023 at 08:56:15PM +0200, Amadeusz Sławiński wrote:
> > Use PCI device IDs from pci_ids.h header.
> 
> Perhaps one more sentence to explain why this is okay change, like:
> "The ACPI IDs are used only internally and lower 16 bits uniquely define
>  the device as vendor ID for Intel is 8086 for all of them."
> 
> Suggested-by: ?
> 
> ...
> 
> > -	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SST_TNG), 0},
> 
> That 0 is not needed, OTOH you may use PCI_DEVICE_DATA(..., 0).

And you missed the patch I sent to you, i.e. replacing field and function
parameter type to be insigned short. Otherwise it won't work with ACPI.

-- 
With Best Regards,
Andy Shevchenko


