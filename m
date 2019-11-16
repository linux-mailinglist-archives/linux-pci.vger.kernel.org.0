Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71CAFF3ED
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfKPQfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 11:35:30 -0500
Received: from verein.lst.de ([213.95.11.211]:49403 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKPQfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 Nov 2019 11:35:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 579D968BE1; Sat, 16 Nov 2019 17:35:28 +0100 (CET)
Date:   Sat, 16 Nov 2019 17:35:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20191116163528.GE23951@lst.de>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com> <20191115130654.GA3414@lst.de> <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 07:48:23PM +0530, Kishon Vijay Abraham I wrote:
> I think the fix on 5.3 was useful for platform drivers (where the platform
> driver will set dma_set_mask as 32bits) even when the system itself supports LPAE.

Well, we can also use the bus_dma_mask for PCI(e) root port quirks,
as we do that for the VIA ones on x86.  But I think the OF parsing code
is missing something here, and Robin did plan to look into that.

> We should find a way to set the DMA mask of of the PCI device based on the DMA
> mask of the PCI controller in the SoC. One option would be to change the
> pci_drivers all over the kernel to set DMA mask to be based on the DMA mask of
> the PCI controller (the PCI device hierarchy should get a reference to the
> device pointer of the PCI controller). Or is there a better way to handle this?

No.  The driver sets the device capabilities.  bus_dma_mask handles
the system limitations.
