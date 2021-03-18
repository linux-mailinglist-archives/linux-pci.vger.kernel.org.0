Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516B33FC0F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 01:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCRACb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 20:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhCRACP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 20:02:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC4D64F26;
        Thu, 18 Mar 2021 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616025734;
        bh=vresu2JOh2P7GZ/rMBfA5rTS0ajtTjBCvoZV08Sk+io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je6CmOhaVM4p4tGNzDMHgEx0pYGEAjhtEWu9Q0qdlDUXnTIGpDK2Bydk3OjUFvhp1
         xc8b1Wv21q+6HkFj4ed+odlffSNg6Z/TscVV5viovfg0jLODgtIxXk4QSU9gXpLckx
         QPd7oxHEawOUuj8X08KNOEfmNERjlzy/u7k1iPVzfBElmAJ7b3Ie4n/gx4afV7AH6G
         lWBwQi17mqeofHOAJcavZbB8KqwsQ9wuSjPBBI8/BHBdMrCMr4m4X8+cSNrXSXLAog
         AM+H04t9NNykXep1a8u/s8Ujh9t+bSaLKbeRUwzGopUqD8Cef7ehLnU0uJVX7sSVpr
         fIKfdwlINGo9g==
Received: by pali.im (Postfix)
        id EFD9B8A9; Thu, 18 Mar 2021 01:02:11 +0100 (CET)
Date:   Thu, 18 Mar 2021 01:02:11 +0100
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
Message-ID: <20210318000211.ykjsfavfc7suu2sb@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
 <20210311123844.qzl264ungtk7b6xz@pali>
 <1615621394.25662.70.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615621394.25662.70.camel@mhfsdcap03>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 13 March 2021 15:43:14 Jianjun Wang wrote:
> On Thu, 2021-03-11 at 13:38 +0100, Pali Rohár wrote:
> > On Wednesday 24 February 2021 14:11:28 Jianjun Wang wrote:
> > > +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> > > +{
> > ...
> > > +
> > > +	/* Delay 100ms to wait the reference clocks become stable */
> > > +	msleep(100);
> > > +
> > > +	/* De-assert PERST# signal */
> > > +	val &= ~PCIE_PE_RSTB;
> > > +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> > 
> > Hello! This is a new driver which introduce yet another custom timeout
> > prior PERST# signal for PCIe card is de-asserted. Timeouts for other
> > drivers I collected in older email [2].
> > 
> > Please look at my email [1] about PCIe Warm Reset if you have any clue
> > about it. Lorenzo and Rob already expressed that this timeout should not
> > be driver specific. But nobody was able to "decode" and "understand"
> > PCIe spec yet about these timeouts.
> 
> Hi Pali,
> 
> I think this is more like a platform specific timeout, which is used to
> wait for the reference clocks to become stable and finish the reset flow
> of HW blocks.
> 
> Here is the steps to start a link training in this HW:
> 
> 1. Assert all reset signals which including the transaction layer, PIPE
> interface and internal bus interface;
> 
> 2. De-assert reset signals except the PERST#, this will make the
> physical layer active and start to output the reference clock, but the
> EP device remains in the reset state.
>    Before releasing the PERST# signal, the HW blocks needs at least 10ms
> to finish the reset flow, and ref-clk needs about 30us to become stable.
> 
> 3. De-assert PERST# signal, wait LTSSM enter L0 state.
> 
> This 100ms timeout is reference to TPVPERL in the PCIe CEM spec. Since
> we are in the kernel stage, the power supply has already stabled, this
> timeout may not take that long.

I think that this is not platform specific timeout or platform specific
steps. This matches generic steps as defined in PCIe CEM spec, section
2.2.1. Initial Power-Up (G3 to S0).

What is platform specific is just how to achieve these steps.

Am I right?

...

TPVPERL is one of my timeout candidates as minimal required timeout for
Warm Reset. I have wrote it in email:

https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/

But I'm not sure as specially in none diagram is described just warm
reset as defined in mPCIe CEM (3.2.4.3. PERST# Signal).

...

Anyway, I would suggest to define constants for those timeouts. I guess
that in future we could be able to define "generic" timeout constants
which would not be in private driver section, but in some common header
file.

> > > +
> > > +	/* Check if the link is up or not */
> > > +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> > > +				 !!(val & PCIE_PORT_LINKUP), 20,
> > > +				 50 * USEC_PER_MSEC);
> > 
> > IIRC, you need to wait at least 100ms after de-asserting PERST# signal
> > as it is required by PCIe specs and also because experiments proved that
> > some Compex wifi cards (e.g. WLE900VX) are not detected if you do not
> > wait this minimal time.
> 
> Yes, this should be 100ms, I will fix it at next version, thanks for
> your review.

In past Bjorn suggested to use msleep(PCI_PM_D3COLD_WAIT); macro for
this step during reviewing aardvark driver.

https://lore.kernel.org/linux-pci/20190426161050.GA189964@google.com/

And next iteration used this PCI_PM_D3COLD_WAIT macro instead of 100:

https://lore.kernel.org/linux-pci/20190522213351.21366-2-repk@triplefau.lt/

> Thanks.
> > 
> > > +	if (err) {
> > > +		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
> > > +		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> > > +		return err;
> > > +	}
> > 
> > [1] - https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> > [2] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
> 
