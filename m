Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8570E2B908E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgKSLCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 06:02:13 -0500
Received: from foss.arm.com ([217.140.110.172]:53128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSLCM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 06:02:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627981396;
        Thu, 19 Nov 2020 03:02:11 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.61.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02D183F718;
        Thu, 19 Nov 2020 03:02:03 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-tegra@vger.kernel.org, Roy Zang <roy.zang@nxp.com>,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@axis.com, Jerome Brunet <jbrunet@baylibre.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Chocron <jonnyc@amazon.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-samsung-soc@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 00/16] PCI: dwc: Another round of clean-ups
Date:   Thu, 19 Nov 2020 11:01:58 +0000
Message-Id: <160578351748.1677.14217204071434748520.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 5 Nov 2020 15:11:43 -0600, Rob Herring wrote:
> Here's another batch of DWC PCI host refactoring. This series primarily
> moves more of the MSI, link up, and resource handling to the core
> code. Beyond a couple of minor fixes, new in this version is runtime
> detection of iATU regions instead of using DT properties.
> 
> No doubt I've probably broken something. Please test. I've run this thru
> kernelci and checked boards with DWC PCI which currently is just
> Layerscape boards (hint: add boards and/or enable PCI). A git branch is
> here[1].
> 
> [...]

Applied to pci/dwc, thanks!

[01/16] PCI: dwc: Support multiple ATU memory regions
        https://git.kernel.org/lpieralisi/pci/c/9f9e59a480
[02/16] PCI: dwc/intel-gw: Move ATU offset out of driver match data
        https://git.kernel.org/lpieralisi/pci/c/1d567aac46
[03/16] PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code
        https://git.kernel.org/lpieralisi/pci/c/a0fd361db8
[04/16] PCI: dwc/intel-gw: Remove some unneeded function wrappers
        https://git.kernel.org/lpieralisi/pci/c/1cc9a55999
[05/16] PCI: dwc: Ensure all outbound ATU windows are reset
        https://git.kernel.org/lpieralisi/pci/c/458ad06c4c
[06/16] PCI: dwc/dra7xx: Use the common MSI irq_chip
        https://git.kernel.org/lpieralisi/pci/c/7f170d35f5
[07/16] PCI: dwc: Drop the .set_num_vectors() host op
        https://git.kernel.org/lpieralisi/pci/c/331e9bcead
[08/16] PCI: dwc: Move MSI interrupt setup into DWC common code
        https://git.kernel.org/lpieralisi/pci/c/5bcb1757e6
[09/16] PCI: dwc: Rework MSI initialization
        https://git.kernel.org/lpieralisi/pci/c/f78f02638a
[10/16] PCI: dwc: Move link handling into common code
        https://git.kernel.org/lpieralisi/pci/c/886a9c1347
[11/16] PCI: dwc: Move dw_pcie_msi_init() into core
        https://git.kernel.org/lpieralisi/pci/c/59fbab1ae4
[12/16] PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
        https://git.kernel.org/lpieralisi/pci/c/b9ac0f9dc8
[13/16] PCI: dwc: Remove unnecessary wrappers around dw_pcie_host_init()
        https://git.kernel.org/lpieralisi/pci/c/60f5b73fa0
[14/16] Revert "PCI: dwc/keystone: Drop duplicated 'num-viewport'"
        https://git.kernel.org/lpieralisi/pci/c/fcde397422
[15/16] PCI: dwc: Move inbound and outbound windows to common struct
        https://git.kernel.org/lpieralisi/pci/c/9ca17af552
[16/16] PCI: dwc: Detect number of iATU windows
        https://git.kernel.org/lpieralisi/pci/c/281f1f99cf

Thanks,
Lorenzo
