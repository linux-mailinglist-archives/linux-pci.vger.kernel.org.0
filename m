Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75452139E
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiEJL1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiEJL1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 07:27:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B02ABBF4;
        Tue, 10 May 2022 04:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9384ECE1E1A;
        Tue, 10 May 2022 11:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FE9C385C2;
        Tue, 10 May 2022 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652181816;
        bh=5ZJgn0Zghtzaiu2qbpmdNbr1rwDe/IiPV/mYtoG6HA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OW/Ke/sgpzuHPUyRzpms1qOc2XLOIcXoZcZbY2dWEX8ECxIpYNcCh6v/5omvQpb97
         sTdKM2jeHUVartD2XdpvYbOW29XN4joTf1kTBYQIwsr3upSynALi/l82MXrk2Yalgb
         pIu4qYrAobipn8F2FA8Rsshm9vtlEbFtJ/ul6SeMd9GlWlaKJcgLK5hDR96vVtm2Bs
         ivKOZ8fI7xV55CEsvMJ4uymfOqK4k3+G17XSVvfVSNyxzVJFvzxs1jEdNgWQDS+OBg
         SWx3hHs7uf6wtz9fPqHZL6oZ9L9FI7ooPrULOYtT4DLftRW1+/zeAvWR/xCrfmDEa+
         e5n5OMiBvmIIg==
Date:   Tue, 10 May 2022 12:23:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, helgaas@kernel.org,
        alexander.shishkin@linux.intel.com, lorenzo.pieralisi@arm.com,
        mark.rutland@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v7 1/7] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
Message-ID: <20220510112326.GA27790@willie-the-truck>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-2-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407125841.3678-2-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 07, 2022 at 08:58:35PM +0800, Yicong Yang wrote:
> The DMA operations of HiSilicon PTT device can only work properly with
> identical mappings. So add a quirk for the device to force the domain
> as passthrough.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I still don't like this being part of the SMMU driver, but given that
(a) Robin doesn't seem to agree with the objection and (b) you've been
refreshing the patch series:

Acked-by: Will Deacon <will@kernel.org>

If you do respin, then:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..5ec15ae2a9b1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2839,6 +2839,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>  	}
>  }

It might be worth adding a brief comment here to explain what this device is
and why it needs an identity mapping.

> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> +					 (pdev)->device == 0xa12e)

Will
