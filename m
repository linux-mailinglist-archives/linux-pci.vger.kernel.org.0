Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09C177441
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgCCKdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:33:33 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50054 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgCCKdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:33:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AXMFu005259;
        Tue, 3 Mar 2020 04:33:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583231602;
        bh=H23/C9c6D1Bn7rFt5P52oUsGTGwNGkRyxfjO34gCRzc=;
        h=From:To:CC:Subject:Date;
        b=VFKQTpXi/80VK2MnN/qbPYsMYvGxB/0mL7cf3fYGW9RoLsmJaReCFxMQQwNT9dXBW
         hW1Lbp2WG31Vtx39Z7dT9qJMLBaLR1CFRktt0NDrOHS3uma/uhMEU5lRn3pfrlDBrM
         8k6euOn/HIURI+6xrDbM/mYdlfw67AdTcUXc2aWA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 023AXMuB105817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 04:33:22 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:33:22 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:33:22 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 023AXJvb114370;
        Tue, 3 Mar 2020 04:33:19 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
Date:   Tue, 3 Mar 2020 16:07:47 +0530
Message-ID: <20200303103752.13076-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch series uses dma engine APIs in pci-epf-test to transfer data using
DMA. It also adds an option "-d" in pcitest for the user to indicate
whether DMA has to be used for data transfer. This also prints
throughput information for data transfer.

Changes from v1:
*) Fixed some of the function names from pci_epf_* to pci_epf_test_*
since the DMA support is now been moved to pci-epf-test.c

Kishon Vijay Abraham I (5):
  PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer
    data
  PCI: endpoint: functions/pci-epf-test: Print throughput information
  misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation
  tools: PCI: Add 'd' command line option to support DMA
  misc: pci_endpoint_test: Add support to get DMA option from userspace

 drivers/misc/pci_endpoint_test.c              | 165 ++++++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 253 +++++++++++++++++-
 include/uapi/linux/pcitest.h                  |   5 +
 tools/pci/pcitest.c                           |  20 +-
 4 files changed, 412 insertions(+), 31 deletions(-)

-- 
2.17.1

