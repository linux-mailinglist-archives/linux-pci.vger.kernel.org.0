Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93AC7421FE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjF2IVi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjF2IUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 04:20:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5935B0;
        Thu, 29 Jun 2023 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688026742; x=1719562742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bwl4CrAT36OPSAV+5Pw0nBFpLFCNkMjbBXcbb8Asm+c=;
  b=iyNRgDZlnCLOLLsc2ocN2NeJtGai03BaaWR8maqEcWxvz9kIDKl5bbxd
   ScTfskkKRrGfZE8LjXFCTbTJQkh7nbGJPjA+Kg+mxkbRTWxZMi0L/YtDi
   UQPdGBOibY2pcI0fPr6pneNALtbj0LrD9d8su6ujgtXaheQPpXi/uOAxo
   jpcAqNdlzk4Op1uZGLoO5yF1SIhjomsGDTwL7v5GGedNxAuW0xeF6NmwW
   EcJHN/ZQhunEzKp3gscCOziQo0CXVHhOF46oYPOE7x8WUaeoN1TgCXDB0
   wqaM1NrYNi3wRPQVRPtk3Rau8/NwVPgU073i+bujLHuCoVkygVV6qoTLO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351854317"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351854317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891331233"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="891331233"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:18:59 -0700
Message-ID: <fce465f5-4d3d-aed1-e2f9-c7b31d72ce08@linux.intel.com>
Date:   Thu, 29 Jun 2023 10:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/8] ALSA: hda: Update PCI ID list
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
 <20230628205135.517241-4-amadeuszx.slawinski@linux.intel.com>
 <ZJxH7lcU4tSzCjb1@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZJxH7lcU4tSzCjb1@smile.fi.intel.com>
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

On 6/28/2023 4:47 PM, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 10:51:30PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header and while at it change to using
>> PCI_VDEVICE macro, to simplify declarations. This allows to change magic
>> number PCI vendor IDs to macro ones for all vendors. For Intel devices
>> use device IDs macros where defined.
> 
> ...
> 
>>   					((pci)->device == 0x490d) || \
>>   					((pci)->device == 0x4f90) || \
>>   					((pci)->device == 0x4f91) || \
>>   					((pci)->device == 0x4f92)))
> 
> Why are not these be added in the header as well for the sake of consistency?

Will do.

> 
> ...
> 
>>   	/* CPT */
>> -	{ PCI_DEVICE(0x8086, 0x1c20),
>> +	{ PCI_VDEVICE(INTEL, 0x1c20),
>>   	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
> 
> With the first patch seems all of these (x86) can be converted
> to use PCI_DEVICE_DATA().
> 

Main reason is that some of device ids are missing and PCI_DEVICE_DATA() 
requires them to be defined. I didn't want to mix both PCI_VDEVICE() and 
PCI_DEVICE_DATA().
