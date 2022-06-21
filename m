Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C0552D9F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiFUIzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347394AbiFUIzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 04:55:11 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F427144;
        Tue, 21 Jun 2022 01:55:05 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 18A8D4407B7;
        Tue, 21 Jun 2022 11:54:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655801679;
        bh=kzwDweRYdmF9VZ9rId4uGj3KSP3nY1/NkAN1K4avLsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jLcWXEbf/NvzEGv21abzI5Z0ImDF6d6U41lD5HfZmv3fKmEacgA2j5UMqaY1ewr12
         FBjwv9phNqkwWcOG6wuucIvyRgjfq/4m4NCIMFfZYvsFk72Mw24nN4rKSa2cgTJ4XY
         1luQcRxwiHVAYluhVbDr0FypGlWxfby6vVALMasuXvmQ1mvXHuBtaZDvGCgemAo/R3
         WKg4DG5QoyFa5RQLkaKijdxtnDutlqtL7KhnOQiOEpavvR2JgkKhLN+WgCRVpdtGOB
         Ru7MRMLxr874+bqp7mDxzAyVyZIZXvuX3PKmz5XgcUGZXZihs+EeJbBTl5Oa6Ys0OR
         ybhavdFY/qS3Q==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v8 0/3] PCI: IPQ6018 platform support
Date:   Tue, 21 Jun 2022 11:54:51 +0300
Message-Id: <cover.1655799816.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v8:

  * Update sign-off addresses to avoid bounce from the defunct codeaurora.org 
    email domain

  * Add review, ack, and test tags from Rob, Stanimir, and Robert

  * Drop reset assert on init error path for consistency with deinit

  * Code formatting cleanup

Changes in v7:

  * Use FIELD_PREP for power limit and scale fields

  * Add Stanimir Varbanov to Cc

  * Rebase on v5.19-rc1

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
 drivers/pci/controller/dwc/pcie-qcom.c       | 147 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
 3 files changed, 152 insertions(+), 8 deletions(-)

-- 
2.35.1

