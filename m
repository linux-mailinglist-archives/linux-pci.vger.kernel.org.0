Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52046CC0C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhLHEQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhLHEQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:16:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839AC061574;
        Tue,  7 Dec 2021 20:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D099B81F60;
        Wed,  8 Dec 2021 04:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B179BC00446;
        Wed,  8 Dec 2021 04:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638936749;
        bh=gFJPgHU3rF0+oH3Tv/ru3zNDZuTRZu9S6ukLJe+ET+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jH2bKsVQqTONUuVL5o90V6g5UaDw/shn9+qBIPC/wfFON1sqD+Bge2VB0ysNc/Hir
         V83jfomzlevvQ8BMdjpDHo9TPfQji8qg34Ksc/lMWP3kvxl9iltKh4fyc9tw+QzYVE
         bG87+yE2nL1kQUvo/E7742enyLcKNpVEYpE+9CzSMCia4UoFBb3bsPOo9UWBxvLvec
         UEGMFhdkiYjByYQLjZQAvcP/up18IGAnE5QA2oOzjUHKmEM6YNJFcXOxMNRfWeYIRc
         4Oa92xp3Ta6fSkHF+u+F+qWURn6qySsYYPy8uLloU63SRl15Nxsogewid8xghKEvbX
         jqmjgG2vc4JrQ==
Date:   Tue, 7 Dec 2021 22:12:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     qizhong.cheng@mediatek.com, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com,
        pali@kernel.org, maz@kernel.org, alyssa@rosenzweig.io,
        luca@lucaceresoli.net
Subject: Re: [RESEND PATCH v2] PCI: mediatek: Delay 100ms to wait power and
 clock to become stable
Message-ID: <20211208041228.GA103736@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3cb32527f48df70@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 10:00:43PM +0100, Mark Kettenis wrote:
> > Date: Tue, 7 Dec 2021 11:54:16 -0600
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > 
> > [+cc Marc, Alyssa, Mark, Luca for reset timing questions]
> 
> Hi Bjorn,
> 
> > On Tue, Dec 07, 2021 at 04:41:53PM +0800, qizhong cheng wrote:
> > > Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> > > 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> > > be delayed 100ms (TPVPERL) for the power and clock to become stable.
> > > 
> > > Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> > > Acked-by: Pali Rohár <pali@kernel.org>

> > ...
> > 3) Most importantly, this needs to be reconciled with the similar
> > change to the apple driver:
> > 
> >   https://lore.kernel.org/r/20211123180636.80558-2-maz@kernel.org
> > 
> > In the apple driver, we're doing:
> > 
> >   - Assert PERST#
> >   - Set up REFCLK
> >   - Sleep 100us (T_perst-clk, CEM r5 2.2, 2.9.2)
> >   - Deassert PERST#
> >   - Sleep 100ms (not sure there's a name? PCIe r5 6.6.1)
> > 
> > But here in mediatek, we're doing:
> > 
> >   - Assert PERST#
> >   - Sleep 100ms (T_pvperl, CEM r5 2.2, 2.2.1, 2.9.2)
> >   - Deassert PERST#
> > 
> > My questions:
> 
> My understanding of the the Apple PCIe hardware is somewhat limited but:
> 
> >   - Where does apple enforce T_pvperl?  I can't tell where power to
> >     the slot is turned on.
> 
> So far all available machines only have PCIe devices that are soldered
> onto the motherboard, so there are no "real" slots.  As far as we can
> tell the PCIe power domain is already powered on at the point where
> the m1n1 bootloader takes control.  There is a GPIO that controls
> power to some devices (WiFi, SDHC on the M1 Pro/Max laptops) and those
> devices are initially powered off.  The Linux driver doesn't currently
> attempt to power these devices on, but U-Boot will power them on if
> the appropriate GPIO is defined in the device tree.  The way this is
> specified in the device tree is still under discussion.

Does this mean we basically assume that m1n1 and early Linux boot
takes at least the 100ms T_pvperl required by CEM sec 2.2, but we take
pains to delay the 100us T_perst-clk?  That seems a little weird, but
I guess it is clear that REFCLK is *not* enabled before we enable it,
so we do need at least the 100us there.

It also niggles at me a little that the spec says T_pvperl starts from
*power stable* (not from power enable) and T_perst-clk starts from
*REFCLK stable* (not REFCLK enable).  Since we don't know the time
from enable to stable, it seems like native drivers should add some
circuit-specific constants to the spec values.

> >   - Where does mediatek enforce the PCIe sec 6.6.1 delay after
> >     deasserting PERST# and before config requests?
> > 
> >   - Does either apple or mediatek support speeds greater than 5 GT/s,
> >     and if so, shouldn't we start the sec 6.6.1 100ms delay *after*
> >     Link training completes?
> 
> The Apple hardware advertises support for 8 GT/s, but all the devices
> integrated on the Mac mini support only 2.5 GT/s or 5 GT/s.

The spec doesn't say anything about what the downstream devices
support (obviously it can't because we don't *know* what those devices
are until after we enumerate them).  So to be pedantically correct,
I'd argue that we should pay attention to what the Root Port
advertises.  Of course, I don't think we do this correctly *anywhere*
today.

Bjorn
