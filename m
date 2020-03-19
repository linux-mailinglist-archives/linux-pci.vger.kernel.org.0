Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3FE18ADA7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCSHyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 03:54:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:23146 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgCSHyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 03:54:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Mar 2020 16:54:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6082118005C;
        Thu, 19 Mar 2020 16:54:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Mar 2020 16:54:13 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 8D5DB1A0E67;
        Thu, 19 Mar 2020 16:54:12 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] PCI: Add new UniPhier PCIe endpoint driver
Date:   Thu, 19 Mar 2020 16:54:07 +0900
Message-Id: <1584604449-13461-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds PCIe endpoint controller driver for Socionext UniPhier
SoCs. This controller is based on the DesignWare PCIe core. This driver
supports Pro5 SoC.

Changes since v1:
- dt-bindings: Add Reviewed-by line
- Fix register value to set EP mode
- Add error message when failed to get phy
- Replace INTX assertion time with macro

Kunihiko Hayashi (2):
  dt-bindings: PCI: Add UniPhier PCIe endpoint controller description
  PCI: uniphier: Add UniPhier PCIe endpoint controller support

 .../devicetree/bindings/pci/uniphier-pcie-ep.txt   |  47 +++
 MAINTAINERS                                        |   4 +-
 drivers/pci/controller/dwc/Kconfig                 |  13 +-
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 405 +++++++++++++++++++++
 5 files changed, 466 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c

-- 
2.7.4

