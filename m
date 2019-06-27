Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AED57EAD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfF0IvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 04:51:20 -0400
Received: from verein.lst.de ([213.95.11.211]:50729 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0IvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 04:51:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 742B868B20; Thu, 27 Jun 2019 10:50:47 +0200 (CEST)
Date:   Thu, 27 Jun 2019 10:50:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 11/25] memremap: lift the devmap_enable manipulation
 into devm_memremap_pages
Message-ID: <20190627085047.GA11420@lst.de>
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-12-hch@lst.de> <20190626190445.GE4605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626190445.GE4605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 12:04:46PM -0700, Ira Weiny wrote:
> > +static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
> > +{
> > +	if (!pgmap->ops->page_free) {
> 
> NIT: later on you add the check for pgmap->ops...  it should probably be here.
> 
> But not sure that bisection will be an issue here.

At this point we do not allow a NULL ops pointer.  That only becomes
a valid option one the internal refcount is added.  Until then a NULL
->ops pointer leads to an error return from devm_memremap_pages.
