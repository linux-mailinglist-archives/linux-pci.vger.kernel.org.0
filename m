Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FC6B9517
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCNNAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjCNM7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 08:59:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EE29BA52;
        Tue, 14 Mar 2023 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678798538; x=1710334538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rmow8MmVfNohfbbu6S6MxBXECwf/J7vfVWyiDy1C384=;
  b=fsRjA52x8HyiQzO3IJo0feCUqHqgLtRjUW2jmuOd6Mo786joSaqQGg/1
   xZ3j+V2o3wBxX4+r1YC6WhJoyJD9/Ez3dAkCz/tWrc+87LDxIwFtpL+fL
   z6NGXmKWZBFWHx2J7zu19j4ahZQOQu2d4Jn8B5hEUikfVYowbah42abO6
   PbnihmCgehdoz6TNwRnWPq4eMiQqGYfECmzF3bqV9Hrm+u4ElG3vqOp8C
   BI3pMUjbUUVTbWfUczPhI8q850EBxUyaSfkCDHbglGG/DLen86KZMmSik
   R8TBOpHVF5gZ6P5rL4ggRBVVYJ4Y0/P/elkXLeCV2V9oOBMimYKzXUfGT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339777496"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="339777496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 05:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="768077784"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="768077784"
Received: from julieape-mobl.amr.corp.intel.com (HELO [10.209.119.116]) ([10.209.119.116])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 05:52:32 -0700
Message-ID: <646638fa-42e8-624a-068b-9c8a26ebfd98@linux.intel.com>
Date:   Tue, 14 Mar 2023 05:52:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230313211201.GA1540091@bhelgaas>
 <6339c50a-8dfe-f3a2-63d7-504abd4e62f0@linux.intel.com>
 <c7a68d5f-3b95-723f-f384-223fcbd6a877@os.amperecomputing.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c7a68d5f-3b95-723f-f384-223fcbd6a877@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
> 
> 
> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>> Hi Kulkarni,
>>
>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>> As per PCI specification (PCI Express Base Specification Revision
>>>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>>>> independently for ATS capability, however the STU(Smallest Translation
>>>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>>>> the associated PF's value applies to VFs.
>>>>
>>>> In the current code, the STU is being configured while enabling the PF ATS.
>>>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>>>> associated PF already.
>>>>
>>>> Adding a function pci_ats_stu_configure(), which can be called to
>>>> configure the STU during PF enumeration.
>>>> Latter enumerations of VFs can successfully enable ATS independently.
>>>
>>> s/STU(Smallest/STU (Smallest/ (add space before paren)
>>> s/Adding a function pci_ats_stu_configure()/Add pci_ats_stu_configure()/
>>> s/Latter/Subsequent/
>>>
>>> Add blank line between paragraphs (it looks like "Latter enumerations"
>>> is intended to start a new paragraph).
>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Given an ack for the IOMMU patch, I'd be happy to merge both (and I
>>> can do the commit log tweaks); just let me know.
>>>
>>> One comment/question below.
>>>
>>>> ---
>>>>   drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>>>>   include/linux/pci-ats.h |  3 +++
>>>>   2 files changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>> index f9cc2e10b676..1611bfa1d5da 100644
>>>> --- a/drivers/pci/ats.c
>>>> +++ b/drivers/pci/ats.c
>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>   +/**
>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>> + * @dev: the PCI device
>>>> + * @ps: the IOMMU page shift
>>>> + *
>>>> + * Returns 0 on success, or negative on failure.
>>>> + */
>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>> +{
>>>> +    u16 ctrl;
>>>> +
>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>> +        return 0;
>>>
>>> I might return an error for the VF case on the assumption that it's
>>> likely an error in the caller.  I guess one could argue that it
>>> simplifies the caller if it doesn't have to check for PF vs VF.  But
>>> the fact that STU is shared between PF and VFs is an important part of
>>> understanding how ATS works, so the caller should be aware of the
>>> distinction anyway.
>>
>> I have already asked this question. But let me repeat it.
>>
>> We don't have any checks for the PF case here. That means you can re-configure
>> the STU as many times as you want until ATS is enabled in PF. So, if there are
>> active VFs which uses this STU, can PF re-configure the STU at will?
>>
> 
> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 1611bfa1d5da..f7bb01068e18 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>         if (dev->ats_enabled || dev->is_virtfn)
>                 return 0;
> 
> +       /* Configured already */
> +       if (dev->ats_stu)
> +               return 0;
> +

Theoretically, you can re-configure STU as long as no one is using it. Instead of this check, is
there a way to check whether there are active VMs which enables ATS?

>         if (!pci_ats_supported(dev))
>                 return -EINVAL;
>>>
>>>> +
>>>> +    if (!pci_ats_supported(dev))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>> +        return -EINVAL;
>>>> +
>>>> +    dev->ats_stu = ps;
>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>> +
>>>>   /**
>>>>    * pci_enable_ats - enable the ATS capability
>>>>    * @dev: the PCI device
>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>           return -EINVAL;
>>>>         /*
>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>> -     * with the same STU on the PF.
>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>> +     * configured with the same STU on the PF.
>>>>        */
>>>>       ctrl = PCI_ATS_CTRL_ENABLE;
>>>>       if (dev->is_virtfn) {
>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>> index df54cd5b15db..7d62a92aaf23 100644
>>>> --- a/include/linux/pci-ats.h
>>>> +++ b/include/linux/pci-ats.h
>>>> @@ -8,6 +8,7 @@
>>>>   /* Address Translation Service */
>>>>   bool pci_ats_supported(struct pci_dev *dev);
>>>>   int pci_enable_ats(struct pci_dev *dev, int ps);
>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>>   void pci_disable_ats(struct pci_dev *dev);
>>>>   int pci_ats_queue_depth(struct pci_dev *dev);
>>>>   int pci_ats_page_aligned(struct pci_dev *dev);
>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>>   { return false; }
>>>>   static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>>   { return -ENODEV; }
>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>>> +{ return -ENODEV; }
>>>>   static inline void pci_disable_ats(struct pci_dev *d) { }
>>>>   static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>>   { return -ENODEV; }
>>>> -- 
>>>> 2.38.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> Thanks,
> Ganapat
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
