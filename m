Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30BB135B79
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgAIOgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 09:36:16 -0500
Received: from verein.lst.de ([213.95.11.211]:55012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgAIOgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:36:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F9BD68BFE; Thu,  9 Jan 2020 15:36:13 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:36:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Message-ID: <20200109143613.GC22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com> <1577823863-3303-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-5-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:22PM -0700, Jon Derrick wrote:
> Devices on the VMD domain use the VMD endpoint's requester-id and have
> been relying on the VMD endpoint's dma operations. The downside of this
> was that VMD domain devices would use the VMD endpoint's attributes when
> doing DMA and IOMMU mapping. We can be smarter about this by only using
> the VMD endpoint when mapping and providing the correct child device's
> attributes during dma operations.
> 
> This patch adds a new dma alias mechanism by adding a hint to a pci_dev
> to point to a singular DMA requester's pci_dev. This integrates into the
> existing dma alias infrastructure to reduce the impact of the changes
> required to support this mode.

If we want to lift this check into common code I think it should go
into struct device, as that is what DMA operates on normally.  That
being said given that this insane hack only exists for braindamage in
Intel hardware I'd rather keep it as isolated as possible.
