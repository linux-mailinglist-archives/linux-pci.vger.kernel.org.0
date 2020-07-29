Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09F2325EA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgG2UMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 16:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2UMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:34 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F16F206D7;
        Wed, 29 Jul 2020 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053553;
        bh=kdpsq8PMJl2/l+LJvMyLArAk9Zs2gSAW1t4EPgknXS8=;
        h=From:To:Cc:Subject:Date:From;
        b=COAbw1pBwZY2vEEs56fbnU558HbMxPwgZDtcJSxO8cBqVMtvIeGrtnFFsbQESQzm8
         G7nQjtKChSkgvdsPpS4qBmGe5B2YRQeI28rpZnIO0XYbHTtJ834Clill6yODgVhQbM
         NvMP3xIuQEEOFtW01WT5BSOkfTtiss5KOYXT8ias=
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
Subject: [PATCH v3 0/6] PCI: Minor kerneldoc warning fixes
Date:   Wed, 29 Jul 2020 22:12:18 +0200
Message-Id: <20200729201224.26799-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Changes since v2:
1. Fix almost all warnings, except:
   drivers/pci/controller/pci-hyperv.c:2534: warning: Function parameter or member 'version' not described in 'hv_pci_protocol_negotiation'
   drivers/pci/controller/pci-hyperv.c:2534: warning: Function parameter or member 'num_version' not described in 'hv_pci_protocol_negotiation'
   Not sure what are these.

2. New patches, split per driver or subdirectory

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  PCI: Fix kerneldoc
  PCI: endpoint: Fix kerneldoc
  PCI: hotplug: Fix kerneldoc
  PCI: dwc: Fix kerneldoc
  PCI: rockchip: Fix kerneldoc
  PCI: xilinx: Fix kerneldoc

 drivers/pci/ats.c                               | 3 ++-
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 drivers/pci/controller/pcie-rockchip-ep.c       | 1 +
 drivers/pci/controller/pcie-xilinx-cpm.c        | 1 +
 drivers/pci/endpoint/functions/pci-epf-test.c   | 2 +-
 drivers/pci/endpoint/pci-ep-cfs.c               | 2 +-
 drivers/pci/endpoint/pci-epc-core.c             | 2 +-
 drivers/pci/endpoint/pci-epc-mem.c              | 2 +-
 drivers/pci/endpoint/pci-epf-core.c             | 4 +++-
 drivers/pci/hotplug/acpi_pcihp.c                | 4 ++--
 drivers/pci/hotplug/pciehp_core.c               | 1 +
 drivers/pci/of.c                                | 2 ++
 drivers/pci/pci-pf-stub.c                       | 2 +-
 drivers/pci/setup-bus.c                         | 1 +
 drivers/pci/vc.c                                | 1 -
 15 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.17.1

