Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F013135B87
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgAIOhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 09:37:03 -0500
Received: from verein.lst.de ([213.95.11.211]:55031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbgAIOhD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:37:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25B8D68BFE; Thu,  9 Jan 2020 15:37:01 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:37:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 5/5] x86/PCI: Remove unused X86_DEV_DMA_OPS
Message-ID: <20200109143700.GD22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com> <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:23PM -0700, Jon Derrick wrote:
> VMD was the only user of device dma operations. Now that the IOMMU has
> been made aware of direct DMA aliases, VMD domain devices can reference
> the VMD endpoint directly and the VMD device dma operations has been
> made obsolete.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This seems to be a 1:1 copy of my patch from August?
