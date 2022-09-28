Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98B5ED3E6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 06:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiI1Ea6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 00:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiI1Ea5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 00:30:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951C9B871;
        Tue, 27 Sep 2022 21:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664339453; x=1695875453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dpjycpQPackQteLHBBGJE4Wm5YPd9EdeBKzweZPn9SA=;
  b=maIrD6EPCXJ6n214ubE52k369f/QNALPQu5c1CjobKbvGnbGfZ7w2k/0
   4itPhGeceouaDjFUb8yPT4ObpqMWnRJ8feJgIVUyHCgTn07Uwq6RrNBVR
   fCCpgEv6AoQKn6tyQ7uj+oaLhAqoIEG/F5oW0/NOQdXud53xIUx9CTu/r
   s1en1i5kW2Eptd/AZy6UYh68TFrAJ/90OIUfhv9Vt9BFAgjJ8O1zzN6IH
   MtbKDXIkBYA0Ox+EGYZ9Go2ygd7GuVxavc9xv/hnWbcZwLsB4oC5T8GX/
   oOC0M97P69fwcs4vr4lzpv2Ys0TNOCIt6TnjbIII2sPUbtNScLI+Lkh1m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300218824"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300218824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 21:30:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684250788"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="684250788"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 21:30:51 -0700
Message-ID: <d3a5edb8-03cb-2ecb-b54c-9a2e05765805@linux.intel.com>
Date:   Tue, 27 Sep 2022 21:30:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [External] Re: [PATCH v2 3/9] NTB: Change to use
 pci_aer_clear_uncorrect_error_status()
Content-Language: en-US
To:     Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-4-chenzhuo.1@bytedance.com>
 <d8123aa3-a5e0-6131-bd0d-109f67923ff2@linux.intel.com>
 <1d62d0ac-b47c-94b5-dd75-b7df71817d0d@bytedance.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1d62d0ac-b47c-94b5-dd75-b7df71817d0d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/27/22 9:20 PM, Zhuo Chen wrote:
> 
> 
> On 9/28/22 3:39 AM, Sathyanarayanan Kuppuswamy wrote:
>>
>>
>> On 9/27/22 8:35 AM, Zhuo Chen wrote:
>>> Status bits for ERR_NONFATAL errors only are cleared in
>>> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
>>> error status in idt_init_pci(), so we change to use
>>> pci_aer_clear_uncorrect_error_status().
>>
>> You mean currently driver does not clear fatal errors now, and it is
>> a problem? Any error reported?
>>
> Hi Sathyanarayanan,
> 
> No error reports yet, I just changes the behavior back to what it was before commit e7b0b847de6d ("PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery"), because this commit change the original function in commit bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support").
> 

Ok. Thanks for clarifying.

>> Also, I am wondering why is it required to clear errors during init
>> code. Is it a norm?
>>
> I think there is no need to clear errors during init code.
>>>
>>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>>> ---
>>>   drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
>>> index 0ed6f809ff2e..d5f0aa87f817 100644
>>> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
>>> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
>>> @@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>>>       ret = pci_enable_pcie_error_reporting(pdev);
>>>       if (ret != 0)
>>>           dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
>>> -    else /* Cleanup nonfatal error status before getting to init */
>>> -        pci_aer_clear_nonfatal_status(pdev);
>>> +    else /* Cleanup uncorrectable error status before getting to init */
>>> +        pci_aer_clear_uncorrect_error_status(pdev);
>>>         /* First enable the PCI device */
>>>       ret = pcim_enable_device(pdev);
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
