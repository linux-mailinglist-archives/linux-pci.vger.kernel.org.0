Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2467EAA44
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 06:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjKNFzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 00:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKNFzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 00:55:06 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7C3F1BF;
        Mon, 13 Nov 2023 21:55:02 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.03,301,1694703600"; 
   d="scan'208";a="186678313"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Nov 2023 14:55:01 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 91F4A4162940;
        Tue, 14 Nov 2023 14:55:01 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/6] PCI: controllers: tidy code up
Date:   Tue, 14 Nov 2023 14:54:50 +0900
Message-Id: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series tidies the code of PCIe dwc controllers and some
controllers up.

Changes from v1:
https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add a new patch to drop host prefix of members from dw_pcie_host_ops
   in the patch 1/6.
 - Add Reviewed-by tag in the patch 3/6.
 - Drop unneeded local variable in the patch 4/6.
 - Add new patches to resolve issues of clang warnings in the patch [56]/6.

Justin Stitt (1):
  PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning

Yoshihiro Shimoda (5):
  PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
  PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
  PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
  PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
  PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning

 drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
 drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
 drivers/pci/controller/dwc/pci-meson.c        |   2 +-
 drivers/pci/controller/dwc/pcie-al.c          |   2 +-
 drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
 drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 249 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  30 +--
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
 drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
 drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
 30 files changed, 203 insertions(+), 177 deletions(-)

-- 
2.34.1

