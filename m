Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59174A3BC8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3QSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 12:18:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfH3QSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2019 12:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I09fo0Z72elrZNTtFC7i1aCRoS4BvE/ve/oDk4fjlIs=; b=W17LJbvvnqhDwgrfqSVNFz6uW
        /ysTEHWWEgOWA/hTDj5uwUkmg1oJhx4y+Wrnp5+qkbj+prf+jbJtzOgNYNnGrJ2AmRzLxxXyoBUwY
        btk5HYQTEjvYtn2luICzXICZc9P/Y72hS78Yz3WDcN9b9uT1KZJKsZfGOyj8bJjd2WEcQKsfv5PxB
        QdNPQxoNNss2RWPBZAgsVVh5hKgixig2DztZFjQe+41EZBb3GLp/J717qOT9P+ksZV4wpSGxmMNIc
        idYGJjDaNNVe0nK8WnaMLAG0+a0pd3OCzES4/kiNv1s3a6Wx81ofNR81JyKO4o3nQrElzdVZ8tIY0
        NlOhydYNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jbk-0002ZI-QE; Fri, 30 Aug 2019 16:18:40 +0000
Date:   Fri, 30 Aug 2019 09:18:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: Move ATS declarations to linux/pci.h
Message-ID: <20190830161840.GA9733@infradead.org>
References: <20190830150756.21305-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150756.21305-1-kw@linux.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 30, 2019 at 05:07:56PM +0200, Krzysztof Wilczynski wrote:
> Move ATS function prototypes from include/linux/pci-ats.h to
> include/linux/pci.h so users only need to include <linux/pci.h>:

Why is that so important?  Very few PCI(e) device drivers use ATS,
so keeping it out of everyones include hell doesn't seem all bad.
