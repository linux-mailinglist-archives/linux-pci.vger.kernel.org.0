Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06823FB264
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhH3I0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:26:01 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:50711 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhH3I0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:26:01 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id A03B244064E;
        Mon, 30 Aug 2021 11:24:50 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: IPQ6018 PCIe support
Date:   Mon, 30 Aug 2021 11:24:49 +0300
Message-Id: <cover.1630311481.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
ported from downstream Codeaurora v5.4 kernel. The main difference from 
downstream code is the split of PCIe registers configuration from .init to 
.post_init, since it requires phy_power_on().

Tested on IPQ6010 based hardware.

Changes in v3:

  * Drop applied patches

  * Rely on generic code for speed setup

  * Drop unused macros

  * Formatting fixes

Changes in v2:

  * Add patch moving GEN3_RELATED macros to a common header

  * Drop ATU configuration from pcie-qcom

  * Remove local definition of common registers

  * Use bulk clk and reset APIs

  * Remove msi-parent from device-tree

Baruch Siach (1):
  PCI: dwc: tegra: move GEN3_RELATED DBI register to common header

Selvam Sathappan Periakaruppan (2):
  PCI: qcom: add support for IPQ60xx PCIe controller
  arm64: dts: ipq6018: Add pcie support

 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 100 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 141 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
 4 files changed, 248 insertions(+), 6 deletions(-)

-- 
2.33.0

