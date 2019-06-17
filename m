Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCAA4909D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfFQTyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 15:54:37 -0400
Received: from verein.lst.de ([213.95.11.211]:40590 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbfFQTyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 15:54:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 306A367358; Mon, 17 Jun 2019 21:54:05 +0200 (CEST)
Date:   Mon, 17 Jun 2019 21:54:04 +0200
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/25] memremap: validate the pagemap type passed to
 devm_memremap_pages
Message-ID: <20190617195404.GA20275@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-8-hch@lst.de> <CAPcyv4hbGfOawfafqQ-L1CMr6OMFGmnDtdgLTXrgQuPxYNHA2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hbGfOawfafqQ-L1CMr6OMFGmnDtdgLTXrgQuPxYNHA2w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 12:02:09PM -0700, Dan Williams wrote:
> Need a lead in patch that introduces MEMORY_DEVICE_DEVDAX, otherwise:

Or maybe a MEMORY_DEVICE_DEFAULT = 0 shared by fsdax and p2pdma?
