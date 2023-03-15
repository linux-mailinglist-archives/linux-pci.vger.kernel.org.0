Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C445B6BA61E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 05:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCOEWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCOEWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 00:22:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9E31E17;
        Tue, 14 Mar 2023 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678854129; x=1710390129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O1b/vZwXDv9P3fE6hz6f8P7YAE0JUZNpzgRhOi7jUrs=;
  b=lWlcsv4eDtLEo5kBFIb2wbxR0cvmwKal4wrLodYUDKiz7Cz0gwTibciA
   oB3tgELdTnrgi49d7sPUukYigu82CVI35NeqvHuedBZu3HEGm/E1uGfxk
   PZBh4xoeYVhQEWEqhtT4ZdlOsu9MMXI3FSxLShJMd48c5GD0WJf8/J/U7
   zi+EiwGHAiK/W2kg9eM9zribProrFcvQ7HRAVN5EfustWvYLI0ZlpIWRb
   i3vFJNhz7o1S6BHOX3LV6oGQvpCqmd9lczMgoHRsiOwX0H3VOqdoOVQh7
   CGD+lvI8d4humKsmUiNz0NCZwouav2+cbjmkZS1L1LzrTMmkrJRH2ATm8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400192927"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="400192927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 21:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672593121"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="672593121"
Received: from cfwielan-mobl.amr.corp.intel.com (HELO [10.209.88.145]) ([10.209.88.145])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 21:22:08 -0700
Message-ID: <de9c80fe-d857-c0e8-4950-1607ca3712fe@linux.intel.com>
Date:   Tue, 14 Mar 2023 21:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230314211739.GA1679724@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230314211739.GA1679724@bhelgaas>
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



On 3/14/23 2:17 PM, Bjorn Helgaas wrote:
> On Tue, Mar 14, 2023 at 11:12:11AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 3/14/23 10:10 AM, Bjorn Helgaas wrote:
>>> On Tue, Mar 14, 2023 at 09:50:06AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> On 3/14/23 9:02 AM, Bjorn Helgaas wrote:
>>>>> On Tue, Mar 14, 2023 at 08:06:07PM +0530, Ganapatrao Kulkarni wrote:
>>>>>> On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
>>>>>>> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
>>>>>>>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>>>>>>>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>>>>>>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>>>>>>>>> As per PCI specification (PCI Express Base Specification
>>>>>>>>>>> Revision 6.0, Section 10.5) both PF and VFs of a PCI EP
>>>>>>>>>>> are permitted to be enabled independently for ATS
>>>>>>>>>>> capability, however the STU(Smallest Translation Unit) is
>>>>>>>>>>> shared between PF and VFs. For VFs, it is hardwired to
>>>>>>>>>>> Zero and the associated PF's value applies to VFs.
>>>>>>>>>>>
>>>>>>>>>>> In the current code, the STU is being configured while
>>>>>>>>>>> enabling the PF ATS.  Hence, it is not able to enable ATS
>>>>>>>>>>> for VFs, if it is not enabled on the associated PF
>>>>>>>>>>> already.
>>>>>>>>>>>
>>>>>>>>>>> Adding a function pci_ats_stu_configure(), which can be
>>>>>>>>>>> called to configure the STU during PF enumeration.  Latter
>>>>>>>>>>> enumerations of VFs can successfully enable ATS
>>>>>>>>>>> independently.
>>>>>
>>>>>>>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>>>>>>>>    }
>>>>>>>>>>>    EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>>>>>>>>    +/**
>>>>>>>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>>>>>>>>> + * @dev: the PCI device
>>>>>>>>>>> + * @ps: the IOMMU page shift
>>>>>>>>>>> + *
>>>>>>>>>>> + * Returns 0 on success, or negative on failure.
>>>>>>>>>>> + */
>>>>>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>>>>>> +{
>>>>>>>>>>> +    u16 ctrl;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>>>>>>>>> +        return 0;
>>>>>>>>>>
>>>>>>>>>> I might return an error for the VF case on the assumption
>>>>>>>>>> that it's likely an error in the caller.  I guess one could
>>>>>>>>>> argue that it simplifies the caller if it doesn't have to
>>>>>>>>>> check for PF vs VF.  But the fact that STU is shared between
>>>>>>>>>> PF and VFs is an important part of understanding how ATS
>>>>>>>>>> works, so the caller should be aware of the distinction
>>>>>>>>>> anyway.
>>>>>>>>>
>>>>>>>>> I have already asked this question. But let me repeat it.
>>>>>>>>>
>>>>>>>>> We don't have any checks for the PF case here. That means you
>>>>>>>>> can re-configure the STU as many times as you want until ATS
>>>>>>>>> is enabled in PF. So, if there are active VFs which uses this
>>>>>>>>> STU, can PF re-configure the STU at will?
>>>>>>>>
>>>>>>>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>>>>> index 1611bfa1d5da..f7bb01068e18 100644
>>>>>>>> --- a/drivers/pci/ats.c
>>>>>>>> +++ b/drivers/pci/ats.c
>>>>>>>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>>>          if (dev->ats_enabled || dev->is_virtfn)
>>>>>>>>                  return 0;
>>>>>>>>
>>>>>>>> +       /* Configured already */
>>>>>>>> +       if (dev->ats_stu)
>>>>>>>> +               return 0;
>>>>>>>
>>>>>>> Theoretically, you can re-configure STU as long as no one is using
>>>>>>> it. Instead of this check, is there a way to check whether there
>>>>>>> are active VMs which enables ATS?
>>>>>>
>>>>>> Yes I agree, there is no limitation on how many times you write STU
>>>>>> bits, but practically it is happening while PF is enumerated.
>>>>>>
>>>>>> The usage of function pci_ats_stu_configure is almost
>>>>>> similar(subset) to pci_enable_ats and only difference is one does
>>>>>> ATS enable + STU program and another does only STU program.
>>>>>
>>>>> What would you think of removing the STU update feature from
>>>>> pci_enable_ats() so it always fails if pci_ats_stu_configure() has not
>>>>> been called, even when called on the PF, e.g.,
>>>>>
>>>>>   if (ps != pci_physfn(dev)->ats_stu)
>>>>>     return -EINVAL;
>>>>
>>>> If we are removing the STU update from pci_enable_ats(), why
>>>> even allow passing "ps (page shift)" parameter? IMO, we can assume that
>>>> for STU reconfigure, users will call pci_ats_stu_configure().
>>>
>>> The reason to pass "ps" would be to verify that the STU the caller
>>> plans to use matches the actual STU.
>>
>> Do we really need to verify it? My thinking is, by introducing
>> pci_ats_stu_configure() we are already trying to decouple the STU config
>> from pci_enable_ats(). So why again check for it when enabling ATS?
> 
> Yeah, maybe we don't need to.  I was thinking that STU would be
> configured by the host, while the caller of pci_enable_ats() for a VF
> might be in a guest, but I guess that's not the case, right?

I think the idea is to configure the STU during PF enumeration in the
host. So, when VF enables ATS in the VM, it does not need to worry about
the STU configuration. So I don't think we need to re-check the STU in
the VF case.

> 
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
