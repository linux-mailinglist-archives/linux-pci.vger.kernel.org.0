Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6C4B6CE5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 14:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiBONBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 08:01:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiBONBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 08:01:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48277F6ED;
        Tue, 15 Feb 2022 05:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B72DB819A9;
        Tue, 15 Feb 2022 13:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D88C340EB;
        Tue, 15 Feb 2022 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644930054;
        bh=rBQWeVT+EjzsgM3r1Lc4uCaVLYnzGjhTjj/msDXK3JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Krj7P+C91g6qOvjxvKB81mvkRoyrAHTF2oSPNlKRcBJo6UzBrK7m9Qlspp+bE8L60
         XCQxx4QeOVrwnNgvEJ86FjQZg7CL9v5KzzXIYET+suGKDkot+JLR+jgRJgrDF8PHXb
         y8zl/wECo6oZ0t040D0GT8hit88BtxAcseq6Nt54m60DPgh6P+Wc7CDmPmCCQirWT6
         /bhPJTdJme5BWgevr8q2KdY9PycccGncoMNM4ZarxRXa6gIzXof5emg7hWNjzMo6+z
         8OapdOtjag5MQHSESLH0Mvw9rq7Q9xmSOPi/qCAVtsiX7TXBH/kk03l0SaDjMWwS86
         AStehWQJl8CIg==
Date:   Tue, 15 Feb 2022 13:00:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        helgaas@kernel.org, alexander.shishkin@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        song.bao.hua@hisilicon.com
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Message-ID: <20220215130044.GA7154@willie-the-truck>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58888c1-5448-77c7-7f6c-f5db999a888f@huawei.com>
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

On Mon, Feb 14, 2022 at 08:55:20PM +0800, Yicong Yang wrote:
> On 2022/1/24 21:11, Yicong Yang wrote:
> > The DMA of HiSilicon PTT device can only work with identical
> > mapping. So add a quirk for the device to force the domain
> > passthrough.
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 6dc6d8b6b368..6f67a2b1dd27 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
> >  	}
> >  }
> >  
> > +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> > +					 (pdev)->device == 0xa12e)
> > +
> > +static int arm_smmu_def_domain_type(struct device *dev)
> > +{
> > +	if (dev_is_pci(dev)) {
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +		if (IS_HISI_PTT_DEVICE(pdev))
> > +			return IOMMU_DOMAIN_IDENTITY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct iommu_ops arm_smmu_ops = {
> >  	.capable		= arm_smmu_capable,
> >  	.domain_alloc		= arm_smmu_domain_alloc,
> > @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
> >  	.sva_unbind		= arm_smmu_sva_unbind,
> >  	.sva_get_pasid		= arm_smmu_sva_get_pasid,
> >  	.page_response		= arm_smmu_page_response,
> > +	.def_domain_type	= arm_smmu_def_domain_type,
> >  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> >  	.owner			= THIS_MODULE,
> >  };
> > 
>
> Is this quirk ok with the SMMU v3 driver? Just want to confirm that I'm on the
> right way to dealing with the issue of our device.

I don't think the quirk should be in the SMMUv3 driver. Assumedly, you would
have the exact same problem if you stuck the PTT device behind a different
type of IOMMU, and so the quirk should be handled by a higher level of the
stack.

Will
