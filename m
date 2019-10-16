Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E00D96DD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393669AbfJPQSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 12:18:51 -0400
Received: from foss.arm.com ([217.140.110.172]:44632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJPQSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 12:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8F928;
        Wed, 16 Oct 2019 09:18:49 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7A43F68E;
        Wed, 16 Oct 2019 09:18:48 -0700 (PDT)
Date:   Wed, 16 Oct 2019 17:18:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, robh@kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191016161846.GC7457@e121166-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
 <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
 <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
 <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75fb3519-80eb-fec2-d3eb-cc1b884fef25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+RobH, Robin]

On Wed, Oct 16, 2019 at 05:29:50PM +0200, Marek Vasut wrote:

[...]

> >> The firmware provides all the ranges which are available and usable,
> >> that's the hardware description and that should be in the DT.
> > 
> > If the HW (given that those dma-ranges are declared for the PCI host
> > controller) can't be programmed to enable those DMA ranges - those
> > ranges are neither available nor usable, ergo DT is broken.
> 
> The hardware can be programmed to enable those DMA ranges, just not all
> of them at the same time.

Ok, we are down to DT bindings interpretation then.

> It's not the job of the bootloader to guess which ranges might the next
> stage like best.

By the time this series:

https://patchwork.ozlabs.org/user/todo/linux-pci/?series=132419

is merged, your policy will require the host controller driver to
remove the DMA ranges that could not be programmed in the inbound
address decoders from the dma_ranges list, otherwise things will
fall apart.

> >> The firmware cannot decide the policy for the next stage (Linux in
> >> this case) on which ranges are better to use for Linux and which are
> >> less good. Linux can then decide which ranges are best suited for it
> >> and ignore the other ones.
> > 
> > dma-ranges is a property that is used by other kernel subsystems eg
> > IOMMU other than the RCAR host controller driver. The policy, provided
> > there is one should be shared across them. You can't leave a PCI
> > host controller half-programmed and expect other subsystems (that
> > *expect* those ranges to be DMA'ble) to work.
> > 
> > I reiterate my point: if firmware is broken it is better to fail
> > the probe rather than limp on hoping that things will keep on
> > working.
> 
> But the firmware is not broken ?

See above, it depends on how the dma-ranges property is interpreted,
hopefully we can reach consensus in this thread, I won't merge a patch
that can backfire later unless we all agree that what it does is
correct.

Lorenzo
