Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C674A5A2A1B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHZOzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiHZOz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:55:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231A257E1C
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 07:55:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l6so1243905qvu.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BrTLacSnbf6oFImdqEgVUZIjME/7YHXIyccjprWNwk4=;
        b=mHRa7tH9lrqyG9/6gTfietcIEX6xZi+pIKdTHb7PunUG8sEiZ30YR+OIfBUhSggOYO
         1RdSAlkb+h8N/p/h5z18F+vF42N8tQW7jW35YZ9EVMXWlJZjGH2ry/uBb+Axv45Vqz97
         mY2wX7pAPb/OUf0g90EDqXEiIjXgQYt4naZERvAFif0z7Qjjzr1BPQA5SRTU7tCdW4oV
         yPB4pLXvbXhwRDJmpwamgSnCPdH7Udbz0ilRVrJAoL0pkVV0KtQ4hrFJqIojvKUVSnsD
         8bVhLvgJtXcpixLqdKww5r9AoSgM+LFUExSf1IbjjGokPP8xAjPcKYWOQhY0RI0CAmoX
         /BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BrTLacSnbf6oFImdqEgVUZIjME/7YHXIyccjprWNwk4=;
        b=JdY7A+QvdPjnwfFABkCVM88wcEr7GIxBU+7SBXA+GucD88N4ABJpECXvOpQxHOKZcK
         vobB9SSJGHdi1d3DcPmS0prPkMSSV+qOwvtJrXTwxiUt6ZJTX8Q0ai7rATw018FOZw0i
         1ruwwKUwMHpn/C9XlpyuFZxiFziRI+acicbPuznQPICMllPbpu5vPs9f7G9OoaaABGLz
         26HWGGlqkVTI1oSZ9qXqC+Tx4OAXJaTNPwMc6754LqG+35klwub+GRw3hqXgxaM52Xxw
         5mfxzC1iNsb83vSnJRW/tJ2NiI4JoKIJePq1uYyrQYUUb9DAg9V5PNHNW8XopgJWD0Wa
         P1Mw==
X-Gm-Message-State: ACgBeo1u2DF8HyXpQ35QCHzqAD1/Vl1OPk8eEEXaIje+Irde6vin4AIY
        3vVFHMHHCMkrNsr8R+i8ubpiZA==
X-Google-Smtp-Source: AA6agR5qDyhkD133f/ehjgqAwooinpO/QhnaSdbrmeFFD3oEWDttSdHeqvLTznJtHDryMtB5Vql/zw==
X-Received: by 2002:a05:6214:1d28:b0:497:f3b:cabb with SMTP id f8-20020a0562141d2800b004970f3bcabbmr8254958qvd.115.1661525725236;
        Fri, 26 Aug 2022 07:55:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n14-20020a05620a294e00b006b8e63dfffbsm1890692qkp.58.2022.08.26.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 07:55:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oRajz-000dBP-D1;
        Fri, 26 Aug 2022 11:55:23 -0300
Date:   Fri, 26 Aug 2022 11:55:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/17] iommu: Make free of iommu_domain_ops optional
Message-ID: <Ywje2199uFTzCubw@ziepe.ca>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-9-baolu.lu@linux.intel.com>
 <YwjeW+nSIDkmmggd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwjeW+nSIDkmmggd@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 11:53:15AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:32PM +0800, Lu Baolu wrote:
> > So that the drivers are able to implement static singleton instance for
> > some special domains. The blocking domain is an example. The driver has
> > no need to allocate different memory for each blocking domain allocation
> > request. Hence, no need for a free callback.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Tested-by: Tony Zhu <tony.zhu@intel.com>
> > ---
> >  drivers/iommu/iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index e985f4d5895f..630e1b64ed89 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1972,7 +1972,8 @@ void iommu_domain_free(struct iommu_domain *domain)
> >  	if (domain->type == IOMMU_DOMAIN_SVA)
> >  		mmdrop(domain->mm);
> >  	iommu_put_dma_cookie(domain);
> > -	domain->ops->free(domain);
> > +	if (domain->ops->free)
> > +		domain->ops->free(domain);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_domain_free);
> 
> This patch is in the wrong order, it needs to be before the ARM patch
> implementing the blocking domain

Oh, nevermind, I am reading them in the wrong order :)

Jason
