Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E36B9C8F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCNRKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCNRKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 13:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158B61AAE;
        Tue, 14 Mar 2023 10:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79EAF61865;
        Tue, 14 Mar 2023 17:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4172C433D2;
        Tue, 14 Mar 2023 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678813847;
        bh=ok1k63vTwaFT1h6WbAsaye8ZP5fcNL1HoRcPKwtbVtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b5JwnUG5XA7W5kE4jyFISaw2q860l5uvxAHwMuk5lHg+BEEqh0TT2uVLDCxsmCTDQ
         3C84R7HuY2lWuRB01w97S61A/z25ENX9FxOXCp7sZTZf+l/2PfEpCR29v8vnqK/fWe
         IZI1l5Uz3qZCF0f9VqGtsQWMiH7QcvuKHE96fVzJSBRpU0/vOYpFLPc2ANuPmZ36Gm
         VapqcxYrs+3lnS9Qy5HXZeE9aEb56zmuIvadvnGSg1VyYozj0yLpdCY4Xq9vT0jMie
         Y6EXwMWAfnQuE1YYVshLMkYLi09aT9Fn5BDqP4nTSxCN7A313gbcyUTl4KJmAJ+Nu3
         pY/eTBAqYMyKg==
Date:   Tue, 14 Mar 2023 12:10:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Message-ID: <20230314171046.GA1655423@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d3b4608-f859-f1c3-2391-0017d1b512f4@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 09:50:06AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/14/23 9:02 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 14, 2023 at 08:06:07PM +0530, Ganapatrao Kulkarni wrote:
> >> On 14-03-2023 06:22 pm, Sathyanarayanan Kuppuswamy wrote:
> >>> On 3/14/23 3:08 AM, Ganapatrao Kulkarni wrote:
> >>>> On 14-03-2023 04:00 am, Sathyanarayanan Kuppuswamy wrote:
> >>>>> On 3/13/23 2:12 PM, Bjorn Helgaas wrote:
> >>>>>> On Mon, Feb 27, 2023 at 08:21:36PM -0800, Ganapatrao Kulkarni wrote:
> >>>>>>> As per PCI specification (PCI Express Base Specification
> >>>>>>> Revision 6.0, Section 10.5) both PF and VFs of a PCI EP
> >>>>>>> are permitted to be enabled independently for ATS
> >>>>>>> capability, however the STU(Smallest Translation Unit) is
> >>>>>>> shared between PF and VFs. For VFs, it is hardwired to
> >>>>>>> Zero and the associated PF's value applies to VFs.
> >>>>>>>
> >>>>>>> In the current code, the STU is being configured while
> >>>>>>> enabling the PF ATS.  Hence, it is not able to enable ATS
> >>>>>>> for VFs, if it is not enabled on the associated PF
> >>>>>>> already.
> >>>>>>>
> >>>>>>> Adding a function pci_ats_stu_configure(), which can be
> >>>>>>> called to configure the STU during PF enumeration.  Latter
> >>>>>>> enumerations of VFs can successfully enable ATS
> >>>>>>> independently.
> > 
> >>>>>>> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
> >>>>>>>    }
> >>>>>>>    EXPORT_SYMBOL_GPL(pci_ats_supported);
> >>>>>>>    +/**
> >>>>>>> + * pci_ats_stu_configure - Configure STU of a PF.
> >>>>>>> + * @dev: the PCI device
> >>>>>>> + * @ps: the IOMMU page shift
> >>>>>>> + *
> >>>>>>> + * Returns 0 on success, or negative on failure.
> >>>>>>> + */
> >>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> >>>>>>> +{
> >>>>>>> +    u16 ctrl;
> >>>>>>> +
> >>>>>>> +    if (dev->ats_enabled || dev->is_virtfn)
> >>>>>>> +        return 0;
> >>>>>>
> >>>>>> I might return an error for the VF case on the assumption
> >>>>>> that it's likely an error in the caller.  I guess one could
> >>>>>> argue that it simplifies the caller if it doesn't have to
> >>>>>> check for PF vs VF.  But the fact that STU is shared between
> >>>>>> PF and VFs is an important part of understanding how ATS
> >>>>>> works, so the caller should be aware of the distinction
> >>>>>> anyway.
> >>>>>
> >>>>> I have already asked this question. But let me repeat it.
> >>>>>
> >>>>> We don't have any checks for the PF case here. That means you
> >>>>> can re-configure the STU as many times as you want until ATS
> >>>>> is enabled in PF. So, if there are active VFs which uses this
> >>>>> STU, can PF re-configure the STU at will?
> >>>>
> >>>> IMO, Since STU is shared, programming it multiple times is not expected from callers code do it, however we can add below check to allow to program STU once from a PF.
> >>>>
> >>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> >>>> index 1611bfa1d5da..f7bb01068e18 100644
> >>>> --- a/drivers/pci/ats.c
> >>>> +++ b/drivers/pci/ats.c
> >>>> @@ -60,6 +60,10 @@ int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> >>>>          if (dev->ats_enabled || dev->is_virtfn)
> >>>>                  return 0;
> >>>>
> >>>> +       /* Configured already */
> >>>> +       if (dev->ats_stu)
> >>>> +               return 0;
> >>>
> >>> Theoretically, you can re-configure STU as long as no one is using
> >>> it. Instead of this check, is there a way to check whether there
> >>> are active VMs which enables ATS?
> >>
> >> Yes I agree, there is no limitation on how many times you write STU
> >> bits, but practically it is happening while PF is enumerated.
> >>
> >> The usage of function pci_ats_stu_configure is almost
> >> similar(subset) to pci_enable_ats and only difference is one does
> >> ATS enable + STU program and another does only STU program.
> > 
> > What would you think of removing the STU update feature from
> > pci_enable_ats() so it always fails if pci_ats_stu_configure() has not
> > been called, even when called on the PF, e.g.,
> > 
> >   if (ps != pci_physfn(dev)->ats_stu)
> >     return -EINVAL;
> 
> If we are removing the STU update from pci_enable_ats(), why
> even allow passing "ps (page shift)" parameter? IMO, we can assume that
> for STU reconfigure, users will call pci_ats_stu_configure().

The reason to pass "ps" would be to verify that the STU the caller
plans to use matches the actual STU.

> Since zero is a valid STU, enabling ATS can be decoupled from STU
> update.
>
> >   pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
> >   ctrl |= PCI_ATS_CTRL_ENABLE;
> >   pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> > 
> > Would probably also have to set "dev->ats_stu = 0" in
> > pci_disable_ats() to allow the possibility of calling
> > pci_ats_stu_configure() again.
> > 
> >> IMO, I dont think, there is any need to find how many active VMs
> >> with attached VFs and it is not done for pci_enable_ats as well.
> > 
> > Enabling or disabling ATS in a PF or VF has no effect on other
> > functions.
> > 
> > But changing STU while a VF has ATS enabled would definitely break any
> > user of that VF, so if it's practical to verify that no VFs have ATS
> > enabled, I think we should.
> 
> I also think it is better to check for a ats_enabled status of VF before
> configuring the STU.
> 
> May be something like below (untested),
> 
> static int is_ats_enabled_in_vf(struct pci_dev *dev)
> {
>         struct pci_sriov *iov = dev->sriov;
>         struct pci_dev *vdev;
> 
>         if (dev->is_virtfn) 
>                 return -EINVAL;
> 
>         for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>                 vdev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
>                                              pci_iov_virtfn_bus(dev, i),
>                                              pci_iov_virtfn_devfn(dev, i));

I would try hard to avoid pci_get_domain_bus_and_slot().  That's
expensive (searches *all* PCI devs with for_each_pci_dev()) and
requires dealing with reference counts.

Maybe an atomic count in the PF of VFs with ATS enabled.

>                 if (vdev && vdev->ats_enabled)
>                         return 1;
>         }
> 
>         return 0;
> 
> }
> 
> int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> {
> ...
> if (is_ats_enabled_in_vf(dev))
>    return -EBUSY;
> 
> > 
> >> Also the caller has the requirement to call either
> >> pci_ats_stu_configure or pci_enable_ats while enumerating the PF.
> >>
> >>>>          if (!pci_ats_supported(dev))
> >>>>                  return -EINVAL;
> >>>>>>
> >>>>>>> +
> >>>>>>> +    if (!pci_ats_supported(dev))
> >>>>>>> +        return -EINVAL;
> >>>>>>> +
> >>>>>>> +    if (ps < PCI_ATS_MIN_STU)
> >>>>>>> +        return -EINVAL;
> >>>>>>> +
> >>>>>>> +    dev->ats_stu = ps;
> >>>>>>> +    pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
> >>>>>>> +    ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> >>>>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> >>>>>>> +
> >>>>>>> +    return 0;
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
> >>>>>>> +
> >>>>>>>    /**
> >>>>>>>     * pci_enable_ats - enable the ATS capability
> >>>>>>>     * @dev: the PCI device
> >>>>>>> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
> >>>>>>>            return -EINVAL;
> >>>>>>>          /*
> >>>>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
> >>>>>>> -     * with the same STU on the PF.
> >>>>>>> +     * Note that enabling ATS on a VF fails unless it's already
> >>>>>>> +     * configured with the same STU on the PF.
> >>>>>>>         */
> >>>>>>>        ctrl = PCI_ATS_CTRL_ENABLE;
> >>>>>>>        if (dev->is_virtfn) {
> >>>>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> >>>>>>> index df54cd5b15db..7d62a92aaf23 100644
> >>>>>>> --- a/include/linux/pci-ats.h
> >>>>>>> +++ b/include/linux/pci-ats.h
> >>>>>>> @@ -8,6 +8,7 @@
> >>>>>>>    /* Address Translation Service */
> >>>>>>>    bool pci_ats_supported(struct pci_dev *dev);
> >>>>>>>    int pci_enable_ats(struct pci_dev *dev, int ps);
> >>>>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
> >>>>>>>    void pci_disable_ats(struct pci_dev *dev);
> >>>>>>>    int pci_ats_queue_depth(struct pci_dev *dev);
> >>>>>>>    int pci_ats_page_aligned(struct pci_dev *dev);
> >>>>>>> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
> >>>>>>>    { return false; }
> >>>>>>>    static inline int pci_enable_ats(struct pci_dev *d, int ps)
> >>>>>>>    { return -ENODEV; }
> >>>>>>> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
> >>>>>>> +{ return -ENODEV; }
> >>>>>>>    static inline void pci_disable_ats(struct pci_dev *d) { }
> >>>>>>>    static inline int pci_ats_queue_depth(struct pci_dev *d)
> >>>>>>>    { return -ENODEV; }
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
