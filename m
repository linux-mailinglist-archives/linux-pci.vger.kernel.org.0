Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA901B03E6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgDTIKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTIKj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 04:10:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D3AC061A0C;
        Mon, 20 Apr 2020 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1JU5+id39RVYYiwVLrKINx5vf4t7nToazXLCIKWefE=; b=kaM0tk5W81sI2+qX4Q+fhFqknM
        bURUCNk0t2z/tH3hUWbh5Ya9slhk5rLszSWU71wkyFyy7q2Tqtylx0B1qa4oBZPhzl1Pzd0n9iYI8
        U7EmgJ8u5DWdLj8f4XGdJLn1gEer0ExVNct3iwrHWd6KEFcS/i5dzVd1+giEP2fKM0YZ5nI94pJGU
        bLc0GipQGkEljB04yFayRugJ2xmfUknk0m5ohkt5kM/71a59PYsDPRLMCziNvX2mPRoqrCALoAuOB
        x+Diqoon7jrr1Snwm2VWR5aH9n2Hpqx5jH6fbbjyms2QLla8aBMh0zsJvsuQdVSIVR0dIm7P9QRvO
        X5rQmNQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQRVi-0007EB-H6; Mon, 20 Apr 2020 08:10:34 +0000
Date:   Mon, 20 Apr 2020 01:10:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420081034.GA17305@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420074213.GA3180232@myrica>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> Right, I can see the appeal. I still like having a single mmu notifier per
> mm because it ensures we allocate a single PASID per mm (as required by
> x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
> to avoid iterating over all bonds during allocation.

Given that the PASID is a pretty generic and important concept can
we just add it directly to the mm_struct and allocate it lazily once
we first need it?
