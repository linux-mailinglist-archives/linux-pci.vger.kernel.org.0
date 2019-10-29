Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0410E85CA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 11:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfJ2Ke7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 06:34:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfJ2Ke7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 06:34:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E43337;
        Tue, 29 Oct 2019 03:34:58 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402143F71F;
        Tue, 29 Oct 2019 03:34:57 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:34:52 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment
 for each controller entry
Message-ID: <20191029103452.GA27171@e121166-lin.cambridge.arm.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
 <20191026182659.2390-2-marek.vasut@gmail.com>
 <TYAPR01MB45441C49E8E4C33DDBB09071D8660@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191028102048.GA4414@e121166-lin.cambridge.arm.com>
 <TYAPR01MB4544E78D7F49E2A1F9C53103D8610@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4544E78D7F49E2A1F9C53103D8610@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 01:18:04AM +0000, Yoshihiro Shimoda wrote:
> Hi Lorenzo,
> 
> > From: Lorenzo Pieralisi, Sent: Monday, October 28, 2019 7:21 PM
> > 
> > On Mon, Oct 28, 2019 at 08:35:32AM +0000, Yoshihiro Shimoda wrote:
> > > Hi Marek-san.
> > >
> > > > From: Marek Vasut, Sent: Sunday, October 27, 2019 3:27 AM
> > > >
> > > > Due to hardware constraints, the size of each inbound range entry
> > > > populated into the controller cannot be larger than the alignment
> > > > of the entry's start address. Currently, the alignment for each
> > > > "dma-ranges" inbound range is calculated only once for each range
> > > > and the increment for programming the controller is also derived
> > > > from it only once. Thus, a "dma-ranges" entry describing a memory
> > > > at 0x48000000 and size 0x38000000 would lead to multiple controller
> > > > entries, each 0x08000000 long.
> > >
> > > I added a debug code [1] and I confirmed that each entry is not 0x08000000 long [2].
> > >
> > > After fixed the commit log above,
> > 
> > So what does this mean in practice ? Does it mean that the commit log is
> > wrong or that the issue is not present as described, in the mainline
> > code ?
> 
> I meant the commit log is wrong. In such the case, the multiple controller
> entries has 3 kind of size like below.

OK, that's confusing. The commit log is describing the issue it is
fixing and you are reporting that's not what happens in practice, so in
short my question is, is it possible to describe the issue you
are fixing with an example representative of what's happening and
explaining why we need to apply this patch please ?

Thanks,
Lorenzo

> > > +		dev_dbg(pcie->dev, "idx%d: 0x%016llx..0x%016llx -> 0x%016llx\n",
> > > +			idx, cpu_addr, size, pci_addr);
> <snip>
> > > [    0.374771] rcar-pcie fe000000.pcie: idx0: 0x0000000048000000..0x0000000008000000 -> 0x0000000048000000
> 
> The first entry's size is 0x08000000.
> 
> > > [    0.374777] rcar-pcie fe000000.pcie: idx2: 0x0000000050000000..0x0000000010000000 -> 0x0000000050000000
> 
> The second one's size is 0x10000000.
> 
> > > [    0.374782] rcar-pcie fe000000.pcie: idx4: 0x0000000060000000..0x0000000020000000 -> 0x0000000060000000
> 
> The third one's size is 0x20000000.
> 
> > Please clarify and send a v5 accordingly.
> 
> Marek-san, would you send a v5 patch series?
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > Thanks,
> > Lorenzo
> > 
> > > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > And I tested on r8a7795-salvator-xs with my debug code. So,
> > >
> > > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > ---
> > > [1] Based on next-20191025 with this patch series:
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > index fde6ec1..9bdd39e 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > @@ -2684,7 +2684,7 @@
> > >  				0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> > >  				0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> > >  			/* Map all possible DDR as inbound ranges */
> > > -			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> > > +			dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
> > >  			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> > >  				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> > >  				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> > > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > > index 0dadccb..54ad977 100644
> > > --- a/drivers/pci/controller/pcie-rcar.c
> > > +++ b/drivers/pci/controller/pcie-rcar.c
> > > @@ -11,6 +11,8 @@
> > >   * Author: Phil Edworthy <phil.edworthy@renesas.com>
> > >   */
> > >
> > > +#define DEBUG
> > > +
> > >  #include <linux/bitops.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/delay.h>
> > > @@ -1054,6 +1056,8 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> > >  		mask = roundup_pow_of_two(size) - 1;
> > >  		mask &= ~0xf;
> > >
> > > +		dev_dbg(pcie->dev, "idx%d: 0x%016llx..0x%016llx -> 0x%016llx\n",
> > > +			idx, cpu_addr, size, pci_addr);
> > >  		/*
> > >  		 * Set up 64-bit inbound regions as the range parser doesn't
> > >  		 * distinguish between 32 and 64-bit types.
> > > ---
> > > [2]
> > > [    0.374771] rcar-pcie fe000000.pcie: idx0: 0x0000000048000000..0x0000000008000000 -> 0x0000000048000000
> > > [    0.374777] rcar-pcie fe000000.pcie: idx2: 0x0000000050000000..0x0000000010000000 -> 0x0000000050000000
> > > [    0.374782] rcar-pcie fe000000.pcie: idx4: 0x0000000060000000..0x0000000020000000 -> 0x0000000060000000
> > > ---
> > >
