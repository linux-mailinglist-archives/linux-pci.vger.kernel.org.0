Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB81912CFFA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfL3Mb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52584 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfL3Mb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVIuN069300;
        Mon, 30 Dec 2019 06:31:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709078;
        bh=h1bBuCCt5p3npXFEeqmlW/XTH5HMdwLY7PMMhaC3OJs=;
        h=From:To:CC:Subject:Date;
        b=HoGPOyLwSvSx+HCBFECvXbTkr33tTMtHlzCLGV63NjT6+YUxhx1TNDfwH0/EovR8U
         60xPaSHbLnsUu1eVJhTawnA6sMvShK2FbwZfrN2mdlqXFmOk2/jAgueqrnZMgCv3+l
         a+SojzeUQncMV35M6pL0fBCGfG/4zbxQxSFLg1hs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUCVITa058483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 06:31:18 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:17 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhM002491;
        Mon, 30 Dec 2019 06:31:15 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Improvements to pci_endpoint_test driver
Date:   Mon, 30 Dec 2019 18:03:08 +0530
Message-ID: <20191230123315.31037-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds improvements and fixes to pci_endpoint_test driver
mostly applicable when used with multi-function endpoint (or multiple
endpoint instances using pci_epf_test).

*) Using module parameter to determine irqtype would indicate all the
   pci_endpoint_test device have the same irqtype. Fix it here.
*) Add ioctl to clear irq so that "cat /proc/interrupts" only lists
   the entries for the devices that is actually being used.
*) Creating more than 10 pci-endpoint-test devices results in a kernel
   error.
*) Use full pci-endpoint-test name in request irq so that it's easy to
   profile the interrupt details in "cat /proc/interrupts"
*) Always enable legacy interrupt.

Kishon Vijay Abraham I (7):
  misc: pci_endpoint_test: Avoid using module parameter to determine
    irqtype
  misc: pci_endpoint_test: Do not request or allocate IRQs in probe
  misc: pci_endpoint_test: Add ioctl to clear IRQ
  tools: PCI: Add 'e' to clear IRQ
  misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
  misc: pci_endpoint_test: Use full pci-endpoint-test name in request
    irq
  misc: pci_endpoint_test: Enable legacy interrupt

 drivers/misc/pci_endpoint_test.c | 43 +++++++++++++++++++++++++-------
 include/uapi/linux/pcitest.h     |  1 +
 tools/pci/pcitest.c              | 16 +++++++++++-
 3 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.17.1

