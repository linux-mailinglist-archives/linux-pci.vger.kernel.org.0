Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C894B16CF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 21:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbiBJUOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 15:14:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJUOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 15:14:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB226F3
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644524045; x=1676060045;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hxbgACi/K9twy9oVNttDmaTok36q0FyOIfxCIra+76E=;
  b=U+7OVwFctdu0UKs6tx093L/XE43LUq3F2+cADay75MzJksz8x/dw84cc
   P2r+zKse9Z2HxdQ2GBvSskybyTw0tvBtMQChYvgFVpBPNHmKatdPVQDIS
   6uF7Ik6/s8TsXW7FxKIQ4ktABOGynGTzpQCmPLY2JbBTLntw+ie+JYWMq
   40eCGwoIktZH8plaDPno3oC2gWR+9SNWfZRrNI85IdlRGV+mXRQwnV0Uj
   4subB27CZaeAeiZYdiRQJvHUUyhXvIm52iAI2l7tLct5wr9JpQL09FAuu
   w6fyNyDK/ynoJmZaHLCBIdW5H7HSZK/JU32qf2jbrZQhru2KyiqDd2hJO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233142975"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="233142975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:14:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="633809649"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.131.28]) ([10.212.131.28])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:14:04 -0800
Message-ID: <c66d146a-ca62-3da5-a93e-394d2d444934@linux.intel.com>
Date:   Thu, 10 Feb 2022 13:14:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] PCI: vmd: Check EIME mode before MSI remapping
Content-Language: en-US
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220204084036.5017-1-nirmal.patel@linux.intel.com>
 <6def8bea-d6ae-90ec-0804-11812d1ae8eb@linux.intel.com>
 <2244c362-44c0-81b5-da1c-5b0311c93152@linux.dev>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <2244c362-44c0-81b5-da1c-5b0311c93152@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/10/2022 10:40 AM, Jonathan Derrick wrote:
>
>
> On 2/9/2022 1:56 PM, Patel, Nirmal wrote:
>> On 2/4/2022 1:40 AM, Nirmal Patel wrote:
>>> We are observing DMAR errors from vt-d when vmd is enabled along with
>>> interrupt remapping and extended interrupt mode. As a result the host
>>> machine is not able boot successfully.
>>>
>>> DMAR: DRHD: handling fault status reg 2
>>> DMAR: [INTR-REMAP] Request device [0xc9:0x05.0] fault index 0xa00
>>> [fault reason 0x25] Blocked a compatibility format interrupt request
>>>
>>> The issue was observed in intel Whitley platform and newer with ICE
> Capitalize 'Intel'
Sure.
>
>
>>> Lake processor with latest kernel. The issued was also reproduced in
>>> 5.10 by backporting patches related to commit ee81ee84f873 ("PCI: vmd:
>>> Disable MSI-X remapping when possible")
>>>
>>> According to Intel VT-d specs section "5.1.4 Interrupt-Remapping
>>> Hardware Operation", If Extended Interrupt Mode is enabled (EIME), or
>>> if the Compatibility format interrupts are disabled (CFIS), the
>>> Compatibility format interrupts are blocked.
>>>
>>> Do not disable MSI remapping if interrupt remapping enabled and
>>> x2apic_opt_out mode is disabled.
> This doesn't really satisfy the explanation as to why this mode is not
> working. The compatibility format interrupt requests are correctly blocked,
> however they should not be being programmed with compatibility format
> interrupt requests in the first place. The interrupt request programming
> should be done according to the Intel IRQ remapping formats and this should
> be VMD-compatible (or at least, it was at one point). Though I don't know
> how EIME differs from what I observed before...
>
> If this patch is just a placeholder until the issue can be investigated
> and fixed, can you please say that in the commit message?
>
>
This patch is indeed a placeholder which allow platforms to boot normally.
I will try to figure out how I can keep the interrupts in remappable format
instead of compatibility format.

>>>
>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>> ---
>>>   drivers/pci/controller/vmd.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index cc166c683638..4eb38c6bd578 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/srcu.h>
>>>   #include <linux/rculist.h>
>>>   #include <linux/rcupdate.h>
>>> +#include <asm/apic.h>
>>>     #include <asm/irqdomain.h>
>>>   @@ -814,7 +815,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>        * remapping doesn't become a performance bottleneck.
>>>        */
>>>       if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>>> -        !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>> +        x2apic_enabled() || !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>>           offset[0] || offset[1]) {
> This conditional is getting a little unsightly and over-encompassing.
> Can you split it up into multiple conditionals and add appropriate comments?
>
Sure. I will add corrections.
>
>>>           ret = vmd_alloc_irqs(vmd);
>>>           if (ret)
>>
>> Hello,
>>
>> Gentle ping. Please let me know if there is a suggestion.
>>
>> Thanks.
>>

