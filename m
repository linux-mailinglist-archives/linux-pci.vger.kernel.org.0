Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87C490A3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFQTz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 15:55:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40606 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfFQTz4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 15:55:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 82B6768B02; Mon, 17 Jun 2019 21:55:26 +0200 (CEST)
Date:   Mon, 17 Jun 2019 21:55:26 +0200
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
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
Message-ID: <20190617195526.GB20275@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-9-hch@lst.de> <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 10:51:35AM -0700, Dan Williams wrote:
> > -       struct dev_pagemap *pgmap = _pgmap;
> 
> Whoops, needed to keep this line to avoid:
> 
> tools/testing/nvdimm/test/iomap.c:109:11: error: ‘pgmap’ undeclared
> (first use in this function); did you mean ‘_pgmap’?

So I really shouldn't be tripping over this anymore, but can we somehow
this mess?

 - at least add it to the normal build system and kconfig deps instead
   of stashing it away so that things like buildbot can build it?
 - at least allow building it (under COMPILE_TEST) if needed even when
   pmem.ko and friends are built in the kernel?
