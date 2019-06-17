Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FA490FB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 22:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFQUKa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 16:10:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40726 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfFQUKa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 16:10:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0673468B02; Mon, 17 Jun 2019 22:09:58 +0200 (CEST)
Date:   Mon, 17 Jun 2019 22:09:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
Message-ID: <20190617200957.GA20645@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-9-hch@lst.de> <d68c5e4c-b2de-95c3-0b75-1f2391b25a34@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68c5e4c-b2de-95c3-0b75-1f2391b25a34@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 02:08:14PM -0600, Logan Gunthorpe wrote:
> I just noticed this is missing a line to set pgmap->ops to
> pci_p2pdma_pagemap_ops. I must have gotten confused by the other users
> in my original review. Though I'm not sure how this compiles as the new
> struct is static and unused. However, it is rendered moot in Patch 16
> when this is all removed.

It probably was there in the original and got lost in the merge conflicts
from the rebase.  I should have dropped all the reviewed-bys for patches
with non-trivial merge resolution, sorry.
