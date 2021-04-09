Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4035985B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhDIIzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 04:55:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhDIIzJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 04:55:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 998CD1FB;
        Fri,  9 Apr 2021 01:54:56 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.43.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B6863F73D;
        Fri,  9 Apr 2021 01:54:52 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     jh80.chung@samsung.com, zong.li@sifive.com, robh+dt@kernel.org,
        vidyas@nvidia.com, alex.dewar90@gmail.com, erik.danie@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, Greentime Hu <greentime.hu@sifive.com>,
        aou@eecs.berkeley.edu, sboyd@kernel.org,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, p.zabel@pengutronix.de, bhelgaas@google.com,
        helgaas@kernel.org, devicetree@vger.kernel.org,
        paul.walmsley@sifive.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Fri,  9 Apr 2021 09:54:46 +0100
Message-Id: <161795835843.16967.18210803147557738620.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
> This patchset includes SiFive FU740 PCIe host controller driver. We also
> add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> PCIe driver to use it.
> 
> This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> v5.11 Linux kernel.
> 
> [...]

Applied to pci/dwc [dropped patch 6], thanks!

[1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
[2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
[3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
      https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
[4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
      https://git.kernel.org/lpieralisi/pci/c/b86d55c107
[5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
      https://git.kernel.org/lpieralisi/pci/c/327c333a79

Thanks,
Lorenzo
