Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9770060D41D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJYSv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiJYSv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 14:51:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64511876D;
        Tue, 25 Oct 2022 11:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2D8AB81E81;
        Tue, 25 Oct 2022 18:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBA9C433D6;
        Tue, 25 Oct 2022 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666723913;
        bh=sbHHHHik1ots3ugg9bWS1aJ74WP1MU5+FlwWTqdu/Ic=;
        h=From:To:Cc:Subject:Date:From;
        b=lXeX/X72neXmJl7dxIPdLhMBZaIRV+QjRLeYOxd3IpR9dHMztEdyHCFsbemC+gf0c
         vLbToENare7yvqy/PTS6N/+zOqcxiTJyiuaOhhBFHZyPHWrfTOlyfxcYjam0opx+CW
         0bdI8NX8dYCIibHoXynU8oMsSr/pDu3Jvz+V3waE6x+/tijZCg0do5RyR8HMGxc4rv
         1baPQXAGZu0nU+uhDcrdYTrwLvlk82MpWyFD1ukLMrmGLCmhfJjiXML0rAky3rtpAI
         RTFwGGJNP8D7U13bX6/0IwViYbwezcAFbjx0Uzc6c3YYRUIkx2amVjpQkw7a1h9i28
         lf+zoKvu4kyfg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/4] PCI: Remove unnecessary <linux/of_irq.h> includes
Date:   Tue, 25 Oct 2022 13:51:43 -0500
Message-Id: <20221025185147.665365-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Many host controller drivers #include <linux/of_irq.h> even though they
don't need it.  Remove the unnecessary #includes.

v1: https://lore.kernel.org/all/20221019195452.37606-1-helgaas@kernel.org/

Changes from v1 to v2:
  - Include <linux/irqdomain.h> explicitly in altera-msi and microchip,
    which don't need <linux/of_irq.h> itself, but relied on it to include
    <linux/irqdomain.h>
  - Include <linux/irqdomain.h> explicitly in mvebu, which needs both it
    and <linux/of_irq.h>

Bjorn Helgaas (4):
  PCI: altera-msi: Include <linux/irqdomain.h> explicitly
  PCI: microchip: Include <linux/irqdomain.h> explicitly
  PCI: mvebu: Include <linux/irqdomain.h> explicitly
  PCI: Remove unnecessary <linux/of_irq.h> includes

 drivers/pci/controller/cadence/pci-j721e.c   | 1 -
 drivers/pci/controller/dwc/pci-layerscape.c  | 1 -
 drivers/pci/controller/dwc/pcie-armada8k.c   | 1 -
 drivers/pci/controller/dwc/pcie-tegra194.c   | 1 -
 drivers/pci/controller/pci-mvebu.c           | 1 +
 drivers/pci/controller/pci-v3-semi.c         | 1 -
 drivers/pci/controller/pci-xgene-msi.c       | 1 -
 drivers/pci/controller/pci-xgene.c           | 1 -
 drivers/pci/controller/pcie-altera-msi.c     | 2 +-
 drivers/pci/controller/pcie-iproc-platform.c | 1 -
 drivers/pci/controller/pcie-iproc.c          | 1 -
 drivers/pci/controller/pcie-microchip-host.c | 2 +-
 drivers/pci/controller/pcie-rockchip-host.c  | 1 -
 drivers/pci/controller/pcie-xilinx-cpm.c     | 1 -
 drivers/pci/controller/pcie-xilinx-nwl.c     | 1 -
 15 files changed, 3 insertions(+), 14 deletions(-)

-- 
2.25.1

