Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202032325FE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgG2UM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 16:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgG2UM5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77AF02082E;
        Wed, 29 Jul 2020 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053577;
        bh=sHLe5FuGDRZbbcJ2DSTc7bJp/OFHU619yFh5NL4U0aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rp3Qd9sQ9P8TZLVuMXChB7CXqlnfo/dqXWu4FRNN6t0ptX3rEABLFCP3tncyfSOir
         OjGFH1gXoWXB1u1xvkA0tz6CA3X7GWUR2bVIhL6yn+vpoxELbyxvlM82KFBajSXHRW
         a4z/xjY14D/2HeDPXBYAXo2v/Befm22pd2jwhjcg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 6/6] PCI: xilinx: Fix kerneldoc
Date:   Wed, 29 Jul 2020 22:12:24 +0200
Message-Id: <20200729201224.26799-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729201224.26799-1-krzk@kernel.org>
References: <20200729201224.26799-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/controller/pcie-xilinx-cpm.c:122: warning: Function parameter or member 'cpm_domain' not described in 'xilinx_cpm_pcie_port'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 66f554694e03..cd8c77457b5f 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -104,6 +104,7 @@
  * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
  * @dev: Device pointer
  * @intx_domain: Legacy IRQ domain pointer
+ * @cpm_domain: CPM IRQ domain pointer
  * @cfg: Holds mappings of config space window
  * @intx_irq: legacy interrupt number
  * @irq: Error interrupt number
-- 
2.17.1

