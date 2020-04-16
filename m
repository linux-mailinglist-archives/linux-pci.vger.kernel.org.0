Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70941AB9EE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439296AbgDPH24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439247AbgDPH2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 03:28:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA613C061A0C;
        Thu, 16 Apr 2020 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jphD0QxUkx58Leqoht9un+IW160yDSl4a16sN6p0wp0=; b=ZQMTfiSf0WNZaROzM2Vhq2JZIW
        flXWEldz7UFTJIRSqBk3edg5nQSUF6LsWtPN+mawKB4PsOsdkxYadKG8t1s+1HIyvjGViM+/4u9XJ
        sgPwv3FT/YG+CfgsVteNEl5xbrhxqk9RuXFgnRaUgaEUWVkwUoI4/jt/bXvBlrJVdXXG3LOUI7axo
        EZJxFj7JnlE9kwMDzkbS/YdTknhS9MaRxElQ9Zw+X7NQaTkjHzqWCOaA3K7u8MzLxFSeFj+5JpGfy
        g45mkULRGMxSAE63aQiVISOPNMz3DDBt98u/jefGfgi26MakebbHZn+tDgCIHIRaECC9QSl/RRB5L
        zV3sruZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyxA-00058d-St; Thu, 16 Apr 2020 07:28:52 +0000
Date:   Thu, 16 Apr 2020 00:28:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416072852.GA32000@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414170252.714402-3-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> +				       start, end - start);
> +	rcu_read_unlock();
> +}

What is the reason that the devices don't register their own notifiers?
This kinds of multiplexing is always rather messy, and you do it for
all the methods.
