Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BC2C0293
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 10:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKWJxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 04:53:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKWJxS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 04:53:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF18101E;
        Mon, 23 Nov 2020 01:53:17 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.62.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8EA23F70D;
        Mon, 23 Nov 2020 01:53:14 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 0/5] Add DW PCIe support for Exynos5433 SoCs
Date:   Mon, 23 Nov 2020 09:53:08 +0000
Message-Id: <160612514814.21459.9917651424181472858.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
References: <CGME20201113170156eucas1p176314e4076c593d1f2e68159be880f86@eucas1p1.samsung.com> <20201113170139.29956-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 Nov 2020 18:01:34 +0100, Marek Szyprowski wrote:
> This patchset is a resurrection of the DW PCIe support for the Exynos5433
> SoCs posted long time ago here: https://lkml.org/lkml/2016/12/26/6 and
> later here: https://lkml.org/lkml/2017/12/21/296 .
> 
> In meantime the support for the Exynos5440 SoCs has been completely
> dropped from mainline kernel, as those SoCs never reached the market. The
> PCIe driver for Exynos5440 variant however has not been removed yet. This
> patchset simply reworks it to support the Exynos5433 variant. The lack of
> the need to support both variants significantly simplifies the driver
> code.
> 
> [...]

Applied to pci/dwc, thanks!

[1/5] dt-bindings: PCI: exynos: drop samsung,exynos5440-pcie binding
      https://git.kernel.org/lpieralisi/pci/c/83fbffcd13
[2/5] dt-bindings: PCI: exynos: add the samsung,exynos-pcie binding
      https://git.kernel.org/lpieralisi/pci/c/eea23e4a00
[3/5] dt-bindings: phy: exynos: add the samsung,exynos-pcie-phy binding
      https://git.kernel.org/lpieralisi/pci/c/a7b4dba9a7
[4/5] phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PCIe PHY
      https://git.kernel.org/lpieralisi/pci/c/46bc965df0
[5/5] PCI: dwc: exynos: Rework the driver to support Exynos5433 variant
      https://git.kernel.org/lpieralisi/pci/c/f0a6743028

Thanks,
Lorenzo
