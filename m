Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B78A8FC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfHLVHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 17:07:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:44251 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLVHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 17:07:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 14:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="180983819"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2019 14:06:33 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id A6A615806A0;
        Mon, 12 Aug 2019 14:06:33 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-2-efremov@linux.com>
 <925a00be-c2b6-697d-d46b-a279856105b4@linux.intel.com>
 <d243b4e7-acd9-790f-9332-2654a908cf6e@linux.intel.com>
 <20190812204024.r54ihfwdcbwdj563@wunner.de>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <c9bb5e76-d6f6-9d59-d581-564e1385aa45@linux.intel.com>
Date:   Mon, 12 Aug 2019 14:03:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812204024.r54ihfwdcbwdj563@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/12/19 1:40 PM, Lukas Wunner wrote:
> On Mon, Aug 12, 2019 at 11:49:23AM -0700, sathyanarayanan kuppuswamy wrote:
>>> On 8/11/19 12:59 PM, Denis Efremov wrote:
>>>> +    if ((!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
>>>> +        (!ATTN_LED(ctrl) || attn == ATTN_NONE))
>>>> +        return;
>> Also I think this condition needs to expand to handle the case whether pwr
>> != PWR_NONE and !PWR_LED(ctrl) is true.
>>
>> you need to return for case, pwr = PWR_ON, !PWR_LED(ctrl)=true ,
>> !ATTN_LED(ctrl)=false, attn=on
> Why should we return in that case?  We need to update the Attention
> Indicator Control to On.

Attempting to PWR_ON when !PWR_LED(ctrl) is true is incorrect right ? 
Even if you don't want to return (to handle ATTN part of the function), 
may be you should skip updating PWR mask and cmd for this case.

>
> Thanks,
>
> Lukas
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

