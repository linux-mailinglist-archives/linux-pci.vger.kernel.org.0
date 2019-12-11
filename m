Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3111AB30
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 13:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfLKMpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 07:45:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35786 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLKMpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 07:45:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBCiwt2089410;
        Wed, 11 Dec 2019 06:44:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576068298;
        bh=OE99JeSd1ur9H7sMDQrhfvYhHqNRrzL04S/LysYScMs=;
        h=From:To:CC:Subject:Date;
        b=s07zZQl/I/+upfp1a7uutKA1zM3iv8WSqmOTUtUpQx0CK20B+5bGr46hmHV2ZSnE6
         XNLM1KaMG8zFIt31uDaFA65zxpRPZpjQNluH1519lWYkrlhvk8X2+yjO98+9mCwugA
         asgJA0BPjbwUb6XDcu3Gk7oBnBu0vSpzJ0wyz5BQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBCivUQ108608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 06:44:57 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 06:44:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 06:44:57 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCirfh125451;
        Wed, 11 Dec 2019 06:44:54 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 0/4] Redesign MSI-X support in PCIe Endpoint Core
Date:   Wed, 11 Dec 2019 18:16:04 +0530
Message-ID: <20191211124608.887-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Existing MSI-X support in Endpoint core has limitations:
 1) MSIX table (which is mapped to a BAR) is not allocated by
    anyone. Ideally this should be allocated by endpoint
    function driver.
 2) Endpoint controller can choose any random BARs for MSIX
    table (irrespective of whether the endpoint function driver
    has allocated memory for it or not)

In order to avoid these limitations, pci_epc_set_msix() is
modified to include BAR Indicator register (BIR) configuration
and MSIX table offset as arguments. This series also fixed MSIX
support in dwc driver and add MSI-X support in Cadence PCIe driver.

The previous version of Cadence EP MSI-X support is @ [1].
This series is created on top of [2]

[1] -> https://patchwork.ozlabs.org/patch/971160/
[2] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com

Alan Douglas (1):
  PCI: cadence: Add MSI-X support to Endpoint driver

Kishon Vijay Abraham I (3):
  PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
  PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSIX table
    address
  PCI: keystone: Add AM654 PCIe Endpoint to raise MSIX interrupt

 .../pci/controller/cadence/pcie-cadence-ep.c  | 112 +++++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h |  10 ++
 drivers/pci/controller/dwc/pci-keystone.c     |   5 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  61 +++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  31 ++++-
 drivers/pci/endpoint/pci-epc-core.c           |   7 +-
 drivers/pci/endpoint/pci-epf-core.c           |   2 +
 include/linux/pci-epc.h                       |   6 +-
 include/linux/pci-epf.h                       |  15 +++
 10 files changed, 207 insertions(+), 43 deletions(-)

-- 
2.17.1

