Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764B5B238C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiIHQZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIHQZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 12:25:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED86895D0
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 09:25:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so3105242wru.6
        for <linux-pci@vger.kernel.org>; Thu, 08 Sep 2022 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dpvUUBmrVBJXdXzTGjJjQlhI+WRTTf8cffEB6shyZ4E=;
        b=T0Ych89KMD5a2BAiaAlBK4ZBCijC8Z91doILrAPNvwn9BJo7ejCp64NSQwp7fjTwt3
         2fV0SHmJVtKdkIpy8+k0pcn1ItjtRqaYR99HoHpkwNUkvDaJvg9cFnUopcCUprV2EeSV
         4fpYZyqJZVbF8BSkoyyPEAJxTCF7Jn4qF0HLoMrUHXd4/vghiFW3+HPxED6lP5EhfN2k
         W5q2N9MzOWlINfCXFVKksy1vuS7OPcPROonLgw/P04iXTgr5Gt8JQUe7KpdBeq7UHMsW
         VO0p8fUZKzUG4itNhw98hWnqReawCckwg4BXk/EYFIbVZJVLw7j5AGAYnOtO37e8JYBH
         pKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dpvUUBmrVBJXdXzTGjJjQlhI+WRTTf8cffEB6shyZ4E=;
        b=7JZcrjpqUWICC/3u1SohompfhC2/eu9rYbPqloONt+PiuCKM3w6Xg2AuTN5IXrBdf5
         fTclRqDyNKDmDbw4wK2MnUsPxP2cTSGPBkKsmBqZMLbubH0shP0YrJZ2DCsh3+GvCHzR
         +nB18MOd8Y0DCS86DyLQ/sdSC92xGjwLAGqrSvmfK6cLyN0uJcM3B3vfxk4wZHsUSxgJ
         YVGkdUh3SZvL7yZDNA5hQrpWNzOk/xBnKswB+03eBNAAWEh16n0rICvVN/P7uAjeXUMn
         R8KpX/L6XtEIYh0aNWx5txiCB+ZyZignOMxh5y/szQUAvOvm56i61kP7/s8C44nQcN9Y
         q/EQ==
X-Gm-Message-State: ACgBeo3PvTcGQs4cNsPgX0aG/BAmkZUQvA4Xg6ybLye945UY6W0fVedK
        FDtvafa822QKpOT07tLsv0UxNg==
X-Google-Smtp-Source: AA6agR5g8DYaRh95kPvbGxbmrld5Zfa4WOcxY6LHIW8pnzKAjQJiOkA37+1+hiydlpRdIQ7Fb7pZSw==
X-Received: by 2002:a5d:5887:0:b0:220:81c9:8ab7 with SMTP id n7-20020a5d5887000000b0022081c98ab7mr5606176wrf.702.1662654336709;
        Thu, 08 Sep 2022 09:25:36 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b003a60f0f34b7sm3102445wmq.40.2022.09.08.09.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:25:35 -0700 (PDT)
Date:   Thu, 8 Sep 2022 17:25:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <YxoXfCQcD3yC5ppn@myrica>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
 <YxhqbhMmWLeFS512@myrica>
 <YxjV1y/FF0nCI/WO@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjV1y/FF0nCI/WO@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 02:33:11PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 10:54:54AM +0100, Jean-Philippe Brucker wrote:
> 
> > Is iommu_domain still going to represent both a device context (whole
> > PASID table) and individual address spaces, or are you planning to move
> > away from that?  What happens when a driver does:
> > 
> >   d1 = iommu_domain_alloc()
> >   iommu_attach_device(d1)
> >   d2 = iommu_sva_bind_device()
> >   iommu_detach_device(d1)
> > 
> > Does detach
> > (a) only disable the non-PASID address space?
> > (b) disable everything?
> > (c) fail because the driver didn't unbind first?
> 
> I think it must be (a), considering how everything is defined and the
> needs for vIOMMU emulation.

Yes (a) is probably better. The SMMU driver currently implements (c) to
ensure that you can't switch device driver without unbinding everything
first, and we should keep that check somewhere

> 
> If it is any other option then we have a problem of what to do if the
> guest VM asks to change the page table associated with the RID while a
> PASID is attached.
>  
> > I'm asking because the SMMU driver is still using smmu_domain to represent
> > all address spaces + the non-PASID one, and using the same type
> > "iommu_domain" for the new object makes things unreadable. I think
> > internally we'll want to use distinct variable names, something like
> > "domain" and "address_space". If (a) is not the direction you're going,
> > then it may be worth renaming the API as well.
> > 
> > I'm also not sure why set_dev_pasid() is a domain_ops of the SVA domain,
> > but acts on the parent domain which contains the PASID table. Shouldn't it
> > be an IOMMU op like remove_dev_pasid(), or on the parent domain?
> 
> There is no "parent domain"
> 
> PASID or RID+PASID are completely equal concepts for binding.
> 
> If you are thinking "parent domain" because SMMU is storing the PASID
> table in the RID's iommu_domain, then I think that is a misplacement
> in the SMMU driver...
> 
> The PASID table belongs in the iommu driver's per-group data
> structure. The iommu domain should only have the actual IOPTEs.
> 
> Otherwise everything blows up if you attach an iommu_domain to two
> RIDs - the API demands that every RID gets its own PASID mapping, even
> if the RID shares iommu_domains. We do not have an API to share PASID
> tables.

Well, we still do since SMMU implements it. Changing the API is fine, but
someone will need to rework the SMMU driver to align with the new meaning
of iommu_domain. I can take a stab if no one volunteers but probably not
before next year.

Thanks,
Jean

> 
> Thus the PASID table is NOT part of the iommu_domain.
> 
> The exception will be for nested translation where we will have a
> special ARM iommu_domain that contains the PASID table in userspace
> memory. When this domain is attached it will logically claim the RID
> and every PASID and thus disable the PASID API for that RID.
> 
> Remember also that an UNMANAGED iommu_domain should be attachable to
> many PASID's and RID's concurrently.
> 
> Jason
