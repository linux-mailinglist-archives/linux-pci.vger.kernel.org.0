Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61F1B221B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDUIza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUIza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 04:55:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBDFC061A0F;
        Tue, 21 Apr 2020 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TpKuw/piS7tkOzNHb5163BQiSydgsqXnGL17Bi9pIXc=; b=LLXaj31F1SppFy6MghvYaRRE1+
        QqN2HC2nMR5iG9DkLgeCfPVGYcB4g4jeeLucL7dv26bQ8SVNgS3U9esD3F2Ge10NEC1XL8P1AvKUV
        Kx5PxSvAsln7Q5hWK6bySudtYQ3j1gReRrxf2EAFELegUA1Kmq2/+xUd9WUjMxkpNOueRqf3LyXuI
        HHvGbluS5RXGfgaXsdlFNN1aPeqMVrTJrYubQJ+gCQSB6JA0J1l2NrpGO6h7eyBbxJ0hkYbzdKY3Q
        6VKqB4BS0aoY1WQQgGz2pa/GMrSRSy40hCXicGCzTViwqYOBDw8NG3bdMKvluYftNIYbak9jqL9uu
        TriHhV6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQogf-0005Gs-NA; Tue, 21 Apr 2020 08:55:25 +0000
Date:   Tue, 21 Apr 2020 01:55:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, zhangfei.gao@linaro.org,
        xuzaibo@huawei.com, "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200421085525.GA6900@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
 <20200420135727.GO26002@ziepe.ca>
 <20200420104850.60531cb6@jacob-builder>
 <20200420181437.GA229170@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420181437.GA229170@romley-ivt3.sc.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 11:14:37AM -0700, Fenghua Yu wrote:
> > Agreed, perhaps Fenghua can consider that in his patchset. It would
> > help align life cycles as well.
> > https://lkml.org/lkml/2020/3/30/910>
> 
> Seems we depend on each other: my patch defines pasid in mm_struct.
> I can free PASID in your detach() function.

Looks like this should go into the same series.  I also don't see any
good reason to have the pasid in the x86-specific context vs the common
mm_struct.
