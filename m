Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2055D2C72B0
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgK1VuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from verein.lst.de ([213.95.11.211]:40023 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729983AbgK1Sdm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 13:33:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9163A68AFE; Sat, 28 Nov 2020 18:15:01 +0100 (CET)
Date:   Sat, 28 Nov 2020 18:15:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev":
 many XHCI swiotlb buffer is full / DMAR: Device bounce map failed
 errors on thunderbolt connected XHCI controller
Message-ID: <20201128171500.GA3550@lst.de>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com> <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com> <20201124102715.GA16983@lst.de> <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com> <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com> <20201127161900.GA10986@lst.de> <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can you give this one-liner a spin?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c6622011d4938c..e889111b55c71d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4007,6 +4007,7 @@ static const struct dma_map_ops bounce_dma_ops = {
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 	.dma_supported		= dma_direct_supported,
+	.max_mapping_size	= swiotlb_max_mapping_size,
 };
 
 static inline int iommu_domain_cache_init(void)
