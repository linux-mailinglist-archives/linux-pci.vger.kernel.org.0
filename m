Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9802768994
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGaBZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaBZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C3A1A4
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 18:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E15260DFC
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 01:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD7C433C8;
        Mon, 31 Jul 2023 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690766752;
        bh=JQkjNDhRH/onHAEQGgvrKxtIJ8PAuAHJDwYmJ2sF+Ok=;
        h=From:To:Cc:Subject:Date:From;
        b=Q2Oe/mIOZ+/flyoVU2z0odIVPWeDT2hgLsk19Ad0zXlktLXvGpjYW0DYRjrodsIK9
         U/BlacdpCPSmQAn+9dsnLgU+XG5lDGzNf665FZTDb/4lGG1rzmXdEXpSGQJmMEHZHZ
         5qA/nF6AsIeMvpjKZFl5J0ByYLTCay2VY+1nVjxaKaurop+iaQpH9Si0kXgGdDQVtZ
         aICNWSCcwA5J5Xuc075yRlofLgZBcng93w+763MpFE8aUplm54xlUrP/CdQ985vz+s
         9JvU82+ylKfCaKgP8m06x4jD5qfPeskiMW3qYJ/kr8akEP0eJ4vUB7nKO0Ixuzz0JE
         g5PVHvumnHUJw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] Cleanup IRQ type definitions
Date:   Mon, 31 Jul 2023 10:25:48 +0900
Message-ID: <20230731012550.728070-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

