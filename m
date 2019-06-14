Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0063F454A2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfFNGYB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:24:01 -0400
Received: from verein.lst.de ([213.95.11.211]:44352 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfFNGYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:24:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 50BC268B02; Fri, 14 Jun 2019 08:23:31 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:23:31 +0200
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
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
Message-ID: <20190614062331.GG7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de> <d83280b5-8cca-3b28-1727-58a70648e2b9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83280b5-8cca-3b28-1727-58a70648e2b9@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 06:47:57PM -0700, John Hubbard wrote:
> On 6/13/19 2:43 AM, Christoph Hellwig wrote:
> > noveau is currently using this through an odd hmm wrapper, and I plan
> 
>   "nouveau"

Meh, I keep misspelling that name.  I've already fixed it up a few times
for this series along.

