Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0C32E100
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCEFFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 00:05:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCEFFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 00:05:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12554MVb074851;
        Thu, 4 Mar 2021 23:04:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614920662;
        bh=U0H1T2uqfz94VIfupekbSvG64g6Q1bFcWLHxDtZXkRo=;
        h=From:To:CC:Subject:Date;
        b=Wux98L/XpAmOM9Zb2Eh+ZhhJsnrgGtKK0RPf8ykrGgND+z4oygQL0Nuc0uUHW1KSP
         AcnmxZ6+p7jqpDJd0qgMLAc7vdcff+Fzk8qQBJxeYsGoJA497pIKnCeNldZFGujxdE
         w1om3sRvuPNmuldvIX2OekFrlhVzl/fQOeFB9reg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12554MQH012146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 23:04:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 23:04:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 23:04:21 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12554D95116197;
        Thu, 4 Mar 2021 23:04:14 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nadeem Athani <nadeem@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 0/7] Add SR-IOV support in PCIe Endpoint Core
Date:   Fri, 5 Mar 2021 10:34:03 +0530
Message-ID: <20210305050410.9201-1-kishon@ti.com>
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

Here both physical functions and virtual functions use the same
pci_endpoint_test driver and existing pcitest utility can be used
to test virtual functions as well.

Changes from v2:
*) Fixed DT binding documentation comment by Rob
*) Fixed the error check in pci-epc-core.c

Changes from v1:
*) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
   binding for EP)

[1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com

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
 .../devicetree/bindings/pci/pci-ep.yaml       |   9 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 251 +++++++++++++++---
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 +--
 drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  79 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  66 +++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 ++
 drivers/pci/endpoint/pci-epc-core.c           | 130 ++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 144 +++++++++-
 include/linux/pci-epc.h                       |  57 ++--
 include/linux/pci-epf.h                       |  16 +-
 15 files changed, 666 insertions(+), 203 deletions(-)

-- 
2.17.1

