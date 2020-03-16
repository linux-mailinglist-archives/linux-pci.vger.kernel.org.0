Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9331869E1
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgCPLT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 07:19:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42716 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCPLT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 07:19:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJm3l028209;
        Mon, 16 Mar 2020 06:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357588;
        bh=TXweXkc9bYpRJKgOX6VT1UgIdPViLnWUJ/3d12z4TYk=;
        h=From:To:CC:Subject:Date;
        b=dRbqlykoCzvt57Xyq4ghTZLa5+yImu5vg55rsFK2IKoWxfXI13rghioExpmlHArin
         +hGOjbanvCdDglVcfAhsu0SMAPab2rZxUxbTZWHGBMVfs+EkydBUA9Y8f5Y2vW0wPi
         dBBPSAw+G8AfUcb4vV+V61FjikgdCYda4f/FBYxs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02GBJmXv017161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 06:19:48 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:19:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:19:47 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJiTv049775;
        Mon, 16 Mar 2020 06:19:44 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/5]  PCI: functions/pci-epf-test: Add DMA data transfer
Date:   Mon, 16 Mar 2020 16:54:19 +0530
Message-ID: <20200316112424.25295-1-kishon@ti.com>
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

Changes from v2:
*) Removed use of "bool" in uapi/linux/pcitest.h as that seems to fail
   for certain configs (header should be self contained). It was failing
   for "x86_64 allmodconfig".
*) Modified function comments added before DMA transfer functions.

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
 include/uapi/linux/pcitest.h                  |   7 +
 tools/pci/pcitest.c                           |  23 +-
 4 files changed, 417 insertions(+), 31 deletions(-)

-- 
2.17.1

