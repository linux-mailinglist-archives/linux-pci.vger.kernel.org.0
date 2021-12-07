Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB846C5C7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 22:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhLGVEu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 16:04:50 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:55815 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbhLGVER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 16:04:17 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 45929648;
        Tue, 7 Dec 2021 22:00:43 +0100 (CET)
Date:   Tue, 7 Dec 2021 22:00:43 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     qizhong.cheng@mediatek.com, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com,
        pali@kernel.org, maz@kernel.org, alyssa@rosenzweig.io,
        luca@lucaceresoli.net
In-Reply-To: <20211207175416.GA42725@bhelgaas> (message from Bjorn Helgaas on
        Tue, 7 Dec 2021 11:54:16 -0600)
Subject: Re: [RESEND PATCH v2] PCI: mediatek: Delay 100ms to wait power and
 clock to become stable
References: <20211207175416.GA42725@bhelgaas>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <d3cb32527f48df70@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 7 Dec 2021 11:54:16 -0600
> From: Bjorn Helgaas <helgaas@kernel.org>
> 
> [+cc Marc, Alyssa, Mark, Luca for reset timing questions]

Hi Bjorn,

> On Tue, Dec 07, 2021 at 04:41:53PM +0800, qizhong cheng wrote:
> > Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> > 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> > be delayed 100ms (TPVPERL) for the power and clock to become stable.
> > 
> > Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> > Acked-by: Pali Rohár <pali@kernel.org>
> > ---
> > 
> > v2:
> >  - Typo fix.
> >  - Rewrap into one paragraph.
> 
> 1) If you change something, even in the commit log or comments, it is
> a new version, not a "RESEND".  A "RESEND" means "I sent this quite a
> while ago and didn't hear anything, so I'm sending the exact same
> thing again in case the first one got lost."
> 
> 2) I suggested a subject line update, which apparently got missed.
> Here's a better one:
> 
>   PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize
> 
> 3) Most importantly, this needs to be reconciled with the similar
> change to the apple driver:
> 
>   https://lore.kernel.org/r/20211123180636.80558-2-maz@kernel.org
> 
> In the apple driver, we're doing:
> 
>   - Assert PERST#
>   - Set up REFCLK
>   - Sleep 100us (T_perst-clk, CEM r5 2.2, 2.9.2)
>   - Deassert PERST#
>   - Sleep 100ms (not sure there's a name? PCIe r5 6.6.1)
> 
> But here in mediatek, we're doing:
> 
>   - Assert PERST#
>   - Sleep 100ms (T_pvperl, CEM r5 2.2, 2.2.1, 2.9.2)
>   - Deassert PERST#
> 
> My questions:

My understanding of the the Apple PCIe hardware is somewhat limited but:

>   - Where does apple enforce T_pvperl?  I can't tell where power to
>     the slot is turned on.

So far all available machines only have PCIe devices that are soldered
onto the motherboard, so there are no "real" slots.  As far as we can
tell the PCIe power domain is already powered on at the point where
the m1n1 bootloader takes control.  There is a GPIO that controls
power to some devices (WiFi, SDHC on the M1 Pro/Max laptops) and those
devices are initially powered off.  The Linux driver doesn't currently
attempt to power these devices on, but U-Boot will power them on if
the appropriate GPIO is defined in the device tree.  The way this is
specified in the device tree is still under discussion.

>   - Where does mediatek enforce the PCIe sec 6.6.1 delay after
>     deasserting PERST# and before config requests?
> 
>   - Does either apple or mediatek support speeds greater than 5 GT/s,
>     and if so, shouldn't we start the sec 6.6.1 100ms delay *after*
>     Link training completes?

The Apple hardware advertises support for 8 GT/s, but all the devices
integrated on the Mac mini support only 2.5 GT/s or 5 GT/s.

Hope this helps,

Mark
