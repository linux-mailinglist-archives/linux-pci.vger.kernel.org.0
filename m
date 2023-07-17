Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2275659B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGQN4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGQN4c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 09:56:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45791BD;
        Mon, 17 Jul 2023 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689602192; x=1721138192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pdA/qAf4rNsoNPcNDK7jVMmv1VVjib0VXxBO+XA3soA=;
  b=fjqi8BA4OiUMva3dECWRIrW80rOjRDyKZf0pzU3BWD+pP08cEXrmMmnn
   /SYznqUyPp/Zi5IQ1xpH3qpDz6Dym2vxyVLMopLlIUfir+SIoUAyqH2fm
   MjEYpyDc+XacUAv6jb9P7jejB+wxWMn0z6BO5xg840ZoNtt3a/aewb1zW
   7FtQd9UsxNnqwRhZdqrP+Syl1VH2/CdODR3f0dKvZREJcUhq7djPXUzu3
   PbirgZWnu+wPRwNylozrXRv43sZBipdqK332maQ5ZOvzeuiPW2NGAL6m0
   YnvPBNVh8Oxro6BUb73+BBhzZpvIGhAfF1LzFFMDYKdDcmffH0TEcBm4l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345526079"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345526079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752903787"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752903787"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:56:28 -0700
Message-ID: <c1f766c1-94eb-7339-f4c1-537f6d2e502e@linux.intel.com>
Date:   Mon, 17 Jul 2023 15:56:13 +0200
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
 <ZLVIGlpoNsr0RRGE@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZLVIGlpoNsr0RRGE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/17/2023 3:54 PM, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 01:44:57PM +0200, Amadeusz Sławiński wrote:
>> Some of the PCI IDs are not sorted correctly, reorder them by growing ID
>> number.
> 
> Hmm... I don't see a cover letter...
> 

It's out there...

https://lore.kernel.org/alsa-devel/20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com/T/#t
