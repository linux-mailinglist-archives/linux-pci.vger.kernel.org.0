Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9C1390F5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 13:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMMUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 07:20:50 -0500
Received: from 8bytes.org ([81.169.241.247]:59738 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMMUu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 07:20:50 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2F3482C3; Mon, 13 Jan 2020 13:20:48 +0100 (CET)
Date:   Mon, 13 Jan 2020 13:20:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC 2/5] iommu/vt-d: Unlink device if failed to add to group
Message-ID: <20200113122045.GE28359@8bytes.org>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-3-git-send-email-jonathan.derrick@intel.com>
 <e45b00d9-579b-e141-e704-7084fe05bd29@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45b00d9-579b-e141-e704-7084fe05bd29@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 09:36:56AM +0800, Lu Baolu wrote:
> On 1/1/20 4:24 AM, Jon Derrick wrote:
> > If the device fails to be added to the group, make sure to unlink the
> > reference before returning.
> > 
> > Signed-off-by: Jon Derrick<jonathan.derrick@intel.com>
> 
> Queued for v5.6.

No need to do so, I sent it upstream with the last pile of iommu fixes.


Thanks,

	Joerg

