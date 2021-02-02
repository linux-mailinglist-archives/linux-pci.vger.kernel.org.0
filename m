Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E130C26F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhBBOuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 09:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhBBOtb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 09:49:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D9064F49;
        Tue,  2 Feb 2021 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612277329;
        bh=G3KQesqI3VgP63AXwofPugp+1nSxUQ1OQ3Asy+jaNxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eojN5/2N4cQk8EnY0ICyh6i1TcTTpwXBuPH3WiiD+Is0PsjvGpY6et9QhxsGT5VuL
         j2sZioAI4vghYTiCSjBPzgNsLMs1/gfmvuCGiKiwY4jRuKAUk34iNtn/+vkSZEbnhr
         k9d4cJ0KKieTU51s6fPYwc2gIvP21tuqwVnRXaECdcxkgRA4n5XFeDOSnW4hKtmA8v
         aAGKa2F7Y0LeNpYwk9gqDbsPb7gTaSCc/kJQbcS0BWF8UEpHqg9XIafhyzb8kZ6WAg
         0cnqrnXAnajN7ayCTf4OOpA1XV8iLkFGReeBa9UEfwdBe1rEW+W/NUOVo2j0JJkxgi
         ZysjLyIga5lLQ==
Date:   Tue, 2 Feb 2021 08:48:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@axis.com, Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] Add support for Hikey 970 PCIe
Message-ID: <20210202144847.GA97183@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 02:29:45PM +0100, Mauro Carvalho Chehab wrote:
> This series add support for Kirin 970 and for the Hikey 970
> board at the already-existing  driver.
> 
> patches 1-3 were previously submitted as RFC:
> 
> - Patch 1 converts the Synopsys Designware PCIe binding
>   documentation to the DT schema;
> - Patch 2 converts the pcie-kirin DT binding to the DT schema;
> - Patch 3 adds some extra configuration needed by
>   Kirin 970.
> 
> Patches 4-5 were imported from Manivannan's Hikey 970
> tree:
> 
>    https://git.linaro.org/people/manivannan.sadhasivam/96b-common.git/commit/?h=hikey970_pcie&id=4917380ad023c62960aa0f876bd4f23cefc8729e
> 
> It contains the original port made by Linaro.
> 
> patches 6 to 12 contains several cleanups applied on the
> top of Manivann's work, in order to simplify the extra data
> that would be required at DT, and to ensure that the power
> regulator needed to enable the PCI support on Hikey970
> will be enabled before trying to power it on, as otherwise,
> PCI resource allocation will fail.
> 
> -
> 
> patch 13 is here mostly as an example about what is needed
> in order for PCIe (and Ethernet) to start working on Hikey 970.
> 
> It won't apply cleanly, as it depends on another patch series,
> adding the needed regulator drivers.
> 
> I'll re-submit patch 13 after the pending stuff gets merged
> upstream.
> 
> Manivannan Sadhasivam (2):
>   pci: dwc: pcie-kirin: add HI3670 PCI-E controller support
>   arm64: dts: hisilicon: Add HI3670 PCI-E controller support
> 
> Mauro Carvalho Chehab (11):
>   doc: bindings: pci: designware-pcie.txt: convert it to yaml
>   doc: bindings: kirin-pcie.txt: convert it to yaml
>   doc: bindings: add new parameters used by Hikey 970
>   pci: dwc: pcie-kirin: simplify error handling logic
>   pci: dwc: pcie-kirin: simplify kirin 970 get resource logic
>   pci: dwc: pcie-kirin: place common init code altogether
>   pci: dwc: pcie-kirin: allow to optionally require a regulator
>   pci: dwc: pcie-kirin: allow using multiple reset GPIOs
>   pci: dwc: pcie-kirin: add support for clkreq GPIOs
>   pci: dwc: pcie-kirin: cleanup kirin970_pcie_get_eyeparam()
>   arm64: dts: hisilicon: cleanup Hikey 970 PCI schema

Please match:

  $ git log --oneline drivers/pci/controller/dwc/pcie-kirin.c
  60f5b73fa0f2 ("PCI: dwc: Remove unnecessary wrappers around dw_pcie_host_init()")
  b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code")
  59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
  886a9c134755 ("PCI: dwc: Move link handling into common code")
  5bcb1757e637 ("PCI: dwc: Move MSI interrupt setup into DWC common code")
  a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
  ecc3e424d190 ("PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't ready")

We've already picked "PCIe" (not "PCI-E") as the preferred spelling.
Please adopt in subject lines, commit logs, comments, etc.

Similarly, "YAML" in comments & text, since acronyms are normally
capitalized.

"DesignWare" (not "Designware").

HiSilicon seems to use "HiKey" (not "Hikey"), so let's follow them.

Pick either "Kirin 970" or "HiKey 970" From
http://www.o.hisilicon.com/en/Products/ProductList/HiKey, it looks
like "HiKey 970" refers to a board, and "Kirin 970" refers to a piece
of it.

Please wrap commit logs to fill 75 columns.

>  .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
>  .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
>  .../bindings/pci/designware-pcie.txt          |  77 --
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 144 ++++
>  .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
>  .../bindings/pci/hisilicon-pcie.txt           |   2 +-
>  .../devicetree/bindings/pci/kirin-pcie.txt    |  50 --
>  .../bindings/pci/layerscape-pci.txt           |   2 +-
>  .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
>  .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
>  .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
>  .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
>  .../devicetree/bindings/pci/snps,pcie.yaml    | 139 ++++
>  .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
>  .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
>  .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
>  MAINTAINERS                                   |   4 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  64 ++
>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |   1 -
>  drivers/pci/controller/dwc/pcie-kirin.c       | 736 +++++++++++++++++-
>  23 files changed, 1084 insertions(+), 187 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,pcie.yaml
> 
> -- 
> 2.29.2
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
