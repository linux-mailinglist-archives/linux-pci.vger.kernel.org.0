Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00006B9C16
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCNQuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCNQuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 12:50:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5E84804;
        Tue, 14 Mar 2023 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678812608; x=1710348608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tM1RpcZvwfdv2gg0/DYI/dHIKcwOWSpAYkoA6QoGt90=;
  b=l2vWxcRxTYFN1iHHJWq8GuHM9hY4gmFOiOO0Ycvt2zhTXj1qVtrMIV1t
   FhEOhO2uSQSciDRAxIdTwcdDUtwhzABXhufSYyps34fyQX6sztGBkzj5W
   3sdUdwhSQ0iIdARWPqn+dwH4HSFCm1m0RdKGAW8DauYaAl5KI2U7tXr1w
   18aKugQSZ4X8h+XdlNZ1KdGusFw5EpbS6/8vQUBJPWUlx8bAuC6onOn+p
   xTeDEnrSDzBEwCVFuluN8tssTvU9z/Pko86qqRlLSYCHY7fIpcfZexFfb
   Tg7p4M5Srr/zcTpNyZL8HhDWOYGfGYXiCtIBwjgECqt1Ay7Qc1FXRO4Al
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321331427"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="321331427"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="789439391"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="789439391"
Received: from julieape-mobl.amr.corp.intel.com (HELO [10.209.119.116]) ([10.209.119.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:50:07 -0700
Message-ID: <6d3b4608-f859-f1c3-2391-0017d1b512f4@linux.intel.com>
Date:   Tue, 14 Mar 2023 09:50:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230314160227.GA1645738@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230314160227.GA1645738@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/14/23 9:02 AM, Bjorn Helgaas wrote:
> On Tue, Mar 14, 2023 at 08:06:07PM +0530, Ganapatrao Kulkarni wrote:
>> On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
>>> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
>>>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
>>>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
>>>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
>>>>>>> As per PCI specification (PCI Express Base Specification
>>>>>>> Revision 6.0, Section 10.5) both PF and VFs of a PCI EP
>>>>>>> are permitted to be enabled independently for ATS
>>>>>>> capability, however the STU(Smallest Translation Unit) is
>>>>>>> shared between PF and VFs. For VFs, it is hardwired to
>>>>>>> Zero and the associated PF's value applies to VFs.
>>>>>>>
>>>>>>> In the current code, the STU is being configured while
>>>>>>> enabling the PF ATS.  Hence, it is not able to enable ATS
>>>>>>> for VFs, if it is not enabled on the associated PF
>>>>>>> already.
>>>>>>>
>>>>>>> Adding a function pci_ats_stu_configure(), which can be
>>>>>>> called to configure the STU during PF enumeration.  Latter
>>>>>>> enumerations of VFs can successfully enable ATS
>>>>>>> independently.
> 
>>>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>>>>    }
>>>>>>>    EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>>>>    +/**
>>>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>>>>> + * @dev: the PCI device
>>>>>>> + * @ps: the IOMMU page shift
>>>>>>> + *
>>>>>>> + * Returns 0 on success, or negative on failure.
>>>>>>> + */
>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>>>> +{
>>>>>>> +    u16 ctrl;
>>>>>>> +
>>>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>>>>> +        return 0;
>>>>>>
>>>>>> I might return an error for the VF case on the assumption
>>>>>> that it's likely an error in the caller.  I guess one could
>>>>>> argue that it simplifies the caller if it doesn't have to
>>>>>> check for PF vs VF.  But the fact that STU is shared between
>>>>>> PF and VFs is an important part of understanding how ATS
>>>>>> works, so the caller should be aware of the distinction
>>>>>> anyway.
>>>>>
>>>>> I have already asked this question. But let me repeat it.
>>>>>
>>>>> We don't have any checks for the PF case here. That means you
>>>>> can re-configure the STU as many times as you want until ATS
>>>>> is enabled in PF. So, if there are active VFs which uses this
>>>>> STU, can PF re-configure the STU at will?
>>>>
>>>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
>>>>
>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>> index 1611bfa1d5da..f7bb01068e18 100644
>>>> --- a/drivers/pci/ats.c
>>>> +++ b/drivers/pci/ats.c
>>>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>>          if (dev->ats_enabled || dev->is_virtfn)
>>>>                  return 0;
>>>>
>>>> +       /* Configured already */
>>>> +       if (dev->ats_stu)
>>>> +               return 0;
>>>
>>> Theoretically, you can re-configure STU as long as no one is using
>>> it. Instead of this check, is there a way to check whether there
>>> are active VMs which enables ATS?
>>
>> Yes I agree, there is no limitation on how many times you write STU
>> bits, but practically it is happening while PF is enumerated.
>>
>> The usage of function pci_ats_stu_configure is almost
>> similar(subset) to pci_enable_ats and only difference is one does
>> ATS enable + STU program and another does only STU program.
> 
> What would you think of removing the STU update feature from
> pci_enable_ats() so it always fails if pci_ats_stu_configure() has not
> been called, even when called on the PF, e.g.,
> 
>   if (ps != pci_physfn(dev)->ats_stu)
>     return -EINVAL;


If we are removing the STU update from pci_enable_ats(), why
even allow passing "ps (page shift)" parameter? IMO, we can assume that
for STU reconfigure, users will call pci_ats_stu_configure().

Since zero is a valid STU, enabling ATS can be decoupled from STU
update.

> 
>   pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>   ctrl |= PCI_ATS_CTRL_ENABLE;
>   pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> 
> Would probably also have to set "dev->ats_stu = 0" in
> pci_disable_ats() to allow the possibility of calling
> pci_ats_stu_configure() again.
> 
>> IMO, I dont think, there is any need to find how many active VMs
>> with attached VFs and it is not done for pci_enable_ats as well.
> 
> Enabling or disabling ATS in a PF or VF has no effect on other
> functions.
> 
> But changing STU while a VF has ATS enabled would definitely break any
> user of that VF, so if it's practical to verify that no VFs have ATS
> enabled, I think we should.

I also think it is better to check for a ats_enabled status of VF before
configuring the STU.

May be something like below (untested),

static int is_ats_enabled_in_vf(struct pci_dev *dev)
{
        struct pci_sriov *iov = dev->sriov;
        struct pci_dev *vdev;

        if (dev->is_virtfn) 
                return -EINVAL;

        for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
                vdev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
                                             pci_iov_virtfn_bus(dev, i),
                                             pci_iov_virtfn_devfn(dev, i));
                if (vdev && vdev->ats_enabled)
                        return 1;
        }

        return 0;

}

