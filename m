Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7411F768
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2019 12:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfLOL2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Dec 2019 06:28:15 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33497 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfLOL2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2019 06:28:14 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2A494240004;
        Sun, 15 Dec 2019 11:28:09 +0000 (UTC)
Date:   Sun, 15 Dec 2019 12:36:34 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: amlogic: Make PCIe working reliably on AXG
 platforms
Message-ID: <20191215113634.GB7304@voidbox>
References: <20191208210320.15539-1-repk@triplefau.lt>
 <1jpngxew6l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jpngxew6l.fsf@starbuckisacylon.baylibre.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 09:32:18AM +0100, Jerome Brunet wrote:
> 
> On Sun 08 Dec 2019 at 22:03, Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > PCIe device probing failures have been seen on some AXG platforms and were
> > due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
> > solved the problem. After being contacted about this, vendor reported that
> > this bit was linked to PCIe PLL CML output.
> 
> Thanks for reporting the problem.
> 
> As Martin pointed out, the CML outputs already exist in the AXG clock
> controller but are handled using HHI_PCIE_PLL_CNTL6. Although
> incomplete, it seems to be aligned with the datasheet I have (v0.9)
> 
> According to the same document, HHI_MIPI_CNTL0 belong to the MIPI Phy.
> Unfortunately bit 26 is not documented
> 
> AFAICT, the clock controller is not appropriate driver to deal with this
> register/bit
> 

Regarding both @Martin's and your remark.

Unfortunately the documentation I have and vendor feedback are a bit
vague to me. I do agree that CLKID_PCIE_PLL_CML_ENABLE is not a proper
name for this bit because this register is MIPI related.

Here is the information I got from the vendor [1]. As you can see
HHI_MIPI_CNTL0[29] and HHI_MIPI_CNTL0[26] are related together, and
HHI_MIPI_CNTL0[29] is implemented in the clock controller as
axg_mipi_enable which is why I used this driver for HHI_MIPI_CNTL0[26].

So maybe I could rename this bit to something MIPI related ?

> >
> > This serie adds a way to set this bit through AXG clock gating logic.
> > Platforms having this kind of issue could make use of this gating by
> > applying a patch to their devicetree similar to:
> >
> >                 clocks = <&clkc CLKID_USB
> >                         &clkc CLKID_MIPI_ENABLE
> >                         &clkc CLKID_PCIE_A
> > -                       &clkc CLKID_PCIE_CML_EN0>;
> > +                       &clkc CLKID_PCIE_CML_EN0
> > +                       &clkc CLKID_PCIE_PLL_CML_ENABLE>;
> >                 clock-names = "pcie_general",
> >                                 "pcie_mipi_en",
> >                                 "pcie",
> > -                               "port";
> > +                               "port",
> > +                               "pll_cml_en";
> >                 resets = <&reset RESET_PCIE_PHY>,
> >                         <&reset RESET_PCIE_A>,
> >                         <&reset RESET_PCIE_APB>;
> 
> A few remarks for your future patches:
> 
> * You need to document any need binding you introduce:
>   It means that there should have been a patch in
>   Documentation/devicetree/... before using your newclock name in the
>   pcie driver. As Martin pointed out, dt-bindings should be dealt with
>   in their own patches
> 
> >
> >
> > Remi Pommarel (2):
> >   clk: meson: axg: add pcie pll cml gating
> 
> Whenever possible, patches intended for different maintainers should be
> sent separately (different series)

Thanks, will do both of the above remarks.

> 
> >   PCI: amlogic: Use PCIe pll gate when available
> >
> >  drivers/clk/meson/axg.c                | 3 +++
> >  drivers/clk/meson/axg.h                | 2 +-
> >  drivers/pci/controller/dwc/pci-meson.c | 5 +++++
> >  include/dt-bindings/clock/axg-clkc.h   | 1 +
> >  4 files changed, 10 insertions(+), 1 deletion(-)
> 

Thanks for reviewing this.

[1] https://i.snipboard.io/bHMPeq.jpg
-- 
Remi

