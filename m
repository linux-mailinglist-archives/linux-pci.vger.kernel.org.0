Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC681C3FD6
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgEDQ3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgEDQ3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 12:29:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30581C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 09:29:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so21731205wrx.3
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/BYU4Om8WCi34VBttwlHwqi6sY2A9tyjvz9dkBW4YR0=;
        b=s6Hn20ig/1KbhienjCm7bWbYtxGwNnasjezCMNITDVyM/NfgWs1dMhB2gCybX/gMQM
         3PvzgyisZ2pcL/5UM64ddSx6TGvAftzzX2OE4x2ldSBevHUIJbL1Lh1SiucuLKAInJzC
         JyGj2737261kvOO484ymYbWd/jxHFDiMYcTkvLmUpxHi1Y6R9OGmzwL+SyZduBlcfchC
         yt06HQpOncV1dier8AcJ71lobnxArlTYPJOBYmytmIEueWGSRW/a8lt5bEx+1Kv93NkY
         QrDTWiKqlp5t4HiJUdr0nvqoLZypO0n42pp908ZiZk6LUi9G3Qz27wXfntChz79dBe0/
         HgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/BYU4Om8WCi34VBttwlHwqi6sY2A9tyjvz9dkBW4YR0=;
        b=ah7qiI8w+IK6FL3xKBo0FgMJZ70HMCSmcH8wNqT72eROShYuIWOJQrVDWBvqunBFQC
         /o78juI5+/9IJjM6tsOsZwHtDBcoGxXmQGlpZZbk3VJMJsg9QWFARQbDIl3cyTHhoo7R
         wC+/r77vAoM2Mn3URCkc2VJdOGCoy/YYABbEKfbpq3txIw2nDpEQbQ/QyUbUKNO8dKqv
         YAXwQN2kJ+/YekWjQi3D1DM2xIRZz5o6q+AEMx+t6sn3iGA9iqjCa7DlDj3twdHEwGWH
         4kjxyVWL8or4sq0NKbkuNgxVAd1etDe518lQ3Znkkwtk1t/QRmGey3v0mmGmHqulkL0t
         HE/A==
X-Gm-Message-State: AGi0PuZnUFvscyHzme+85Fokq/mBS8a28vCdwV8HMbamX8tu3n7JoKED
        rOoTEd0I3OHHZyVxcjY5Bpal7Q==
X-Google-Smtp-Source: APiQypIHji+0UmZIp3eRiES/RsK7nvGgkSn0DrHKmgTnip/V9mOn0fBeB0vJOAU40Okt9fYQT7236g==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr159739wro.124.1588609753958;
        Mon, 04 May 2020 09:29:13 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id l5sm13656680wmi.22.2020.05.04.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:29:13 -0700 (PDT)
Date:   Mon, 4 May 2020 18:29:03 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Zaibo <xuzaibo@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 01/25] mm: Add a PASID field to mm_struct
Message-ID: <20200504162903.GH170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-2-jean-philippe@linaro.org>
 <ffe0aca4-575b-98d3-0ba5-88d5e6eb29fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe0aca4-575b-98d3-0ba5-88d5e6eb29fe@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 09:52:44AM +0800, Xu Zaibo wrote:
> 
> On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> > Some devices can tag their DMA requests with a 20-bit Process Address
> > Space ID (PASID), allowing them to access multiple address spaces. In
> > combination with recoverable I/O page faults (for example PCIe PRI),
> > PASID allows the IOMMU to share page tables with the MMU.
> > 
> > To make sure that a single PASID is allocated for each address space, as
> > required by Intel ENQCMD, store the PASID in the mm_struct. The IOMMU
> > driver is in charge of serializing modifications to the PASID field.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > For the field's validity I'm thinking invalid PASID = 0. In ioasid.h we
> > define INVALID_IOASID as ~0U, but I think we can now change it to 0,
> > since Intel is now also reserving PASID #0 for Transactions without
> > PASID and AMD IOMMU uses GIoV for this too.
> > ---
> >   include/linux/mm_types.h | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 4aba6c0c2ba80..8db6472758175 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -534,6 +534,10 @@ struct mm_struct {
> >   		atomic_long_t hugetlb_usage;
> >   #endif
> >   		struct work_struct async_put_work;
> > +#ifdef CONFIG_IOMMU_SUPPORT
> > +		/* Address space ID used by device DMA */
> > +		unsigned int pasid;
> > +#endif
> Maybe '#ifdef CONFIG_IOMMU_SVA ... #endif' is more reasonable?

CONFIG_IOMMU_SVA enables a few helpers but IOMMU drivers don't have to use
them, so I think IOMMU_SUPPORT is more appropriate.

Thanks,
Jean
