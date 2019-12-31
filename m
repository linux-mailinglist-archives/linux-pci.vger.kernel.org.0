Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40A712D7B4
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLaKBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34306 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaKBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1WAD088940;
        Tue, 31 Dec 2019 04:01:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786492;
        bh=pZGbRajgB05vkTgu4/ik8qf1XwF0gZdL+BeuszkKc+o=;
        h=From:To:CC:Subject:Date;
        b=pzCeHJEyyDeaU+bkbIDKIBBjkSbndC/jI9Yr+ac5JUTXk+mddE4GTWKw3B6KD+rN2
         NuL/kfXRgZAT63U3YG4OcEAp+ju692MKIBH1+T4z6qMPURdlbS8WIsNLsktEAj8z2a
         wZC86VXdsDSHt9OM4a83k4ZAiWR2rbNQ1HTKwV+0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVA1WS8116823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 04:01:32 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:32 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZf020876;
        Tue, 31 Dec 2019 04:01:30 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Improvements to PCIe Endpoint Core
Date:   Tue, 31 Dec 2019 15:33:26 +0530
Message-ID: <20191231100331.6316-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

This series is created on top of [1] and [2]
[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20191230123315.31037-1-kishon@ti.com

Kishon Vijay Abraham I (5):
  PCI: endpoint: Use notification chain mechanism to notify EPC events
    to EPF
  PCI: endpoint: Replace spinlock with mutex
  PCI: endpoint: Protect concurrent access to memory allocation with
    mutex
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

