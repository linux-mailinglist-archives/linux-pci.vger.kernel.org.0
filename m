Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0711D2F12
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENMD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 08:03:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:18126 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgENMD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 08:03:26 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 14 May 2020 21:03:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A9EE060057;
        Thu, 14 May 2020 21:03:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 14 May 2020 21:03:24 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EBE581A12AD;
        Thu, 14 May 2020 21:03:23 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/2]  PCI: Add new UniPhier PCIe endpoint driver
Date:   Thu, 14 May 2020 21:03:19 +0900
Message-Id: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds PCIe endpoint controller driver for Socionext UniPhier
SoCs. This controller is based on the DesignWare PCIe core.

This driver supports Pro5 SoC only, so Pro5 needs multiple clocks and
resets in devicetree node.

Changes since v3:
- dt-bindings: Convert with dt-schema
- Replace with devm_platform_ioremap_resource()
- Add a commnet that mutex covers raising legacy IRQ

Changes since v2:
- dt-bindings: Add clock-names, reset-names, and fix example for Pro5
- Remove 'is_legacy' indicating that the compatible is for legacy SoC
- Use pci_epc_features instead of defining uniphier_soc_data
- Remove redundant register read access
- Clean up return code on uniphier_add_pcie_ep()
- typo: intx -> INTx

Changes since v1:
- dt-bindings: Add Reviewed-by line
- Fix register value to set EP mode
- Add error message when failed to get phy
- Replace INTx assertion time with macro

Kunihiko Hayashi (2):
  dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
  PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller
    driver

 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  92 +++++
 MAINTAINERS                                        |   4 +-
 drivers/pci/controller/dwc/Kconfig                 |  13 +-
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 383 +++++++++++++++++++++
 5 files changed, 489 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c

-- 
2.7.4

