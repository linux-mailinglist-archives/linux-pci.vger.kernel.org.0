Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D056EA1A4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 04:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjDUCaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjDUCay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 22:30:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8D2680;
        Thu, 20 Apr 2023 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682044253; x=1713580253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lXmb3JKMQYphwt/h/vLhy2biJxC/A3UU1XVEqedzQEc=;
  b=Ibdf87UTT57mwRLYE9PRvoufavJsyCZtiZRphTpzCDcgdHdbmtejbWVd
   Sp30EfDuaOZBHHi1iWt7jX6qHZet6+9BLT3XXNdurj3059fCestLKVsRZ
   F0Lx7VvnF/yeRN5uuxFkVddTONF9ieyt3rQ1kr2EjavdBKnr0peyILhVc
   MkvaLeUmZ3qwx7kTId4+EBSM+o+MFRW3kaka95bX2IjOPcOXak+MOCUou
   HM+L39dDEKYWNJaQQ2XwAoZSn6iS6blSO+Y1Rrq74Y6dS85+UBobI+vIC
   glNqgdrCAKHbru/1OqIkYJOlnoKOQcIjB0lZuhUAmirFGC2ZP6v9gVK+F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="408836761"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="408836761"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 19:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="866546785"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="866546785"
Received: from bgroza-mobl.amr.corp.intel.com (HELO [10.212.168.100]) ([10.212.168.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 19:30:51 -0700
Message-ID: <adad9761-b671-66ec-8946-78d017071076@linux.intel.com>
Date:   Thu, 20 Apr 2023 19:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/4] PCI: Keep AER status in pci_restore_state()
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <e84eda25-dbe9-a108-c4d4-ee3fa746d9ca@linux.intel.com>
 <CAAd53p4hYR9f_Mh9cxGfBVnK_akLQMBACLDBnEHHzacJ5OZEGg@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAd53p4hYR9f_Mh9cxGfBVnK_akLQMBACLDBnEHHzacJ5OZEGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/20/23 6:35 PM, Kai-Heng Feng wrote:
> Hi Sathyanarayanan,
> 
> On Thu, Apr 20, 2023 at 10:39 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Hi Kai,
> 
> It's Kai-Heng :)
> 
>>
>> On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
>>> When AER is using the same IRQ as PME, AER interrupt is treated as a
>>> wakeup event and it can disrupt system suspend process.
>>>
>>> If that happens, the system will report it's woken up by PME IRQ without
>>> indicating any AER error since AER status is cleared on resume.
>>>
>>> So keep the AER status so users can know the system is woken up by AER
>>> instead of PME.
>>>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>
>> Any history on why it is cleared before? Is it done to hide some resume
>> issues?
> 
> It was introduced by commit b07461a8e45b ("PCI/AER: Clear error status
> registers during enumeration and restore").
> The justification is quite reasonable so I think maybe we should keep it as is.

Yes. It looks like it is better to leave it as it is.


> 
> Kai-Heng
> 
>>
>>> v3:
>>>  - No change.
>>>
>>> v2:
>>>  - New patch.
>>>
>>>  drivers/pci/pci.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 7a67611dc5f4..71aead00fc20 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1778,7 +1778,6 @@ void pci_restore_state(struct pci_dev *dev)
>>>       pci_restore_dpc_state(dev);
>>>       pci_restore_ptm_state(dev);
>>>
>>> -     pci_aer_clear_status(dev);
>>>       pci_restore_aer_state(dev);
>>>
>>>       pci_restore_config_space(dev);
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
