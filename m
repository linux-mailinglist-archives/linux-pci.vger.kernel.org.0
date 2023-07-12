Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E87505E5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGLLWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGLLWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 07:22:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF2E5C;
        Wed, 12 Jul 2023 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689160948; x=1720696948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xBZcBmhOfXfYdNnXfJbg5VBF8lSNiEl9Njv9g8HbBXk=;
  b=U4fLKFVuMCjVIfzq0GY7ihnNZZl5aj8aDerJDMRvnmdQKy4C/MJaMOZa
   YP0RiKYAHBUopFaEgAfixWB2Rwr3Ehe5d+cVSiZppXk5P2si9erEAE3RZ
   imKM+SVAumn6qsv42iLpXOxiU5m3gvNpdzuS/+t3DKsd+F4A01pmnd2Mo
   9yoAhBCg4KuCLxDtkDSSS1pguywkDhzd1YAKBsSARKIm24ncbDOgaRPFU
   dw0OEHGW6wZfCm0yqypnUauwAWTUQ4TKkOQhl30cNl4cMUSK3/WThy9cg
   pd4ulm4i7YdZ+8yvoIvqDhnyD53MZaX1ORPgaPESvzkAp6Gs7U3O+UQvC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367484061"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="367484061"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811527775"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="811527775"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:22:24 -0700
Message-ID: <ec8bf2d3-6db0-bb9e-0964-fadcf8fa654d@linux.intel.com>
Date:   Wed, 12 Jul 2023 13:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/13] ALSA: hda: Convert to PCI device IDs defines
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
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-9-amadeuszx.slawinski@linux.intel.com>
 <ZK1iES4aIwr9o29F@smile.fi.intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZK1iES4aIwr9o29F@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/2023 4:07 PM, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 02:57:21PM +0200, Amadeusz Sławiński wrote:
