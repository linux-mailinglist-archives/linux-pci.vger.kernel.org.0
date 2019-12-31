Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9D12D840
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLaLeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 06:34:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaLeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXdPS121093;
        Tue, 31 Dec 2019 05:33:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792019;
        bh=Pajx8yxPYy9hpNMBr5wGSpnGBlMhhMxaOBX8Gt0CXWc=;
        h=From:To:CC:Subject:Date;
        b=xpYlx9RH8ZH2mpS8/0vaGZcJSzosrfpZvtfmjD+XskBPHD7wRj7lmrQdKnAWcps01
         XgIP7Jx1gW8KBXspH1MtP0jXF0Q77WwGlKCgrA48SkReVbeZJcBVVk2QFkuuCJCIPA
         Xe+tPtDK3uDAHChnP0yA5QxGTW6jrGSnfDLfS2NA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBXd3M090029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:33:39 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:33:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:33:39 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX31024759;
        Tue, 31 Dec 2019 05:33:34 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/7] Add SR-IOV support in PCIe Endpoint Core
Date:   Tue, 31 Dec 2019 17:05:27 +0530
Message-ID: <20191231113534.30405-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
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
to test virtual functions also.

This series is created on top of [1], [2], [3] & [4]
[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20191211124608.887-1-kishon@ti.com
[3] -> http://lore.kernel.org/r/20191230123315.31037-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com

Kishon Vijay Abraham I (7):
  Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
  dt-bindings: PCI: cadence: Add binding to specify max virtual
    functions
  PCI: endpoint: Add support to add virtual function in endpoint core
  PCI: endpoint: Add support to link a physical function to a virtual
    function
  PCI: endpoint: Add virtual function number in pci_epc ops
  PCI: cadence: Add support to configure virtual functions
  misc: pci_endpoint_test: Populate sriov_configure ops to configure
    SR-IOV device

 .../PCI/endpoint/pci-endpoint-cfs.rst         |  12 +-
 .../bindings/pci/cdns,cdns-pcie-ep.txt        |   2 +
 .../bindings/pci/ti,j721e-pci-ep.yaml         |   8 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 232 +++++++++++++++---
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  36 +--
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  64 ++---
 drivers/pci/endpoint/pci-ep-cfs.c             |  24 ++
 drivers/pci/endpoint/pci-epc-core.c           | 126 +++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  92 ++++++-
 include/linux/pci-epc.h                       |  53 ++--
 include/linux/pci-epf.h                       |  16 +-
 14 files changed, 541 insertions(+), 150 deletions(-)

-- 
2.17.1

