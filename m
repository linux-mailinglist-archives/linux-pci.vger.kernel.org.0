Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA8454D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfFNGgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:36:19 -0400
Received: from verein.lst.de ([213.95.11.211]:44446 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNGgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:36:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 50C3C68B02; Fri, 14 Jun 2019 08:35:49 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:35:49 +0200
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
Subject: Re: [PATCH 13/22] device-dax: use the dev_pagemap internal refcount
Message-ID: <20190614063549.GK7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-14-hch@lst.de> <20190614002217.GB783@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614002217.GB783@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 05:22:17PM -0700, Ira Weiny wrote:
> > -	dev_dax->pgmap.ref = &dev_dax->ref;
> 
> I don't think this exactly correct.  pgmap.ref is a pointer to the dev_dax ref
> structure.  Taking it away will cause devm_memremap_pages() to fail AFAICS.
> 
> I think you need to change struct dev_pagemap as well:

Take a look at the previous patch, which adds an internal_ref field
to dev_pagemap that ->ref is set up to point to if not otherwise
initialized.
