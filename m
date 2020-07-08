Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C35218735
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgGHM0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 08:26:04 -0400
Received: from verein.lst.de ([213.95.11.211]:35063 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgGHM0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 08:26:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7232068AFE; Wed,  8 Jul 2020 14:26:01 +0200 (CEST)
Date:   Wed, 8 Jul 2020 14:26:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu/intel: Avoid SAC address trick for PCIe
 devices
Message-ID: <20200708122601.GB19619@lst.de>
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks pretty sensible.

> -	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
> +	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32) &&
> +	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev))) {

The only thing I wonder is if it is worth to add a little helper
for this check, but with everything moving to dma-iommu that might
not be needed.

Btw, does anyone know what the status of the intel-iommu conversion
to dma-iommu is?
