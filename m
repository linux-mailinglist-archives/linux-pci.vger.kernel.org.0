Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732D7415E1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF1P6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 11:58:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:20599 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbjF1P6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687967883; x=1719503883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K5zT2FY0Az4cbHZonZ/hBNeNzPWJNFzal6qbbQFy0DU=;
  b=U64Ow9jXTUpQU+JRimRbhOu7QgI5l8iYFx+jhu0WWTOIPH1m+yWL4KzQ
   19liz2OOkmeAxNcksaYUhqeB+ptRIFcr7uREdtPtW12uaOxDcHzuGYOBy
   a41D/ZrHr52b48q2TMfJIJtvM5hFk0Htm9t2U++4XxbFIf2/tw2O1fANu
   tPcIQmmMhUNE+OgjhNmudvvciOfE0Vd9GqWBP3iaCXeqGCBtEGR5n+VyD
   Ug3aA6vAzub921r3jcikmQphAqHXvcv+bFcIs254blfDzpw446gNvv4u5
   cQ3VSGJB46VE8IrYuSsFFDxWKzJVy32TAy7HGpkeYq1zJojziomFaQhhj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="448269762"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="448269762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="841122398"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="841122398"
Received: from sdiskin-mobl.ger.corp.intel.com (HELO [10.251.217.207]) ([10.251.217.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:57:59 -0700
Message-ID: <bbe9f772-e049-4ad3-18aa-cca0b793439f@linux.intel.com>
Date:   Wed, 28 Jun 2023 17:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/8] PCI: Define Intel PCI IDs and use them in drivers
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
 <ZJxIZGV4+5Al0CpW@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZJxIZGV4+5Al0CpW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/28/23 16:49, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 10:51:27PM +0200, Amadeusz Sławiński wrote:
>> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
>> various configurations and historical reasons. Currently almost all uses
>> of HDA PCI IDs have corresponding comment telling which platform it is.
>> Additionally there are some inconsistencies between drivers about which
>> ID corresponds to which device.
>>
>> Simplify things, by adding PCI IDs to global header and make use of them
>> in drivers. This allows for removal of comments by having IDs themselves
>> being self explanatory. Additionally it allows for removal of existing
>> inconsistencies by having one source of truth.
> 
> I'm in favour of this series. It allows to use PCI_DEVICE_DATA() in many places.
> With that said, I think you can also add some more definitions to PCI IDs header
> for the sake of being able to use that macro.

I don't have any objections on the change.

The big open is how we add new definitions without a 3-way deadlock
between PCI, sound and ASoC trees, and how those definitions can be
added to the -stable trees.

This isn't an hypothetical case, we have 2 pending submissions for
LunarLake [1] and ArrowLake [2] which will be provided as soon as the
merge window closes.

It's not clear to me if Bjorn is ok to let those audio-specific PCI IDs
go the audio trees, and how things would work between Mark and Takashi.

[1] https://github.com/thesofproject/linux/pull/4425
[2] https://github.com/thesofproject/linux/pull/4437