int pci_ats_stu_configure(struct pci_dev *dev, int ps)
{
...
if (is_ats_enabled_in_vf(dev))
   return -EBUSY;

> 
>> Also the caller has the requirement to call either
>> pci_ats_stu_configure or pci_enable_ats while enumerating the PF.
>>
>>>>          if (!pci_ats_supported(dev))
>>>>                  return -EINVAL;
>>>>>>
>>>>>>> +
>>>>>>> +    if (!pci_ats_supported(dev))
>>>>>>> +        return -EINVAL;
>>>>>>> +
>>>>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>>>>> +        return -EINVAL;
>>>>>>> +
>>>>>>> +    dev->ats_stu = ps;
>>>>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
>>>>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>>>>> +
>>>>>>>    /**
>>>>>>>     * pci_enable_ats - enable the ATS capability
>>>>>>>     * @dev: the PCI device
>>>>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>>>>            return -EINVAL;
>>>>>>>          /*
>>>>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>>>>> -     * with the same STU on the PF.
>>>>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>>>>> +     * configured with the same STU on the PF.
>>>>>>>         */
>>>>>>>        ctrl = PCI_ATS_CTRL_ENABLE;
>>>>>>>        if (dev->is_virtfn) {
>>>>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>>>>> index df54cd5b15db..7d62a92aaf23 100644
>>>>>>> --- a/include/linux/pci-ats.h
>>>>>>> +++ b/include/linux/pci-ats.h
>>>>>>> @@ -8,6 +8,7 @@
>>>>>>>    /* Address Translation Service */
>>>>>>>    bool pci_ats_supported(struct pci_dev *dev);
>>>>>>>    int pci_enable_ats(struct pci_dev *dev, int ps);
>>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>>>>>    void pci_disable_ats(struct pci_dev *dev);
>>>>>>>    int pci_ats_queue_depth(struct pci_dev *dev);
>>>>>>>    int pci_ats_page_aligned(struct pci_dev *dev);
>>>>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>>>>>>>    { return false; }
>>>>>>>    static inline int pci_enable_ats(struct pci_dev *d, int ps)
>>>>>>>    { return -ENODEV; }
>>>>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
>>>>>>> +{ return -ENODEV; }
>>>>>>>    static inline void pci_disable_ats(struct pci_dev *d) { }
>>>>>>>    static inline int pci_ats_queue_depth(struct pci_dev *d)
>>>>>>>    { return -ENODEV; }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
