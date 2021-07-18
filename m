Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D873CC8D5
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhGRLoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 07:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhGRLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B843161184;
        Sun, 18 Jul 2021 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626608458;
        bh=Vegbn4flDicHKXx7lHf5cMiwPfbQHkr1Aa8q19WmyQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=RsF3O5tv/+spITV5IChI+SHmK6QckQ44Cc0MdYNjtYTxu80psQ69MUn023cJmSHgm
         OBg0ciYlxEN5/qLqn7XOuzcGbqrSq4n1vvyCHnSIekBu2qyloR65GksFjNoUeqIkud
         MyG7U7eZ+XIMxGyvlQknkUq30rb1rnPNEKegK6HXX2MU6+gCoqq988RPrMkvw1QdXy
         dTo7ac9m5MPCSVSOyiiqBsAqvAE3xAx3rgS45g6CYDowPu6dxp0/9ufSAoBQXFdK9q
         EwUbQuX+1rhWK3jRSs8PXiD8T94MTiMYAov3GBUi7xWFilnXnPdpNSjk3y2Dsn8gDl
         sK+IPF/mc+iXg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m55AE-001Dvt-5w; Sun, 18 Jul 2021 13:40:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v5 0/5] convert designware-pcie.txt to yaml
Date:   Sun, 18 Jul 2021 13:40:47 +0200
Message-Id: <cover.1626608375.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series convert designware-pcie.txt to DT schema.

I opted to move the pcie-kirin.txt changes out of this series. I'll submit
it in separate, as they should come after some changes I'm doing at
pcie-kirin.c driver.

v5:
- Addressed some issues pointed by Rob Herring:
  Added interrupts and interrupt-cells to DT;
  Addressed warnings generated with make dbs-check on existing
  *.dts* files.

Mauro Carvalho Chehab (5):
  dt-bindings: PCI: add snps,dw-pcie.yaml
  dt-bindings: PCI: add snps,dw-pcie-ep.yaml
  dt-bindings: PCI: update references to Designware schema
  dt-bindings: PCI: remove designware-pcie.txt
  dt-bindings: arm64: tegra: fix pcie-ep DT nodes

 .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
 .../bindings/pci/designware-pcie.txt          |  77 -------------
 .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
 .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
 .../bindings/pci/layerscape-pci.txt           |   2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |   7 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
 .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +--
 .../bindings/pci/samsung,exynos-pcie.yaml     |   4 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |   4 +-
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  90 ++++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 102 ++++++++++++++++++
 .../pci/socionext,uniphier-pcie-ep.yaml       |   4 +-
 .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
 MAINTAINERS                                   |   3 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |   2 +-
 .../boot/dts/nvidia/tegra194-p3509-0000.dtsi  |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   6 +-
 22 files changed, 228 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml

-- 
2.31.1


