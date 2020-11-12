Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B052B0BB8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 18:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgKLRyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 12:54:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58988 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgKLRyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:54:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHs6rF028144;
        Thu, 12 Nov 2020 11:54:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605203646;
        bh=HA3K100VAjy/WJiVUwI1rftvyIQDtTVShTwH9A10BPc=;
        h=From:To:CC:Subject:Date;
        b=CZB1+EY7ZUKGNPw9RnUOGj366lJN4UWQdUiOGSzukNsV1RI0CH/29cTf4TjOv0ZbM
         rq65kLuL0i224Lp+ZLC45PvM8iPFWwRPenJxHdsMoqHEmnz7+W/1Vh9g6/9FnTVyBh
         I4msOU26EjwCo0d21l64VNJ0tp9CvD6UilkpSSAw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACHs6ml027624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 11:54:06 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 11:54:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 11:54:06 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHrx9q094087;
        Thu, 12 Nov 2020 11:54:00 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/6] Add SR-IOV support in PCIe Endpoint Core
Date:   Thu, 12 Nov 2020 23:23:52 +0530
Message-ID: <20201112175358.2653-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series
*) Adds support to add virtual functions to enable endpoint controller
   which supports SR-IOV capability
*) Add support in Cadence endpoint driver to configure virtual functions
*) Enable pci_endpoint_test driver to create pci_device for virtual
   functions

Here both physical functions and virtual functions use the same
pci_endpoint_test driver and existing pcitest utility can be used
to test virtual functions as well.

Changes from v1:
*) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
   binding for EP)

Patch series is created on top of NTB series [2]

v1 of the patch series can be found @ [1]

[1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201111153559.19050-1-kishon@ti.com

Kishon Vijay Abraham I (6):
  dt-bindings: PCI: pci-ep: Add binding to specify virtual function
  PCI: endpoint: Add support to add virtual function in endpoint core
  PCI: endpoint: Add support to link a physical function to a virtual
    function
  PCI: endpoint: Add virtual function number in pci_epc ops
  PCI: cadence: Add support to configure virtual functions
  misc: pci_endpoint_test: Populate sriov_configure ops to configure
    SR-IOV device

 .../devicetree/bindings/pci/pci-ep.yaml       |   9 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 251 +++++++++++++++---
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 +--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  83 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  66 +++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 ++
 drivers/pci/endpoint/pci-epc-core.c           | 166 +++++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 144 +++++++++-
 include/linux/pci-epc.h                       |  57 ++--
 include/linux/pci-epf.h                       |  16 +-
 14 files changed, 693 insertions(+), 204 deletions(-)

-- 
2.17.1

