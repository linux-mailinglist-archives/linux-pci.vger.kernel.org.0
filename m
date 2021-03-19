Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B5342551
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSSyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 14:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhCSSxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 14:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 468CD6191F;
        Fri, 19 Mar 2021 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616180024;
        bh=NwrtCO6JNbhykgaZnJI5HFj68c9ePk8Pf1xRIwTiWys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNpInxvuzmJYjrSuGnFKJUchQYHAX33qIUU75+sTbxSRGGfrkazg472r9REvA4yzk
         2IRuJGLN0iVIKMqwoK/vEP+/0YE+Ad3sJe6dyA74/SzRv3elKepID9Oj/Kn4yHzTfX
         iAoD7C7cT8ddnD7Y4Rnht+vWTT7Ni9WKYKodpga/jEkbzSI1n0OaIHwxFjybCbZmXp
         GjTXmszGDFo/bf2LOVEu5ac79qxsexjYpxmm8V48CKVQwAdFRTGUzLf+Lr8M7kAXS4
         xAuujS8A4i5WiRool75oNI6FFiBF9P7mXgd2xtubLBSs/PlHas0bzNRYRWNvA6OjB8
         S1DHtLjMIhGRg==
Received: by pali.im (Postfix)
        id 596916FE; Fri, 19 Mar 2021 19:53:41 +0100 (CET)
Date:   Fri, 19 Mar 2021 19:53:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <20210319185341.nyxmo7nwii5fzsxc@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
 <20210311123844.qzl264ungtk7b6xz@pali>
 <1615621394.25662.70.camel@mhfsdcap03>
 <20210318000211.ykjsfavfc7suu2sb@pali>
 <1616046487.31760.16.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616046487.31760.16.camel@mhfsdcap03>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 March 2021 13:48:07 Jianjun Wang wrote:
> On Thu, 2021-03-18 at 01:02 +0100, Pali Rohár wrote:
> > On Saturday 13 March 2021 15:43:14 Jianjun Wang wrote:
> > > On Thu, 2021-03-11 at 13:38 +0100, Pali Rohár wrote:
> > > > On Wednesday 24 February 2021 14:11:28 Jianjun Wang wrote:
> > > > > +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> > > > > +{
> > > > ...
> > > > > +
> > > > > +	/* Delay 100ms to wait the reference clocks become stable */
> > > > > +	msleep(100);
> > > > > +
> > > > > +	/* De-assert PERST# signal */
> > > > > +	val &= ~PCIE_PE_RSTB;
> > > > > +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> > > > 
> > > > Hello! This is a new driver which introduce yet another custom timeout
> > > > prior PERST# signal for PCIe card is de-asserted. Timeouts for other
> > > > drivers I collected in older email [2].
> > > > 
> > > > Please look at my email [1] about PCIe Warm Reset if you have any clue
> > > > about it. Lorenzo and Rob already expressed that this timeout should not
> > > > be driver specific. But nobody was able to "decode" and "understand"
> > > > PCIe spec yet about these timeouts.
> > > 
> > > Hi Pali,
> > > 
> > > I think this is more like a platform specific timeout, which is used to
> > > wait for the reference clocks to become stable and finish the reset flow
> > > of HW blocks.
> > > 
> > > Here is the steps to start a link training in this HW:
> > > 
> > > 1. Assert all reset signals which including the transaction layer, PIPE
> > > interface and internal bus interface;
> > > 
> > > 2. De-assert reset signals except the PERST#, this will make the
> > > physical layer active and start to output the reference clock, but the
> > > EP device remains in the reset state.
> > >    Before releasing the PERST# signal, the HW blocks needs at least 10ms
> > > to finish the reset flow, and ref-clk needs about 30us to become stable.
> > > 
> > > 3. De-assert PERST# signal, wait LTSSM enter L0 state.
> > > 
> > > This 100ms timeout is reference to TPVPERL in the PCIe CEM spec. Since
> > > we are in the kernel stage, the power supply has already stabled, this
> > > timeout may not take that long.
> > 
> > I think that this is not platform specific timeout or platform specific
> > steps. This matches generic steps as defined in PCIe CEM spec, section
> > 2.2.1. Initial Power-Up (G3 to S0).
> > 
> > What is platform specific is just how to achieve these steps.
> > 
> > Am I right?
> > 
> > ...
> > 
> > TPVPERL is one of my timeout candidates as minimal required timeout for
> > Warm Reset. I have wrote it in email:
> > 
> > https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/
> > 
> > But I'm not sure as specially in none diagram is described just warm
> > reset as defined in mPCIe CEM (3.2.4.3. PERST# Signal).
> > 
> > ...
> > 
> > Anyway, I would suggest to define constants for those timeouts. I guess
> > that in future we could be able to define "generic" timeout constants
> > which would not be in private driver section, but in some common header
> > file.
> 
> I agree with this, but I'm not sure if we really need that long time in
> the kernel stage, because the power supply has already stable and it's
> really impact the boot time, especially when the platform have multi
> ports and not connect any EP device, we need to wait 200ms for each port
> when system bootup.

Ports are independent. So you can initialize them in parallel, right?

If you initialize each port in separate worker then during msleep calls
kernel can schedule other kernel thread to run and so it does not
increase boot time. While pcie is sleeping kernel can do other things.
So the result is that whole boot time is not increased, just reordered.

> For this PCIe controller driver, I would like to change the timeout
> value to 10ms to comply with the HW design, and save some boot time.

In case you can connect _any_ PCIe card to your HW then you cannot
decrease or change timeouts required by PCIe specs. Otherwise there can
be a card which would not be initialized correctly.

I'm debugging driver for aardvark PCIe controller and I see that Compex
cards really needs these timeouts, otherwise link is down and card
cannot be detected.

So I guess that there can be also other cards which requires other
timeouts as specified in PCIe specs.

> > 
> > > > > +
> > > > > +	/* Check if the link is up or not */
> > > > > +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> > > > > +				 !!(val & PCIE_PORT_LINKUP), 20,
> > > > > +				 50 * USEC_PER_MSEC);
> > > > 
> > > > IIRC, you need to wait at least 100ms after de-asserting PERST# signal
> > > > as it is required by PCIe specs and also because experiments proved that
> > > > some Compex wifi cards (e.g. WLE900VX) are not detected if you do not
> > > > wait this minimal time.
> > > 
> > > Yes, this should be 100ms, I will fix it at next version, thanks for
> > > your review.
> > 
> > In past Bjorn suggested to use msleep(PCI_PM_D3COLD_WAIT); macro for
> > this step during reviewing aardvark driver.
> > 
> > https://lore.kernel.org/linux-pci/20190426161050.GA189964@google.com/
> > 
> > And next iteration used this PCI_PM_D3COLD_WAIT macro instead of 100:
> > 
> > https://lore.kernel.org/linux-pci/20190522213351.21366-2-repk@triplefau.lt/
> 
> Sure, I will use PCI_PM_D3COLD_WAIT macro instead in the next version.
> 
> Thanks.
> 
> > 
> > > Thanks.
> > > > 
> > > > > +	if (err) {
> > > > > +		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
> > > > > +		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> > > > > +		return err;
> > > > > +	}
> > > > 
> > > > [1] - https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > > > [2] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
> > > 
> 
