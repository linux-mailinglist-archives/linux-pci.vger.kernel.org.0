Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52C1B034A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDTHmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 03:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgDTHmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 03:42:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A4C061A0F
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 00:42:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so10783355wrw.12
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36LtjihBEpeBnaRGeeCm9e2L3d20jrMG7L1AL/HArJs=;
        b=BM8Iccy/hIQbCpSekYbFcZATX4MvhvRHEo8t56sYYDBHLuWrWlNfN2U/Avqh8pAzQ+
         lJSChUqVOtITG+ntElIAo3FofQYlSUeJmVFTj1QctC3aH4uQ5UOifop/IzHxEXYnZ5my
         opGELuSrSZd/x7koJ8jWqGqe0lytTCYPvTb7bSWeBNbpH/ZOHDSjLzxqvp1xpOJsbc7o
         xGsbkEr+LTYIBgtKOpVnk5Pox8r0hmqVt3bRtQ6GUZafBrjVD4r2u3tGSKQbcyjfOLch
         9Sfd2Iw3VJ/3lDfpUqoBIiiH3MRh0hqtXjIK8Ip29Za7xcLJ1b9QXuz0Pl6RJ3xDyOUI
         iYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36LtjihBEpeBnaRGeeCm9e2L3d20jrMG7L1AL/HArJs=;
        b=odj1++3+pd3XD3ke1Ro9cjwcwGseI6PUjOod78BJYUcXY/zleLeoC51HQqBQlCyYdb
         mvXFnIaJPvfwPB1x3RaCMBhy1Q5XY2MGXE4EZV1oE6QX8T2FSKDtK2iTsXa3bHO3Oe9E
         q0hu0shA6aG04tGElMU2fMjHhmy0CKZSCmNVlcTtilMf3sn4wMfKbjQAEQTLHgoKifDc
         ech+vHg50j9t5La6GvOM5muZ+IFi0DVkJqZkYOQdkBOVK0yqVGzXcB11LtHAUo4r/tpW
         wVdUxQiWdSjeb6hp2jJxLvsm1GpJneN/lzaQjy/kz3cFUjSf2RdrhX1OCpwJftN0mBgR
         syvA==
X-Gm-Message-State: AGi0PuZ3XSG/yy8TlgdxC7T50a9ZWj8jLjpLrIlqhcapvZWAQTZtqVq3
        My63TFdQZ1BF/ta1763myB1Kdw==
X-Google-Smtp-Source: APiQypIBGqen1kzX4d4Wf5UYEkYdzKCnAPaaEvwxdtpe+zlIYgN/+aoVVamwm9Ox3hy3wg9aLlAaUA==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr16380670wrt.270.1587368542719;
        Mon, 20 Apr 2020 00:42:22 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm203507wml.43.2020.04.20.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:42:22 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:42:13 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420074213.GA3180232@myrica>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416121331.GA18661@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker wrote:
> > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > > > +	rcu_read_lock();
> > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > > > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > > > +				       start, end - start);
> > > > +	rcu_read_unlock();
> > > > +}
> > > 
> > > What is the reason that the devices don't register their own notifiers?
> > > This kinds of multiplexing is always rather messy, and you do it for
> > > all the methods.
> > 
> > This sends TLB and ATC invalidations through the IOMMU, it doesn't go
> > through device drivers
> 
> I don't think we mean the same thing, probably because of my rather
> imprecise use of the word device.
> 
> What I mean is that the mmu_notifier should not be embedded into the
> io_mm structure (whch btw, seems to have a way to generic name, just
> like all other io_* prefixed names), but instead into the
> iommu_bond structure.  That avoid the whole multiplexing layer.

Right, I can see the appeal. I still like having a single mmu notifier per
mm because it ensures we allocate a single PASID per mm (as required by
x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
to avoid iterating over all bonds during allocation.

Thanks,
Jean
