Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DCD9578
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392929AbfJPP0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 11:26:06 -0400
Received: from foss.arm.com ([217.140.110.172]:43286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbfJPP0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 11:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28331142F;
        Wed, 16 Oct 2019 08:26:05 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2660D3F68E;
        Wed, 16 Oct 2019 08:26:04 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:26:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191016152601.GB7457@e121166-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
 <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4353d63-6f78-92b3-91c9-acc9327e1d80@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 05:10:02PM +0200, Marek Vasut wrote:
> On 10/16/19 5:00 PM, Lorenzo Pieralisi wrote:
> > On Fri, Aug 09, 2019 at 07:57:40PM +0200, Marek Vasut wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> In case the "dma-ranges" DT property contains either too many ranges
> >> or the range start address is unaligned in such a way that populating
> >> the range into the controller requires multiple entries, a situation
> >> may occur where all ranges cannot be loaded into the controller.
> >>
> >> Currently, the driver refuses to probe in such a situation. Relax this
> >> behavior, load as many ranges as possible and warn if some ranges do
> >> not fit anymore.
> > 
> > Patches (1) and (3) are fine but I do not think this one is.
> > 
> > Firmware (DT) should provide dma-ranges according to what HW can handle,
> > more so given that other subsystems (eg IOMMU) rely on the dma-ranges
> > value to set-up eg DMA - if there is a mismatch between PCI host inbound
> > regions and software structures describing DMA'able ranges all bets are
> > off.
> 
> The firmware provides all the ranges which are available and usable,
> that's the hardware description and that should be in the DT.

If the HW (given that those dma-ranges are declared for the PCI host
controller) can't be programmed to enable those DMA ranges - those
ranges are neither available nor usable, ergo DT is broken.

> The firmware cannot decide the policy for the next stage (Linux in
> this case) on which ranges are better to use for Linux and which are
> less good. Linux can then decide which ranges are best suited for it
> and ignore the other ones.

dma-ranges is a property that is used by other kernel subsystems eg
IOMMU other than the RCAR host controller driver. The policy, provided
there is one should be shared across them. You can't leave a PCI
host controller half-programmed and expect other subsystems (that
*expect* those ranges to be DMA'ble) to work.

I reiterate my point: if firmware is broken it is better to fail
the probe rather than limp on hoping that things will keep on
working.

Lorenzo
