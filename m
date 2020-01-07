Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE690132126
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 09:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAGIQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 03:16:49 -0500
Received: from mout.perfora.net ([74.208.4.197]:51591 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgAGIQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 03:16:49 -0500
Received: from marcel-pc.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M8gu5-1ikb5n0Gif-004m1X;
 Tue, 07 Jan 2020 09:11:38 +0100
Message-ID: <40295d6f803a76ed169506e2417357cccea4958f.camel@ziswiler.com>
Subject: Re: [PATCH v1] pci: tegra: fix afi_pex2_ctrl reg offset for tegra30
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org
Date:   Tue, 07 Jan 2020 09:11:35 +0100
In-Reply-To: <20200102123822.GA1924669@ulmo>
References: <20191230005209.1546434-1-marcel@ziswiler.com>
         <20200102123822.GA1924669@ulmo>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PLPrRRMEyaBZaBDxY0OoJwssd+Z8aTY0h4imk7UzoXeYSK62VgJ
 Kfb49CXps328d0mFyTYU8mSijJag1G4KZxpu329IMIUf02kfq85b2kdXX9pDES3jrO1CUjW
 pxyAkfsan/sOBmOkDLCW35c+uPGYYlY0sLofapyp8VPp19Lq2nmtgsrG0R2rjYKflIJJ1tD
 g6SncQJMcZSEzkV2Dl6lA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDq291wX9xo=:L4w7V7AUqB3ZJhP38cuvwt
 FG3fNY3BmKhOTYp9vtUB1K4G8MBj8pxFrep0yZKhx0mbREr3/cdxEecae+wsY63+mhq4QtgQa
 K8x3S3nMO+uu4ZzZ2RHjpWBL5qkTuznCdwSj5dYQ+g8IFBre5szfPeDHT9joKBDzm5vT/oDAR
 a8aMiVUSkBrt9MTBGkyUMeno+aby8w+wkrFOt15VFqCjQ0boV8TagH5P1NWg/vNjkpBNbV5XD
 NeRD1HRjFZjyi5Kv0S5lg4kJZOxyi5s51oZ56FgW3U2q4Y6bZEw02UKAHN1uDMPphoc9Y5+0W
 tAewOoZiEuLVItvq+JUEp+P6DvQKg7rvzAZSsoUUGx57t1t59I3IK9tuc1+BzrkghHMuh8u7i
 aRMl1n99hFPaf5L8iBkE47yIdYzvAldlRM72RUd5Y7X0L9aT8OErPHAQungWOWYgxsflI/b74
 UOuL5spvs8HgvTykUOi0J3B2AwtsUjYa+nQ8ZMLmaacZBBholZSRJJK/vHVQE7cQjtySVs5cC
 ZJR+3OLfUqGaBtCyyNzvvnknsR4Tu93SQE6RS3z/Zqf84RnlMzpgqmB6aAxUY/odVqqm2kERk
 y0PosJtyLnxxBbUM5FCmm8H9Sly2gk9uGwPbtKCH/Dgsn30brYeLDhZibclwgcV9+VLN56N6R
 fXfv2XmPX6hKWd9x4pUHqlxu9RoWSBElmc49Vn4fB0/W3qHpkYLXCHo/ST0LpRKkT2AX6iu4b
 /8M/1bSJHtBbXbTIBiLRl0guL1JO65U+9ZC/1ByF56J4ZzCNemKf0gmLBHOCWu3wHZ2huVUKO
 BQKRoP8R9EqUmu4X4CttgGqmOmkbZCKWpsthaMNPN0tokRPOWVaitcyXFGLIZhBxUm/INibme
 h9B6K/z4VO4GGFAPP2g33wj8odmq4enRQfXZpIX5I=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thierry

On Thu, 2020-01-02 at 13:38 +0100, Thierry Reding wrote:
> On Mon, Dec 30, 2019 at 01:52:09AM +0100, Marcel Ziswiler wrote:
> > Fix AFI_PEX2_CTRL reg offset for tegra30 by moving it from the
> > tegra20
> > SoC struct where it erroneously got added by commit adb2653b3d2e
> > ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC struct").
> > This fixes the AFI_PEX2_CTRL reg offset being uninitialised
> > subsequently failing to bring up the third PCIe port.
> > 
> > Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> > 
> > ---
> > 
> >  drivers/pci/controller/pci-tegra.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Marcel,
> 
> the recipient list looks somewhat odd. Mailing lists typically go
> into
> the Cc: line and subsystem maintainers into the To: line. That way
> you
> increase chances of people's filters catching important emails.

I'm using U-Boot's patman with the same LKML configuration since years
and nobody ever complained. I adjusted this now, thanks!

> You may also want to fix up the subject line to use the more standard
> "PCI: tegra: " prefix. Also, maybe capitalize "fix" -> "Fix" to match
> standard formatting rules for commit messages. In the subject and the
> commit message, also, please spell "tegra20" and "tegra30" as
> "Tegra20"
> and "Tegra30", which can help when searching logs.

While this whole capitalisation is utterly stupid and I remember in the
old days we kinda agreed to just lower case (don't know when/why this
suddenly changed) but this anyway should not matter if doing proper
case insensitive searching (;-p). Anyway, I will also adhere to this in
a v2, thanks!

> With the above fixed, this looks good, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks, Thierry.

Cheers

Marcel

> > diff --git a/drivers/pci/controller/pci-tegra.c
> > b/drivers/pci/controller/pci-tegra.c
> > index 090b632965e2..ac93f5a0398e 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc
> > tegra20_pcie = {
> >  	.num_ports = 2,
> >  	.ports = tegra20_pcie_ports,
> >  	.msi_base_shift = 0,
> > -	.afi_pex2_ctrl = 0x128,
> >  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
> >  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
> >  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > @@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc
> > tegra30_pcie = {
> >  	.num_ports = 3,
> >  	.ports = tegra30_pcie_ports,
> >  	.msi_base_shift = 8,
> > +	.afi_pex2_ctrl = 0x128,
> >  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> >  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> >  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > -- 
> > 2.24.1

