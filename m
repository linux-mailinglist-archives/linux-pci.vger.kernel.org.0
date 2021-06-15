Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F33A8B5E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOVvS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 15 Jun 2021 17:51:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52244 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhFOVvR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:51:17 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ltGvk-0002Ci-Or; Tue, 15 Jun 2021 23:49:08 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Tue, 15 Jun 2021 23:49:07 +0200
Message-ID: <3238453.R1toDxpfAE@diego>
In-Reply-To: <CAL_JsqL8iDo5sLmgNVuXs5wt3TpVJbKHfk7gE740DidmvLOwiQ@mail.gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com> <3105233.izSxrag8PF@diego> <CAL_JsqL8iDo5sLmgNVuXs5wt3TpVJbKHfk7gE740DidmvLOwiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, 15. Juni 2021, 23:29:12 CEST schrieb Rob Herring:
> On Thu, Jun 10, 2021 at 3:50 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi,
> >
> > Am Montag, 7. Juni 2021, 13:28:56 CEST schrieb Punit Agrawal:
> > > The PCIe host bridge on RK3399 advertises a single 64-bit memory
> > > address range even though it lies entirely below 4GB.
> > >
> > > Previously the OF PCI range parser treated 64-bit ranges more
> > > leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
> > > Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> > > the code takes a stricter view and treats the ranges as advertised in
> > > the device tree (i.e, as 64-bit).
> > >
> > > The change in behaviour causes failure when allocating bus addresses
> > > to devices connected behind a PCI-to-PCI bridge that require
> > > non-prefetchable memory ranges. The allocation failure was observed
> > > for certain Samsung NVMe drives connected to RockPro64 boards.
> > >
> > > Update the host bridge window attributes to treat it as 32-bit address
> > > memory. This fixes the allocation failure observed since commit
> > > 9d57e61bf723.
> > >
> > > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> >
> > just for clarity, should I just pick this patch separately for 5.13-rc to
> > make it easy for people using current kernel devicetrees, or should
> > this wait for the update mentioned in the cover-letter response
> > and should go all together through the PCI tree?
> 
> This was dropped from v4, but should still be applied IMO.

It was probably dropped because I applied it ;-)

It's part of armsoc already [0] and should make its way into
5.13 shortly.


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=arm/fixes&id=8efe01b4386ab38a36b99cfdc1dc02c38a8898c3

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 




