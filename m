Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EF3DE5D4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 07:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhHCFD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 01:03:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51332 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhHCFD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 01:03:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17353JLr093182;
        Tue, 3 Aug 2021 00:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627966999;
        bh=xPLECnhwE7VAbRQb07SbvYiefpvIipORqzNtsCbzOA4=;
        h=From:To:CC:Subject:Date;
        b=m+GzT8Y+oZox0RdDDVu+ZHPGV1TaQBrfwIIJ0vwLRoDpu+H8ESbz0u1bB9pCPjTmL
         DiTNmKYXD/KErd5DjZnyGCDxJDf8bZfl+5g5JwvyeycolFmikuDyZQCzkALDrGhYk+
         WSlFSyuktjJtK/BJw77NwbjxwvJ8oNMBmLhKaZYg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17353I6I065316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 00:03:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 00:03:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 3 Aug 2021 00:03:18 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17353BeQ090231;
        Tue, 3 Aug 2021 00:03:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 0/7] Add SR-IOV support in PCIe Endpoint Core
Date:   Tue, 3 Aug 2021 10:33:03 +0530
Message-ID: <20210803050310.27122-1-kishon@ti.com>
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

v1 of the patch series can be found at [1]
v2 of the patch series can be found at [2]
v3 of the patch series can be found at [3]
v4 of the patch series can be found at [4]
v5 of the patch series can be found at [5]
v6 of the patch series can be found at [6]

Here both physical functions and virtual functions use the same
pci_endpoint_test driver and existing pcitest utility can be used
to test virtual functions as well.

Changes from v6:
*) Rebased to 5.13-rc4

Changes from v5:
*) Rebased to 5.13-rc1

Changes from v4:
*) Added a fix in Cadence driver which was overwriting BAR configuration
   of physical function.
*) Didn't include Tom's Acked-by since Cadence driver is modified in
   this revision.

Changes from v3:
*) Fixed Rob's comment and added his Reviewed-by as suggested by him.

Changes from v2:
*) Fixed DT binding documentation comment by Rob
*) Fixed the error check in pci-epc-core.c

Changes from v1:
*) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
   binding for EP)

[1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com
[3] -> https://lore.kernel.org/r/20210305050410.9201-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20210310160943.7606-1-kishon@ti.com
[5] -> https://lore.kernel.org/r/20210419083401.31628-1-kishon@ti.com
[6] -> http://lore.kernel.org/r/20210517074723.10212-1-kishon@ti.com

Kishon Vijay Abraham I (7):
  dt-bindings: PCI: pci-ep: Add binding to specify virtual function
  PCI: endpoint: Add support to add virtual function in endpoint core
  PCI: endpoint: Add support to link a physical function to a virtual
    function
  PCI: endpoint: Add virtual function number in pci_epc ops
  PCI: cadence: Add support to configure virtual functions
  misc: pci_endpoint_test: Populate sriov_configure ops to configure
    SR-IOV device
  Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV

 .../PCI/endpoint/pci-endpoint-cfs.rst         |  12 +-
 .../devicetree/bindings/pci/pci-ep.yaml       |   7 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 285 ++++++++++++++----
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 +--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  79 +++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  66 ++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 ++
 drivers/pci/endpoint/pci-epc-core.c           | 130 +++++---
 drivers/pci/endpoint/pci-epf-core.c           | 144 ++++++++-
 include/linux/pci-epc.h                       |  57 ++--
 include/linux/pci-epf.h                       |  16 +-
 15 files changed, 684 insertions(+), 217 deletions(-)

-- 
2.17.1

