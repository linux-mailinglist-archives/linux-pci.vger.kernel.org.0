Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22232325FB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgG2UMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 16:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgG2UMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E422084D;
        Wed, 29 Jul 2020 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053573;
        bh=V9EprXKVGXX24mCzeJue9CSAcDBKDafQ+ljW7XVDoV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrFkGLYurRYjIboIfx1hF2mlT0Qg/vg4lsSrYsSNP4vLC/VSGJehNKxyW3JHBV+l2
         wolsiMH61jqLqDmNMXQ+/J8rQmiHEfXuedaaraBLPOdaqQpSIhcrnnpd7uPi+gW6RB
         hJ4B01uQzn9o47Eo7pD13oZt5q721nv3ChWY7tPA=
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
Subject: [PATCH v3 5/6] PCI: rockchip: Fix kerneldoc
Date:   Wed, 29 Jul 2020 22:12:23 +0200
Message-Id: <20200729201224.26799-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729201224.26799-1-krzk@kernel.org>
References: <20200729201224.26799-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/controller/pcie-rockchip-ep.c:50: warning: Function parameter or member 'epc' not described in 'rockchip_pcie_ep'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 5eaf36629a75..7631dc3961c1 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -22,6 +22,7 @@
 /**
  * struct rockchip_pcie_ep - private data for PCIe endpoint controller driver
  * @rockchip: Rockchip PCIe controller
+ * @epc: PCI EPC device
  * @max_regions: maximum number of regions supported by hardware
  * @ob_region_map: bitmask of mapped outbound regions
  * @ob_addr: base addresses in the AXI bus where the outbound regions start
-- 
2.17.1

