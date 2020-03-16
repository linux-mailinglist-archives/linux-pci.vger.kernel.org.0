Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0993186EEF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgCPPrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 11:47:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbgCPPrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouN0e4/1zqiBLoUJJ4QgzJ5Y6SjVqjDFHS+Tu4nAdmM=; b=LJScDWCjj3NCA4uVHCSkioMP/q
        /Z7XCUgEjkky9gRxRqun4cAZU1jNAliOiH17ROlaWz91YJlSBnmbXIR142K9TDY8WJI+fiVPH2KQX
        GESP7Vu07So0GETmAOlWvCQn7UXcBwg8Ya+QmAceR3w3eBV2c8pAp5CfPNfABsdRslgltWnytBCoP
        qPoV38uCGdIE9woLQ2E8wMziYu21I2p72c0gppQ5GAdApUH55lp3uCCSy/ENm2L3bRV0sRL9YhWB3
        CYKx0LHNkpiirDs6Thno8xvGgd+zMeIzwagUfoLnlv1S6AtPy7ECDPuX+MvSNfdzQuzP6kxCS0AbG
        UoDB9Zig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDrxD-00028Q-5o; Mon, 16 Mar 2020 15:46:59 +0000
Date:   Mon, 16 Mar 2020 08:46:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        kevin.tian@intel.com, Dimitri Sivanich <sivanich@sgi.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, robin.murphy@arm.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, catalin.marinas@arm.com,
        zhangfei.gao@linaro.org, Andrew Morton <akpm@linux-foundation.org>,
        will@kernel.org, christian.koenig@amd.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200316154659.GA18704@infradead.org>
References: <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130919.GJ31668@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> This is why release must do invalidate all - but it doesn't need to do
> any more - as no SPTE can be established without a mmget() - and
> mmget() is no longer possible past release.

Maybe we should rename the release method to invalidate_all?
