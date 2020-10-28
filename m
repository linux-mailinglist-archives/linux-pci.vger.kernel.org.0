Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46CF29D547
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgJ1V7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:59:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:49812 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgJ1V7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:45 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Oct 2020 10:31:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B7AE560058;
        Wed, 28 Oct 2020 10:31:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Oct 2020 10:31:54 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 00A931A0509;
        Wed, 28 Oct 2020 10:31:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v8 0/3] PCI: uniphier: Add PME/AER support for UniPhier PCIe host controller
Date:   Wed, 28 Oct 2020 10:31:40 +0900
Message-Id: <1603848703-21099-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
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

Changes since v7:
- Add Reviewed-by: line to 1st and 3rd patches

Changes since v6:
- Separate patches for iATU and phy error from this series
- Add Reviewed-by: line to dwc patch

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

