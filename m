Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7523198E33
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgCaIXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 04:23:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCaIXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 04:23:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A4D530E;
        Tue, 31 Mar 2020 01:23:33 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C58F3F71E;
        Tue, 31 Mar 2020 01:23:31 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:23:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bjorn@helgaas.com
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        Andrew Murray <andrew.murray@arm.com>, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200331082325.GA32028@e121166-lin.cambridge.arm.com>
References: <20200330214721.GA128269@google.com>
 <bba72560-85cc-b59b-b0e8-bfc7c7408736@nvidia.com>
 <CABhMZUXub++CLTJ_E88Jwar5RvVfL+3aWOHqZf5XSVeyS8X=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUXub++CLTJ_E88Jwar5RvVfL+3aWOHqZf5XSVeyS8X=wA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 10:00:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2020 at 9:55 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> >
> >
> >
> > On 3/31/2020 3:17 AM, Bjorn Helgaas wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
> > >> Add support for the endpoint mode of Synopsys DesignWare core based
> > >> dual mode PCIe controllers present in Tegra194 SoC.
> > >>
> > >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > >> Acked-by: Thierry Reding <treding@nvidia.com>
> > >> ---
> > >> V5:
> > >> * Added Acked-by: Thierry Reding <treding@nvidia.com>
> > >> * Removed unwanted header file inclusion
> > >>
> > >> V4:
> > >> * Addressed Lorenzo's review comments
> > >> * Started using threaded irqs instead of kthreads
> > >>
> > >> V3:
> > >> * Addressed Thierry's review comments
> > >>
> > >> V2:
> > >> * Addressed Bjorn's review comments
> > >> * Made changes as part of addressing review comments for other patches
> > >>
> > >>   drivers/pci/controller/dwc/Kconfig         |  30 +-
> > >>   drivers/pci/controller/dwc/pcie-tegra194.c | 679 ++++++++++++++++++++-
> > >>   2 files changed, 691 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > >> index 0830dfcfa43a..169cde58dd92 100644
> > >> --- a/drivers/pci/controller/dwc/Kconfig
> > >> +++ b/drivers/pci/controller/dwc/Kconfig
> > >> @@ -248,14 +248,38 @@ config PCI_MESON
> > >>          implement the driver.
> > >>
> > >>   config PCIE_TEGRA194
> > >> -     tristate "NVIDIA Tegra194 (and later) PCIe controller"
> > >> +     tristate
> > >> +
> > >> +config PCIE_TEGRA194_HOST
> > >> +     tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
> > >>        depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> > >>        depends on PCI_MSI_IRQ_DOMAIN
> > >>        select PCIE_DW_HOST
> > >>        select PHY_TEGRA194_P2U
> > >> +     select PCIE_TEGRA194
> > >> +     default y
> > >
> > > Sorry I missed this before, but why is this "default y"?  From
> > > Documentation/kbuild/kconfig-language.rst:
> > >
> > >    The default value deliberately defaults to 'n' in order to avoid
> > >    bloating the build. With few exceptions, new config options should
> > >    not change this. The intent is for "make oldconfig" to add as little
> > >    as possible to the config from release to release.
> > >
> > > I do see that several other things in other drivers/pci/ Kconfig files
> > > are also "default y", and we should probably change some of them.  But
> > > I don't want to add even more unless there's a good reason.
> > >
> > > I'm not looking for more reactions like these:
> > >
> > > https://lore.kernel.org/r/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com
> > > https://lore.kernel.org/r/CA+55aFzPpuHU1Nqd595SEQS=F+kXMzPs0Rba9FUgTodGxmXsgg@mail.gmail.com
> > >
> > > Can you please update this patch to either remove the "default y" or
> > > add the rationale for keeping it?
> > I'm fine with removing 'default y' line.
> > Should I send a patch only with this change?
> 
> I think it's probably just as easy for Lorenzo to delete that line on
> his branch.  If not, I'll cherry-pick the patches on that branch and
> do it locally.

Done, pushed out. It is a guideline that it is worth keeping in mind
while I review the code, sorry for missing it.

Lorenzo
