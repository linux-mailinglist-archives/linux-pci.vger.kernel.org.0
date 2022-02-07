Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAB4AC2F7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiBGPXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442929AbiBGPKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:10:13 -0500
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DEFC0401C4;
        Mon,  7 Feb 2022 07:08:44 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 109E2440F5F;
        Mon,  7 Feb 2022 16:51:33 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644245493;
        bh=7aNgLkH2AUxOLsKPef7Ni1LA2rtSGekKuigyuyViuyM=;
        h=From:To:Cc:Subject:Date:From;
        b=phl7B+KswJvMTbObMss9Cr38/Rv2yuwI3qlHHebcV/DS1pszFdGbMI7/7nxGZymiC
         jQx18rL8gZefPL7KiLw+JV/BK4ySQRPqgJVxIxx3BIdl4w4KKs+LdJCNrSJjsmXrvD
         cW5vKdeVJTKEpbn26VKLRCeKs3OHFAUGbWezCSKFj1NNlcJ1Lnn6lX2nyBxqzfA50A
         yi52Em5Z3nVshHockJep7Ta7lNt5QF1kw1Oh3Ynlf+2DQi5jbAkKQiqqwTw5C75X8b
         cbDQxxr5IKuRVMJjHoC0Cgvkd3v0mjLiCCRRB23cf+kzTwFqhq1Wn3LWvunWBQji6H
         d+NgVT6RIlvRA==
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
Subject: [PATCH v6 0/3] PCI: IPQ6018 platform support
Date:   Mon,  7 Feb 2022 16:51:23 +0200
Message-Id: <cover.1644234441.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
ported from downstream Codeaurora v5.4 kernel. The main difference from 
downstream code is the split of PCIe registers configuration from .init to 
.post_init, since it requires phy_power_on().

Tested on IPQ6010 based hardware.

Changes in v6:

  * Drop DT patch applied to the qcom tree

  * Normalize driver changes subject line

  * Add a preparatory patch to rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL,
    and define it using PCI_EXP_SLTCAP_* macros

  * Drop a vague comment about ASPM configuration

  * Add a comment about the source of delay periods

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
  PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
  PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*

Selvam Sathappan Periakaruppan (1):
  PCI: qcom: Add IPQ60xx support

 drivers/pci/controller/dwc/pcie-designware.h |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
 3 files changed, 160 insertions(+), 8 deletions(-)

-- 
2.34.1

