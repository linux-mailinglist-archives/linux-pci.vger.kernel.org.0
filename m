Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA0C7A54E3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjIRVOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjIRVOJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 17:14:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837F10D;
        Mon, 18 Sep 2023 14:14:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D4BC433C8;
        Mon, 18 Sep 2023 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695071643;
        bh=4tOam79bsmTQzdb8YxeKxMt9ug/E8wwrIxDwgg6YENk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VxSE3duFc9Htup9Yy3e5tbU5pz5quf6oJUGYO++yGvHs8+YOooxiZwN5JkeOCaNGN
         nhpQVmYQfIsk4LBqwYrMneOWJjcVf3BL7kMlDsMZgV7pWg4nlhKRxqey8XID6ua2r3
         RfSVU5q2gH+74/xFjquv8Dn7CZd+YlnH2is5MclBLjHnIhLBkEQjdBFBueqpafY1zr
         iLNlNjOWRVjkB0lvb92bnePGGK0jjTkVErUAx/Qw+uTtIAB/8HMWbvZ19MdBnEfjUB
         6iQoV7e6RL6sxvwlgqgibUYlIwm+mjE93zkB4ksXJa49WvjEY2sZSqvShLgsLQCCKv
         r2dggUro/aECw==
Date:   Mon, 18 Sep 2023 16:14:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] PCI: mediatek: Correct type for virt_to_phys()
Message-ID: <20230918211400.GA208009@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQWGd/RyKaUBRhUY@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 16, 2023 at 01:41:59PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 14, 2023 at 03:31:46PM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 14, 2023 at 10:23:24PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > +	addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);
> > 
> > Lots of these drivers use either virt_to_phys() or
> > platform_get_resource_byname() to get a physical address that they
> > then use as the MSI target.
> > 
> > But I don't think that's quite right -- the MSI is a DMA transaction
> > on PCI, and in general there's no guarantee that bus addresses are
> > identical to CPU physical addresses, so shouldn't we use a dma_addr_t
> > obtained from the DMA API?
> > 
> > dw_pcie_msi_host_init() has a complicated version of this that uses
> > dmam_alloc_coherent().
> 
> Fair enough. I leave it to you then to get it fixed properly.
> Consider this as just a heads up for the old report.

Sounds good, thanks!

Bjorn
