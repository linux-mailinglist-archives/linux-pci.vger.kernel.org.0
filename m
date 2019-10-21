Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE05CDE930
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 12:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfJUKSi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 06:18:38 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48020 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUKSi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 06:18:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA47E493;
        Mon, 21 Oct 2019 03:18:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CCC3F718;
        Mon, 21 Oct 2019 03:18:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:18:06 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 03:28:04PM +0200, Marek Vasut wrote:
> On 8/16/19 3:23 PM, Simon Horman wrote:
> > On Fri, Aug 09, 2019 at 07:57:40PM +0200, marek.vasut@gmail.com wrote:
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
> > What is the motivation for relaxing this?
> 
> U-Boot can fill the ranges in properly now, the list would be longer in
> such a case and the driver would fail to probe (because the list is
> longer than what the hardware can support).

Is this the U-Boot patch you refer to:

https://patchwork.ozlabs.org/patch/1129436/

As pci_set_region is called with the same address for PCI and CPU memory
this implies there is a 1:1 mapping - therefore I don't see a need for
multiple mappings for each DRAM bank. (Also if this controller has a
32 bit limitation, shouldn't this code limit the addresses before calling
pci_set_region?).

Thanks,

Andrew Murray

> 
> -- 
> Best regards,
> Marek Vasut
