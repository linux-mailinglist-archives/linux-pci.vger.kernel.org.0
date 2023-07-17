Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9F7565B6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGQODe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGQODe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 10:03:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67041D1;
        Mon, 17 Jul 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689602613; x=1721138613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eak0Awh/jpPpCIghRwyoQAOusxOLZVy8MBwHFNwXJ0A=;
  b=fatd0RwR9OK4XzRGNqlH+Wt1J+Z7l8n8bsl8B23smt6+fRo4d0/Sp93d
   7c/ibu9pErWQ5MxZlBGCkcaifQecJb0IN+7G3sIV6vzgX07Rx/aQehi9D
   KB0iDGXb05JoZQLt9nn7V3HwZGB+Z8JLgU1+TXCALiwXCDJ582jOy7tog
   ciOvY9WGu8RKlUBIeF4lsqQE3YmSGIKAsG1E2VSyKw87KAe/ueEfKtUFl
   6Mtvvo8ZG65rGtzSPPVi/4aQIIiPWCwOyePV8IlH2wx06hM7ro9xtX3Vo
   9KeDVPDZ5lqpS2dA3sOrah9wGmJWMlbM8pERdxsM4pasEuF5RJYBAi8eG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="396765748"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396765748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726555400"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726555400"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:02:57 -0700
Message-ID: <78f7ff79-cb32-1e08-f87a-9186c9114056@linux.intel.com>
Date:   Mon, 17 Jul 2023 16:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/15] PCI: Sort Intel PCI IDs by number
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
 <20230717114511.484999-2-amadeuszx.slawinski@linux.intel.com>
 <ZLVIGlpoNsr0RRGE@smile.fi.intel.com> <ZLVI8NuiIZZrhjRg@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZLVI8NuiIZZrhjRg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/17/2023 3:58 PM, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 04:54:34PM +0300, Andy Shevchenko wrote:
>> On Mon, Jul 17, 2023 at 01:44:57PM +0200, Amadeusz Sławiński wrote:
>>> Some of the PCI IDs are not sorted correctly, reorder them by growing ID
>>> number.
>>
>> Hmm... I don't see a cover letter...
> 
> Okay, `b4` fetches it. It seems I asked you (or my memory is doing a trick?)
> to avoid using my @intel.com for LKML archives...
> 

It was on NHLT patchset review with Cezary, but I will also try to 
remember it for future patches.
