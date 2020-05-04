Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45061C3E28
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEDPJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEDPJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 11:09:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A38C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 08:09:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so11079007wrt.9
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ymxZ/AHKc54MsFnFnjiy487/cd2cO0lIerw33LQLJwg=;
        b=QNbwqk4D1MPIi3P7kInzB1wd9Nwnz4c2VQo9LuhJOdRLdMrPzNMgpvKqTLZMK1uPi+
         P2pe+v2OCrrPEexPYdYwl192CIA5G6xYliglrRqqtdaIAR+usOr6a/3cJuAgWCIrlSe1
         OdskZIteDeuDIgetVe9zuT/oEpmFwh99LEyLr+Zq8PUuCUTWaKKGaTmfFvbQ2/+u5d3b
         tftW1WWsJsddoYK8llhhdNTtirX5vLRtjEeFAIEdNjNGfsIxaS1xLDMsskU7xZaWG3ng
         uBZkgyMKL71WDmOBvkjPrl5x7RLtobyGsphgAfOHe28m7ebcN/qz+Xrs9em6Jezxz6jQ
         4Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ymxZ/AHKc54MsFnFnjiy487/cd2cO0lIerw33LQLJwg=;
        b=s+ECjVEXraL1R0D3xyW7KxH5+PgyXtiGupjOCprNDH7Ym+YxLvC6EWk2z3jDGMImBW
         BNtaCKxed6/ZfBrvFAOJ3toC9oonKdk1i4ZvOSbkRNlmcsif9bdJwPMpVR2zqAkyLUTr
         UFLzm443S21wr5wWrK2E/IpuNSUHvRSQ6VskK1ue+1dlauq85Z6RlXh5ti5avwBCxaxn
         kHNEcl6iXF7QGzITMq+CjTQIppTYUWvjgoRWdoUHm4jupdDMbmbyHvsWGWQXk3eyNiZo
         mvdxOtoeCZbDmEapsb4jaoJgsZDWX5/oi1xklGGzOYmLb9iO+0oOrZesL8Z2MLgATQ5M
         gK1Q==
X-Gm-Message-State: AGi0PuZw2D7xi1YvebUaX5wfA7evmk5wMpkABfByxEb8qINH+ztm2gLe
        Oc7kGWCUdOSlZXL8ty0niRysGw==
X-Google-Smtp-Source: APiQypIDrGUvuteScMrJ9fLWEogSG6ijt2/PYwyFrJ0NSjLGFvyO34VY4LnIIaZoFl/ctKT+r9PVxQ==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr56993wro.419.1588604976411;
        Mon, 04 May 2020 08:09:36 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id w83sm14711145wmb.37.2020.05.04.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:09:35 -0700 (PDT)
Date:   Mon, 4 May 2020 17:09:26 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/25] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200504150926.GA176594@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430141816.595b758f@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430141816.595b758f@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 02:18:16PM -0700, Jacob Pan wrote:
> On Thu, 30 Apr 2020 16:33:59 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Shared Virtual Addressing (SVA) allows to share process page tables
> > with devices using the IOMMU, PASIDs and I/O page faults. Add SVA
> > support to the Arm SMMUv3 driver.
> > 
> > Since v5 [1]:
> > 
> > * Added patches 1-3. Patch 1 adds a PASID field to mm_struct as
> >   discussed in [1] and [2]. This is also needed for Intel ENQCMD.
> > Patch 2 adds refcounts to IOASID and patch 3 adds a couple of helpers
> > to allocate the PASID.
> > 
> > * Dropped most of iommu-sva.c. After getting rid of io_mm following
> >   review of v5, there wasn't enough generic code left to justify the
> >   indirect branch overhead of io_mm_ops in the MMU notifiers. I ended
> > up with more glue than useful code, and couldn't find an easy way to
> > deal with domains in the SMMU driver (we keep PASID tables per domain,
> >   while x86 keeps them per device). The direct approach in patch 17 is
> >   nicer and a little easier to read. The SMMU driver only gained 160
> >   lines, while iommu-sva lost 470 lines.
> > 
> >   As a result I dropped the MMU notifier patch.
> > 
> >   Jacob, one upside of this rework is that we now free ioasids in
> >   blocking context, which might help with your addition of notifiers
> > to ioasid.c
> > 
> Thanks for the note. It does make notifier much easier, plus the
> refcount can alleviate the constraint on ordering.
> 
> I guess we don't share mmu notifier code for now :)

I think it's more efficient for each IOMMU driver to at least implement
their own invalidate_range() callback and avoid indirect branches. For the
rest I couldn't find a lot of code to share, most of it is writing PASID
tables and invalidating. We can revisit later, as long as we agree on the
bind() API the implementations should be similar enough.

Thanks,
Jean
