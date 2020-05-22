Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705771DE411
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEVKSK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgEVKSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 06:18:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16DBC05BD43
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 03:18:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so9654985wrx.3
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rDNDKX0HkLYt94EgaC8KrXxbFTf0b5UZDhkhcEUmDsA=;
        b=WVJ//CKH4dmTBE0aqIBZXt0aAGFbLb2/HSsz+TTszSD504939LXSss4CoipdpB/CaP
         UYEC49gciPAa156HBkX3vD6agGFcawT7wJGuqinqgdldtVpJcnYlHy8kYO+4r5wUGW4N
         dybibnHmXgJPE6Yx//FGirSeVMwet4YQ4pqdD8PfOkmlAM9lkmxvRxK8W5pq10wP/QdV
         nPZKGtAyqCQjPtUOqPpWTpK7PWQ7g8PDTvbQ9eAr9/mGFFzSg02tY1TfCtIKZQykmP7N
         B8ikx09FYbHX1EDesimTPNwCJGF8URn5yiI0zH0eo0dpPE+4HsehFV61iZGVMleox6n1
         gTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDNDKX0HkLYt94EgaC8KrXxbFTf0b5UZDhkhcEUmDsA=;
        b=rSp95WTEIJ8yDRyvAMtozVU/HxQPrb1ZYC13w8Ncwuq9utzLzgwI1WCKB6K+lFeq05
         UAHxoS6cioufzV1Wko0GdM2v0FD2Eo8RKB6Kv2nqfYqh4b6sYaPn96JFyi8JbhYnu7/i
         41ocE9z8eq3lo/TF8rKTHbqnFbIUfC9ykAYGlz0TYrZnOSIZVwJ8qKcRyoufd1K9/juA
         01cULx8GJFmPrJCZDa5aL5Zkbd0vTYPi6p0QTR85fFXa2VDsQZZr0LpMr0R3z6nhRnvK
         WhoigRsdYTx0gsaTLlDCn3XDxFDe2KYaTswcnYHkiDIePmZFBxqg6hBawnF5HnsquqB2
         Pd4Q==
X-Gm-Message-State: AOAM533P/jJf7E+5HTmbcYSagbR4ctETs2JTMKDAo4xdSwFVscfBekPE
        St/7KEn00WtPtkgltPzdE0B6fA==
X-Google-Smtp-Source: ABdhPJzB2HI5kI/EmFJDdYOUgVosMpdPIKY9IaspD/NoZu4lv6KFYPamr6Pcq0PBpjpQXhtZ+2g/kQ==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr2740621wrw.17.1590142686217;
        Fri, 22 May 2020 03:18:06 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id d126sm9765981wmd.32.2020.05.22.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 03:18:05 -0700 (PDT)
Date:   Fri, 22 May 2020 12:17:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org, joro@8bytes.org,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org, eric.auger@redhat.com
Subject: Re: [PATCH v7 13/24] iommu/arm-smmu-v3: Enable broadcast TLB
 maintenance
Message-ID: <20200522101755.GA3453945@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-14-jean-philippe@linaro.org>
 <20200521141730.GJ6608@willie-the-truck>
 <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c896ad27b43b2de554cf772f9453d0a@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Eric]

On Thu, May 21, 2020 at 03:38:35PM +0100, Marc Zyngier wrote:
> On 2020-05-21 15:17, Will Deacon wrote:
> > [+Marc]
> > 
> > On Tue, May 19, 2020 at 07:54:51PM +0200, Jean-Philippe Brucker wrote:
> > > The SMMUv3 can handle invalidation targeted at TLB entries with shared
> > > ASIDs. If the implementation supports broadcast TLB maintenance,
> > > enable it
> > > and keep track of it in a feature bit. The SMMU will then be
> > > affected by
> > > inner-shareable TLB invalidations from other agents.
> > > 
> > > A major side-effect of this change is that stage-2 translation
> > > contexts
> > > are now affected by all invalidations by VMID. VMIDs are all shared
> > > and
> > > the only ways to prevent over-invalidation, since the stage-2 page
> > > tables
> > > are not shared between CPU and SMMU, are to either disable BTM or
> > > allocate
> > > different VMIDs. This patch does not address the problem.
> > 
> > This sounds like a potential performance issue, particularly as we
> > expose
> > stage-2 contexts via VFIO directly.

Yes it's certainly going to affect SMMU performance, though I haven't
measured it. QEMU and kvmtool currently use stage-1 translations instead
of stage-2, so it won't be a problem until they start using nested
translation (and unless the SMMU only supports stage-2).

In the coming month I'd like to have a look at coordinating VMID
allocation between KVM and SMMU, for guest SVA. If the guest wants to
share page tables with the SMMU, the SMMU has to use the same VMIDs as the
VM to receive broadcast TLBI.

Similarly to patch 06 ("arm64: mm: Pin down ASIDs for sharing mm with
devices") the SMMU would request a VMID allocated by KVM, when setting up
a nesting VFIO container. One major downside is that the VMID is pinned
and cannot be recycled on rollover while it's being used for DMA.

I wonder if we could use this even when page tables aren't shared between
CPU and SMMU, to avoid splitting the VMID space.

> > Maybe we could reserve some portion
> > of
> > VMID space for the SMMU? Marc, what do you reckon?
> 
> Certainly doable when we have 16bits VMIDs. With smaller VMID spaces (like
> on
> v8.0), this is a bit more difficult (we do have pretty large v8.0 systems
> around).

It's only an issue if those systems have an SMMUv3 supporting DVM. With
any luck that doesn't exist?

> How many VMID bits are we talking about?

That's anyone's guess... One passed-through device per VM would halve the
VMID space. But the SMMU allocates one VMID for each device assigned to a
guest, not one per VM (well one per domain, or VFIO container, but I think
it boils down to one per device with QEMU). So with SR-IOV for example it
should be pretty easy to reach 256 VMIDs in the SMMU.

Thanks,
Jean
