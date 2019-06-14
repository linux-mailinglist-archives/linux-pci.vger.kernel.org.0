Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA04549E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfFNGVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:21:40 -0400
Received: from verein.lst.de ([213.95.11.211]:44340 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfFNGVj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:21:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 105CE68B02; Fri, 14 Jun 2019 08:21:11 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:21:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
Message-ID: <20190614062110.GF7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-5-hch@lst.de> <20190613190501.GQ22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613190501.GQ22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 07:05:07PM +0000, Jason Gunthorpe wrote:
> Hurm, is hmm following this comment from mm_types.h?
> 
>  * If you allocate the page using alloc_pages(), you can use some of the
>  * space in struct page for your own purposes.  The five words in the main
>  * union are available, except for bit 0 of the first word which must be
>  * kept clear.  Many users use this word to store a pointer to an object
>  * which is guaranteed to be aligned.  If you use the same storage as
>  * page->mapping, you must restore it to NULL before freeing the page.
> 
> Maybe the assumption was that a driver is using ->mapping ?

Maybe.  The union layou in struct page certainly doesn't help..
