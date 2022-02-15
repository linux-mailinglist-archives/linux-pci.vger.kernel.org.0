Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6300B4B6DDB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiBONmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 08:42:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiBONmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 08:42:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F7D109F;
        Tue, 15 Feb 2022 05:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F87461738;
        Tue, 15 Feb 2022 13:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE7EC340EB;
        Tue, 15 Feb 2022 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644932561;
        bh=sPlaSv3uGOe1rBpD1b6tMALG2r6FmsdUBd5JcLKY/rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADHUvjwj9Oe3t/tiApaS/AJnM1P+CQUcZQ67xTzYYvFNmBcU1uCzzqF7NWYQalEvy
         gJTNSlIWBWLuO+yail/1N4zB3JbCP/vmE/7+2FtS6ugoJoSkgJMepB7C5FZ2AmySkH
         dT3RoLsrzDOtZrq6vybeG4gwPznNokPn/Hq2GbspR15L4i3CTCI5BTMmGur2g4Qgf1
         eSU4GbZUlO7oaFBXg53tDI4A6EIrrFWJptmLb3aKsN+8We+9miOuPr5p9w1pPNwp73
         VpY76Z9RlyGgJnEDvQ9tbgwf9sDiLVWhxwgubw3X9L3L+uYUF/fHrmNOnZW2OhEIK0
         qXCu2FNGJ5kTQ==
Date:   Tue, 15 Feb 2022 13:42:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, mark.rutland@arm.com,
        prime.zeng@huawei.com, alexander.shishkin@linux.intel.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        daniel.thompson@linaro.org, peterz@infradead.org, mingo@redhat.com,
        helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        acme@kernel.org, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        leo.yan@linaro.org
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Message-ID: <20220215134232.GA7592@willie-the-truck>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
 <20220215130044.GA7154@willie-the-truck>
 <9018a1d9-4d42-3a99-dbc6-c55139abcb1e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9018a1d9-4d42-3a99-dbc6-c55139abcb1e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 01:30:26PM +0000, Robin Murphy wrote:
> On 2022-02-15 13:00, Will Deacon wrote:
> > On Mon, Feb 14, 2022 at 08:55:20PM +0800, Yicong Yang wrote:
> > > On 2022/1/24 21:11, Yicong Yang wrote:
> > > > The DMA of HiSilicon PTT device can only work with identical
> > > > mapping. So add a quirk for the device to force the domain
> > > > passthrough.
> > > > 
> > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > ---
> > > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
> > > >   1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index 6dc6d8b6b368..6f67a2b1dd27 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
> > > >   	}
> > > >   }
> > > > +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> > > > +					 (pdev)->device == 0xa12e)
> > > > +
> > > > +static int arm_smmu_def_domain_type(struct device *dev)
> > > > +{
> > > > +	if (dev_is_pci(dev)) {
> > > > +		struct pci_dev *pdev = to_pci_dev(dev);
> > > > +
> > > > +		if (IS_HISI_PTT_DEVICE(pdev))
> > > > +			return IOMMU_DOMAIN_IDENTITY;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   static struct iommu_ops arm_smmu_ops = {
> > > >   	.capable		= arm_smmu_capable,
> > > >   	.domain_alloc		= arm_smmu_domain_alloc,
> > > > @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
> > > >   	.sva_unbind		= arm_smmu_sva_unbind,
> > > >   	.sva_get_pasid		= arm_smmu_sva_get_pasid,
> > > >   	.page_response		= arm_smmu_page_response,
> > > > +	.def_domain_type	= arm_smmu_def_domain_type,
> > > >   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> > > >   	.owner			= THIS_MODULE,
> > > >   };
> > > > 
> > > 
> > > Is this quirk ok with the SMMU v3 driver? Just want to confirm that I'm on the
> > > right way to dealing with the issue of our device.
> > 
> > I don't think the quirk should be in the SMMUv3 driver. Assumedly, you would
> > have the exact same problem if you stuck the PTT device behind a different
> > type of IOMMU, and so the quirk should be handled by a higher level of the
> > stack.
> 
> Conceptually, yes, but I'm inclined to be pragmatic here. Default domain
> quirks could only move out as far as the other end of the call from
> iommu_get_def_domain_type() - it's not like we could rely on some flag in a
> driver which may not even be loaded yet, let alone matched to the device.
> And even then there's an equal and opposite argument for why the core code
> should have to maintain a list of platform-specific quirks rather than code
> specific to the relevant platforms. The fact is that a HiSilicon RCiEP is
> not going to end up behind anything other than a HiSilicon IOMMU, and if
> those ever stop being SMMUv3 *and* such a quirk still exists we can worry
> about it then.

Perhaps, but you know that by adding this hook it's only a matter of time
before we get random compatible string matches in there, so I'd rather keep
the flood gates closed as long as we can.

Given that this is a PCI device, why can't we have a PCI quirk for devices
which require an identity mapping and then handle that in the IOMMU core?

> Ugly as it is, this is the status quo. I don't recall anyone ever arguing
> that the equivalent quirks for Intel integrated graphics should be made
> generic ;)

I don't know anything about Intel integrated graphics. Have they solved this
problem in a better way, or could they equally make use of a generic quirk?

Will
