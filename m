Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0A307354
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 11:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhA1KBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 05:01:45 -0500
Received: from muru.com ([72.249.23.125]:53956 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbhA1KBc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 05:01:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 752CB80A9;
        Thu, 28 Jan 2021 10:00:44 +0000 (UTC)
Date:   Thu, 28 Jan 2021 12:00:35 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
Message-ID: <YBKLQ1m35Bouc6/B@atomide.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc>
 <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc>
 <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24391e62b107040435766fff52bdd31@walle.cc>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

* Michael Walle <michael@walle.cc> [210125 19:52]:
> Although I do have the changes for the builtin_platform_driver_probe()
> ready, I don't think it makes much sense to send these unless we agree
> on the increased memory footprint. While there are just a few
> builtin_platform_driver_probe() and memory increase _might_ be
> negligible, there are many more module_platform_driver_probe().

I just noticed this thread today and have pretty much come to the same
conclusions. No need to post a patch for pci-dra7xx.c, I already posted
a patch for pci-dra7xx.c yesterday as part of genpd related changes.

For me probing started breaking as the power-domains property got added.

FYI, it's the following patch:

[PATCH 01/15] PCI: pci-dra7xx: Prepare for deferred probe with module_platform_driver

Regards,

Tony


