Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F114984C3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiAXQ3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 11:29:08 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:34336 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243733AbiAXQ3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jan 2022 11:29:07 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 26FF2440430;
        Mon, 24 Jan 2022 18:28:47 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1643041727;
        bh=DjS6s/K0SfWhGGh/pVn+WNtUFdUvuIJItZj5VJ/R+Es=;
        h=From:To:Cc:Subject:Date:From;
        b=UrCf5rBnp+G3/q5NFvmCkABIJFE7lwrGfR6GHA9ugyuD0Hb42NFM1idKvhhCH0lDM
         wZRe437uHmFyhuBj1iOsevI0O7YpwD6seLZJu4y+sThgOPjYfdrgBJ4FpexYL0sJ1r
         Br7mUnKuhWcJgiEqxCgBMhGmp1YaLRGvsogdZeSJyWtWL21iduzQMOB7Mvf5Kq2F60
         7+q0kNb+ClKJC5M0fYy/rKrK+Zbj/ZzGUhyrsfiQ2oGGS079CtsYOlNQ6Dkwo0m38o
         nQBNKx6aAQu0fMRJY6MTi5rJyJDuBRQQL5qv3ujuO51H3y0o5KfvZeFfw1HO/ZypKa
         WD/tnwi2CA2kg==
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
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 0/3] arm64: IPQ6018 PCIe support
Date:   Mon, 24 Jan 2022 18:27:28 +0200
Message-Id: <cover.1643041464.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
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

Changes in v5:

  * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)

Changes in v4:

  * Drop applied DT bits

  * Add max-link-speed that was missing from the applied v2 patch

  * Rebase the driver on v5.16-rc3

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

Baruch Siach (2):
  arm64: dts: qcom: ipq6018: add pcie max-link-speed
  PCI: dwc: tegra: move GEN3_RELATED DBI register to common header

Selvam Sathappan Periakaruppan (1):
  PCI: qcom: add support for IPQ60xx PCIe controller

 arch/arm64/boot/dts/qcom/ipq6018.dtsi        |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 137 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
 4 files changed, 145 insertions(+), 6 deletions(-)

-- 
2.34.1

