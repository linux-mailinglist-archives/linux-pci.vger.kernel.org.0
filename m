Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335B753B40
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjGNMoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNMoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:44:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA82113;
        Fri, 14 Jul 2023 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689338652; x=1720874652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WF/K2HzY3n3CH1+aoKkuQP7RvM/fmg1fj65u6T6pEec=;
  b=A09En8z5BoHgjZiYanfiM4UXDeAzuzWenknHUZnswiz3v25gZMX9IVmh
   A2QgasN6X6Pq3OzgguyWiHH1h/NLOSDs2I5rM61XfYhYPhRAfaquJoFs0
   Jmc5s1v4aDm62Zvb0+08drzljX0Yf6D1AU0j31ovifeBZd0UKdSrAbXe1
   CNdDQBMV9+ZelZxNXFv3dgBRKtEmHKMaj3wFky4Ck8t/Iy8F1uzrsB12E
   +hb1GahsyqKvUS3Mxi3br3vbaf5DOK8RBdL0kofCPhNlSL8d3otcaQLHb
   kqKxbJHekvo2j8Ao0KLQ7b6rt0XBB2GRulfSd6Vuhd/9b7LqcMh4KSKQ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368104465"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="368104465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812423824"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="812423824"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:44:08 -0700
Message-ID: <a23f2c59-34a7-f5d0-f2a2-44364fc1e37c@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/15] ASoC: SOF: Remove unused Broxton PCI ID
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
 <20230714202457.423866-4-amadeuszx.slawinski@linux.intel.com>
 <ZLFBBzmJXgXeWZ0y@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZLFBBzmJXgXeWZ0y@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/14/2023 2:35 PM, Andy Shevchenko wrote:
> On Fri, Jul 14, 2023 at 10:24:45PM +0200, Amadeusz Sławiński wrote:
>> Current code references 0x1a98 which is BXT-M (not -T as it is
>> commented) and it's an RVP, BXT-M B0 to be specific. From what we know
>> no BXT is available on market.
> 
> ...
> 
>>   sound/hda/intel-dsp-config.c  | 7 -------
>>   sound/soc/sof/intel/pci-apl.c | 2 --
> 
> I dunno how SOF and HDA are related to each other, but in the next patch you
> also do something about HDA, either group all of them, or split HDA, or split
> on per file basis. I'm not familiar with the relationship between them up to
> you which way you choose.
> 

Well SOF is a DSP driver, so that's why I split it from HDA - 
intel-dsp-config.c file is used to perform checks to know if it should 
load DSP driver (and which one), hence the "weird" split.
