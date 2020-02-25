Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6F16BB93
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgBYINA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 03:13:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41006 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgBYINA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 03:13:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P8CdVP022785;
        Tue, 25 Feb 2020 02:12:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582618359;
        bh=xkzJNhAlvIUswcXOd5q7Ot5BwbFTcYnpu6axmC8+x1c=;
        h=From:To:CC:Subject:Date;
        b=FoXCHVRFSklOB8eUHOzbY459HgtxT2Y16H80LUfNCBLxeow0X2sd7EbOBLXPz6PfA
         MK0EqVWoxMmRfOXKIIej6I0xze+qD/MtUVygkflRp+WYQF18/91VtSBrVQJt9wI0ZF
         NY6U/8nkxr81SIWr7jmn8VCLMfduChkSBtI+VZFg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P8CdES092156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 02:12:39 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 02:12:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 02:12:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P8CYu8026220;
        Tue, 25 Feb 2020 02:12:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 0/3] PCIe: Endpoint: Redesign MSI-X support
Date:   Tue, 25 Feb 2020 13:47:00 +0530
Message-ID: <20200225081703.8857-1-kishon@ti.com>
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

Changes from v1:
*) Removed Cadence MSI-X support from the series
*) Fixed nits pointed out by Bjorn

Kishon Vijay Abraham I (3):
  PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
  PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table
    address
  PCI: keystone: Allow AM654 PCIe Endpoint to raise MSI-X interrupt

 drivers/pci/controller/dwc/pci-keystone.c     |  5 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 61 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 31 ++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  7 ++-
 drivers/pci/endpoint/pci-epf-core.c           |  2 +
 include/linux/pci-epc.h                       |  6 +-
 include/linux/pci-epf.h                       | 15 +++++
 8 files changed, 86 insertions(+), 42 deletions(-)

-- 
2.17.1

