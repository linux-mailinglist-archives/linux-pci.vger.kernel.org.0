Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA07E1B76
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 08:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKFHoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 02:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKFHoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 02:44:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708F93;
        Sun,  5 Nov 2023 23:44:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 611E46732D; Mon,  6 Nov 2023 08:44:48 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:44:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231106074448.GB17777@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103195949.0af884d0@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103195949.0af884d0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 07:59:49PM +0100, Petr Tesařík wrote:
> I don't think it's possible to improve the allocation logic without
> modifying the page allocator and/or the DMA atomic pool allocator to
> take additional constraints into account.
> 
> I had a wild idea back in March, but it would require some intrusive
> changes in the mm subsystem. Among other things, it would make memory
> zones obsolete. I mean, people may actually like to get rid of DMA,
> DMA32 and NORMAL, but you see how many nasty bugs were introduced even
> by a relatively small change in SWIOTLB. Replacing memory zones with a
> system based on generic physical allocation constraints would probably
> blow up the universe. ;-)

It would be very nice, at least for DMA32 or the 30/31-bit DMA pools
used on some architectures.  For the x86-style 16MB zone DMA I suspect
just having a small pool on the side that's not even exposed to the
memory allocator would probably work better.

I think a lot of the MM folks would love to be able to kill of the
extra zones.
