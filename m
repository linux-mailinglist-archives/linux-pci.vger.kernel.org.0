Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D2A1C7F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfH2OO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 10:14:58 -0400
Received: from verein.lst.de ([213.95.11.211]:46641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2OO5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 10:14:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2351F68B20; Thu, 29 Aug 2019 16:14:54 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:14:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI/vmd: Stop overriding dma_map_ops
Message-ID: <20190829141453.GC18677@lst.de>
References: <20190828141443.5253-1-hch@lst.de> <20190828141443.5253-5-hch@lst.de> <20190828150106.GD23412@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828150106.GD23412@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 09:01:06AM -0600, Keith Busch wrote:
> On Wed, Aug 28, 2019 at 07:14:42AM -0700, Christoph Hellwig wrote:
> > With a little tweak to the intel-iommu code we should be able to work
> > around the VMD mess for the requester IDs without having to create giant
> > amounts of boilerplate DMA ops wrapping code.  The other advantage of
> > this scheme is that we can respect the real DMA masks for the actual
> > devices, and I bet it will only be a matter of time until we'll see the
> > first DMA challeneged NVMe devices.
> 
> This tests out fine on VMD hardware, but it's quite different than the
> previous patch. In v1, the original dev was used in iommu_need_mapping(),
> but this time it's the vmd device. Is this still using the actual device's
> DMA mask then?

True.  But then again I think the old one was broken as well, as it
will pass the wrong dev to identity_mapping() or
iommu_request_dma_domain_for_dev.   So I guess I'll need to respin it
a bit to do the work in iommu_need_mapping again, and then factor
that one to make it obvious what device we deal with.
