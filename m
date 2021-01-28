Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009E83073DA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 11:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhA1KgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 05:36:16 -0500
Received: from muru.com ([72.249.23.125]:54012 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhA1KgI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 05:36:08 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A61380A9;
        Thu, 28 Jan 2021 10:35:30 +0000 (UTC)
Date:   Thu, 28 Jan 2021 12:35:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
Message-ID: <YBKTadhZZsySC9ak@atomide.com>
References: <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc>
 <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
 <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com>
 <CAGETcx-0G-Y8wT_+BfP5vbi0gW6KonwgoJ6DdqjaGbFkutTGag@mail.gmail.com>
 <CAMuHMdXMaAtrbQibJh+Z2v5qhe_Tg0hQU9YqxuU0ow_iNO1atg@mail.gmail.com>
 <CAGETcx8=woX_SVckG+gs68KMif-JGoy3a1PQGfonMNBH18Ak6A@mail.gmail.com>
 <CAMuHMdUpzaRutO+jKffXtGDoy5g2QoXkbO+-tzbEzibNYbhCuA@mail.gmail.com>
 <CAGETcx_81qOe2LvX-J_PBZWdouykPoPYdf5=yMVhnjgDxAkgaw@mail.gmail.com>
 <CAMuHMdVHouzMFiGcUz=0M0_RFL-OBvkRvQiF5h56XKDMZuC7Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVHouzMFiGcUz=0M0_RFL-OBvkRvQiF5h56XKDMZuC7Kg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [210128 09:32]:
> It wasn't.  The regression is that the driver no longer probes at first
> try, because its dependencies are now probed later.  The question is:
> why are the dependencies now probed later?  How to fix that?

I'm afraid that may be unfixable.. It depends on things like the bus
driver probe that might get also deferred.

As suggested, I agree it's best to get rid of builtin_platform_driver_probe
where possible at the cost of dropping the __init as needed.

To me it seems we can't even add a warning to __platform_driver_probe()
if there's drv->driver.of_match_table for example. That warning would
show up on all the devices with driver in question built in even if
the device has no such hardware.

Regards,

Tony
