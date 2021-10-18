Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A66431622
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 12:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJRKce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJRKcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 06:32:33 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E8C06161C;
        Mon, 18 Oct 2021 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rwl8ks5Dht1UAV49Z0niSFrj7ZoB/NjqJVELlq4s5gI=; b=p7Vygy0na/9BqGnMQGwHihS/FC
        4jM3crSFwcGX6eK0lD1SdmBSEetGLmWLuMWtR+d8S5DXdcDaPLG3wGxwBXA+zyd3JI5/+8O58B29+
        hZurbb8sjCT3c2dBrXkFxM7xv2gFTkFRCQaYXiV04f+PwTmhUGkS0W10QpU5zv+2+atnQInmWkmiy
        yqVx6Ew+Z3vGPaS9cLRIXGPDKEznznNHd4RzIiTisiwctqxQNgWXR4v6uZf3W8RrhTlFg4sqo0Jw3
        5jVRaTmTuwaMWToqib5wmqPjE8rbxBxRQvVM8ytZRc13lCzL7BSSl8oPwQWmo1uRO9utEr6gW/TfH
        KeMHsReA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPuL-00F1VI-Gq; Mon, 18 Oct 2021 10:30:17 +0000
Date:   Mon, 18 Oct 2021 03:30:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the unused pci wrappers pci_pool_xxx()
Message-ID: <YW1MuU8GfGuIAzR1@infradead.org>
References: <20211018081629.151-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018081629.151-1-caihuoqing@baidu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 18, 2021 at 04:16:28PM +0800, Cai Huoqing wrote:
> The wrappers around dma_pool_xxx should go away, so
> remove the unused pci wrappers.
> Prefer using dma_pool_xxx() instead of the pci wrappers
> pci_pool_xxx(), and the use of pci_pool_xxx was already
> removed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

This looks good.

But did this survive a few rounds of buildbot randomconfig build on
various architectures?  I'd be somewhat surprised if no file at all
dependended on this implicit inclusion of dmapool.h.
