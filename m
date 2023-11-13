Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA67E9417
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 02:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjKMBdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Nov 2023 20:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2023 20:33:07 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9011D10CE;
        Sun, 12 Nov 2023 17:33:03 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.03,298,1694703600"; 
   d="scan'208";a="186494700"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Nov 2023 10:33:02 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 60B8740031CF;
        Mon, 13 Nov 2023 10:33:02 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] PCI: dwc: Improve code readability
Date:   Mon, 13 Nov 2023 10:32:57 +0900
Message-Id: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
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

This patch series is based on the latest pci.git / next branch.
The patch 1/3 is related to the "note" in the commit [1]
The patches [23]/3 are related to the "Note" which in the commit [2].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9baa8a18e31b7167885c11c38841ce92bbe20f4f

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7873b49b41b92edb3395bff9a528eaf89da5e41c

Yoshihiro Shimoda (3):
  PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
  PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
  PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers

 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   2 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 248 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   6 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 12 files changed, 154 insertions(+), 127 deletions(-)

-- 
2.34.1

