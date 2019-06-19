Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED0F4B4EC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfFSJ3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFSJ3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 05:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jtxKl7bP9WhTKx233rZpXTlNeL+UlP6cFEICtqcLUw0=; b=LN2FCWmoRrgKfBVycnXsX10uL
        3yI48kyAsHgHn3pjiblnc+uamXLSAr9CrHyEpC6UrdnxjVzg+fuYjrRjh9GtMXTFeilIIUyjRm3qA
        o/w/sOgUiAOpvwnRB/fPAPw8B4UezFwR5CB1NDfMvI2VDGTqwF0nnHhVrtnlMov19htva/5rkam6c
        ilaX42hocrazqb111xFwMvUi2JPkIOP365QEhZi2Lb5hWZ+UTfkwlLvMUbTOBW0/FSfI+kPzqGSKr
        TUsTc3WJ/5Zy2j8OMgS0784vbQNOpyE61OlklUi+Rwb1UfHIgMeJh1DCSr9SlvvGRihc54InfBJQW
        5TPm++DyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdWu0-0003rq-24; Wed, 19 Jun 2019 09:29:12 +0000
Date:   Wed, 19 Jun 2019 02:29:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Message-ID: <20190619092912.GA14578@infradead.org>
References: <20190522201252.2997-1-logang@deltatee.com>
 <20190618204007.GB110859@google.com>
 <69724119-5037-000c-a711-856703c60429@deltatee.com>
 <71daf07c-f1a4-806c-a24d-80e97aef19d0@deltatee.com>
 <49c98e2d-1daf-426c-5ccb-0ee3ab3f89c6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c98e2d-1daf-426c-5ccb-0ee3ab3f89c6@amd.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 09:26:42AM +0000, Koenig, Christian wrote:
> I was hoping to get my use case into 5.4 or 5.5, but we are still stuck 
> with some of the DMA-buf related pieces.

Can you make sure you have Logand and me, and maybe the iommu list
Cced when you posted it?  I'd like to make sure we all have a common
understanding where we are moving with the APIs and use cases.
