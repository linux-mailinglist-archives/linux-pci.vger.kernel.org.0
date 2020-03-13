Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE57184286
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 09:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMIZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 04:25:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMIZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 04:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ZdDlbLqNOvakJ4NWfeKFrm2xJH0FxuVXIiomBTeWY0=; b=h0nC3b0lys4AAFlklVuzX011mM
        aHVnRucRLsffajpU6AVN5ImOUq9DYUQk/8gBFO80Sg/fTAjqTJ0XiqmWvPve7tuqVDjJEqyAmYuUZ
        bqQ/GWEiKM8bO0yKpKacYY2OQJClYNWda3Wf4EyMniDg4/SLt23w5bwyeHZu2x52xijyMGx23TdqG
        T83ispvqZvSbDr2cgRfJPZ4jpDnloh/lNDY7Vdho5o+etQWEpjKmccgwP0uzeCdHBOnDLLv68D5vd
        B6GTSlbxQfeBfIwAJxva6gGs6+dJtEAhcXMLMzVmW7AQktEp5K2Clsb0pU1yj3qpp0rNK3viZRG0l
        WR2idzGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCfch-0005OI-Ce; Fri, 13 Mar 2020 08:24:51 +0000
Date:   Fri, 13 Mar 2020 01:24:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 4/6] MIPS: Loongson: Add DMA support for 7A1000
Message-ID: <20200313082451.GA20331@infradead.org>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 09, 2020 at 04:23:24PM +0800, Tiezhu Yang wrote:
> Implement __phys_to_dma() and __dma_to_phys() according to the
> node id offset in 7A1000 DMA route config register.

Can you just switch Loongson over to use the dma_pfn_offset field in
struct device?  I'd love to kill the __phys_to_dma and __dma_to_phys
hooks wherever possible.
