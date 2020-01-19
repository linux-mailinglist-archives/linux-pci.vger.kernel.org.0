Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE87142068
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 23:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgASWSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jan 2020 17:18:47 -0500
Received: from verein.lst.de ([213.95.11.211]:42023 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgASWSq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Jan 2020 17:18:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E9FB68B20; Sun, 19 Jan 2020 23:18:43 +0100 (CET)
Date:   Sun, 19 Jan 2020 23:18:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
Message-ID: <20200119221843.GA4759@lst.de>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com> <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 17, 2020 at 09:27:26AM -0700, Jon Derrick wrote:
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev;
> +
> +		pdev = pci_real_dma_dev(to_pci_dev(dev));
> +		dev = &pdev->dev;

I think this could be simplified to

	if (dev_is_pci(dev))
		dev = &pci_real_dma_dev(to_pci_dev(dev)->dev;

