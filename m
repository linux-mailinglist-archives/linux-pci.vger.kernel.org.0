Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC415A7A5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 12:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBLLVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 06:21:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48448 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLLVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 06:21:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLiPH021367;
        Wed, 12 Feb 2020 05:21:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581506504;
        bh=OKW4SgkgKNhhGYTzK/oI4Jq7PUrtd1o0Bfyk+239kPk=;
        h=From:To:CC:Subject:Date;
        b=L1xQkKehpDONKfTMgp5Lsurvxdvs9ksbGC/j4mh/yEsZGYT+ASpmTTe++UR6w231S
         50NMU+Hp0RPKMnkLACl2DfYOR8JDJx6NSDrMPTvxTw8kaJuWuM25mjhcKMTD2A+8b1
         M2iWRdcePIIIwSB2tKijplIQk0xFOJorvSR/shMU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLihi078506;
        Wed, 12 Feb 2020 05:21:44 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 05:21:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 05:21:41 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLc5W049841;
        Wed, 12 Feb 2020 05:21:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/5] PCI: Endpoint: Miscellaneous improvements
Date:   Wed, 12 Feb 2020 16:55:09 +0530
Message-ID: <20200212112514.2000-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

