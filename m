Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDA76C7B9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHBIAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjHBIAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 04:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1884930C2
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 00:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B1261861
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 07:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79CAC433C8;
        Wed,  2 Aug 2023 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690963187;
        bh=U9YuhUGErNhjK/kY172v7sWDABARpio3gfH6hLRoFGE=;
        h=From:To:Cc:Subject:Date:From;
        b=kdq50U6iXNIMAN1UJs9eBhxjv2U8rLG+41AQTBQDi4tGor9YsGIjivUP2fYYxgv79
         EPvbV8dMnC0Ut3NTwSVE0/CN2PWSFpylT1zrPgCCJkIzpC1p+tNHW+7rxawV3ylCoM
         kp+H/Zy7v02kJuc7Y7lYzhx2pdd3YkMX2YnEVGXTrLT3PCs4N9leF8XThkYQA2vuBH
         ivFy86UJ5sfqhR3SohiD497oldIYRyV3UnvPQPEqTvGhEVdi53fFoOWAXAyEjXULWN
         NXPoiOZdVOIczADBCg9UrfEBePbQir4x+VIHa2MGTFpq+PTk1YyrMsMh4NKjFjTTeR
         RaIGQ2jgdVbAA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] Cleanup IRQ type definitions
Date:   Wed,  2 Aug 2023 16:59:42 +0900
Message-ID: <20230802075944.937619-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
Bjorn (hence the patch authorship is given to him).

The second patch removes the redundant IRQ type definitions
PCI_EPC_IRQ_XXX and replace these with a direct use of the PCI_IRQ_XXX
definitions. Going forward, more cleanups renaming "legacy" to "intx"
in various drivers can be added on top of this series.

Changes from v1:
 - Updated first patch Signed-of tag and commit message as suggested by
   Bjorn.
 - Added review tags.

Bjorn Helgaas (1):
  PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX

Damien Le Moal (1):
  PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions

 drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
 drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
 drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
 drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
 drivers/pci/controller/dwc/pcie-artpec6.c         |  8 ++++----
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 drivers/pci/controller/dwc/pcie-keembay.c         | 13 ++++++-------
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
 drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
 drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
 drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
 drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
 drivers/pci/endpoint/pci-epc-core.c               |  2 +-
 include/linux/pci-epc.h                           | 11 ++---------
 include/linux/pci.h                               |  4 +++-
 22 files changed, 65 insertions(+), 82 deletions(-)

-- 
2.41.0

