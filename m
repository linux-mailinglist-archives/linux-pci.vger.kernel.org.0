Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63596753972
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGNLXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNLXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:23:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE942D63;
        Fri, 14 Jul 2023 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333790; x=1720869790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R+OgewhlbgSo5E0OBrtwt2RMUqV7BjX8qJS7OtNH8Nc=;
  b=laKZ+vgb+mSL/+32ouEvCK3fOjAKNgDEMp8i0Yo4AfaDSNVqCCnVunb0
   5pH7Y9vbWwvCaQU8LRHG/BntZI5/qtozkEjMFs3w/5G5TmuQ6nsV46FSA
   0+X+NIsppqoY/K47VuROky4V288hIPGXpfHTjc2Nh/89V5ZNAmErnUp2G
   e7JfJsG6SC2guT+iKHv/GAxZTlYElq6poMm0/8trbb2qt4Xg3x9v+dxfR
   +XFd+kOkSdfm0T+bf2k/0A8qG401yV/mzHm+AwRhnG3zdtquFa9MHuHKZ
   X4Tjv2fAFd8xnrkzUL85emWhZxe2mDtI7SbP0un0Dzn1Q7U7cdJkNj7sO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355386521"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="355386521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="752011334"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="752011334"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:23:07 -0700
Message-ID: <71f8c48d-8e28-9292-ae31-a1a11498ec1b@linux.intel.com>
Date:   Fri, 14 Jul 2023 13:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/15] ALSA: hda/i915: Use global PCI match macro
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
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-8-amadeuszx.slawinski@linux.intel.com>
 <ZLEvZ3Ss05A+x1ty@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZLEvZ3Ss05A+x1ty@smile.fi.intel.com>
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

On 7/14/2023 1:20 PM, Andy Shevchenko wrote:
> On Fri, Jul 14, 2023 at 08:56:07PM +0200, Amadeusz Sławiński wrote:
>> Instead of using local macro to match PCI device, use global one.
> 
> ...
> 
>> @@ -2718,7 +2718,6 @@
>>   #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
>>   #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
>>   #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
>> -#define PCI_DEVICE_ID_INTEL_HDA_APL_T	0x1a98
>>   #define PCI_DEVICE_ID_INTEL_HDA_CPT	0x1c20
>>   #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
>>   #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f
> 
> Looks like it should be a separate change.
> 

Oops... must have fixed up wrong patch, and I even looked at all patches 
before sending them, to check for something like that :|
