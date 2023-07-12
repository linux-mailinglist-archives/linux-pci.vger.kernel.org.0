Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78C750531
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLKyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGLKyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 06:54:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005FE77;
        Wed, 12 Jul 2023 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689159276; x=1720695276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sgwbJuDsOwUVl2lh42e25SNssLTIeH+vnDdXIxvdlz0=;
  b=dwnEYjBssP7F6QNFfEOFYsoY25If6jQm3Zy8+OVLjmTs5uD52G8Q8Qqq
   dTv2xIo5cy4shN0J2uFsf5QBuMBYAnK4mWcr+JZAzXb/B0lToO0eav3nb
   CVLTvle325zegerKC99MgSv+H2p4K836W++DEXVDiZHcwoEmlJ/5ISxcf
   MRCeK5imfWQy+OMVtky521d0xyMI1Q5g0gXwpo9t4dptUV96spZhZcQ+x
   WuxKBk7ngf35HuhDuTnMDsyGWcy7N2m82UuI1cX9d+alMZclmCsrj0uQc
   1PZ20B4qvDqb36Z4w/4Ef2j4Up5/cDL/NSIGPF1nZ2otpzO3q0kZsgmuF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362325000"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="362325000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 03:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698829108"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="698829108"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 03:54:32 -0700
Message-ID: <5780dc05-c8cb-7c2c-6e61-6e643e17ea2a@linux.intel.com>
Date:   Wed, 12 Jul 2023 12:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/13] ALSA: hda: Add controller matching macros
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-4-amadeuszx.slawinski@linux.intel.com>
 <ZK1ayXcoTfIrr18V@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1ayXcoTfIrr18V@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/2023 3:36 PM, Andy Shevchenko wrote:
>> +#define HDA_CONTROLLER_IN_GPU(pci) (HDA_CONTROLLER_IS_HSW(pci) || \
>> +		pci_match_id((struct pci_device_id []){ \
> I think if you start with pci_match_id() and move HDA_CONTROLLER_IS_HSW() at
> the end it will make this macro aligned with the rest, so easier to get them
> all at once.
> 

Ack.
