Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37CF7E5100
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjKHHa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 02:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjKHHa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 02:30:56 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7F198;
        Tue,  7 Nov 2023 23:30:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61CA16732D; Wed,  8 Nov 2023 08:30:49 +0100 (CET)
Date:   Wed, 8 Nov 2023 08:30:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231108073048.GA5277@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103171447.02759771.pasic@linux.ibm.com> <20231103214831.26d29f4d@meshulam.tesarici.cz> <20231106074243.GA17777@lst.de> <20231107182437.06632f6e.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107182437.06632f6e.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 07, 2023 at 06:24:37PM +0100, Halil Pasic wrote:
> Thanks Christoph! So for NVMe in certain contexts the low
> bits of addresses get discarded, but in other contexts the high bits
> of addresses get discarded and the low bits need to remain the same
> after the bounce (and that's why we need commits 36950f2da1ea ("driver
> core: add a min_align_mask) and 1f221a0d0dbf ("swiotlb: respect
> min_align_mask").

Nothing really gets discarded.  NVMe basicaly requires all pages
(where the page is a device page, currently hard coded to 4k in
Linux) except for the first to not have an offset.  This is what
the driver sets the virt boundary to in Linux.  When bounce buffering
thus all segments (except possibly the first) need to keep their
alignment.

