Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17E5B3339
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfIPC2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 22:28:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48900 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfIPC2Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Sep 2019 22:28:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D71820051D;
        Mon, 16 Sep 2019 04:28:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 276DA20012D;
        Mon, 16 Sep 2019 04:28:15 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A6AF4402E6;
        Mon, 16 Sep 2019 10:28:06 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 0/6] Add the Mobiveil EP and Layerscape Gen4 EP driver support
Date:   Mon, 16 Sep 2019 10:17:36 +0800
Message-Id: <20190916021742.22844-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set are for adding Mobiveil EP driver and adding PCIe Gen4
EP driver of NXP Layerscape platform.

This patch set depends on:
https://patchwork.kernel.org/project/linux-pci/list/?series=159139

Xiaowei Bao (6):
  PCI: mobiveil: Add the EP driver support
  dt-bindings: Add DT binding for PCIE GEN4 EP of the layerscape
  PCI: mobiveil: Add PCIe Gen4 EP driver for NXP Layerscape SoCs
  PCI: mobiveil: Add workaround for unsupported request error
  arm64: dts: lx2160a: Add PCIe EP node
  misc: pci_endpoint_test: Add the layerscape PCIe GEN4 EP device
    support

 .../bindings/pci/layerscape-pcie-gen4.txt          |  28 +-
 MAINTAINERS                                        |   3 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  56 ++
 drivers/misc/pci_endpoint_test.c                   |   2 +
 drivers/pci/controller/mobiveil/Kconfig            |  22 +-
 drivers/pci/controller/mobiveil/Makefile           |   2 +
 .../controller/mobiveil/pcie-layerscape-gen4-ep.c  | 169 ++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c | 568 +++++++++++++++++++++
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |  99 +++-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |  72 +++
 10 files changed, 1009 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c

-- 
2.9.5

