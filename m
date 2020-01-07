Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5851327F7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAGNl2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 08:41:28 -0500
Received: from 8bytes.org ([81.169.241.247]:59212 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgAGNl2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 08:41:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CACC53AA; Tue,  7 Jan 2020 14:41:26 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:41:25 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 0/5] Clean up VMD DMA Map Ops
Message-ID: <20200107134125.GD30750@8bytes.org>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:18PM -0700, Jon Derrick wrote:
> Jon Derrick (5):
>   iommu: Remove device link to group on failure
>   iommu/vt-d: Unlink device if failed to add to group

Added 'Fixes:' tags to these two and applied them for v5.5, thanks.
