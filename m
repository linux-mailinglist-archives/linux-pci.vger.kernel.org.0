Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486CA37298C
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEDL3w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 07:29:52 -0400
Received: from foss.arm.com ([217.140.110.172]:57058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhEDL3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 07:29:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C159D6E;
        Tue,  4 May 2021 04:28:56 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.46.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908CA3F73B;
        Tue,  4 May 2021 04:28:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, hayashi.kunihiko@socionext.com,
        sboyd@kernel.org, vidyas@nvidia.com, aou@eecs.berkeley.edu,
        helgaas@kernel.org, linux-clk@vger.kernel.org, bhelgaas@google.com,
        zong.li@sifive.com, hes@sifive.com, alex.dewar90@gmail.com,
        erik.danie@sifive.com, jh80.chung@samsung.com,
        Greentime Hu <greentime.hu@sifive.com>,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, khilman@baylibre.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Tue,  4 May 2021 12:28:45 +0100
Message-Id: <162012762098.17915.18389066004997041156.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210504105940.100004-1-greentime.hu@sifive.com>
References: <20210504105940.100004-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 May 2021 18:59:34 +0800, Greentime Hu wrote:
> This patchset includes SiFive FU740 PCIe host controller driver. We also
> add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> PCIe driver to use it.
> 
> This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> v5.11 Linux kernel.
> 
> [...]

Applied to pci/risc-v, thanks.

[1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/c61287bf17
[2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/e4d368e0b6
[3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/2da0dd5e30
[4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
      https://git.kernel.org/lpieralisi/pci/c/43cea116be
[5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
      https://git.kernel.org/lpieralisi/pci/c/d5f9eb3dbb
[6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
      https://git.kernel.org/lpieralisi/pci/c/dc69e229c1

Thanks,
Lorenzo
