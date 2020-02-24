Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2216A301
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBXJuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 04:50:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36498 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBXJuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 04:50:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O9nwWL077916;
        Mon, 24 Feb 2020 03:49:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582537798;
        bh=HLip2YpnIGSxCwy5xrSBcH9I9sf6oirYzrhmh5MeiXA=;
        h=From:To:CC:Subject:Date;
        b=N51uzigHsE1ZPyzRl0CJpmg5wq7auBaamExDjhbMdcCpCxaTL4pEizhmxZHK6IfGR
         ONmRBcsYzHjo2+TTtiCDDs0HwgW/XjEm8LquqxWSccaL37jsIJf7CAn6gVo9Xq7A+e
         wAyofX/qBwoYoHq4ZVaX8/drBHwJdJOWJFNeD0KM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O9nww6097396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 03:49:58 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 03:49:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 03:49:57 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O9nsnB103443;
        Mon, 24 Feb 2020 03:49:55 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] PCI: Endpoint: Miscellaneous improvements
Date:   Mon, 24 Feb 2020 15:23:33 +0530
Message-ID: <20200224095338.3758-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v2:
*) Added "Tested-by" tag from Vidya Sagar
*) Added stable fixes tag to "Fix for concurrent memory allocation in
   OB address region"
   
Changes from v1:
Rebased to Linux 5.6-rc1 and removed dependencies to my other series
to unblock [1]

[1] -> http://lore.kernel.org/r/20200103100736.27627-1-vidyas@nvidia.com

v1 of this patch series can be found @
http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com

This series adds miscellaneous improvements to PCIe endpoint core.
1) Protect concurrent access to memory allocation in pci-epc-mem
2) Replace spinlock with mutex in pci-epc-core and also use
   notification chain mechanism to notify EPC events to EPF driver.
3) Since endpoint function device can be created by multiple
   mechanisms (configfs, devicetree, etc..), allowing each of these
   mechanisms to assign a function number would result in mutliple
   endpoint function devices having the same function number. In order
   to avoid this, let EPC core assign a function number to the
   endpoint device.

Kishon Vijay Abraham I (5):
  PCI: endpoint: Use notification chain mechanism to notify EPC events
    to EPF
  PCI: endpoint: Replace spinlock with mutex
  PCI: endpoint: Fix for concurrent memory allocation in OB address
    region
  PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
  PCI: endpoint: Assign function number for each PF in EPC core

 drivers/pci/endpoint/functions/pci-epf-test.c |  13 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |  27 +----
 drivers/pci/endpoint/pci-epc-core.c           | 113 ++++++++----------
 drivers/pci/endpoint/pci-epc-mem.c            |  10 +-
 drivers/pci/endpoint/pci-epf-core.c           |  33 ++---
 include/linux/pci-epc.h                       |  19 ++-
 include/linux/pci-epf.h                       |   9 +-
 7 files changed, 108 insertions(+), 116 deletions(-)

-- 
2.17.1

