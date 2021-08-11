Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6603E8A64
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhHKGsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 02:48:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42338 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhHKGsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 02:48:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17B6l62r026237;
        Wed, 11 Aug 2021 01:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628664426;
        bh=5ToVPmf6k46EPyuQaA+kyIopP+BZEXEzFZsUj6vHfEs=;
        h=From:To:CC:Subject:Date;
        b=duvuwC3oC8q/7b+habCxAah+q2QYc5oJdTvaOWMZSB4eO6InmE+UfSW4xCDbIVVlA
         IIRrhNDvfNr+/EnoGPm7Z27IPew3TDhrtZ+/qMh38IgjRp3KRAQoWrJuUUOIdQ5m9K
         Vcvd+L2/2h6pOAcHBejTbB1kFBCp6U5UqrW5pb8Q=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17B6l6Ft111940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 01:47:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 01:47:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 01:47:05 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17B6kvu1013269;
        Wed, 11 Aug 2021 01:46:57 -0500
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
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>
Subject: [PATCH v8 0/8] Add SR-IOV support in PCIe Endpoint Core
Date:   Wed, 11 Aug 2021 12:16:48 +0530
Message-ID: <20210811064656.15399-1-kishon@ti.com>
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
v7 of the patch series can be found at [7]

Here both physical functions and virtual functions use the same
pci_endpoint_test driver and existing pcitest utility can be used
to test virtual functions as well.

Changes from v7:
1) Added conditional operator to consicely write code to configure BAR
   (Added a new patch to first simplify configuring BAR for physical
    function)
2) Return error if virtual function number is > 1 for configuring config
   space header

Changes from v6:
*) Rebased to 5.14-rc4

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
[7] -> https://lore.kernel.org/r/20210803050310.27122-1-kishon@ti.com

Kishon Vijay Abraham I (8):
  dt-bindings: PCI: pci-ep: Add binding to specify virtual function
  PCI: endpoint: Add support to add virtual function in endpoint core
  PCI: endpoint: Add support to link a physical function to a virtual
    function
  PCI: endpoint: Add virtual function number in pci_epc ops
  PCI: cadence: Simplify code to get register base address for
    configuring BAR
  PCI: cadence: Add support to configure virtual functions
  misc: pci_endpoint_test: Populate sriov_configure ops to configure
    SR-IOV device
  Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV

 .../PCI/endpoint/pci-endpoint-cfs.rst         |  12 +-
 .../devicetree/bindings/pci/pci-ep.yaml       |   7 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 194 +++++++++++++-----
 drivers/pci/controller/cadence/pcie-cadence.h |  11 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 ++--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  89 ++++----
 drivers/pci/endpoint/functions/pci-epf-test.c |  74 ++++---
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 +++
 drivers/pci/endpoint/pci-epc-core.c           | 134 ++++++++----
 drivers/pci/endpoint/pci-epf-core.c           | 144 ++++++++++++-
 include/linux/pci-epc.h                       |  57 ++---
 include/linux/pci-epf.h                       |  16 +-
 15 files changed, 611 insertions(+), 225 deletions(-)

-- 
2.17.1

