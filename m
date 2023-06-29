Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E38742200
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjF2IVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjF2IUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 04:20:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB924212;
        Thu, 29 Jun 2023 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688026751; x=1719562751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iDqHrC+b5je00aAWpKWWDWwFkzD6FMRna9LaqlrNfh8=;
  b=mb3SUDr1cRhxID62EMZS2R76NopIqq9iqPG+8iRpgL9vgxI/AIyjPOum
   cDjaR6Bp5w3+zCO/Ncr15lc6BnWpuvo21KdS6Dvdkm+Vcuw97F68ZYWGz
   DLKF/6X10aOuh5HqqcYjwKv+wYr7IwPpQ3k4zH7QIvGtXF+XBhfcwFn95
   8S2abO3fAqEXCFTcmuqGNWPPrKkmd6Vk1tuWaZxe8Uc6l4HsWu8rfQvp1
   UkRst5hd+F6abTUEUikEK6m2/zlnposfS+1EJba7+V9+ywU+GIFDxwaag
   x7XHfzPyxlRE5jGLocNZxY6I2zQVRR5kBtI/8bSFNQZEG9u46+OM2Qv6f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351854339"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351854339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891331273"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="891331273"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:19:08 -0700
Message-ID: <ca1ede5f-0859-5eea-f59c-9377d5945b71@linux.intel.com>
Date:   Thu, 29 Jun 2023 10:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 7/8] ASoC: Intel: Skylake: Update PCI ID list
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <20230628205135.517241-8-amadeuszx.slawinski@linux.intel.com>
 <ZJxJMg0bldj/M7TY@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZJxJMg0bldj/M7TY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/28/2023 4:52 PM, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 10:51:34PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header and while at it change to using
>> PCI_DEVICE_DATA macro, to simplify declarations.
> 
> PCI_DEVICE_DATA()
> 
> ...
> 
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP,	&snd_soc_acpi_intel_skl_machines) },
> 
> Do you really need TAB(s) in the parameter list?
> 

I did this to align entries, I know it is not that visible in this 
patch, but they are defined close to each other and I feel that it looks 
better if they are aligned, but can drop alignment if you prefer. Should 
I also drop them in other patches, as I don't see comment for that?
