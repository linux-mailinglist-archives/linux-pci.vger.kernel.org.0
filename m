Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC41826C8D0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgIPS6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgIPRxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 13:53:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A2C002181
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 07:11:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so6411744edo.10
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlUrkn99PMIYQmVGLdB0+eN+QkGnfm38LGdCqXub4Ao=;
        b=hAS45VSzPObmCMHNxGfkG+NDKM1TzVnv7KNEr8vj9xy4MrtNPbVMnP3E+c0FUzYGVO
         wPqjGd58SjTgvD4ElwGMVTkJ/vQJgVksPrNujXbUCvaSYAR+nYUFKIv9GmdPmsAeTw1w
         SLEokVTwh41c06RWTQK8ga+0WnZtxqNFStmhRekL0xLKWTqn8cVn6iVyLbEJCK4D+afx
         gIcqGW5V3Meio++Xlq1PULg8xgNkm9FJhgcaQPYCFJl1o7cQZmddSIXGNjtX54ocOxnB
         XkpAgcnLOKialpbNRhtfkofkZ/QjghU36lEKLA39h4h8TVkfr6on/E7w7xYxDBzj+JkY
         +i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlUrkn99PMIYQmVGLdB0+eN+QkGnfm38LGdCqXub4Ao=;
        b=A02BpZjjwX7X8jdEhNDJLgALPVUWirNOq5Z/UADroRztVA8yWsbBKcuNSRpVRhKROR
         yI5WUcGbRJ4oNPql/ZD3+sugxEAmh4tAu+QtohGy2gvTYX2YpPQZZpBLu8gx6NuUPnbj
         3ZQNUj4T3sRwiZYyJoFf7Ws2FHehyvG6vPZ6jddOPYGGGB6icep52gsgqsskCCMVhNHI
         /VjWY1+/0dmaRr6AOYSUTPVQ+yLhXik0skNR2XG5+cQpCCBBmSt8IF2RsvLNC9jUsqqV
         d5/IpIO0rUGzNmnh/hAvMgTUFZ4bKlTm8VYPjCHmR2N104948zisk1MinVampKJeEKOE
         KQEw==
X-Gm-Message-State: AOAM533g1cmD/4NH8QkPsb7bYlQ8zXVb9epdK20o7eZUhSLFqddbzQQZ
        sj0dlGFElX9U1kIYkNKK593a945z9SPCV1am
X-Google-Smtp-Source: ABdhPJxCXAJVT89OOq1cTZqdGdXIDr/MyyoQoJRJeCQxhnHcd7r64qYaYdWt6ztGRzTK/qlOZ2O25Q==
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr28642771edx.125.1600265507151;
        Wed, 16 Sep 2020 07:11:47 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y25sm13933983edv.15.2020.09.16.07.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:11:46 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:11:28 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, fenghua.yu@intel.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        catalin.marinas@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        hch@infradead.org, zhangfei.gao@linaro.org,
        Jonathan.Cameron@huawei.com, felix.kuehling@amd.com,
        xuzaibo@huawei.com, will@kernel.org, christian.koenig@amd.com,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Message-ID: <20200916141128.GC5316@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
 <472fdcf6-f306-60bc-5813-4ad421ee03f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472fdcf6-f306-60bc-5813-4ad421ee03f2@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 28, 2020 at 05:28:22PM +0800, Zenghui Yu wrote:
> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> > @@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> >   			smmu->features |= ARM_SMMU_FEAT_E2H;
> >   	}
> > +	if (reg & (IDR0_HA | IDR0_HD)) {
> > +		smmu->features |= ARM_SMMU_FEAT_HA;
> > +		if (reg & IDR0_HD)
> > +			smmu->features |= ARM_SMMU_FEAT_HD;
> > +	}
> > +
> 
> nitpick:
> 
> As per the IORT spec (DEN0049D, 3.1.1.2 SMMUv3 node, Table 10), the
> "HTTU Override" flag of the SMMUv3 node can override the value in
> SMMU_IDR0.HTTU. You may want to check this bit before selecting the
> {HA,HD} features and shout if there is a mismatch between firmware and
> the SMMU implementation. Just like how ARM_SMMU_FEAT_COHERENCY is
> selected.

Thanks for pointing this out, I didn't know about these flags but have
added them to the patch now.

Thanks,
Jean
