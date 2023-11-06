Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79E7E1B73
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 08:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKFHmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 02:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKFHmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 02:42:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0E593;
        Sun,  5 Nov 2023 23:42:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3F0D6732D; Mon,  6 Nov 2023 08:42:43 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:42:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231106074243.GA17777@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com> <20231103171447.02759771.pasic@linux.ibm.com> <20231103214831.26d29f4d@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103214831.26d29f4d@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 09:50:53PM +0100, Petr Tesařík wrote:
> Seconded. I have also been struggling with the various alignment
> constraints. I have even written (but not yet submitted) a patch to
> calculate the combined alignment mask in swiotlb_tbl_map_single() and
> pass it down to all other functions, just to make it clear what
> alignment mask is used.

That does sound like a good idea.

> My understanding is that buffer alignment may be required by:
> 
> 1. hardware which cannot handle an unaligned base address (presumably
>    because the chip performs a simple OR operation to get the addresses
>    of individual fields);

There's all kinds of weird encodings that discard the low bits.
For NVMe it's the PRPs (that is actually documented in the NVMe
spec, so it might be easiest to grasp), but except for a Mellox
vendor extension this is also how all RDMA memory registrations
work.

