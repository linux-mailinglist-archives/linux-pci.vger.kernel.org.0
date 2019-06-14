Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A648454F5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNGrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 02:47:46 -0400
Received: from verein.lst.de ([213.95.11.211]:44512 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNGrq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:47:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CC60468B02; Fri, 14 Jun 2019 08:47:16 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:47:16 +0200
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
Subject: Re: [PATCH 21/22] mm: remove the HMM config option
Message-ID: <20190614064716.GN7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-22-hch@lst.de> <20190613200150.GB22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613200150.GB22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 08:01:55PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:24AM +0200, Christoph Hellwig wrote:
> > All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
> > depend on it instead of the mix of a dummy dependency symbol plus the
> > actually selected one.  Drop various odd dependencies, as the code is
> > pretty portable.
> 
> I don't really know, but I thought this needed the arch restriction
> for the same reason get_user_pages has various unique arch specific
> implementations (it does seem to have some open coded GUP like thing)?
> 
> I was hoping we could do this after your common gup series? But sooner
> is better too.

Ok, I've added the arch and 64-bit dependency back in for now.  It does
not look proper to me, and is certainly underdocumented, but the whole
pagetable walking code will need a lot of love eventually anyway, and
the Kconfig stuff for it can be done properly then.
