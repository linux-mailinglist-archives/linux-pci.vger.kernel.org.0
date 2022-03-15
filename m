Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55B84DA11B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiCOR2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347737AbiCOR2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 13:28:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4469758810;
        Tue, 15 Mar 2022 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647365211; x=1678901211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ziFZXhnT03uuTOlbqC0mwUAOAr35MoEzqvS9Lt46bRY=;
  b=cCl5a8WOzZL0YfmBntZPZOfsuMxJ92lxp6l0S+LDgOEOVenBd4rovwxe
   3wfMIWKzI2ayYoAm4PmOW5dkojF07ehe+syJuDwrWGFBDifEylVNoNOby
   PMTJkqWXfKOkeO+BNkteJZsSUEikaj2ttwwCYLCWsRpLSHaExOPy17neZ
   x6r8mXdpV8gfCm3pKpxpFXFKkURBwDY6jydkdlfs97OvFAsJbeGuvIEW0
   ARWfQkjeLGnb+27v9W2IAeDGkGX++lVWcT4zUq5DcmOg2vhFSDKptBWia
   hHqxi07BY9nfmSUNnjAbVoTG8Di4Fokifsv0wGNxeL8vk+SglLp28y6OE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281143973"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="281143973"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:26:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="512690836"
Received: from rariley-mobl.amr.corp.intel.com (HELO [10.209.120.225]) ([10.209.120.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:26:46 -0700
Message-ID: <2d4e8811-dce6-c891-e92d-e3746434685e@linux.intel.com>
Date:   Tue, 15 Mar 2022 10:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Eric Badger <ebadger@purestorage.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220315171425.GA1521135@ebps>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220315171425.GA1521135@ebps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/22 10:14 AM, Eric Badger wrote:
>>   # Prep injection data for a correctable error.
>>   $ cd /sys/kernel/debug/apei/einj
>>   $ echo 0x00000040 > error_type
>>   $ echo 0x4 > flags
>>   $ echo 0x891000 > param4
>>
>>   # Root Error Status is initially clear
>>   $ setpci -s <Dev ID> ECAP0001+0x30.w
>>   0000
>>
>>   # Inject one error
>>   $ echo 1 > error_inject
>>
>>   # Interrupt received
>>   pcieport <Dev ID>: AER: Root Error Status 0001
>>
>>   # Inject another error (within 5 seconds)
>>   $ echo 1 > error_inject
>>
>>   # No interrupt received, but "multiple ERR_COR" is now set
>>   $ setpci -s <Dev ID> ECAP0001+0x30.w
>>   0003
>>
>>   # Wait for a while, then clear ERR_COR. A new interrupt immediately
>>     fires.
>>   $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
>>   pcieport <Dev ID>: AER: Root Error Status 0002
>>
>> Currently, the above issue has been only reproduced in the ICL server
>> platform.
>>
>> [Eric: proposed reproducing steps]
> Hmm, this differs from the procedure I described on v1, and I don't
> think will work as described here.

I have attempted to modify the steps to reproduce it without returning
IRQ_NONE for all cases (which will break the functionality). But I
think I did not correct the last few steps.

How about replacing the last 3 steps with following?

  # Inject another error (within 5 seconds)
  $ echo 1 > error_inject

  # You will get a new IRQ with only multiple ERR_COR bit set
  pcieport <Dev ID>: AER: Root Error Status 0002

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
