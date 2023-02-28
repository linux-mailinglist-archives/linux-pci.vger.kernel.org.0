Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2716A519F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 04:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjB1DIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 22:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1DIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 22:08:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD60900F;
        Mon, 27 Feb 2023 19:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677553699; x=1709089699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aFeH2nXRI4dqYxpamP5Js4ORwQlkFpZJtH/0H8oYJnw=;
  b=D103bOOs8I9kZ9baOiftgO8dQBX4yVbPHUU52NXWxeRT4s91uk3c2Qwp
   1Is0mwuzxWJvLkoXywai8ENraAiGCBQJrvtr4n39uehvrSlYbqrhjwJGn
   QopvbALNpDCrNrrMoePH85LIgvjRpeY2/XwIBY7KhNbmqQ6Zqb+bTW6ya
   yfnMNxSf4UMZQfY7n8pePEeMQwSd7uJefmyuIIF161tu78VLRZqSIvM1h
   iXfGWmASVa52lu8yf2Mfm9CTAlwlCpMwutF5a5ftpHzKBbb//6lVS9UbO
   +/zFq50161fk8bpICGvf0tMjDNSYzDslNIfnW+bpabb7bzeC8FCT5wenK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="336319426"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="336319426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 19:08:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="783654168"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="783654168"
Received: from ticela-az-102.amr.corp.intel.com (HELO [10.209.55.154]) ([10.209.55.154])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 19:08:18 -0800
Message-ID: <47a88e5f-ee56-9c4b-e134-e018cd6dc49e@linux.intel.com>
Date:   Mon, 27 Feb 2023 19:08:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] PCI/ATS: Add a helper function to configure ATS STU
 of a PF.
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
 <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
 <b7a71cca-8223-7346-c024-edc80a106042@linux.intel.com>
 <e80adfa5-b51a-a1ae-f582-58eaa4a5be68@os.amperecomputing.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e80adfa5-b51a-a1ae-f582-58eaa4a5be68@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/27/23 6:53 PM, Ganapatrao Kulkarni wrote:
> 
> 
> On 28-02-2023 12:59 am, Sathyanarayanan Kuppuswamy wrote:
>> Hi,
>>
>> On 2/27/23 5:21 AM, Ganapatrao Kulkarni wrote:
>>> As per PCI specification (PCI Express Base Specification Revision
>>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>>> independently for ATS capability, however the STU(Smallest Translation
>>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>>> the associated PF's value applies to VFs.
>>>
>>> In the current code, the STU is being configured while enabling the PF ATS.
>>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>>> associated PF already.>
>>> Adding a function pci_ats_stu_configure(), which can be called to
>>> configure the STU during PF enumeration.
>>> Latter enumerations of VFs can successfully enable ATS independently.
>>
>> Why not enable ATS in PF before enabling it in VF? Just updating STU of
>> PF and not enabling it seem odd.
> 
> More details are in PATCH 0/2 and 2/2.
> 
> Also, This was discussed at
> https://lore.kernel.org/linux-arm-kernel/20230221154624.GA3701506@bhelgaas/T/
> 

I agree with Bjorn's comments. It is incorrect to directly configure PF
registers from VF enable function. It is a buggy fix.

My question is, why not ensure PF ATS is configured and enabled before enabling
ATS for VF. Anyway, PF device will be enumerated before VF, right?

>>
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>>   drivers/pci/ats.c       | 32 ++++++++++++++++++++++++++++++--
>>>   include/linux/pci-ats.h |  1 +
>>>   2 files changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>> index f9cc2e10b676..70e1982efdb4 100644
>>> --- a/drivers/pci/ats.c
>>> +++ b/drivers/pci/ats.c
>>> @@ -46,6 +46,34 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>   }
>>>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>   +/**
>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>> + * @dev: the PCI device
>>> + * @ps: the IOMMU page shift
>>> + *
>>> + * Returns 0 on success, or negative on failure.
>>> + */
>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>> +{
>>> +    u16 ctrl;
>>> +
>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>> +        return 0;
>>> +
>>> +    if (!pci_ats_supported(dev))
>>> +        return -EINVAL;
>>> +
>>> +    if (ps < PCI_ATS_MIN_STU)
>>> +        return -EINVAL;
>>> +
>>> +    dev->ats_stu = ps;
>>> +    ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>
>> If you just want to update the STU, don't overwrite other fields.
> 
> Can be read modify write, but felt not necessary, since all other fields are at default value zero.

It may not always be true. If there is a case where AMAD and AMAE attribute values are
configured independently, then your change can overwrite it.

IMO, since your intention is to update STU, I recommend just updating it.

> 
>>
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>> +
>>>   /**
>>>    * pci_enable_ats - enable the ATS capability
>>>    * @dev: the PCI device
>>> @@ -68,8 +96,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>           return -EINVAL;
>>>         /*
>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>> -     * with the same STU on the PF.
>>> +     * Note that enabling ATS on a VF fails unless it's already
>>> +     * configured with the same STU on the PF.
>>>        */
>>>       ctrl = PCI_ATS_CTRL_ENABLE;
>>>       if (dev->is_virtfn) {
>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>> index df54cd5b15db..9b40eb555124 100644
>>> --- a/include/linux/pci-ats.h
>>> +++ b/include/linux/pci-ats.h
>>> @@ -8,6 +8,7 @@
>>>   /* Address Translation Service */
>>>   bool pci_ats_supported(struct pci_dev *dev);
>>>   int pci_enable_ats(struct pci_dev *dev, int ps);
>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>
>> What about dummy declaration for !CONFIG_PCI_ATS case?
> 
> Thanks, I overlooked else case.
>>
>>>   void pci_disable_ats(struct pci_dev *dev);
>>>   int pci_ats_queue_depth(struct pci_dev *dev);
>>>   int pci_ats_page_aligned(struct pci_dev *dev);
>>
> 
> 
> Thanks,
> Ganapat

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
