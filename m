Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6760147070
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFOObO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jun 2019 10:31:14 -0400
Received: from verein.lst.de ([213.95.11.211]:53697 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOObO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jun 2019 10:31:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 57B1468B02; Sat, 15 Jun 2019 16:30:44 +0200 (CEST)
Date:   Sat, 15 Jun 2019 16:30:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/22] mm: factor out a devm_request_free_mem_region
 helper
Message-ID: <20190615143043.GA27825@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-7-hch@lst.de> <56c130b1-5ed9-7e75-41d9-c61e73874cb8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c130b1-5ed9-7e75-41d9-c61e73874cb8@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 07:21:54PM -0700, John Hubbard wrote:
> On 6/13/19 2:43 AM, Christoph Hellwig wrote:
> > Keep the physical address allocation that hmm_add_device does with the
> > rest of the resource code, and allow future reuse of it without the hmm
> > wrapper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  include/linux/ioport.h |  2 ++
> >  kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
> >  mm/hmm.c               | 33 ++++-----------------------------
> >  3 files changed, 45 insertions(+), 29 deletions(-)
> 
> Some trivial typos noted below, but this accurately moves the code
> into a helper routine, looks good.

Thanks for the typo spotting.  These two actually were copy and pasted
from the original hmm code, but I'll gladly fix them for the next
iteration.
