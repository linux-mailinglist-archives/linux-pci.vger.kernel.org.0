Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB81C16BCF6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgBYJHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:07:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47740 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgBYJHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:07:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P977uH037671;
        Tue, 25 Feb 2020 03:07:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582621627;
        bh=S9JO7kVucepr2c7FcYvWKG1W++5dKQhcs5rmNi9JnCQ=;
        h=From:To:CC:Subject:Date;
        b=o2NK+KRa1IrpPenLR6X0crRq0B0cOTg0+6Lun6EQBUL42YzZv+7SaO49UTYmMJxhm
         T1GD278D27d/YxA3UmW+3W9ToN/PjmzLgd7DUsQhFG/bpitbJEvKO3X9ABuJlGoaIM
         y7I7UBXwZKs82JL/YwKnZS42Zf/q/5u/u3qtKJWg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P9771J034879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 03:07:07 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 03:07:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 03:07:07 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P973Po052643;
        Tue, 25 Feb 2020 03:07:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] PCI: functions/pci-epf-test: Add DMA data transfer
Date:   Tue, 25 Feb 2020 14:41:25 +0530
Message-ID: <20200225091130.29467-1-kishon@ti.com>
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

