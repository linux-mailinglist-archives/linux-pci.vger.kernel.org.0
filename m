Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191F0368F83
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDWJj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 05:39:59 -0400
Received: from foss.arm.com ([217.140.110.172]:60516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhDWJj7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Apr 2021 05:39:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9640111D4;
        Fri, 23 Apr 2021 02:39:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29A73F774;
        Fri, 23 Apr 2021 02:39:19 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:39:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, jh80.chung@samsung.com,
        Zong Li <zong.li@sifive.com>, robh+dt@kernel.org,
        vidyas@nvidia.com, alex.dewar90@gmail.com,
        Erik Danie <erik.danie@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Boyd <sboyd@kernel.org>,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver
 support
Message-ID: <20210423093915.GA7784@lpieralisi>
References: <mhng-f3dd2202-8d2b-4e17-9067-c4521aac8125@palmerdabbelt-glaptop>
 <mhng-41850660-4a95-462a-9b1e-33dfc67815a4@palmerdabbelt-glaptop>
 <CAHCEehJHZGEUy2TO6fPg1WyAbQCoVee=AcRrkZE4Zhw+ibYKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEehJHZGEUy2TO6fPg1WyAbQCoVee=AcRrkZE4Zhw+ibYKqQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 23, 2021 at 02:00:46PM +0800, Greentime Hu wrote:
> Palmer Dabbelt <palmer@dabbelt.com> 於 2021年4月23日 週五 下午1:10寫道：
> >
> > On Thu, 22 Apr 2021 21:43:03 PDT (-0700), Palmer Dabbelt wrote:
> > > On Sun, 11 Apr 2021 19:37:50 PDT (-0700), greentime.hu@sifive.com wrote:
> > >> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 於 2021年4月9日 週五 下午4:54寫道：
> > >>>
> > >>> On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
> > >>> > This patchset includes SiFive FU740 PCIe host controller driver. We also
> > >>> > add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> > >>> > PCIe driver to use it.
> > >>> >
> > >>> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> > >>> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> > >>> > v5.11 Linux kernel.
> > >>> >
> > >>> > [...]
> > >>>
> > >>> Applied to pci/dwc [dropped patch 6], thanks!
> > >>>
> > >>> [1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
> > >>>       https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
> > >>> [2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
> > >>>       https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
> > >>> [3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
> > >>>       https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
> > >>> [4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
> > >>>       https://git.kernel.org/lpieralisi/pci/c/b86d55c107
> > >>> [5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
> > >>>       https://git.kernel.org/lpieralisi/pci/c/327c333a79
> > >>>
> > >>> Thanks,
> > >>> Lorenzo
> > >>
> > >> Hi Palmer,
> > >>
> > >> Since the PCIE driver has been applied, would you please pick patch 6
> > >> to RISC-V for-next tree?
> > >> Thank you. :)
> > >
> > > Sorry, I got this confused between the Linux patch set and the u-boot
> > > patch set so I thought more versions of this had kept comming.  The DT
> > > is on for-next now.
> >
> > I spoke too soon: this actually dosn't even build for me.  It's the
> > "clocks = <&prci PRCI_CLK_PCIE_AUX>;" line
> >
> >     Error: arch/riscv/boot/dts/sifive/fu740-c000.dtsi:319.20-21 syntax error
> >     FATAL ERROR: Unable to parse input tree
> >     make[2]: *** [scripts/Makefile.lib:336: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb] Error 1
> >     make[1]: *** [scripts/Makefile.build:514: arch/riscv/boot/dts/sifive] Error 2
> >     make: *** [Makefile:1388: dtbs] Error 2
> >     make: *** Waiting for unfinished jobs....
> >
> > I'm not sure what the issue is, I see an anchor for "prci".  Do you mind
> > sending along a new version that compiles on top of for-next?  If I need
> > the definiton of PRCI_CLK_PCIE_AUX from a PCIe tree then it's probably
> > best to just keep the DTS along with the rest of the patches.  IIRC I
> > alredy Acked it, but just to be clear
> >
> > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >
> > Thanks!
> 
> Thank you, Palmer.
> It is defined in the first commit of this patchset. "clk: sifive: Add
> pcie_aux clock in prci driver for PCIe driver"
> You can select these whole 6 patches to make sure it can be built.
> 
> Hi Lorenzo,
> Would you mind to pick the 6th patch along with the other 5 patches?
> Thank you.

Done, on my pci/dwc branch.

Thanks,
Lorenzo