>> Use PCI device IDs from pci_ids.h header and while at it to simplify
>> declarations change to using PCI_DEVICE_DATA() macro for Intel IDs and
>> PCI_VDEVICE() for all other that have defined vendor.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> See nit-pick below.
> 
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> ---
>>   sound/pci/hda/hda_intel.c | 353 +++++++++++++++-----------------------
>>   1 file changed, 141 insertions(+), 212 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 143efa54b9bf..4a162f27b46e 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -2416,333 +2416,262 @@ static void azx_shutdown(struct pci_dev *pci)
>>   /* PCI IDs */
>>   static const struct pci_device_id azx_ids[] = {
>>   	/* CPT */
>> -	{ PCI_DEVICE(0x8086, 0x1c20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CPT, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM) },
>>   	/* PBG */
>> -	{ PCI_DEVICE(0x8086, 0x1d20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_PBG, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM) },
>>   	/* Panther Point */
>> -	{ PCI_DEVICE(0x8086, 0x1e20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_PPT, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM) },
>>   	/* Lynx Point */
>> -	{ PCI_DEVICE(0x8086, 0x8c20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LPT, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>>   	/* 9 Series */
>> -	{ PCI_DEVICE(0x8086, 0x8ca0),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_9_SERIES, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>>   	/* Wellsburg */
>> -	{ PCI_DEVICE(0x8086, 0x8d20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> -	{ PCI_DEVICE(0x8086, 0x8d21),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_WBG_0, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_WBG_1, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>>   	/* Lewisburg */
>> -	{ PCI_DEVICE(0x8086, 0xa1f0),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
>> -	{ PCI_DEVICE(0x8086, 0xa270),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LBG_0, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LBG_1, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Lynx Point-LP */
>> -	{ PCI_DEVICE(0x8086, 0x9c20),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LPT_LP_0, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>>   	/* Lynx Point-LP */
>> -	{ PCI_DEVICE(0x8086, 0x9c21),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LPT_LP_1, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>>   	/* Wildcat Point-LP */
>> -	{ PCI_DEVICE(0x8086, 0x9ca0),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> -	/* Sunrise Point */
>> -	{ PCI_DEVICE(0x8086, 0xa170),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>> -	/* Sunrise Point-LP */
>> -	{ PCI_DEVICE(0x8086, 0x9d70),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_WPT_LP, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH) },
>> +	/* Skylake (Sunrise Point) */
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	/* Skylake-LP (Sunrise Point-LP) */
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Kabylake */
>> -	{ PCI_DEVICE(0x8086, 0xa171),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Kabylake-LP */
>> -	{ PCI_DEVICE(0x8086, 0x9d71),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Kabylake-H */
>> -	{ PCI_DEVICE(0x8086, 0xa2f0),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Coffelake */
>> -	{ PCI_DEVICE(0x8086, 0xa348),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Cannonlake */
>> -	{ PCI_DEVICE(0x8086, 0x9dc8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* CometLake-LP */
>> -	{ PCI_DEVICE(0x8086, 0x02C8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* CometLake-H */
>> -	{ PCI_DEVICE(0x8086, 0x06C8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0xf1c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RKL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* CometLake-S */
>> -	{ PCI_DEVICE(0x8086, 0xa3f0),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* CometLake-R */
>> -	{ PCI_DEVICE(0x8086, 0xf0c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_CML_R, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Icelake */
>> -	{ PCI_DEVICE(0x8086, 0x34c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Icelake-H */
>> -	{ PCI_DEVICE(0x8086, 0x3dc8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Jasperlake */
>> -	{ PCI_DEVICE(0x8086, 0x38c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x4dc8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICL_N, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_JSL_N, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Tigerlake */
>> -	{ PCI_DEVICE(0x8086, 0xa0c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_TGL_LP, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Tigerlake-H */
>> -	{ PCI_DEVICE(0x8086, 0x43c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_TGL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* DG1 */
>> -	{ PCI_DEVICE(0x8086, 0x490d),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_DG1, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* DG2 */
>> -	{ PCI_DEVICE(0x8086, 0x4f90),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x4f91),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x4f92),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_DG2_0, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_DG2_1, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_DG2_2, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Alderlake-S */
>> -	{ PCI_DEVICE(0x8086, 0x7ad0),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Alderlake-P */
>> -	{ PCI_DEVICE(0x8086, 0x51c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51c9),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51cd),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_P, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_PS, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_PX, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Alderlake-M */
>> -	{ PCI_DEVICE(0x8086, 0x51cc),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_M, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Alderlake-N */
>> -	{ PCI_DEVICE(0x8086, 0x54c8),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ADL_N, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Elkhart Lake */
>> -	{ PCI_DEVICE(0x8086, 0x4b55),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x4b58),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_EHL_0, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_EHL_3, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Raptor Lake */
>> -	{ PCI_DEVICE(0x8086, 0x7a50),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51ca),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51cb),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51ce),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	{ PCI_DEVICE(0x8086, 0x51cf),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	/* Meteorlake-P */
>> -	{ PCI_DEVICE(0x8086, 0x7e28),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_P_0, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_P_1, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_M, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_RPL_PX, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_MTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>>   	/* Lunarlake-P */
>> -	{ PCI_DEVICE(0x8086, 0xa828),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
>> -	/* Broxton-P(Apollolake) */
>> -	{ PCI_DEVICE(0x8086, 0x5a98),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_LNL_P, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
>> +	/* Apollolake (Broxton-P) */
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>>   	/* Broxton-T */
>> -	{ PCI_DEVICE(0x8086, 0x1a98),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_APL_T, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>>   	/* Gemini-Lake */
>> -	{ PCI_DEVICE(0x8086, 0x3198),
>> -	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_GML, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>>   	/* Haswell */
>> -	{ PCI_DEVICE(0x8086, 0x0a0c),
>> -	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
>> -	{ PCI_DEVICE(0x8086, 0x0c0c),
>> -	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
>> -	{ PCI_DEVICE(0x8086, 0x0d0c),
>> -	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_0, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_2, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_3, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
>>   	/* Broadwell */
>> -	{ PCI_DEVICE(0x8086, 0x160c),
>> -	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_BROADWELL },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_BDW, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_BROADWELL) },
>>   	/* 5 Series/3400 */
>> -	{ PCI_DEVICE(0x8086, 0x3b56),
>> -	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
>> -	{ PCI_DEVICE(0x8086, 0x3b57),
>> -	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_5_3400_SERIES_0, AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM) },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_5_3400_SERIES_1, AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM) },
>>   	/* Poulsbo */
>> -	{ PCI_DEVICE(0x8086, 0x811b),
>> -	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE |
>> -	  AZX_DCAPS_POSFIX_LPIB },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_POULSBO, AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE |
>> +	  AZX_DCAPS_POSFIX_LPIB) },
>>   	/* Oaktrail */
>> -	{ PCI_DEVICE(0x8086, 0x080a),
>> -	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_OAKTRAIL, AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE) },
>>   	/* BayTrail */
>> -	{ PCI_DEVICE(0x8086, 0x0f04),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BAYTRAIL },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_BYT, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BAYTRAIL) },
>>   	/* Braswell */
>> -	{ PCI_DEVICE(0x8086, 0x2284),
>> -	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BRASWELL },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_BSW, AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BRASWELL) },
>>   	/* ICH6 */
>> -	{ PCI_DEVICE(0x8086, 0x2668),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH6, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH7 */
>> -	{ PCI_DEVICE(0x8086, 0x27d8),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH7, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ESB2 */
>> -	{ PCI_DEVICE(0x8086, 0x269a),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ESB2, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH8 */
>> -	{ PCI_DEVICE(0x8086, 0x284b),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH8, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH9 */
>> -	{ PCI_DEVICE(0x8086, 0x293e),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH9_0, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH9 */
>> -	{ PCI_DEVICE(0x8086, 0x293f),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH9_1, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH10 */
>> -	{ PCI_DEVICE(0x8086, 0x3a3e),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH10_0, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* ICH10 */
>> -	{ PCI_DEVICE(0x8086, 0x3a6e),
>> -	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	{ PCI_DEVICE_DATA(INTEL, HDA_ICH10_1, AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH) },
>>   	/* Generic Intel */
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
>>   	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>>   	  .class_mask = 0xffffff,
>>   	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_NO_ALIGN_BUFSIZE },
> 
>>   	/* ATI SB 450/600/700/800/900 */
>> -	{ PCI_DEVICE(0x1002, 0x437b),
>> +	{ PCI_VDEVICE(ATI, 0x437b),
>>   	  .driver_data = AZX_DRIVER_ATI | AZX_DCAPS_PRESET_ATI_SB },
>> -	{ PCI_DEVICE(0x1002, 0x4383),
>> +	{ PCI_VDEVICE(ATI, 0x4383),
>>   	  .driver_data = AZX_DRIVER_ATI | AZX_DCAPS_PRESET_ATI_SB },
> 
> I know that AMD owns ATI, but wouldn't make sense to group by company?
> Maybe as a separate (preparatory?) patch.
> 

It seems to be sorted this way because first are Generic ATI and AMD HDA 
cards, followed by ATI HDMI ones. I would just leave it as it is unless 
Takashi also prefers it to be reordered?

>>   	/* AMD Hudson */
>> -	{ PCI_DEVICE(0x1022, 0x780d),
>> +	{ PCI_VDEVICE(AMD, 0x780d),
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
>>   	/* AMD, X370 & co */
>> -	{ PCI_DEVICE(0x1022, 0x1457),
>> +	{ PCI_VDEVICE(AMD, 0x1457),
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
>>   	/* AMD, X570 & co */
>> -	{ PCI_DEVICE(0x1022, 0x1487),
>> +	{ PCI_VDEVICE(AMD, 0x1487),
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
>>   	/* AMD Stoney */
>> -	{ PCI_DEVICE(0x1022, 0x157a),
>> +	{ PCI_VDEVICE(AMD, 0x157a),
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
>>   			 AZX_DCAPS_PM_RUNTIME },
>>   	/* AMD Raven */
>> -	{ PCI_DEVICE(0x1022, 0x15e3),
>> +	{ PCI_VDEVICE(AMD, 0x15e3),
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
>>   	/* ATI HDMI */
>> -	{ PCI_DEVICE(0x1002, 0x0002),
>> +	{ PCI_VDEVICE(ATI, 0x0002),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0x1308),
>> +	{ PCI_VDEVICE(ATI, 0x1308),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0x157a),
>> +	{ PCI_VDEVICE(ATI, 0x157a),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0x15b3),
>> +	{ PCI_VDEVICE(ATI, 0x15b3),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0x793b),
>> +	{ PCI_VDEVICE(ATI, 0x793b),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0x7919),
>> +	{ PCI_VDEVICE(ATI, 0x7919),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0x960f),
>> +	{ PCI_VDEVICE(ATI, 0x960f),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0x970f),
>> +	{ PCI_VDEVICE(ATI, 0x970f),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0x9840),
>> +	{ PCI_VDEVICE(ATI, 0x9840),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0xaa00),
>> +	{ PCI_VDEVICE(ATI, 0xaa00),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa08),
>> +	{ PCI_VDEVICE(ATI, 0xaa08),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa10),
>> +	{ PCI_VDEVICE(ATI, 0xaa10),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa18),
>> +	{ PCI_VDEVICE(ATI, 0xaa18),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa20),
>> +	{ PCI_VDEVICE(ATI, 0xaa20),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa28),
>> +	{ PCI_VDEVICE(ATI, 0xaa28),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa30),
>> +	{ PCI_VDEVICE(ATI, 0xaa30),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa38),
>> +	{ PCI_VDEVICE(ATI, 0xaa38),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa40),
>> +	{ PCI_VDEVICE(ATI, 0xaa40),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa48),
>> +	{ PCI_VDEVICE(ATI, 0xaa48),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa50),
>> +	{ PCI_VDEVICE(ATI, 0xaa50),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa58),
>> +	{ PCI_VDEVICE(ATI, 0xaa58),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa60),
>> +	{ PCI_VDEVICE(ATI, 0xaa60),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa68),
>> +	{ PCI_VDEVICE(ATI, 0xaa68),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa80),
>> +	{ PCI_VDEVICE(ATI, 0xaa80),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa88),
>> +	{ PCI_VDEVICE(ATI, 0xaa88),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa90),
>> +	{ PCI_VDEVICE(ATI, 0xaa90),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0xaa98),
>> +	{ PCI_VDEVICE(ATI, 0xaa98),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
>> -	{ PCI_DEVICE(0x1002, 0x9902),
>> +	{ PCI_VDEVICE(ATI, 0x9902),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0xaaa0),
>> +	{ PCI_VDEVICE(ATI, 0xaaa0),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0xaaa8),
>> +	{ PCI_VDEVICE(ATI, 0xaaa8),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0xaab0),
>> +	{ PCI_VDEVICE(ATI, 0xaab0),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
>> -	{ PCI_DEVICE(0x1002, 0xaac0),
>> +	{ PCI_VDEVICE(ATI, 0xaac0),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaac8),
>> +	{ PCI_VDEVICE(ATI, 0xaac8),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaad8),
>> +	{ PCI_VDEVICE(ATI, 0xaad8),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaae0),
>> +	{ PCI_VDEVICE(ATI, 0xaae0),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaae8),
>> +	{ PCI_VDEVICE(ATI, 0xaae8),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaaf0),
>> +	{ PCI_VDEVICE(ATI, 0xaaf0),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xaaf8),
>> +	{ PCI_VDEVICE(ATI, 0xaaf8),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab00),
>> +	{ PCI_VDEVICE(ATI, 0xab00),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab08),
>> +	{ PCI_VDEVICE(ATI, 0xab08),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab10),
>> +	{ PCI_VDEVICE(ATI, 0xab10),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab18),
>> +	{ PCI_VDEVICE(ATI, 0xab18),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab20),
>> +	{ PCI_VDEVICE(ATI, 0xab20),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab28),
>> +	{ PCI_VDEVICE(ATI, 0xab28),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab30),
>> +	{ PCI_VDEVICE(ATI, 0xab30),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>> -	{ PCI_DEVICE(0x1002, 0xab38),
>> +	{ PCI_VDEVICE(ATI, 0xab38),
>>   	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
>>   	  AZX_DCAPS_PM_RUNTIME },
>>   	/* GLENFLY */
>> @@ -2752,15 +2681,15 @@ static const struct pci_device_id azx_ids[] = {
>>   	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
>>   	  AZX_DCAPS_NO_MSI | AZX_DCAPS_NO_64BIT },
>>   	/* VIA VT8251/VT8237A */
>> -	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
>> +	{ PCI_VDEVICE(VIA, 0x3288), .driver_data = AZX_DRIVER_VIA },
>>   	/* VIA GFX VT7122/VX900 */
>> -	{ PCI_DEVICE(0x1106, 0x9170), .driver_data = AZX_DRIVER_GENERIC },
>> +	{ PCI_VDEVICE(VIA, 0x9170), .driver_data = AZX_DRIVER_GENERIC },
>>   	/* VIA GFX VT6122/VX11 */
>> -	{ PCI_DEVICE(0x1106, 0x9140), .driver_data = AZX_DRIVER_GENERIC },
>> +	{ PCI_VDEVICE(VIA, 0x9140), .driver_data = AZX_DRIVER_GENERIC },
>>   	/* SIS966 */
>> -	{ PCI_DEVICE(0x1039, 0x7502), .driver_data = AZX_DRIVER_SIS },
>> +	{ PCI_VDEVICE(SI, 0x7502), .driver_data = AZX_DRIVER_SIS },
>>   	/* ULI M5461 */
>> -	{ PCI_DEVICE(0x10b9, 0x5461), .driver_data = AZX_DRIVER_ULI },
>> +	{ PCI_VDEVICE(AL, 0x5461), .driver_data = AZX_DRIVER_ULI },
>>   	/* NVIDIA MCP */
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID),
>>   	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>> @@ -2773,9 +2702,9 @@ static const struct pci_device_id azx_ids[] = {
>>   	  .driver_data = AZX_DRIVER_TERA | AZX_DCAPS_NO_64BIT },
>>   	/* Creative X-Fi (CA0110-IBG) */
>>   	/* CTHDA chips */
>> -	{ PCI_DEVICE(0x1102, 0x0010),
>> +	{ PCI_VDEVICE(CREATIVE, 0x0010),
>>   	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
>> -	{ PCI_DEVICE(0x1102, 0x0012),
>> +	{ PCI_VDEVICE(CREATIVE, 0x0012),
>>   	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
>>   #if !IS_ENABLED(CONFIG_SND_CTXFI)
>>   	/* the following entry conflicts with snd-ctxfi driver,
>> @@ -2789,18 +2718,18 @@ static const struct pci_device_id azx_ids[] = {
>>   	  AZX_DCAPS_NO_64BIT | AZX_DCAPS_POSFIX_LPIB },
>>   #else
>>   	/* this entry seems still valid -- i.e. without emu20kx chip */
>> -	{ PCI_DEVICE(0x1102, 0x0009),
>> +	{ PCI_VDEVICE(CREATIVE, 0x0009),
>>   	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
>>   	  AZX_DCAPS_NO_64BIT | AZX_DCAPS_POSFIX_LPIB },
>>   #endif
>>   	/* CM8888 */
>> -	{ PCI_DEVICE(0x13f6, 0x5011),
>> +	{ PCI_VDEVICE(CMEDIA, 0x5011),
>>   	  .driver_data = AZX_DRIVER_CMEDIA |
>>   	  AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_SNOOP_OFF },
>>   	/* Vortex86MX */
>> -	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
>> +	{ PCI_VDEVICE(RDC, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
>>   	/* VMware HDAudio */
>> -	{ PCI_DEVICE(0x15ad, 0x1977), .driver_data = AZX_DRIVER_GENERIC },
>> +	{ PCI_VDEVICE(VMWARE, 0x1977), .driver_data = AZX_DRIVER_GENERIC },
>>   	/* AMD/ATI Generic, PCI class code and Vendor ID for HD Audio */
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_ANY_ID),
>>   	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>> @@ -2811,11 +2740,11 @@ static const struct pci_device_id azx_ids[] = {
>>   	  .class_mask = 0xffffff,
>>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI },
>>   	/* Zhaoxin */
>> -	{ PCI_DEVICE(0x1d17, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
>> +	{ PCI_VDEVICE(ZHAOXIN, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
>>   	/* Loongson HDAudio*/
>> -	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDA),
>> +	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_HDA),
>>   	  .driver_data = AZX_DRIVER_LOONGSON },
>> -	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
>> +	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
>>   	  .driver_data = AZX_DRIVER_LOONGSON },
>>   	{ 0, }
>>   };
>> -- 
>> 2.34.1
>>
> 

