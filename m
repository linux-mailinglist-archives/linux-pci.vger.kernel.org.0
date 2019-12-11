Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01ACF11B868
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfLKQSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 11:18:18 -0500
Received: from foss.arm.com ([217.140.110.172]:37844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbfLKQSR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 11:18:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A06B30E;
        Wed, 11 Dec 2019 08:18:16 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9443F52E;
        Wed, 11 Dec 2019 08:18:15 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     soc@kernel.org, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [GIT PULL] PCI: dt: Remove magic numbers for legacy PCI IRQ interrupts
Date:   Wed, 11 Dec 2019 16:18:08 +0000
Message-Id: <20191211161808.7566-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

Please consider this pull request.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://linux-arm.org/linux-am.git tags/pci-dt-intx-defines-5.5-rc1

for you to fetch changes up to d50e85b9ad3d4287ab3c5108b7b36ad4fd50e5b4:

  dt-bindings: PCI: Use IRQ flags for legacy PCI IRQ interrupts (2019-12-11 16:05:55 +0000)

----------------------------------------------------------------
PCI: dt: Remove magic numbers for legacy PCI IRQ interrupts

PCI devices can trigger interrupts via 4 physical/virtual lines known
as INTA, INTB, INTC or INTD. Due to interrupt swizzling it is often
required to describe the interrupt mapping in the device tree. Let's
avoid the existing magic numbers and replace them with a #define to
improve clarity.

This is based on v5.5-rc1. As this series covers multiple architectures
and updates include/dt-bindings it was felt that it may be more
convenient to merge in one go.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>

----------------------------------------------------------------
Andrew Murray (7):
      PCI: dt: Add legacy PCI IRQ defines
      arm64: dts: Use IRQ flags for legacy PCI IRQ interrupts
      arm: dts: Use IRQ flags for legacy PCI IRQ interrupts
      xtensa: dts: Use IRQ flags for legacy PCI IRQ interrupts
      powerpc: dts: fsl: Use IRQ flags for legacy PCI IRQ interrupts
      powerpc: dts: Use IRQ flags for legacy PCI IRQ interrupts
      dt-bindings: PCI: Use IRQ flags for legacy PCI IRQ interrupts

 .../devicetree/bindings/pci/83xx-512x-pci.txt      |  21 +--
 .../devicetree/bindings/pci/aardvark-pci.txt       |  12 +-
 .../devicetree/bindings/pci/altera-pcie.txt        |  13 +-
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |  12 +-
 .../bindings/pci/cdns,cdns-pcie-host.txt           |  12 +-
 .../devicetree/bindings/pci/faraday,ftpci100.txt   |  70 +++++-----
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  12 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  26 ++--
 .../devicetree/bindings/pci/host-generic-pci.txt   |  12 +-
 .../devicetree/bindings/pci/kirin-pcie.txt         |  12 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |  12 +-
 .../devicetree/bindings/pci/mediatek-pcie.txt      |  46 ++++---
 .../devicetree/bindings/pci/mobiveil-pcie.txt      |  11 +-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  10 +-
 .../devicetree/bindings/pci/pci-thunder-pem.txt    |  12 +-
 Documentation/devicetree/bindings/pci/pcie-al.txt  |   6 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          |  26 ++--
 .../devicetree/bindings/pci/ralink,rt3883-pci.txt  |  20 +--
 .../devicetree/bindings/pci/rockchip-pcie-host.txt |  12 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |  13 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt      |  12 +-
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  36 ++---
 .../devicetree/bindings/pci/versatile.txt          |  42 +++---
 .../devicetree/bindings/pci/xgene-pci-msi.txt      |  12 +-
 .../devicetree/bindings/pci/xgene-pci.txt          |  12 +-
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |  12 +-
 .../devicetree/bindings/pci/xilinx-pcie.txt        |  26 ++--
 arch/arm/boot/dts/alpine.dtsi                      |   6 +-
 arch/arm/boot/dts/artpec6.dtsi                     |  10 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         |  34 ++---
 arch/arm/boot/dts/gemini-sl93512r.dts              |  34 ++---
 arch/arm/boot/dts/gemini-sq201.dts                 |  34 ++---
 arch/arm/boot/dts/gemini-wbd111.dts                |  34 ++---
 arch/arm/boot/dts/gemini-wbd222.dts                |  34 ++---
 arch/arm/boot/dts/imx6qdl.dtsi                     |  10 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  10 +-
 arch/arm/boot/dts/integratorap.dts                 |  36 ++---
 arch/arm/boot/dts/keystone-k2e.dtsi                |  11 +-
 arch/arm/boot/dts/keystone.dtsi                    |  10 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  10 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |  10 +-
 arch/arm/boot/dts/versatile-pb.dts                 |  36 ++---
 arch/arm64/boot/dts/al/alpine-v2.dtsi              |   6 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   |   2 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   |   2 +-
 arch/arm64/boot/dts/amd/amd-overdrive.dts          |   2 +-
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |  12 +-
 arch/arm64/boot/dts/amd/husky.dts                  |   2 +-
 arch/arm64/boot/dts/arm/fvp-base-revc.dts          |  10 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  12 +-
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      |  10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  10 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  10 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  10 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  10 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  10 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  10 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  11 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |  11 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  12 +-
 arch/powerpc/boot/dts/bluestone.dts                |  12 +-
 arch/powerpc/boot/dts/charon.dts                   |  12 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |  12 +-
 arch/powerpc/boot/dts/fsl/b4420qds.dts             |   4 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/b4860qds.dts             |   4 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |   2 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  12 +-
 arch/powerpc/boot/dts/fsl/bsc9132qds.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi      |  12 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts             |   2 +-
 arch/powerpc/boot/dts/fsl/c293si-post.dtsi         |  12 +-
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts           |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8536ds.dts            |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8536ds_36b.dts        |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8540ads.dts           | 100 +++++++-------
 arch/powerpc/boot/dts/fsl/mpc8544ds.dts            |  22 +--
 arch/powerpc/boot/dts/fsl/mpc8544ds.dtsi           |  22 +--
 arch/powerpc/boot/dts/fsl/mpc8548cds_32b.dts       |  14 +-
 arch/powerpc/boot/dts/fsl/mpc8548cds_36b.dts       |  14 +-
 arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi      |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8560ads.dts           | 100 +++++++-------
 arch/powerpc/boot/dts/fsl/mpc8568mds.dts           |  22 +--
 arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi      |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8569mds.dts           |   2 +-
 arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi      |  12 +-
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         | 150 +++++++++++----------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     | 150 +++++++++++----------
 arch/powerpc/boot/dts/fsl/p2020ds.dts              |   2 +-
 arch/powerpc/boot/dts/fsl/p2020ds.dtsi             |  46 ++++---
 arch/powerpc/boot/dts/fsl/ppa8548.dts              |   2 +-
 arch/powerpc/boot/dts/fsl/sbc8641d.dts             |   4 +-
 arch/powerpc/boot/dts/haleakala.dts                |  12 +-
 arch/powerpc/boot/dts/holly.dts                    |  42 +++---
 arch/powerpc/boot/dts/hotfoot.dts                  |  12 +-
 arch/powerpc/boot/dts/kuroboxHD.dts                |  28 ++--
 arch/powerpc/boot/dts/kuroboxHG.dts                |  28 ++--
 arch/powerpc/boot/dts/lite5200.dts                 |  12 +-
 arch/powerpc/boot/dts/lite5200b.dts                |  22 +--
 arch/powerpc/boot/dts/media5200.dts                |  26 ++--
 arch/powerpc/boot/dts/mpc5121ads.dts               |  20 +--
 arch/powerpc/boot/dts/mpc8308rdb.dts               |  12 +-
 arch/powerpc/boot/dts/mpc8313erdb.dts              |  20 +--
 arch/powerpc/boot/dts/mpc832x_mds.dts              |  60 +++++----
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |  22 +--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |   8 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts              |  60 +++++----
 arch/powerpc/boot/dts/mpc836x_rdk.dts              |  16 ++-
 arch/powerpc/boot/dts/mucmc52.dts                  |  12 +-
 arch/powerpc/boot/dts/mvme5100.dts                 |  48 +++----
 arch/powerpc/boot/dts/pcm030.dts                   |  22 +--
 arch/powerpc/boot/dts/pcm032.dts                   |  22 +--
 arch/powerpc/boot/dts/pq2fads.dts                  |  28 ++--
 arch/powerpc/boot/dts/socrates.dts                 |   8 +-
 arch/powerpc/boot/dts/storcenter.dts               |  28 ++--
 arch/powerpc/boot/dts/stx_gp3_8560.dts             |  36 ++---
 arch/powerpc/boot/dts/taishan.dts                  |  20 +--
 arch/powerpc/boot/dts/tqm5200.dts                  |  12 +-
 arch/powerpc/boot/dts/tqm8540.dts                  |  16 ++-
 arch/powerpc/boot/dts/tqm8541.dts                  |  16 ++-
 arch/powerpc/boot/dts/tqm8555.dts                  |  16 ++-
 arch/powerpc/boot/dts/tqm8560.dts                  |  16 ++-
 arch/powerpc/boot/dts/virtex440-ml510.dts          |  43 +++---
 arch/powerpc/boot/dts/xcalibur1501.dts             |  13 +-
 arch/powerpc/boot/dts/xpedite5200.dts              |   8 +-
 arch/xtensa/boot/dts/virt.dts                      |  12 +-
 include/dt-bindings/interrupt-controller/irq.h     |   8 ++
 128 files changed, 1400 insertions(+), 1189 deletions(-)
