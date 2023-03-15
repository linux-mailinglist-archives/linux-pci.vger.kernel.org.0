Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0106BBF63
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjCOVtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCOVtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 17:49:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9171B2CE;
        Wed, 15 Mar 2023 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678916949; x=1710452949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=24PS3cJVVwtntovVEKNFBbt4dw17GWbJ3h+PsnU0CIw=;
  b=if5h6dhCNz+Qs5/2TDgp82aCWMRuNcpYWz2ETb30MdUBRhQQ/WXDa1Rk
   AVs6miBz+g5hz2644WX6FoaSoN7Y8om7U0f+BsX/gJczMsHbSEFoIEkDZ
   GijPeaOv+FOWnL8ffBaVHggL/O7I/aS9CBDsGYoSzw+1hRIeNgutJqcQb
   yddZi9Vv+KweE1bqWo2CXOPLH7OqqvZsEoIt0C0f1/jrr80svcg17NWTz
   dWf0w6In2UUIjs/Z8hSltylig4wnHzgN6+WMYi1GCexZEFvIwj0JDifG0
   ZqVaxgxElvNlKDRFuwODU3i9ekh2q+U8eAEMD8xfASK6urhyTY4N4WfbS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="326184863"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="326184863"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="822951124"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822951124"
Received: from dtfrankl-mobl1.amr.corp.intel.com (HELO [10.212.10.122]) ([10.212.10.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:49:08 -0700
Message-ID: <2325a961-02a6-ac50-624d-0a3c97e89c7d@linux.intel.com>
Date:   Wed, 15 Mar 2023 14:49:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI:vmd: add the module param to adjust msi mode
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbusch@kernel.org, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20230307083559.2379758-1-korantwork@gmail.com>
 <20230308225718.GA1054189@bhelgaas>
 <CAEm4hYXeNR5by3ZX9V1y=ebOFcQ+JD1AgHGmFiJ3UE3xBJvRCw@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAEm4hYXeNR5by3ZX9V1y=ebOFcQ+JD1AgHGmFiJ3UE3xBJvRCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/9/2023 5:31 AM, Xinghui Li wrote:
> Bjorn Helgaas <helgaas@kernel.org> 于2023年3月9日周四 06:57写道：
>> Please adjust the subject line to match previous history, e.g.,
>>
>>   PCI: vmd: Add ... MSI ...
>>
> OK. I will fix it. Sorry for ignoring the subject format.
>
>>> In the legacy, the vmd msi-mode can only be adjusted by configing
>>> vmd_ids table.This patch adds another way to adjust msi mode by
>>> adjusting module param, which allow users easier to adjust the vmd
>>> according to the I/O scenario without rebuilding driver.There are two
>>> params could be recognized: on, off. The default param is "NULL",
>>> the goal is not to affect the existing settings of the device.
>> Please add a space after the period that ends each sentence.
>> Capitalize "MSI" to match usage in spec.
>>
> Sorry for the format issue. I neglected them. My bad~
>
>>> Signed-off-by: Xinghui Li <korantli@tencent.com>
>>> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> I didn't see a response from Nirmal on the mailing list with the
>> Reviewed-by.  I think it's better if Nirmal responds to the patch
>> directly on the mailing list with the Reviewed-by, and whoever applies
>> the patch can incorporate it.  Otherwise we have no visibility into
>> any interaction between you and Nirmal.
>>
> I pinged Nirmal to reply to this patch, It seems he forgot to cc the
> mail list in the previous version's discussion.
>
>>> +/*
>>> + * The VMD msi_remap module parameter provides the alternative way
>>> + * to adjust msi mode when loading vmd.ko other than vmd_ids table.
>>> + * There are two params could be recognized:
>>> + *
>>> + * 1-off
>>> + * 2-on
>> It looks like your code matches either "on" or "off", not "1" or "2".
>>
> I will change the comment. It does mislead the reader. I mean the No.1
> param is "on" and the No.2 param is "off"
>
>>> + * The default param is "NULL", the goal is not to affect the existing
>>> + * settings of the device.
>>> + */
>>> +char *msi_remap = "NULL";
>> Looks like this should be static?  And using "NULL" (as opposed to
>> something like the empty string "") suggests some intrinsic meaning of
>> "NULL", but I think there is no intrinsic meaning and the only point
>> is that "NULL" doesn't match either "on" or "off".
>>
> The "static" one is better, I will add it.
> Initial parameters with "NULL" just aim to mismatch "on" or "off". Do
> you prefer to init it without the default string?

Please address Bjorn's comments. Thank you.

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

