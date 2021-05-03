Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA18371F9B
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECS0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:26:45 -0400
Received: from verein.lst.de ([213.95.11.211]:36699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECS0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:26:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F8B568BEB; Mon,  3 May 2021 20:25:49 +0200 (CEST)
Date:   Mon, 3 May 2021 20:25:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
Message-ID: <20210503182548.GB17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com> <20210408170123.8788-3-logang@deltatee.com> <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com> <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 10:08:34AM -0600, Logan Gunthorpe wrote:
> Per above, I think the reference count is unnecessary. But I could wrap
> it in a static function for clarity. (There's no reason to export this
> function).

A well documented helper function would really help to improve the
code for the casual reader I think.
