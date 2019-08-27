Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B999F5B5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfH0V6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 17:58:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:52063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfH0V6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 17:58:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 14:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="381075305"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 14:58:08 -0700
Date:   Tue, 27 Aug 2019 15:56:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmd: Stop overriding dma_map_ops
Message-ID: <20190827215621.GB23412@localhost.localdomain>
References: <20190826150652.10316-1-hch@lst.de>
 <8cad7eb5b5b37aeb041fd0c464383bb5223e4a64.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cad7eb5b5b37aeb041fd0c464383bb5223e4a64.camel@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 11:24:05AM -0700, Derrick, Jonathan wrote:
> On Mon, 2019-08-26 at 17:06 +0200, Christoph Hellwig wrote:
> > With a little tweak to the intel-iommu code we should be able to work
> > around the VMD mess for the requester IDs without having to create giant
> > amounts of boilerplate DMA ops wrapping code.  The other advantage of
> > this scheme is that we can respect the real DMA masks for the actual
> > devices, and I bet it will only be a matter of time until we'll see the
> > first DMA challeneged NVMe devices.
> > 
> > The only downside is that we can't offer vmd as a module given that
> > intel-iommu calls into it.  But the driver only has about 700 lines
> > of code, so this should not be a major issue.
> If we're going to remove its ability to be a module, and given its
> small size, could we make this default =y?
> 
> Otherwise we risk breaking platforms which have it enabled with OSVs
> who miss enabling it

Can we keep this as a module if we stick the remapping struct device
in pci_sysdata instead of going through the vmd driver to get it?

Otherwise, very happy to see this dma wrapping go away.
