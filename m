Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CC265C8B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKJdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 05:33:50 -0400
Received: from mx.socionext.com ([202.248.49.38]:30101 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKJdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 05:33:49 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Sep 2020 18:33:47 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A2CAD60060;
        Fri, 11 Sep 2020 18:33:47 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 18:33:47 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 262CE1A0507;
        Fri, 11 Sep 2020 18:33:47 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v7 0/3] PCI: uniphier: Add PME/AER support for UniPhier PCIe host controller
Date:   Fri, 11 Sep 2020 18:33:31 +0900
Message-Id: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The original subject up to v6 is
"PCI: uniphier: Add features for UniPhier PCIe host controller".

This adds a new function called by MSI handler in DesignWare PCIe framework,
that invokes PME and AER funcions to detect the factor from SoC-dependent
registers.

The iATU patches is split from this series as
"PCI: dwc: Move iATU register mapping to common framework".

Changes since v6:
- Separate patches for iATU and phy error from this series
- Add Reviewed-by: line

Changes since v5:
- Add pcie_port_service_get_irq() function to pcie/portdrv
- Call pcie_port_service_get_irq() to get vIRQ interrupt number for PME/AER
- Rebase to the latest linux-next branch,
  and remove devm_platform_ioremap_resource_byname() replacement patch

Changes since v4:
- Add Acked-by: line to dwc patch

Changes since v3:
- Move msi_host_isr() call into dw_handle_msi_irq()
- Move uniphier_pcie_misc_isr() call into the guard of chained_irq
- Use a bool argument is_msi instead of pci_msi_enabled()
- Consolidate handler calls for the same interrupt
- Fix typos in commit messages

Changes since v2:
- Avoid printing phy error message in case of EPROBE_DEFER
- Fix iATU register mapping method
- dt-bindings: Add Acked-by: line
- Fix typos in commit messages
- Use devm_platform_ioremap_resource_byname()

Changes since v1:
- Add check if struct resource is NULL
- Fix warning in the type of dev_err() argument

Kunihiko Hayashi (3):
  PCI: portdrv: Add pcie_port_service_get_irq() function
  PCI: dwc: Add msi_host_isr() callback
  PCI: uniphier: Add misc interrupt handler to invoke PME and AER

 drivers/pci/controller/dwc/pcie-designware-host.c |  3 +
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-uniphier.c        | 77 +++++++++++++++++++----
 drivers/pci/pcie/portdrv.h                        |  1 +
 drivers/pci/pcie/portdrv_core.c                   | 16 +++++
 5 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.7.4

