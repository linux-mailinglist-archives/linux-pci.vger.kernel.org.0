Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6C5B00F1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIGJzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIGJzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 05:55:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FD248C9
        for <linux-pci@vger.kernel.org>; Wed,  7 Sep 2022 02:55:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so232729wrx.7
        for <linux-pci@vger.kernel.org>; Wed, 07 Sep 2022 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D70XsnuK+JjOjhOUycDcv6x9oYap675Tz1NyjMuJJeQ=;
        b=ArTVxjzl4jjkeDcDAykSqOnbsnE4RyYaNvtRv5H01nXkzeOrKwxou3NLe+9X5voQB9
         k8vBvRNWJaoymUSrtwuowm9dD864p86/5v8QwkvKzkadebkZ6/ShoNbrlzL+l5SAiCCx
         HQTor9/YFxw7z2jW2AaREh15/yMAIiW1zXxlnWXxMpFdE3L/pygM619gxQjyHSzp+hnE
         2Qq1zVJxvO9Q2qCIF1/Remeygb1jzO3uN4hRTkbUa8jrz0U3QaC9bj0c9m7GHOJDX0jA
         1nVB3DZ9RNPuUhyDOTG7FiAg6Ue4QvJ7H5bcqUQaTVKkpzkm902atXG64V9WZC6AEILx
         8nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D70XsnuK+JjOjhOUycDcv6x9oYap675Tz1NyjMuJJeQ=;
        b=plvWkcIXrBPEp3CB+WOZuMlN+L8j2+KmuZHRz0kUA1Ru3mD6bACBLITait0Lw3DvaQ
         lMBwI15lNUPgyY1K4BQ0XvHu9hkJqQDsI0rYws8Cmpn9j64Ef2g6vMQgN+CJto/T7ESP
         T6ad3YU/nzCQ9s2Q8St9ZdiUhxh393CQBV2JjLpU+TRuSSOfICkG4e+ScwngNKV8IiMz
         66LT+6+kS56AHhSoBGF0GS80qpCr4REd+bk/Cdao6L5NPD89+YxJRmvFjK9n7q43bdq9
         6CO+pP6josQ4w6maG9oMH/uel44sdyRQ9EamEDu3hqOqL9KScsYjpJFWasQm/TXcsaJp
         HwCQ==
X-Gm-Message-State: ACgBeo1sk0BBZs9IBy1UclhILySBnG5Hgh6jtp4cHikSWoH9+bGhR9Pa
        GOd3aHtKre9extDOdjfcRNopDQ==
X-Google-Smtp-Source: AA6agR46d9IuqClGYsNh6ebHPg5a5F86IxP86Hlmd2vLbW53hk6vAwFPjS5L1FNJqf7fkT07+fz2rA==
X-Received: by 2002:a5d:588d:0:b0:225:9818:668d with SMTP id n13-20020a5d588d000000b002259818668dmr1504825wrf.100.1662544498769;
        Wed, 07 Sep 2022 02:54:58 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0021ee65426a2sm16037248wrb.65.2022.09.07.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 02:54:58 -0700 (PDT)
Date:   Wed, 7 Sep 2022 10:54:54 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YxhqbhMmWLeFS512@myrica>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Baolu,

On Wed, Sep 07, 2022 at 09:27:30AM +0800, Baolu Lu wrote:
> Hi Jean,
> 
> On 2022/9/7 0:36, Jean-Philippe Brucker wrote:
> > On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
> > > +/**
> > > + * iommu_sva_bind_device() - Bind a process address space to a device
> > > + * @dev: the device
> > > + * @mm: the mm to bind, caller must hold a reference to mm_users
> > > + *
> > > + * Create a bond between device and address space, allowing the device to access
> > > + * the mm using the returned PASID. If a bond already exists between @device and
> > > + * @mm, it is returned and an additional reference is taken. Caller must call
> > > + * iommu_sva_unbind_device() to release each reference.
> > This isn't true anymore. How about storing handle in the domain?
> 
> Yes, agreed. How about making the comments like this:
> 
> /**
>  * iommu_sva_bind_device() - Bind a process address space to a device
>  * @dev: the device
>  * @mm: the mm to bind, caller must hold a reference to mm_users
>  *
>  * Create a bond between device and address space, allowing the device to
>  * access the mm using the pasid returned by iommu_sva_get_pasid(). If a
>  * bond already exists between @device and @mm, an additional internal
>  * reference is taken. The reference will be released when the caller calls
>  * iommu_sva_unbind_device().

Sure, that works. I'd keep "Caller must call iommu_sva_unbind_device()
to release each reference"

> 
> Storing the handle in the domain looks odd. Conceptually an iommu domain
> represents a hardware page table and the SVA handle represents a
> relationship between device and the page table for a consumer. It's
> better to make them separated.

Right

> 
> In a separated series, probably we can discuss the possibility of
> removing handle from the driver APIs. Just simply return the sva domain
> instead.
> 
> struct iommu_domain *iommu_sva_bind_device(struct device *dev,
>                                            struct mm_struct *mm);
> void iommu_sva_unbind_device(struct device *dev,
>                              struct iommu_domain *domain);
> u32 iommu_sva_get_pasid(struct iommu_domain *domain);
> 
> If you think it's appropriate, I can send out the code for discussion.

Yes, I don't see a reason to keep struct iommu_sva at the moment.
I believe we needed to keep track of bonds themselves for sva_ops and
driver data but those are gone now.

Is iommu_domain still going to represent both a device context (whole
PASID table) and individual address spaces, or are you planning to move
away from that?  What happens when a driver does:

  d1 = iommu_domain_alloc()
  iommu_attach_device(d1)
  d2 = iommu_sva_bind_device()
  iommu_detach_device(d1)

Does detach
(a) only disable the non-PASID address space?
(b) disable everything?
(c) fail because the driver didn't unbind first?

I'm asking because the SMMU driver is still using smmu_domain to represent
all address spaces + the non-PASID one, and using the same type
"iommu_domain" for the new object makes things unreadable. I think
internally we'll want to use distinct variable names, something like
"domain" and "address_space". If (a) is not the direction you're going,
then it may be worth renaming the API as well.

I'm also not sure why set_dev_pasid() is a domain_ops of the SVA domain,
but acts on the parent domain which contains the PASID table. Shouldn't it
be an IOMMU op like remove_dev_pasid(), or on the parent domain?

Thanks,
Jean

> 
> > 
> > (Maybe also drop my Reviewed-by tags since this has changed significantly,
> > I tend to ignore patches that have them)
> 
> I am sorry that after your review, the SVA domain and attach/detach
> device pasid interfaces have undergone some changes. They mainly exist
> in the following patches. Can you please help to take a look.
> 
> iommu/sva: Refactoring iommu_sva_bind/unbind_device()
> arm-smmu-v3/sva: Add SVA domain support
> iommu: Add IOMMU SVA domain support
> iommu: Add attach/detach_dev_pasid iommu interfaces
> 
> Best regards,
> baolu
