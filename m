Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA8132135
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGISo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 03:18:44 -0500
Received: from mout.perfora.net ([74.208.4.197]:44145 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgAGISo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 03:18:44 -0500
Received: from marcel-pc.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lw0OR-1jlS6n0VZ7-017pUn;
 Tue, 07 Jan 2020 09:13:36 +0100
Message-ID: <f0251cbb5dbc1f95881f9b817376707d2564e972.camel@ziswiler.com>
Subject: Re: [PATCH v1] pci: tegra: fix afi_pex2_ctrl reg offset for tegra30
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Andrew Murray <andrew.murray@arm.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org
Date:   Tue, 07 Jan 2020 09:13:33 +0100
In-Reply-To: <20200103150129.GR42593@e119886-lin.cambridge.arm.com>
References: <20191230005209.1546434-1-marcel@ziswiler.com>
         <20200102123822.GA1924669@ulmo>
         <20200103150129.GR42593@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pLRXasmCG0Dh3Dl5cHaF1SR8ASQey6Y/251Ys7gvNBFxZ+FUS8a
 GuxRQJrIBbFX0J2uK6LbvRyM/HazQQuMRS+dph7djbNARH8H2C+YsfhIF909SO6+T95GPmI
 cLskGHoVWpBrA11iCUYGeruxUKm1DBAWZTzmXkwv/DYDc2l13zN9UlAewlW0ZzHKAouiciL
 PxJS151bS+1cLLSI1eCsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MqP2Ev/XQSU=:vM7auCcIxpc9Ofq1vwRtGq
 qU+/ogYD9KJKkCkSxcsgrT98zsKMl7sCPFS18CM+LACwhW9MGlYu0Frm2M+c6SY3hx3PA6fNI
 zVdTojRHCrLDW9N1iQSbhRC+4kzTmjQselnIbgv9hCrXOyIdKweB2tTJiTK0Hv1+3VzjAnjRM
 x7BFx2Tpi6oj2OyAGYOraFmUGxrzKRM9zgMSaGT4mWpyMTZhvpezNVYFOjGpTGrjLM2CqB2t0
 GjJUu4z8J7PCjer+0aX4x3bA7TdH+nlvBtBGq2RCN3XKt4bJ8Yc1B4pdjRNlD2DgLUU8Gu+DT
 uGui0JQUtGZc9CwPUbsm3kjEJusP9P8oY3UUyDyVycbM5q25mU23PK0U6aViFRiQ185jN1jYR
 2FdtvF/ZrBN91GlZmTpsnHNfloindcunXtcSFKP8EjyGM2hEHXVcFfS+ju7sm4CqIt/53GumJ
 u3axtKWmxeynFTUaSYzObS+AG+4npZrbNm1JRUHdNIDRzBCunSARW25UJ+VQZ6XtsMLnIyTKe
 f9aJvMqV36x97kLdtsyEYaKu0KEs7OCXOw6spWmttMH8Bra0sS0wfMsyjEkS5KlcwRX1nAABM
 nmMRZdwMFwfU5rPhafHXrQh6RzT7GB2AO7vNep7GAgZwBWoXFGlhNmLGC/5yRDTPgOxzLi006
 5LVjSZVqz1IV8UbTZMv4skuYmD4LooBhr+4uKgGBSb377Z7VmGnQN3dmx9b18bulGFZNR5nlS
 QNvfuPsSCyn7yrdq34awJGob31mG2116Cud+Cnksff/cMJmiSfNJryCeAa+IUhC0MOB5PUsLN
 33cGklkLF4EaDgVSDNz1kIibM8cfgNsq+50bNFm3I6Y3Sfm5uk0yOb9ZI9g+Xi8XB79J1i8l8
 uBqYbfPACCTRybtnVS+yRFFp4UcvkU/L9tnckJsuw=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew

On Fri, 2020-01-03 at 15:01 +0000, Andrew Murray wrote:
> On Thu, Jan 02, 2020 at 01:38:22PM +0100, Thierry Reding wrote:
> > On Mon, Dec 30, 2019 at 01:52:09AM +0100, Marcel Ziswiler wrote:
> > > Fix AFI_PEX2_CTRL reg offset for tegra30 by moving it from the
> > > tegra20
> > > SoC struct where it erroneously got added by commit adb2653b3d2e
> > > ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of SoC
> > > struct").
> > > This fixes the AFI_PEX2_CTRL reg offset being uninitialised
> > > subsequently failing to bring up the third PCIe port.
> > > 
> > > Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> > > 
> > > ---
> > > 
> > >  drivers/pci/controller/pci-tegra.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Hi Marcel,
> > 
> > the recipient list looks somewhat odd. Mailing lists typically go
> > into
> > the Cc: line and subsystem maintainers into the To: line. That way
> > you
> > increase chances of people's filters catching important emails.
> > 
> > You may also want to fix up the subject line to use the more
> > standard
> > "PCI: tegra: " prefix. Also, maybe capitalize "fix" -> "Fix" to
> > match
> > standard formatting rules for commit messages. In the subject and
> > the
> > commit message, also, please spell "tegra20" and "tegra30" as
> > "Tegra20"
> > and "Tegra30", which can help when searching logs.
> > 
> > With the above fixed, this looks good, so:
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Also can you please add the following tag:
> 
> Fixes: adb2653b3d2e ("PCI: tegra: Add AFI_PEX2_CTRL reg offset as
> part of SoC struct")

Yeah, sorry. I kinda knew there was a standard way to do this but I was
so happy when I finally found this sucker (;-p). Will adhere to this in
a v2.

> Thanks,
> 
> Andrew Murray

Thanks, Andrew.

Cheers

Marcel

> > > diff --git a/drivers/pci/controller/pci-tegra.c
> > > b/drivers/pci/controller/pci-tegra.c
> > > index 090b632965e2..ac93f5a0398e 100644
> > > --- a/drivers/pci/controller/pci-tegra.c
> > > +++ b/drivers/pci/controller/pci-tegra.c
> > > @@ -2499,7 +2499,6 @@ static const struct tegra_pcie_soc
> > > tegra20_pcie = {
> > >  	.num_ports = 2,
> > >  	.ports = tegra20_pcie_ports,
> > >  	.msi_base_shift = 0,
> > > -	.afi_pex2_ctrl = 0x128,
> > >  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
> > >  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
> > >  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > > @@ -2528,6 +2527,7 @@ static const struct tegra_pcie_soc
> > > tegra30_pcie = {
> > >  	.num_ports = 3,
> > >  	.ports = tegra30_pcie_ports,
> > >  	.msi_base_shift = 8,
> > > +	.afi_pex2_ctrl = 0x128,
> > >  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> > >  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > >  	.pads_refclk_cfg0 = 0xfa5cfa5c,
> > > -- 
> > > 2.24.1

