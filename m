Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDA3F195F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhHSMfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 08:35:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40954 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhHSMfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 08:35:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JCXtus105081;
        Thu, 19 Aug 2021 07:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629376435;
        bh=uIdqzpeb6rsr/wPaBaqhSb1jIF6z59bQ7qEZwC/9NPk=;
        h=From:To:CC:Subject:Date;
        b=TMNvhldexbHQQJ2i+PQC9/mdoCg/F4vESuBTMcgWDUp7RCZFNg/qYmZhhAtVE332J
         bcR6a60OmrV52UKcZhDeLX+XO12ut5Oak/6zZmOHjRv8xdbC4PvYAvft2vWrOJhW8T
         Tat9cmSjeSrD6LDHPP4AjiUrh8cJvZoVUUGflIeE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JCXtJa093161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 07:33:55 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 07:33:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 07:33:54 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JCXlZO035715;
        Thu, 19 Aug 2021 07:33:48 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v9 0/8] Add SR-IOV support in PCIe Endpoint Core
Date:   Thu, 19 Aug 2021 18:03:35 +0530
Message-ID: <20210819123343.1951-1-kishon@ti.com>
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
v8 of the patch series can be found at [8]

Here both physical functions and virtual functions use the same
pci_endpoint_test driver and existing pcitest utility can be used
to test virtual functions as well.

Changes from v8:
1) Include pci-epf.h in pcie-cadence.h and use BAR_4 instead of 4
2) Get reg for configuring BAR using if..else.. for physical function
and virtual function instead of over-writing reg for virtual function.

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
[8] -> https://lore.kernel.org/r/20210811064656.15399-1-kishon@ti.com

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
 .../pci/controller/cadence/pcie-cadence-ep.c  | 196 +++++++++++++-----
 drivers/pci/controller/cadence/pcie-cadence.h |  12 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 ++--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  89 ++++----
 drivers/pci/endpoint/functions/pci-epf-test.c |  74 ++++---
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 +++
 drivers/pci/endpoint/pci-epc-core.c           | 134 ++++++++----
 drivers/pci/endpoint/pci-epf-core.c           | 146 ++++++++++++-
 include/linux/pci-epc.h                       |  57 ++---
 include/linux/pci-epf.h                       |  16 +-
 15 files changed, 616 insertions(+), 225 deletions(-)

-- 
2.17.1

