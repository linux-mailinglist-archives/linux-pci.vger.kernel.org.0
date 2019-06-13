Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBF44E4D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFMVVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:21:30 -0400
Received: from verein.lst.de ([213.95.11.211]:41290 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 17:21:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A375468B02; Thu, 13 Jun 2019 23:21:01 +0200 (CEST)
Date:   Thu, 13 Jun 2019 23:21:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: dev_pagemap related cleanups
Message-ID: <20190613212101.GA27174@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com> <20190613204043.GD22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613204043.GD22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 08:40:46PM +0000, Jason Gunthorpe wrote:
> > Perhaps we should pull those out and resend them through hmm.git?
> 
> It could be done - but how bad is the conflict resolution?

Trivial.  All but one patch just apply using git-am, and the other one
just has a few lines of offsets.

I've also done a preliminary rebase of my series on top of those
patches, and it really nicely helps making the drivers even simpler
and allows using the internal refcount in p2pdma.c as well.
