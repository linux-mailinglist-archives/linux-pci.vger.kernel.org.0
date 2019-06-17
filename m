Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1048A80
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfFQRku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:50 -0400
Received: from verein.lst.de ([213.95.11.211]:39893 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbfFQRkt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 13:40:49 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AA7D667358; Mon, 17 Jun 2019 19:40:18 +0200 (CEST)
Date:   Mon, 17 Jun 2019 19:40:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 06/25] mm: factor out a devm_request_free_mem_region
 helper
Message-ID: <20190617174018.GA18185@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-7-hch@lst.de> <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 10:37:12AM -0700, Dan Williams wrote:
> > +struct resource *devm_request_free_mem_region(struct device *dev,
> > +               struct resource *base, unsigned long size);
> 
> This appears to need a 'static inline' helper stub in the
> CONFIG_DEVICE_PRIVATE=n case, otherwise this compile error triggers:
> 
> ld: mm/hmm.o: in function `hmm_devmem_add':
> /home/dwillia2/git/linux/mm/hmm.c:1427: undefined reference to
> `devm_request_free_mem_region'

*sigh* - hmm_devmem_add already only works for device private memory,
so it shouldn't be built if that option is not enabled, but in the
current code it is.  And a few patches later in the series we just
kill it off entirely, and the only real caller of this function
already depends on CONFIG_DEVICE_PRIVATE.  So I'm tempted to just
ignore the strict bisectability requirement here instead of making
things messy by either adding the proper ifdefs in hmm.c or providing
a stub we don't really need.
