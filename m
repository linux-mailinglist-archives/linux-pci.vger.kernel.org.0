Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEED29736E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbgJWQUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 12:20:19 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:48898 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750315AbgJWQUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 12:20:19 -0400
X-IronPort-AV: E=Sophos;i="5.77,408,1596466800"; 
   d="scan'208";a="60417029"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Oct 2020 01:20:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 11B984007F22;
        Sat, 24 Oct 2020 01:20:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] PCI: pcie-rcar-host: Drop unused members from struct rcar_pcie_host
Date:   Fri, 23 Oct 2020 17:20:08 +0100
Message-Id: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop unused members dev and base from struct rcar_pcie_host.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cdc0963f154e..4d1c4b24e537 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -50,9 +50,7 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 /* Structure representing the PCIe interface */
 struct rcar_pcie_host {
 	struct rcar_pcie	pcie;
-	struct device		*dev;
 	struct phy		*phy;
-	void __iomem		*base;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
-- 
2.17.1

