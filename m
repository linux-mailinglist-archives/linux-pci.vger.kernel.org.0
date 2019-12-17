Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9F12289E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 11:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLQKYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 05:24:45 -0500
Received: from 8bytes.org ([81.169.241.247]:57722 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfLQKYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 05:24:45 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A0DD286; Tue, 17 Dec 2019 11:24:43 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:24:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     James Sewart <jamessewart@arista.com>, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191217102441.GN8689@8bytes.org>
References: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
 <20191210223745.GA167002@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210223745.GA167002@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Dec 10, 2019 at 04:37:45PM -0600, Bjorn Helgaas wrote:
> Heads up Joerg: I also updated drivers/iommu/amd_iommu.c (this is the
> one reported by the kbuild test robot) and removed the printk there
> that prints the same thing as the one in pci_add_dma_alias(), and I
> updated a PCI quirk that was merged after this patch was posted.

Fine with me, thanks for the heads up.

