Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09EE13A33B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANIuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:50:10 -0500
Received: from verein.lst.de ([213.95.11.211]:44867 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANIuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 03:50:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0263668B20; Tue, 14 Jan 2020 09:50:08 +0100 (CET)
Date:   Tue, 14 Jan 2020 09:50:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 2/5] x86/PCI: Expose VMD's PCI Device in pci_sysdata
Message-ID: <20200114085007.GB32024@lst.de>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com> <1578676873-6206-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578676873-6206-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 10, 2020 at 10:21:10AM -0700, Jon Derrick wrote:
> To be used by Intel-IOMMU code to find the correct domain.
> 
> CC: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Looks good, modulo the brace bisection issue already pointed out:

Reviewed-by: Christoph Hellwig <hch@lst.de>
