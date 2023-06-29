Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6B742346
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjF2JaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjF2J3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 05:29:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805C3ABF;
        Thu, 29 Jun 2023 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688030939; x=1719566939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AZfC0g5llZa4NrEUlDxx41BmIYHtzoyZPpjBjZ+qS+Y=;
  b=VJ5luudV4HUi5OFLyQRCkxvLiAPNWoE5usUSHSEkG8cAjWjUvFhYrpEf
   0Y8s2NQpV+mFzvIwN8guPw9RZwAYYZ7o0y++8tj6D8LcwpPePnwDN/R1n
   G2yP5yV1z3a3v7NR4isyauB4DD0Ou3O2/SBVGap6vCyjRK6p3ZSLbwDMA
   p397M2LPxyJ8sHB7UxTb1YBQEnVmojScYjSwXwtpYYY2Z9b3RJ0el5pZx
   0stVUxrt9zlBeqc3zvuhlefrOrg5+B5ZXT5fIoLkxTn2cjnbURhmWVf1H
   ph0QybbKFv0vT4eNQG/byu2gPKNOLHlGZy/+3jajaEitIx1/NoMTSvFhN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360914148"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="360914148"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 02:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782623194"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782623194"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 02:28:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qEnxO-000oTx-1B;
        Thu, 29 Jun 2023 12:28:54 +0300
Date:   Thu, 29 Jun 2023 12:28:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [RFC PATCH 7/8] ASoC: Intel: Skylake: Update PCI ID list
Message-ID: <ZJ1O1glAVAhFysPk@smile.fi.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-8-amadeuszx.slawinski@linux.intel.com>
 <ZJxJMg0bldj/M7TY@smile.fi.intel.com>
 <ca1ede5f-0859-5eea-f59c-9377d5945b71@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca1ede5f-0859-5eea-f59c-9377d5945b71@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 29, 2023 at 10:19:06AM +0200, Amadeusz Sławiński wrote:
> On 6/28/2023 4:52 PM, Andy Shevchenko wrote:
> > On Wed, Jun 28, 2023 at 10:51:34PM +0200, Amadeusz Sławiński wrote:

...

> > > +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP,	&snd_soc_acpi_intel_skl_machines) },
> > 
> > Do you really need TAB(s) in the parameter list?
> 
> I did this to align entries, I know it is not that visible in this patch,
> but they are defined close to each other and I feel that it looks better if
> they are aligned, but can drop alignment if you prefer. Should I also drop
> them in other patches, as I don't see comment for that?

I think we may survive without TABs, but the maintainers may have the last
word on this.

-- 
With Best Regards,
Andy Shevchenko


